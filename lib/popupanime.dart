import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool playOnce;

  const FadeInOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.playOnce = true,
  });

  @override
  State<FadeInOnScroll> createState() => _FadeInOnScrollState();
}

int _activeAnimations = 0;
const int _maxConcurrentAnimations = 5;

class _FadeInOnScrollState extends State<FadeInOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  bool _hasAppeared = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curve);

    _slide = Tween<Offset>(
      begin: const Offset(0.0, 0.10), // ~40px slide up
      end: Offset.zero,
    ).animate(curve);

    _controller.value = 0.0;
  }

  void _startAnimation() {
    if (!mounted) return;

    _activeAnimations++;

    _controller.forward().then((_) {
      if (mounted) {
        _activeAnimations--;
      }
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasAppeared && widget.playOnce) return;

    if (info.visibleFraction > 0.08) {
      _hasAppeared = true;

      void attemptStart() {
        if (_activeAnimations < _maxConcurrentAnimations) {
          _startAnimation();
        } else {
          Future.delayed(const Duration(milliseconds: 60), () {
            if (mounted) attemptStart();
          });
        }
      }

      if (widget.delay == Duration.zero) {
        attemptStart();
      } else {
        Future.delayed(widget.delay, attemptStart);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? ValueKey(hashCode),
      onVisibilityChanged: _onVisibilityChanged,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _slide.value * 40,
              child: Opacity(opacity: _opacity.value, child: child),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

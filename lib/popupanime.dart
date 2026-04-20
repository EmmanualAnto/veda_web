import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInOnScroll extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final bool playOnce;
  final Offset beginOffset;

  const FadeInOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.playOnce = true,
    this.beginOffset = const Offset(0, 40),
  });

  @override
  State<FadeInOnScroll> createState() => _FadeInOnScrollState();
}

const int _maxConcurrentAnimations = 5;

class _FadeInOnScrollState extends State<FadeInOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  bool _hasAppeared = false;

  late final Key _detectorKey;

  @override
  void initState() {
    super.initState();

    _detectorKey = UniqueKey();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slide = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  void _triggerAnimation() {
    if (!mounted) return;

    if (_controller.status == AnimationStatus.completed ||
        _controller.isAnimating) {
      return;
    }

    Future.delayed(widget.delay, () {
      if (!mounted) return;

      if (_controller.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (widget.playOnce && _controller.status == AnimationStatus.completed) {
      return;
    }

    if (info.visibleFraction > 0.05) {
      _hasAppeared = true;
      _triggerAnimation();
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
      key: _detectorKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacity.value,
              child: Transform.translate(offset: _slide.value, child: child),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

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
    this.duration = const Duration(
      milliseconds: 650,
    ), // bit longer → feels premium, less abrupt
    this.delay = Duration.zero,
    this.playOnce =
        true, // changed default to true – usually better UX for scroll reveals
  });

  @override
  State<FadeInOnScroll> createState() => _FadeInOnScrollState();
}

// Simple global throttle – prevents too many simultaneous .forward() calls
int _activeAnimations = 0;
const int _maxConcurrentAnimations =
    5; // tune: 3–6; lower = safer on mid-range devices

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
      curve: Curves.easeOutCubic, // crisp end, good perf balance
      // Alternatives: Curves.easeOutQuart (stronger slowdown), Curves.linearToEaseOut
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curve);

    _slide = Tween<Offset>(
      begin: const Offset(0.0, 0.10), // subtle ~40px lift – feels natural
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

    if (info.visibleFraction > 0.06) {
      // low threshold → starts earlier on approach
      _hasAppeared = true;

      void attemptStart() {
        if (_activeAnimations < _maxConcurrentAnimations) {
          _startAnimation();
        } else {
          // Gentle queue: wait a tiny bit instead of dropping
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
      // Unique-ish key helps with hot reload & list recycling issues
      key: ValueKey('fade_${widget.key?.toString() ?? UniqueKey().toString()}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: RepaintBoundary(
        // isolates repaint → huge win during many anims
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _slide.value * 40.0, // ~40px – tweak 30–60 to taste
              child: Opacity(opacity: _opacity.value, child: child),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

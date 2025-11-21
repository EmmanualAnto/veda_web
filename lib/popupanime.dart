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
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.playOnce = false, // default to false
  });

  @override
  State<FadeInOnScroll> createState() => _FadeInOnScrollState();
}

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

    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _opacity = Tween<double>(begin: 0, end: 1).animate(curve);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(curve);

    _controller.value = 0; // always start hidden
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasAppeared && widget.playOnce) return;

    if (info.visibleFraction > 0) {
      _hasAppeared = true;

      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
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
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: SlideTransition(position: _slide, child: child),
          );
        },
        child: widget.child,
      ),
    );
  }
}

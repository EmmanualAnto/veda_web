import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInUpOnScroll extends StatefulWidget {
  final Widget child;
  final double offsetY;
  final double triggerFraction;
  final Duration duration;
  final Duration delay;
  final String? onceId;
  final bool playOnce;

  const FadeInUpOnScroll({
    super.key,
    required this.child,
    this.offsetY = 40,
    this.triggerFraction = 0.6,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.onceId,
    this.playOnce = true,
  });

  @override
  State<FadeInUpOnScroll> createState() => _FadeInUpOnScrollState();
}

class _FadeInUpOnScrollState extends State<FadeInUpOnScroll>
    with SingleTickerProviderStateMixin {
  static final Set<String> _playedIds = <String>{};
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _translateY;

  bool _hasAppeared = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _translateY = Tween<double>(
      begin: widget.offsetY,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    if (widget.playOnce &&
        widget.onceId != null &&
        _playedIds.contains(widget.onceId)) {
      _hasAppeared = true;
      _controller.value = 1;
    }
  }

  Future<void> _trigger() async {
    if (_hasAppeared) return;
    _hasAppeared = true;

    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }
    if (!mounted) return;

    _controller.forward();

    if (widget.playOnce && widget.onceId != null) {
      _playedIds.add(widget.onceId!);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detectorKey = ValueKey<String>(
      widget.onceId ?? widget.child.runtimeType.toString(),
    );

    return VisibilityDetector(
      key: detectorKey,
      onVisibilityChanged: (info) {
        if (!_hasAppeared && info.visibleFraction > widget.triggerFraction) {
          _trigger();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(
              offset: Offset(0, _translateY.value),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

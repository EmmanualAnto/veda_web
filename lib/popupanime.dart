import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PopupOnScroll extends StatefulWidget {
  final Widget child;
  final double triggerFraction;
  final Duration duration;
  final Duration delay;
  final String? onceId;
  final bool playOnce;

  const PopupOnScroll({
    super.key,
    required this.child,
    this.triggerFraction = 0.1, // trigger early
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.onceId,
    this.playOnce = true,
  });

  @override
  State<PopupOnScroll> createState() => _PopupOnScrollState();
}

class _PopupOnScrollState extends State<PopupOnScroll>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static final Set<String> _playedIds = {}; // global played tracker

  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _hasAppeared = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    // restore previous completed animation if needed
    if (widget.onceId != null && _playedIds.contains(widget.onceId)) {
      _hasAppeared = true;
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasAppeared) return;

    if (info.visibleFraction >= widget.triggerFraction) {
      _hasAppeared = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
      if (widget.playOnce && widget.onceId != null) {
        _playedIds.add(widget.onceId!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: _onVisibilityChanged,
      child: TickerMode(
        enabled: mounted,
        child: FadeTransition(
          opacity: _animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2), // start slightly below
              end: Offset.zero,
            ).animate(_animation),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

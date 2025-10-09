import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A widget that animates its child with a smooth, professional scale-up,
/// fade-in, and slight slide-up effect when it scrolls into view.
class PopupOnScroll extends StatefulWidget {
  final Widget child;

  /// The fraction of the widget that must be visible to trigger the animation (0.0 to 1.0).
  final double triggerFraction;

  /// The duration of the entire animation.
  final Duration duration;

  /// A delay before the animation starts after the widget becomes visible.
  final Duration delay;

  /// A unique ID to ensure the animation plays only once per session, regardless of navigation.
  final String? onceId;

  /// If true, the animation plays only once for a given session/ID.
  final bool playOnce;

  const PopupOnScroll({
    super.key,
    required this.child,
    this.triggerFraction = 0.5,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.onceId,
    this.playOnce = true,
  });

  @override
  State<PopupOnScroll> createState() => _PopupOnScrollState();
}

class _PopupOnScrollState extends State<PopupOnScroll>
    with SingleTickerProviderStateMixin {
  // Static set to track which unique IDs have already played.
  static final Set<String> _playedIds = <String>{};

  late final AnimationController _controller;
  late final Animation<double> _animation;

  bool _hasAppeared = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Using a sophisticated ease-out curve for a professional, non-bouncy feel.
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic, // Smoother and faster acceleration at start
    );

    // If 'playOnce' is true and the ID is in the set, pre-fill the animation.
    if (widget.playOnce &&
        widget.onceId != null &&
        _playedIds.contains(widget.onceId)) {
      _hasAppeared = true;
      _controller.value = 1;
    }
  }

  /// Triggers the animation to play forward after an optional delay.
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
    // Unique key for VisibilityDetector, essential for 'onceId' logic.
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
      // Combining transitions for the professional look: Opacity, Slide, and Scale
      child: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          // Animate from a slight vertical offset (20.0) upwards.
          position: Tween<Offset>(
            begin: const Offset(
              0.0,
              0.05,
            ), // Start 5% lower than final position
            end: Offset.zero,
          ).animate(_animation),
          child: ScaleTransition(
            // Scale from 95% to 100% for a subtle "pop" effect.
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(_animation),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInUpOnScroll extends StatefulWidget {
  final Widget child;
  final double offsetY;
  final double triggerFraction;
  final Duration duration;
  final Duration delay;

  /// Give a stable id per item to ensure it never re-animates once played.
  /// Example: "grid_web", "grid_software", "why_custom"
  final String? onceId;
  final bool playOnce; // default true

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

class _FadeInUpOnScrollState extends State<FadeInUpOnScroll> {
  static final Set<String> _playedIds = <String>{};

  bool _hasAppeared = false;
  bool _animate = false;

  @override
  void initState() {
    super.initState();

    // If this id already played before, start in the "shown" state.
    if (widget.playOnce &&
        widget.onceId != null &&
        _playedIds.contains(widget.onceId)) {
      _hasAppeared = true;
      _animate = true;
    }
  }

  Future<void> _trigger() async {
    if (_hasAppeared) return;
    _hasAppeared = true;
    if (widget.delay > Duration.zero) await Future.delayed(widget.delay);
    if (!mounted) return;
    if (widget.playOnce && widget.onceId != null)
      _playedIds.add(widget.onceId!);
    setState(() => _animate = true);
  }

  @override
  Widget build(BuildContext context) {
    // IMPORTANT: use a stable key for the detector so it doesn't reset.
    final detectorKey = ValueKey<String>(
      widget.onceId ??
          (widget.key?.toString() ?? widget.child.runtimeType.toString()),
    );

    return VisibilityDetector(
      key: detectorKey,
      onVisibilityChanged: (info) {
        if (!_hasAppeared && info.visibleFraction > widget.triggerFraction) {
          _trigger();
        }
      },
      child: AnimatedOpacity(
        opacity: _animate ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: widget.duration,
          transform: Matrix4.translationValues(
            0,
            _animate ? 0 : widget.offsetY,
            0,
          ),
          curve: Curves.easeOut,
          child: widget.child,
        ),
      ),
    );
  }
}

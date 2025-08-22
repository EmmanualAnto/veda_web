import 'package:flutter/material.dart';

class FadeInUpOnScroll extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final double startOffset;
  final double offsetY; // how much it starts below
  final bool visible; // NEW: control from parent

  const FadeInUpOnScroll({
    super.key,
    required this.child,
    required this.controller,
    this.startOffset = 100,
    this.offsetY = 40, // default: 40 pixels below
    this.visible = false, // default false
  });

  @override
  State<FadeInUpOnScroll> createState() => _FadeInUpOnScrollState();
}

class _FadeInUpOnScrollState extends State<FadeInUpOnScroll>
    with SingleTickerProviderStateMixin {
  bool hasAppeared = false;
  double opacity = 0;
  double translateY = 0;

  @override
  void initState() {
    super.initState();
    translateY = widget.offsetY;

    // If parent already says visible, skip animation
    if (widget.visible) {
      opacity = 1;
      translateY = 0;
      hasAppeared = true;
    } else {
      widget.controller.addListener(_checkScroll);
    }
  }

  void _checkScroll() {
    if (!hasAppeared && widget.controller.offset > widget.startOffset) {
      setState(() {
        opacity = 1;
        translateY = 0;
        hasAppeared = true;
      });
      widget.controller.removeListener(_checkScroll);
    }
  }

  @override
  void didUpdateWidget(covariant FadeInUpOnScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If parent updates visible to true, ensure it's shown
    if (widget.visible && !hasAppeared) {
      setState(() {
        opacity = 1;
        translateY = 0;
        hasAppeared = true;
      });
      widget.controller.removeListener(_checkScroll);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: opacity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        transform: Matrix4.translationValues(0, translateY, 0),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

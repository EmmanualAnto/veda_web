import 'package:flutter/material.dart';

class FadeInUpOnScroll extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final double startOffset;
  final double offsetY; // how much it starts below

  const FadeInUpOnScroll({
    super.key,
    required this.child,
    required this.controller,
    this.startOffset = 100,
    this.offsetY = 40,
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

    // Add listener
    widget.controller.addListener(_checkScroll);
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

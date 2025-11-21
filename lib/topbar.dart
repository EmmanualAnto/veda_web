import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

import 'package:veda_main/constants.dart';

class ReusableMenu extends StatefulWidget {
  final Map<String, String> menuRoutes;
  final double topBarHeight;

  const ReusableMenu({
    super.key,
    required this.menuRoutes,
    this.topBarHeight = kToolbarHeight,
  });

  @override
  State<ReusableMenu> createState() => _ReusableMenuState();
}

class _ReusableMenuState extends State<ReusableMenu>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    void _navigate(String route) {
      context.go(route);
      if (_isMenuOpen) setState(() => _isMenuOpen = false);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
      height: widget.topBarHeight + (_isMenuOpen && !isDesktop ? 200 : 0),
      child: Stack(
        children: [
          // Top bar here (unchanged)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: widget.topBarHeight,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Image.asset(
                    'assets/logo.webp',
                    height: 36,
                    fit: BoxFit.contain,
                  ),
                  // Menu / burger button
                  if (isDesktop)
                    Row(
                      children: widget.menuRoutes.keys
                          .map(
                            (item) => _NavButton(
                              title: item,
                              onPressed: (_) =>
                                  _navigate(widget.menuRoutes[item]!),
                            ),
                          )
                          .toList(),
                    )
                  else
                    AnimatedBurger3(
                      isOpen: _isMenuOpen,
                      onTap: () => setState(() => _isMenuOpen = !_isMenuOpen),
                    ),
                ],
              ),
            ),
          ),

          // Mobile dropdown menu
          if (!isDesktop)
            Positioned(
              top: widget.topBarHeight,
              left: 0,
              right: 0,
              child: ClipRect(
                child: AnimatedSlide(
                  offset: _isMenuOpen ? Offset.zero : const Offset(0, -0.15),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _isMenuOpen ? 1.0 : 0.0,
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      // Inside your Positioned -> ClipRect -> AnimatedSize -> Container
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.menuRoutes.entries.map((entry) {
                          return _DrawerMenuItem(
                            title: entry.key,
                            onTap: () => _navigate(entry.value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DrawerMenuItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _DrawerMenuItem({required this.title, required this.onTap});

  @override
  State<_DrawerMenuItem> createState() => _DrawerMenuItemState();
}

class _DrawerMenuItemState extends State<_DrawerMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              fontSize: 18,
              color: _isHovered ? AppColors.primary : Colors.black,
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}

// Reusable nav button with hover effect for desktop
class _NavButton extends StatefulWidget {
  final String title;
  final Function(String)? onPressed;

  const _NavButton({required this.title, this.onPressed});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => widget.onPressed?.call(widget.title),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.instrumentSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 2,
                width: _isHovered ? 40 : 0,
                color: const Color(0xFF017697),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedBurger3 extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onTap;

  const AnimatedBurger3({super.key, required this.isOpen, required this.onTap});

  static const Duration _dur = Duration(milliseconds: 300);
  static const Curve _curve = Curves.easeInOut;
  static const Color _lineColor = Color(0xFF017697);

  static const double _lineHeight = 2.5;
  static const double _closedOffset = 8; // smaller vertical gap

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36, // smaller icon
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Top line
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: isOpen ? 1.0 : 0.0),
                  duration: _dur,
                  curve: _curve,
                  builder: (context, t, child) {
                    final dy = _closedOffset * (1 - t);
                    final angle = (math.pi / 4) * t;
                    return Transform.translate(
                      offset: Offset(0, -dy),
                      child: Transform.rotate(
                        angle: angle,
                        child: _line(width: 28),
                      ),
                    );
                  },
                ),

                // Middle line
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1.0, end: isOpen ? 0.0 : 1.0),
                  duration: _dur,
                  curve: _curve,
                  builder: (context, t, child) {
                    return Opacity(
                      opacity: t,
                      child: Transform.scale(scale: t, child: _line(width: 28)),
                    );
                  },
                ),

                // Bottom line
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: isOpen ? 1.0 : 0.0),
                  duration: _dur,
                  curve: _curve,
                  builder: (context, t, child) {
                    final dy = _closedOffset * (1 - t);
                    final angle = -(math.pi / 4) * t;
                    return Transform.translate(
                      offset: Offset(0, dy),
                      child: Transform.rotate(
                        angle: angle,
                        child: _line(width: 28),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _line({required double width}) {
    return Container(
      width: width,
      height: _lineHeight,
      decoration: BoxDecoration(
        color: _lineColor,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

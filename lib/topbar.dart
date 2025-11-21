import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

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

    return SizedBox(
      height: widget.topBarHeight + (_isMenuOpen && !isDesktop ? 200 : 0),
      child: Stack(
        children: [
          // Fixed TopBar
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

                  // Menu Items / Button
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
                    IconButton(
                      icon: Icon(
                        _isMenuOpen ? Icons.close : Icons.menu,
                        color: const Color(0xFF017697),
                        size: 26,
                      ),
                      onPressed: () =>
                          setState(() => _isMenuOpen = !_isMenuOpen),
                    ),
                ],
              ),
            ),
          ),

          // Dropdown menu for mobile
          if (_isMenuOpen && !isDesktop)
            Positioned(
              top: widget.topBarHeight,
              left: 0,
              right: 0,
              child: AnimatedSlide(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                offset: _isMenuOpen ? Offset.zero : const Offset(0, -0.15),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: _isMenuOpen ? 1.0 : 0.0,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.menuRoutes.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextButton(
                            onPressed: () => _navigate(entry.value),
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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

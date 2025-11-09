import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  final List<String> menuItems;
  final Function(String)? onMenuItemPressed;
  final VoidCallback? onMenuPressed; // ✅ added
  final String logoPath;
  final bool isMenuOpen;

  const TopBar({
    super.key,
    this.menuItems = const ['Home', 'About', 'Services', 'Contact'],
    this.logoPath = 'assets/logo.webp',
    this.onMenuItemPressed,
    this.onMenuPressed, // ✅ added
    this.isMenuOpen = false, // ✅ added
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return SizedBox(
      height: kToolbarHeight, // <-- exact fixed height = 56
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ), // no vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, // keep items centered
          children: [
            Image.asset(logoPath, height: 36, fit: BoxFit.contain),

            if (isDesktop)
              Row(
                children: menuItems
                    .map((item) => _navButton(item, context))
                    .toList(),
              )
            else
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: IconButton(
                  key: ValueKey<bool>(isMenuOpen),
                  icon: Icon(
                    isMenuOpen ? Icons.close : Icons.menu,
                    color: const Color(0xFF017697),
                    size: 26,
                  ),
                  onPressed: onMenuPressed,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: _NavButton(title: title, onPressed: onMenuItemPressed),
    );
  }
}

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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.onPressed != null) widget.onPressed!(widget.title);
        },
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
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: _isHovered
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: 2,
                width: _isHovered ? 40 : 0,
                color: const Color(0xFF017697),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

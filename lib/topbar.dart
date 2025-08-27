import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  final List<String> menuItems;
  final Function(String)? onMenuItemPressed;
  final String logoPath;

  const TopBar({
    super.key,
    this.menuItems = const ['Home', 'About', 'Services', 'Contact'],
    this.logoPath = 'assets/logo.webp',
    this.onMenuItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Image.asset(logoPath, height: 40, width: 120, fit: BoxFit.contain),

          // Menu Items
          if (isDesktop)
            Row(
              children: menuItems
                  .map((item) => _navButton(item, context))
                  .toList(),
            )
          else
            PopupMenuButton<String>(
              color: Colors.white,
              icon: const Icon(Icons.menu, color: Color(0xFF017697)),
              onSelected: (value) {
                if (onMenuItemPressed != null) onMenuItemPressed!(value);
              },
              itemBuilder: (context) {
                return menuItems
                    .map(
                      (item) => PopupMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList();
              },
            ),
        ],
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
            // Text
            Text(
              widget.title,
              style: GoogleFonts.instrumentSans(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            // Underline animation
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
                width: _isHovered ? 40 : 0, // underline width
                color: const Color(0xFF017697),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

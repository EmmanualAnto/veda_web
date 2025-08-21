import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends StatelessWidget {
  final List<String> menuItems;
  final Function(String)? onMenuItemPressed;
  final String logoPath;

  const TopBar({
    super.key,
    this.menuItems = const ['Home', 'About', 'Services', 'Contact'],
    this.logoPath = 'assets/logo.png',
    this.onMenuItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(logoPath, height: 50, width: 150),
          isDesktop
              ? Row(
                  children: menuItems
                      .map((item) => _navButton(item, context))
                      .toList(),
                )
              : Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Color(0xFF017697)),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _navButton(String title, BuildContext context) {
    return TextButton(
      onPressed: () {
        if (onMenuItemPressed != null) onMenuItemPressed!(title);
      },
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

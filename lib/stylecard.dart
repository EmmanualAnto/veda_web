import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/constants.dart';

class StyledCardSection extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;

  final String pageKey;
  final int cardIndex;

  const StyledCardSection({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.pageKey,
    required this.cardIndex,
  });

  @override
  State<StyledCardSection> createState() => _StyledCardSectionState();
}

class _StyledCardSectionState extends State<StyledCardSection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: desktop ? 386.67 : 343,
        height: 355,
        padding: EdgeInsets.all(desktop ? 16 : 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
          border: const Border(
            bottom: BorderSide(color: AppColors.primary, width: 8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container stays fixed
            SizedBox(
              width: double.infinity,
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedScale(
                        scale: _isHovered ? 1.05 : 1.0, // only image scales
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                        child: Image.asset(
                          gaplessPlayback: true,
                          widget.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: GoogleFonts.instrumentSans(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(13, 20, 45, 1),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color.fromRGBO(89, 89, 89, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

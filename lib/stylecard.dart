import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/constants.dart';

class StyledCardSection extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final String pageKey;
  final int cardIndex;
  final VoidCallback? onTap;
  final bool showLearnMore;

  const StyledCardSection({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.pageKey,
    required this.cardIndex,
    this.onTap,
    this.showLearnMore = false,
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
    final cardHeight = desktop
        ? (widget.showLearnMore && widget.onTap != null
              ? 450.0
              : 340.0) // desktop heights
        : (widget.showLearnMore && widget.onTap != null
              ? 450.0
              : 320.0); // mobile heights

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          width: desktop ? 386.67 : 343,
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
          child: SizedBox(
            height: cardHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                SizedBox(
                  width: double.infinity,
                  height: widget.showLearnMore && widget.onTap != null
                      ? 200
                      : 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedScale(
                      scale: _isHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  style: GoogleFonts.instrumentSans(
                    fontSize: desktop ? 23 : 20,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(13, 20, 45, 1),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: desktop ? 15 : 13,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (widget.showLearnMore && widget.onTap != null) ...[
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: widget.onTap,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Learn More',
                          style: GoogleFonts.instrumentSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

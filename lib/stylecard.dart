// ---- Reusable Card Widget ----
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledCardSection extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const StyledCardSection({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Container(
      width: desktop ? 386.67 : 343,
      height: 348,
      padding: EdgeInsets.all(desktop ? 16 : 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
        border: const Border(
          bottom: BorderSide(color: Color.fromRGBO(0, 53, 255, 1), width: 8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              gaplessPlayback: true,
              imagePath,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.instrumentSans(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(13, 20, 45, 1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(89, 89, 89, 1),
            ),
          ),
        ],
      ),
    );
  }
}

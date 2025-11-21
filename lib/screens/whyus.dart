import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/popupanime.dart';
import 'package:veda_main/veda_page_layout.dart';

class WhyUsPage extends StatelessWidget {
  const WhyUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return VedaPageLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '// ',
                      style: GoogleFonts.instrumentSans(
                        color: const Color(0xFF0035FF),
                        fontSize: isDesktop ? 25 : 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: 'Why Veda',
                      style: GoogleFonts.instrumentSans(
                        fontSize: isDesktop ? 22 : 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Reasons Our Clients\n',
                      style: GoogleFonts.instrumentSans(
                        fontSize: isDesktop ? 46 : 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Stay With Us',
                      style: GoogleFonts.instrumentSans(
                        fontSize: isDesktop ? 46 : 26,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0035FF),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Desktop vs Mobile layout
              !isDesktop
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _popupReason(
                          '100%\nCustom Solutions',
                          'Tailored software, not templates. Built to match your business model.',
                          Icons.construction,
                          context,
                          0,
                        ),
                        const SizedBox(height: 20),
                        _popupReason(
                          'Local Support,\nGlobal Standards',
                          'Serving Bahrain-based enterprises with ISO-grade quality.',
                          Icons.public,
                          context,
                          50,
                        ),
                        const SizedBox(height: 20),
                        _popupReason(
                          'Fast\nTurnaround',
                          'Rapid development cycles with clear timelines and zero guesswork.',
                          Icons.speed,
                          context,
                          100,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _popupReason(
                          '100%\nCustom Solutions',
                          'Tailored software, not templates. Built to match your business model.',
                          Icons.construction,
                          context,
                          0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: CustomPaint(
                            size: const Size(100, 1),
                            painter: _DottedLinePainter(),
                          ),
                        ),
                        _popupReason(
                          'Local Support,\nGlobal Standards',
                          'Serving Bahrain-based enterprises with ISO-grade quality.',
                          Icons.public,
                          context,
                          50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: CustomPaint(
                            size: const Size(100, 1),
                            painter: _DottedLinePainter(),
                          ),
                        ),
                        _popupReason(
                          'Fast\nTurnaround',
                          'Rapid development cycles with clear timelines and zero guesswork.',
                          Icons.speed,
                          context,
                          100,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popupReason(
    String title,
    String desc,
    IconData icon,
    BuildContext context,
    int delayMs,
  ) {
    return FadeInOnScroll(
      delay: Duration(milliseconds: delayMs),
      child: _reasonItem(title, desc, icon, context),
    );
  }

  Widget _reasonItem(
    String title,
    String description,
    IconData icon,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0B1736),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.instrumentSans(
                fontSize: isDesktop ? 22 : 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              children: [TextSpan(text: title)],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 15 : 13,
              color: Colors.black.withOpacity(0.8),
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

/// Dotted line painter for desktop separator
class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dotWidth = 4.0;
    const spacing = 6.0;
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dotWidth, 0), paint);
      startX += dotWidth + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

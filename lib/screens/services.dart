import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:go_router/go_router.dart';

import 'package:veda_main/constants.dart';

import 'package:veda_main/popupanime.dart';

import 'package:veda_main/veda_page_layout.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;

    return VedaPageLayout(
      child: Stack(
        children: [
          // STATIC GEOMETRIC BACKGROUND
          Positioned.fill(
            child: RepaintBoundary(child: _StaticGridBackground()),
          ),

          Column(
            children: [
              _buildModernHeader(isDesktop),

              _buildServiceSection(
                context: context,

                index: "01",

                title: "Web Application",

                subtitle: "Scalable Ecosystems",

                description:
                    "We build high-performance web platforms designed for heavy traffic and seamless user experiences. Using modern stacks, we ensure your business is ready for the future cloud.",

                image: "assets/3.webp",

                route: "/webapp",

                isDesktop: isDesktop,

                imageLeft: true,
              ),

              _buildServiceSection(
                context: context,

                index: "02",

                title: "Software Engineering",

                subtitle: "Custom Architecture",

                description:
                    "From ERP systems to bespoke desktop tools, our engineering team focuses on automation and reliability. We solve complex logic problems with clean, maintainable code.",

                image: "assets/4.webp",

                route: "/software",

                isDesktop: isDesktop,

                imageLeft: false, // Flipped layout
              ),

              _buildServiceSection(
                context: context,

                index: "03",

                title: "Infrastructure",

                subtitle: "Network & Security",

                description:
                    "Protecting your digital assets with robust networking and hardware solutions. We provide the backbone for your company's entire digital operation in Bahrain.",

                image: "assets/5.webp",

                route: "/hardware",

                isDesktop: isDesktop,

                imageLeft: true,
              ),

              const SizedBox(height: 120),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernHeader(bool isDesktop) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 120 : 24,

        100,

        isDesktop ? 120 : 24,

        80,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),

              borderRadius: BorderRadius.circular(100),
            ),

            child: Text(
              "OUR CAPABILITIES",

              style: GoogleFonts.inter(
                color: AppColors.primary,

                fontWeight: FontWeight.bold,

                fontSize: 12,

                letterSpacing: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            "Comprehensive technology\nsolutions for modern enterprise.",

            textAlign: TextAlign.center,

            style: GoogleFonts.plusJakartaSans(
              fontSize: isDesktop ? 64 : 36,

              fontWeight: FontWeight.w800,

              height: 1.1,

              letterSpacing: -2,

              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSection({
    required BuildContext context,
    required String index,
    required String title,
    required String subtitle,
    required String description,
    required String image,
    required String route,
    required bool isDesktop,
    required bool imageLeft,
  }) {
    final imageWidget = Container(
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: ResizeImage(AssetImage(image), width: isDesktop ? 1200 : 800),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 8),
          ),
        ],
      ),
    );

    final textWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          index,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: AppColors.primary.withOpacity(0.2),
          ),
        ),
        Text(
          subtitle.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: GoogleFonts.inter(
            fontSize: 18,
            color: AppColors.primary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () => context.go(route),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            "View Case Study",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

    return RepaintBoundary(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 120 : 24,
          vertical: 60,
        ),
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: imageLeft
                    ? [
                        Expanded(child: FadeInOnScroll(child: imageWidget)),
                        const SizedBox(width: 80),
                        Expanded(child: FadeInOnScroll(child: textWidget)),
                      ]
                    : [
                        Expanded(child: FadeInOnScroll(child: textWidget)),
                        const SizedBox(width: 80),
                        Expanded(child: FadeInOnScroll(child: imageWidget)),
                      ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInOnScroll(child: imageWidget),
                  const SizedBox(height: 40),
                  FadeInOnScroll(child: textWidget),
                ],
              ),
      ),
    );
  }
}

// ---------------------- STATIC BG DESIGN ----------------------
class _StaticGridBackground extends StatelessWidget {
  const _StaticGridBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFDFDFD),
      child: Stack(
        children: const [
          _OptimizedGrid(),
          Positioned(
            top: -200,
            left: -200,
            child: _GlowSpot(
              color: Color(0x0D017697), // very light primary
            ),
          ),
          Positioned(
            bottom: 200,
            right: -100,
            child: _GlowSpot(
              color: Color(0x080000FF), // subtle blue glow
            ),
          ),
        ],
      ),
    );
  }
}

class _OptimizedGrid extends StatelessWidget {
  const _OptimizedGrid();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _GridPainter(), size: Size.infinite);
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.05)
      ..strokeWidth = 1;

    const spacing = 100.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _GlowSpot extends StatelessWidget {
  final Color color;

  const _GlowSpot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,

      height: 600,

      decoration: BoxDecoration(
        shape: BoxShape.circle,

        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}

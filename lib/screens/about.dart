import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:veda_main/constants.dart';
import 'package:veda_main/veda_page_layout.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return VedaPageLayout(
      child: Stack(
        children: [
          // 1. DYNAMIC BACKGROUND: The "Fluid" Canvas
          Positioned.fill(child: _CustomBackgroundPainter()),

          SingleChildScrollView(
            child: Column(
              children: [
                // 2. KINETIC HERO SECTION
                _buildKineticHero(isDesktop, size),

                // 6. THE STATS SECTION (Bold Impact)
                _buildLiveImpactStats(isDesktop),
                const SizedBox(height: 120),

                // 3. THE "VISION" SPLIT (Image moving against text)
                _buildParallaxVisionSection(isDesktop, size),

                // 4. THE "NUMBERS" MARQUEE (Moving Social Proof)
                if (isDesktop) AnimatedTicker(),

                if (isDesktop) const SizedBox(height: 50),

                // 2. THE TECH STACK (Modern Field)
                _buildTechEcosystem(isDesktop),

                // 3. OUR GLOBAL FOOTPRINT
                _buildGlobalReach(isDesktop),

                // 8. THE PHILOSOPHY SECTION (Deep Branding)
                _buildPhilosophySection(isDesktop, size),

                const SizedBox(height: 100),
              ],
            ),
          ),

          // 6. FLOATING CONTACT ACTION
          _buildFloatingContact(context, isDesktop),
        ],
      ),
    );
  }

  // --- COMPONENT: KINETIC HERO ---
  Widget _buildKineticHero(bool isDesktop, Size size) {
    return Container(
      constraints: BoxConstraints(
        minHeight: isDesktop ? size.height * 0.8 : 500,
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Text
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "INNOVATE",
                textAlign: TextAlign.center,
                style: GoogleFonts.instrumentSans(
                  fontSize: isDesktop ? 250 : 100,
                  fontWeight: FontWeight.w900,
                  color: Colors.black.withOpacity(0.03),
                ),
              ),
            ),
          ),

          // Foreground Content
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGlassBadge("THE FUTURE IS VEDA"),
              const SizedBox(height: 30),
              Text(
                "WE BUILD\nDIGITAL LUXURY.",
                textAlign: TextAlign.center,
                style: GoogleFonts.brunoAce(
                  fontSize: isDesktop ? 100 : 50,
                  fontWeight: FontWeight.bold,
                  height: 0.95,
                  letterSpacing: isDesktop ? -4 : -2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveImpactStats(bool isDesktop) {
    return RepaintBoundary(
      // Isolates the animation from the background painter
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 24),
        child: Wrap(
          spacing: 80,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: [
            _buildCounter("150", "PROJECTS", "+"),
            _buildCounter("85", "CLIENTS", " %"),
            _buildCounter("24", "EXPERTS", "/7"),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String target, String label, String suffix) {
    final double endValue = double.tryParse(target) ?? 0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: endValue),
      duration: const Duration(
        milliseconds: 1500,
      ), // Slightly faster feels snappier
      // We pass the label as a 'child' so Flutter doesn't rebuild it 60fps
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
          letterSpacing: 2,
        ),
      ),
      builder: (context, value, staticChild) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${value.toInt()}$suffix",
              style: const TextStyle(
                // Use standard TextStyle for the moving number
                fontSize:
                    72, // Apply font family globally in main.dart to save CPU
                fontWeight: FontWeight.w900,
                letterSpacing: -3,
                color: Colors.black,
              ),
            ),
            staticChild!, // This part never rebuilds during animation
          ],
        );
      },
    );
  }

  // --- COMPONENT: PARALLAX VISION ---
  Widget _buildParallaxVisionSection(bool isDesktop, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 24),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          isDesktop
              ? Expanded(
                  child: Transform.rotate(
                    angle: -0.05,
                    child: ClipPath(
                      clipper: OrganicClipper(),
                      child: Image.asset(
                        'assets/2.webp',
                        height: 600,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : ClipPath(
                  clipper: OrganicClipper(),
                  child: Image.asset(
                    'assets/2.webp',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

          if (isDesktop)
            const SizedBox(width: 60)
          else
            const SizedBox(height: 24),

          // TEXT + extended description
          isDesktop
              ? Expanded(child: _buildMissionText(isDesktop))
              : _buildMissionText(isDesktop),
        ],
      ),
    );
  }

  Widget _buildMissionText(bool isDesktop) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "01 / MISSION",
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Crafting high-performance digital artifacts that don't just work—they inspire.",
          style: GoogleFonts.instrumentSans(
            fontSize: isDesktop ? 38 : 28,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 25),
        // Extended description
        Text(
          "Our team focuses on seamless digital experiences that elevate user engagement and brand impact. "
          "We combine creativity, technology, and strategic insight to design products that are not only visually compelling, "
          "but also intuitive and highly functional. Every interaction is carefully considered, ensuring your audience enjoys "
          "an effortless journey through every touchpoint of your digital ecosystem. "
          "From initial concept to full-scale deployment, we prioritize quality, performance, and scalability to deliver "
          "solutions that grow with your vision.",
          style: GoogleFonts.poppins(
            fontSize: isDesktop ? 16 : 14,
            color: Colors.black54,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingContact(BuildContext context, bool isDesktop) {
    return Positioned(
      bottom: 40,
      right: isDesktop ? 40 : 20,
      child: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () => context.go('/contact-us'),
        label: const Text(
          "START A PROJECT",
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class AnimatedTicker extends StatefulWidget {
  const AnimatedTicker({super.key});

  @override
  State<AnimatedTicker> createState() => _AnimatedTickerState();
}

class _AnimatedTickerState extends State<AnimatedTicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30), // Slower is more "premium"
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateZ(-0.02),
      alignment: Alignment.center,
      child: Container(
        height: 100,
        width: double.infinity,
        color: Colors.black,
        // ClipRect is the secret sauce—it hides the overflow
        child: ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FractionalTranslation(
                // We only need a small offset because we will repeat the text
                translation: Offset(-_controller.value, 0),
                child: OverflowBox(
                  maxWidth:
                      double.infinity, // Tells Flutter: "It's okay to be huge"
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(10, (index) => _buildTickerItem()),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTickerItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "• SOFTWARE • DESIGN • STRATEGY • CLOUD • SCALE ",
        style: GoogleFonts.instrumentSans(
          color: Colors.white.withOpacity(0.9),
          fontSize: 32,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

Widget _buildTechEcosystem(bool isDesktop) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: isDesktop ? 100 : 24,
      vertical: !isDesktop ? 50 : 0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGlassBadge("STACK 2.0"),
                const SizedBox(height: 20),
                Text(
                  "Technological\nFoundations",
                  style: GoogleFonts.instrumentSans(
                    fontSize: isDesktop ? 64 : 40,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    letterSpacing: -2,
                  ),
                ),
              ],
            ),
            if (isDesktop) const Spacer(),
            if (isDesktop)
              Text(
                "ENGINEERED FOR\nPERFORMANCE",
                textAlign: TextAlign.right,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Colors.black26,
                  letterSpacing: 2,
                ),
              ),
          ],
        ),
        const SizedBox(height: 60),

        // The Matrix Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = isDesktop
                ? (constraints.maxWidth - 40) / 3
                : constraints.maxWidth;
            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildTechCard(
                  "Flutter",
                  "Mobile & Web",
                  Icons.bolt,
                  cardWidth,
                  true,
                ),
                _buildTechCard(
                  "Python",
                  "AI & Logic",
                  Icons.psychology,
                  cardWidth,
                  false,
                ),
                _buildTechCard(
                  "AWS",
                  "Cloud Infrastructure",
                  Icons.cloud_done,
                  cardWidth,
                  false,
                ),
                _buildTechCard(
                  "Node.js",
                  "Server Systems",
                  Icons.settings_input_component,
                  cardWidth,
                  false,
                ),
                _buildTechCard(
                  "Docker",
                  "Containerization",
                  Icons.layers,
                  cardWidth,
                  true,
                ),
                _buildTechCard(
                  "Firebase",
                  "Live Data",
                  Icons.auto_awesome,
                  cardWidth,
                  false,
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildTechCard(
  String name,
  String role,
  IconData icon,
  double width,
  bool isHighlight,
) {
  return Container(
    width: width,
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: isHighlight ? AppColors.primary : Colors.grey.withOpacity(0.03),
      borderRadius: BorderRadius.circular(32),
      border: Border.all(
        color: isHighlight
            ? Colors.transparent
            : Colors.black.withOpacity(0.05),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: isHighlight ? Colors.white : AppColors.primary,
          size: 32,
        ),
        const SizedBox(height: 40),
        Text(
          name,
          style: GoogleFonts.instrumentSans(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: isHighlight ? Colors.white : Colors.black,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          role,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isHighlight ? Colors.white70 : Colors.black45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildGlassBadge(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.primary.withOpacity(0.1), // Subtle tint
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: AppColors.primary.withOpacity(0.2), // Delicate border
        width: 1,
      ),
    ),
    child: Text(
      text,
      style: GoogleFonts.poppins(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 12,
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _buildGlobalReach(bool isDesktop) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(
      horizontal: isDesktop ? 100 : 24,
      vertical: isDesktop ? 60 : 0,
    ),
    padding: EdgeInsets.all(isDesktop ? 80 : 40),
    decoration: BoxDecoration(
      color: const Color(0xFFF9F9FB),
      borderRadius: BorderRadius.circular(32),
      border: Border.all(color: Colors.black.withOpacity(0.04)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildGlassBadge("OUR BASE"),
            if (isDesktop)
              Text(
                "ESTABLISHED IN MANAMA",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.black26,
                  letterSpacing: 1.5,
                ),
              ),
          ],
        ),
        const SizedBox(height: 40),

        // Content Split (SAFE FIX)
        Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          mainAxisSize: MainAxisSize.min, // 🔥 critical
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isDesktop
                ? Expanded(
                    flex: 3,
                    child: Text(
                      "Homegrown in Bahrain.\nBuilt for the World.",
                      style: GoogleFonts.instrumentSans(
                        color: Colors.black,
                        fontSize: 60,
                        fontWeight: FontWeight.w800,
                        height: 1.0,
                        letterSpacing: -2,
                      ),
                    ),
                  )
                : Text(
                    "Homegrown in Bahrain.\nBuilt for the World.",
                    style: GoogleFonts.instrumentSans(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      height: 1.0,
                      letterSpacing: -2,
                    ),
                  ),

            if (isDesktop) const SizedBox(width: 60),
            if (!isDesktop) const SizedBox(height: 20),

            isDesktop
                ? Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Strategically headquartered in Manama, we combine regional insight with world-class engineering to deliver digital solutions that scale without limits.",
                        style: GoogleFonts.poppins(
                          color: Colors.black54,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ),
                  )
                : Text(
                    "Strategically headquartered in Manama, we combine regional insight with world-class engineering to deliver digital solutions that scale without limits.",
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
          ],
        ),

        const SizedBox(height: 40),
        Divider(color: Colors.black.withOpacity(0.05)),
        const SizedBox(height: 40),

        Wrap(
          spacing: 80,
          runSpacing: 30,
          children: [
            _buildProStat("01", "CENTRAL OFFICE"),
            _buildProStat("GCC", "PRIMARY MARKET"),
            _buildProStat("100%", "LOCAL OWNERSHIP"),
            _buildProStat("INTL", "CODING STANDARDS"),
          ],
        ),
      ],
    ),
  );
}

Widget _buildProStat(String value, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: GoogleFonts.instrumentSans(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          letterSpacing: 1,
        ),
      ),
    ],
  );
}

Widget _buildPhilosophySection(bool isDesktop, Size size) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: isDesktop ? 100 : 24,
      vertical: 40,
    ),
    color: Colors.white,
    child: Flex(
      direction: isDesktop ? Axis.horizontal : Axis.vertical,
      mainAxisSize: MainAxisSize.min, // 🔥 critical fix
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. TEXT CONTENT
        isDesktop
            ? Expanded(child: _buildPhilosophyText(isDesktop))
            : _buildPhilosophyText(isDesktop),

        if (isDesktop)
          const SizedBox(width: 120)
        else
          const SizedBox(height: 60),

        // 2. IMAGE
        isDesktop
            ? Expanded(child: _buildPhilosophyImage(isDesktop))
            : _buildPhilosophyImage(isDesktop),
      ],
    ),
  );
}

Widget _buildPhilosophyText(bool isDesktop) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      _buildGlassBadge("OUR PHILOSOPHY"),
      const SizedBox(height: 24),
      Text(
        "Complexity is the enemy of progress.",
        style: GoogleFonts.instrumentSans(
          color: Colors.black,
          fontSize: isDesktop ? 54 : 36,
          fontWeight: FontWeight.w800,
          height: 1.1,
          letterSpacing: -1.5,
        ),
      ),
      const SizedBox(height: 32),
      Text(
        "We believe that the best solutions are the ones that feel invisible. Our goal is to strip away the noise and deliver digital experiences that feel like second nature to your users.",
        style: GoogleFonts.poppins(
          color: Colors.black54,
          fontSize: 18,
          height: 1.8,
        ),
      ),
    ],
  );
}

Widget _buildPhilosophyImage(bool isDesktop) {
  return Container(
    height: isDesktop ? 500 : 350,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 40,
          offset: const Offset(0, 20),
        ),
      ],
      image: const DecorationImage(
        image: AssetImage('assets/per.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

class OrganicClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // Starting from top-left
    path.lineTo(0, size.height * 0.85);

    // Creating a smooth, liquid-like curve at the bottom
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height * 0.9,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.95,
    );

    path.lineTo(size.width, 0); // Back to top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Custom Painter for the background fluid shapes
class _CustomBackgroundPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _FluidPainter());
  }
}

class _FluidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.04)
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.5,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

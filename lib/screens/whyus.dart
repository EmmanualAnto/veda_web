import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/constants.dart';
import 'package:veda_main/popupanime.dart';
import 'package:veda_main/veda_page_layout.dart';

class WhyUsPage extends StatelessWidget {
  const WhyUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return VedaPageLayout(
      child: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(painter: _WhyUsBackgroundPainter()),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 20,
                vertical: 80,
              ),
              child: Column(
                children: [
                  _hero(isDesktop),
                  const SizedBox(height: 70),

                  _stats(isDesktop),
                  const SizedBox(height: 80),

                  _features(isDesktop),
                  const SizedBox(height: 80),

                  _processSection(isDesktop),
                  const SizedBox(height: 100),

                  _ctaSection(isDesktop, context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hero(bool isDesktop) {
    return Column(
      children: [
        // Section label
        _buildGlassBadge("WHY VEDA"),
        const SizedBox(height: 14),

        // Main headline
        Text(
          "Technology That\nDrives Businesses Forward",
          textAlign: TextAlign.center,
          style: GoogleFonts.instrumentSans(
            fontSize: isDesktop ? 70 : 38,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: Colors.black, // updated to black
          ),
        ),
        const SizedBox(height: 20),

        // Supporting description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            "We design and engineer high-performance digital platforms that help businesses scale faster, operate smarter, and stay competitive.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 18 : 16,
              height: 1.6,
              color: Colors.black, // updated to black
            ),
          ),
        ),
      ],
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

  /// STATS SECTION (Animated)
  Widget _stats(bool isDesktop) {
    return RepaintBoundary(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 24),
        child: Wrap(
          spacing: isDesktop ? 80 : 40,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: [
            _buildCounter("150", "PROJECTS", "+"),
            _buildCounter("85", "CLIENTS", "%"),
            _buildCounter("24", "SUPPORT", "/7"),
            _buildCounter("99", "UPTIME", "%"),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String target, String label, String suffix) {
    final double endValue = double.tryParse(target) ?? 0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: endValue),
      duration: const Duration(milliseconds: 1500),
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
                fontSize: 50,
                fontWeight: FontWeight.w900,
                letterSpacing: -3,
                color: Colors.black,
              ),
            ),
            staticChild!,
          ],
        );
      },
    );
  }

  /// FEATURES
  Widget _features(bool isDesktop) {
    final features = [
      _Feature(
        Icons.build,
        "Custom Software",
        "Fully tailored systems built for your workflow.",
      ),
      _Feature(
        Icons.public,
        "Enterprise Standards",
        "Development following global engineering practices.",
      ),
      _Feature(
        Icons.speed,
        "Fast Development",
        "Rapid agile cycles ensuring quick delivery.",
      ),
      _Feature(
        Icons.security,
        "Security Focused",
        "Secure architecture protecting your data.",
      ),
      _Feature(
        Icons.trending_up,
        "Scalable Systems",
        "Infrastructure designed to grow with your company.",
      ),
      _Feature(
        Icons.support_agent,
        "Dedicated Support",
        "Continuous support and system improvements.",
      ),
    ];

    return Column(
      children: [
        Text(
          "Our Advantages",
          style: GoogleFonts.instrumentSans(
            fontSize: isDesktop ? 40 : 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 50),
        Wrap(
          spacing: 30,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: features
              .asMap()
              .entries
              .map(
                (entry) => FadeInOnScroll(
                  delay: Duration(milliseconds: entry.key * 100),
                  child: _featureCard(entry.value),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _featureCard(_Feature f) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black.withOpacity(.08),
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(f.icon, size: 32, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            f.title,
            style: GoogleFonts.instrumentSans(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            f.desc,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
              color: Colors.black.withOpacity(.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _processSection(bool isDesktop) {
    final steps = [
      _ProcessStep(
        "Discovery",
        "Understanding your business goals and technical requirements.",
        Icons.search,
      ),
      _ProcessStep(
        "Planning",
        "Designing architecture, selecting technologies and defining milestones.",
        Icons.architecture,
      ),
      _ProcessStep(
        "Development",
        "Agile development cycles with testing and continuous improvements.",
        Icons.code,
      ),
      _ProcessStep(
        "Launch & Support",
        "Deployment, monitoring, and long-term support for growth.",
        Icons.rocket_launch,
      ),
    ];

    return Column(
      children: [
        Text(
          "Our Process",
          style: GoogleFonts.instrumentSans(
            fontSize: isDesktop ? 40 : 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "A proven workflow that ensures quality, speed, and reliability.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black.withOpacity(.7),
          ),
        ),
        const SizedBox(height: 60),

        isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: steps.asMap().entries.map((entry) {
                  return FadeInOnScroll(
                    delay: Duration(milliseconds: entry.key * 100),
                    child: Row(
                      children: [
                        _processCard(entry.value, entry.key + 1),
                        if (entry.key != steps.length - 1)
                          Container(
                            width: 80,
                            height: 2,
                            margin: const EdgeInsets.only(bottom: 70),
                            color: AppColors.primary.withOpacity(.3),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              )
            : Column(
                children: steps.asMap().entries.map((entry) {
                  return FadeInOnScroll(
                    delay: Duration(milliseconds: entry.key * 100),
                    child: Column(
                      children: [
                        _processCard(entry.value, entry.key + 1),
                        if (entry.key != steps.length - 1)
                          Container(
                            width: 2,
                            height: 40,
                            color: AppColors.primary.withOpacity(.3),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
      ],
    );
  }

  Widget _processCard(_ProcessStep step, int number) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black.withOpacity(.08),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withOpacity(.1),
            child: Icon(step.icon, color: AppColors.primary),
          ),
          const SizedBox(height: 14),
          Text(
            "$number. ${step.title}",
            textAlign: TextAlign.center,
            style: GoogleFonts.instrumentSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              height: 1.6,
              color: Colors.black.withOpacity(.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ctaSection(bool isDesktop, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: isDesktop ? 325 : 350),
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 90 : 70,
            horizontal: isDesktop ? 60 : 30,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(.85),
                const Color(0xFF0B1736),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
        ),

        Positioned(
          top: -40,
          left: -40,
          child: Container(
            width: isDesktop ? 250 : 160,
            height: isDesktop ? 250 : 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(.08),
            ),
          ),
        ),

        Positioned(
          bottom: -50,
          right: -30,
          child: Container(
            width: isDesktop ? 300 : 200,
            height: isDesktop ? 300 : 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(.06),
            ),
          ),
        ),

        Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: isDesktop ? 320 : 260),
          padding: EdgeInsets.symmetric(
            vertical: isDesktop ? 50 : 70,
            horizontal: isDesktop ? 60 : 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ready to Build Your Next\nDigital Solution?",
                textAlign: TextAlign.center,
                style: GoogleFonts.instrumentSans(
                  color: Colors.white,
                  fontSize: isDesktop ? 36 : 26,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  "Partner with Veda to develop scalable, secure, and high-performance digital platforms tailored for your business.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 15 : 13,
                    height: 1.6,
                    color: Colors.white.withOpacity(.85),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Wrap(
                spacing: 16,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/contact-us'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        return states.contains(WidgetState.hovered)
                            ? Colors.white
                            : Colors.transparent;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        return states.contains(WidgetState.hovered)
                            ? AppColors.primary
                            : Colors.white;
                      }),
                      side: WidgetStateProperty.resolveWith<BorderSide>((
                        states,
                      ) {
                        return states.contains(WidgetState.hovered)
                            ? BorderSide.none
                            : const BorderSide(color: Colors.white, width: 2);
                      }),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    child: const Text("Start Your Project"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// FEATURE MODEL
class _Feature {
  final IconData icon;
  final String title;
  final String desc;

  _Feature(this.icon, this.title, this.desc);
}

/// BACKGROUND PAINTER
class _WhyUsBackgroundPainter extends CustomPainter {
  const _WhyUsBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final gradient = LinearGradient(
      colors: [const Color(0xfff7f9fc), const Color(0xffeef2f7)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    canvas.drawRect(rect, Paint()..shader = gradient.createShader(rect));

    final paint = Paint()..color = const Color(0xFF017697).withOpacity(.05);

    // main circles
    canvas.drawCircle(Offset(size.width * .1, size.height * .2), 180, paint);
    canvas.drawCircle(Offset(size.width * .9, size.height * .25), 140, paint);
    canvas.drawCircle(Offset(size.width * .7, size.height * .85), 200, paint);

    // subtle supporting circles
    canvas.drawCircle(Offset(size.width * .35, size.height * .45), 80, paint);
    canvas.drawCircle(Offset(size.width * .8, size.height * .55), 70, paint);
    canvas.drawCircle(Offset(size.width * .25, size.height * .75), 90, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _ProcessStep {
  final String title;
  final String desc;
  final IconData icon;

  _ProcessStep(this.title, this.desc, this.icon);
}

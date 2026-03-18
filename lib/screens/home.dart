import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/bgpainter.dart';
import 'package:veda_main/constants.dart';
import 'package:veda_main/popupanime.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/headercarousel.dart';
import 'package:veda_main/letstalk.dart';
import 'package:veda_main/stylecard.dart';
import 'package:veda_main/topbar.dart';

class VedaHomePage extends StatefulWidget {
  const VedaHomePage({super.key});

  @override
  State<VedaHomePage> createState() => _VedaHomePageState();
}

class _VedaHomePageState extends State<VedaHomePage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _fadeAnimation;
  late AnimationController _fadeController;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showScrollTopNotifier = ValueNotifier(false);
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _scrollController.addListener(() {
      final shouldShow = _scrollController.offset > 300;

      // Only trigger animation when state changes
      if (shouldShow != _showScrollTopNotifier.value) {
        _showScrollTopNotifier.value = shouldShow;

        if (shouldShow) {
          _fadeController.forward();
        } else {
          _fadeController.reverse();
        }
      }

      // Close menu only if actually open
      if (_isMenuOpen) {
        _isMenuOpen = false; // no setState needed here for full page
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _showScrollTopNotifier.dispose();
    super.dispose();
  }

  void scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;

    final box = ctx.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(
      Offset.zero,
      ancestor: context.findRenderObject(),
    );

    final offset = _scrollController.offset + pos.dy - kToolbarHeight;

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1150;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(painter: ProfessionalBackgroundPainter()),
            ),
          ),

          // 2. Scrollable Content Layer
          CustomScrollView(
            key: const PageStorageKey('veda_home_scroll'),
            controller: _scrollController,
            physics: ClampingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: kToolbarHeight)),

              // Hero & Services Section
              SliverToBoxAdapter(
                child: isDesktop
                    ? Column(
                        children: [
                          const HeaderCarousel(),
                          Transform.translate(
                            offset: const Offset(0, -75),
                            child: _buildServicesGridSection(context),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const HeaderCarousel(),
                          const SizedBox(height: 30),
                          _buildServicesGridSection(context),
                          const SizedBox(height: 30),
                        ],
                      ),
              ),

              // Main Content Sections
              SliverToBoxAdapter(child: _buildAboutUsSection(context)),
              SliverToBoxAdapter(child: _buildOurServicesSection(context)),
              SliverToBoxAdapter(child: _buildWhyVedaSection(context)),

              // Form Section with Bottom Inset Support
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const LetsTalkSection(),
                ),
              ),

              const SliverToBoxAdapter(child: Footer()),
            ],
          ),

          // 3. Navigation Layer (Always Top)
          Align(
            alignment: Alignment.topCenter,
            child: ReusableMenu(
              menuRoutes: {
                'Home': '/',
                'About': '/about',
                'Services': '/services',
                if (screenWidth > 800) 'Contact': '/contact-us',
              },
            ),
          ),

          Positioned(
            bottom: 30,
            right: 30,
            child: ValueListenableBuilder<bool>(
              valueListenable: _showScrollTopNotifier,
              builder: (context, show, child) {
                return show
                    ? FadeTransition(
                        opacity: _fadeAnimation,
                        child: GestureDetector(
                          onTap: _scrollToTop,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2,
                              ),
                              color: Colors.transparent,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_upward,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildServicesGridSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 800) {
    // Mobile: single column
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Mobile
          RepaintBoundary(
            child: FadeInOnScroll(
              playOnce: true,
              key: const ValueKey('services_1'),
              delay: const Duration(milliseconds: 0),
              child: _buildServiceItem(
                context,
                'Web Applications',
                'We build modern, responsive, and user-friendly web apps tailored to your business needs.',
                Icons.web,
              ),
            ),
          ),
          const SizedBox(height: 20),
          RepaintBoundary(
            child: FadeInOnScroll(
              playOnce: true,
              key: const ValueKey('services_2'),
              delay: const Duration(milliseconds: 50),
              child: _buildServiceItem(
                context,
                'Software Applications',
                'Custom software solutions designed to improve efficiency and streamline your business.',
                Icons.apps,
              ),
            ),
          ),
          const SizedBox(height: 20),
          RepaintBoundary(
            child: FadeInOnScroll(
              playOnce: true,
              key: const ValueKey('services_3'),
              delay: const Duration(milliseconds: 100),
              child: _buildServiceItem(
                context,
                'Hardware & Networking',
                'Reliable hardware setup and networking solutions to keep your systems connected and secure.',
                Icons.settings_input_hdmi,
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    // Medium & Desktop: Wrap for responsive layout
    double cardWidth = 370;
    if (screenWidth >= 600 && screenWidth < 1200) {
      cardWidth = (screenWidth / 2) - 30;
      if (cardWidth > 370) cardWidth = 370;
    }

    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          // Desktop (same ids)
          RepaintBoundary(
            child: FadeInOnScroll(
              playOnce: true,
              key: const ValueKey('services_4'),
              delay: const Duration(milliseconds: 0),
              child: _buildServiceItem(
                context,
                'Web Applications',
                'We build modern, responsive, and user-friendly web apps tailored to your business needs.',
                Icons.web,
                width: cardWidth,
              ),
            ),
          ),
          RepaintBoundary(
            child: FadeInOnScroll(
              playOnce: true,
              key: const ValueKey('services_5'),
              delay: const Duration(milliseconds: 50),
              child: _buildServiceItem(
                context,
                'Software Applications',
                'Custom software solutions designed to improve efficiency and streamline your business.',
                Icons.apps,
                width: cardWidth,
              ),
            ),
          ),
          RepaintBoundary(
            child: FadeInOnScroll(
              playOnce: true,
              key: const ValueKey('services_6'),
              delay: const Duration(milliseconds: 100),
              child: _buildServiceItem(
                context,
                'Hardware & Networking',
                'Reliable hardware setup and networking solutions to keep your systems connected and secure.',
                Icons.settings_input_hdmi,
                width: cardWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildServiceItem(
  BuildContext context,
  String title,
  String description,
  IconData icon, {
  double width = 370,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final bool isMobile = screenWidth < 800;

  bool isHovered = false; // the ONLY hover variable

  return StatefulBuilder(
    builder: (context, setState) {
      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),

        child: SizedBox(
          // Full hit-test area
          width: width,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 12),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border(
                top: BorderSide(color: AppColors.primary, width: 0.6),
                right: BorderSide(color: AppColors.primary, width: 0.6),
                bottom: BorderSide(color: AppColors.primary, width: 8),
                left: BorderSide(color: AppColors.primary, width: 0.6),
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.30),
                        offset: const Offset(0, 6),
                        blurRadius: 14,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isHovered ? AppColors.primary : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: isHovered ? Colors.white : AppColors.primary,
                    size: 30,
                  ),
                ),

                SizedBox(width: screenWidth > 600 ? 8 : 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.serviceTitle(isMobile: isMobile),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: AppTextStyles.servicedescription(
                          isMobile: isMobile,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildAboutUsSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final desktop = screenWidth >= 800;
  final isMobile = screenWidth < 800;
  return LayoutBuilder(
    builder: (context, constraints) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(30, 0, 30, desktop ? 50 : 20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1300, // ✅ keeps content from being too wide
          ),
          child: Wrap(
            spacing: 30, // space between image and text horizontally
            runSpacing: 20, // space vertically when wrapped
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width: 600,
                height: desktop ? 400 : 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset('assets/2.webp', fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 650,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: desktop ? 20 : 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '// ',
                            style: AppTextStyles.slash(isMobile: isMobile),
                          ),
                          TextSpan(
                            text: 'About Us',
                            style: AppTextStyles.slashTitle(isMobile: isMobile),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Where Experience Meets',
                            style: GoogleFonts.instrumentSans(
                              fontSize: desktop ? 46 : 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '\nInnovation',
                            style: GoogleFonts.instrumentSans(
                              color: AppColors.primary,
                              fontSize: desktop ? 46 : 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'We are a technology-driven team passionate about transforming ideas into impactful solutions. Our expertise spans software development, web applications, and IT infrastructure management, helping clients stay ahead in a fast-evolving digital world.',
                      style: GoogleFonts.poppins(
                        fontSize: desktop ? 16 : 14,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.justify,
                      'With years of experience and a commitment to innovation, we focus on delivering scalable, user-friendly, and future-ready solutions that empower businesses to grow confidently.',
                      style: GoogleFonts.poppins(
                        fontSize: desktop ? 16 : 14,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildOurServicesSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final desktop = screenWidth > 800;

  return LayoutBuilder(
    builder: (context, constraints) {
      double contentWidth = constraints.maxWidth > 1200
          ? 1140
          : constraints.maxWidth * 0.9;

      return Container(
        width: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(
          desktop ? 130 : 30,
          10,
          desktop ? 130 : 30,
          desktop ? 20 : 30,
        ),
        child: SizedBox(
          width: contentWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // ✅ keep left aligned
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '// ',
                      style: GoogleFonts.instrumentSans(
                        color: AppColors.primary,
                        fontSize: desktop ? 25 : 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: 'Our Services',
                      style: GoogleFonts.instrumentSans(
                        fontSize: desktop ? 22 : 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Smart Tech Services\n',
                      style: GoogleFonts.instrumentSans(
                        fontSize: desktop ? 46 : 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'That Drive Results',
                      style: GoogleFonts.instrumentSans(
                        color: AppColors.primary,
                        fontSize: desktop ? 46 : 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        playOnce: true,
                        key: const ValueKey('services_7'),
                        delay: const Duration(
                          milliseconds: 0,
                        ), // shows immediately
                        child: StyledCardSection(
                          pageKey: 'web_page',
                          cardIndex: 0,
                          imagePath: 'assets/3.webp',
                          title: 'Web Application',
                          description:
                              'We design and develop powerful web applications with user-friendly interfaces and robust functionality. From business portals to custom platforms, our solutions are secure, scalable, and optimized to help your business grow online.',
                          onTap: () => context.go('/webapp'),
                          showLearnMore: true,
                        ),
                      ),
                    ),
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        playOnce: true,
                        key: const ValueKey('services_8'),
                        delay: const Duration(
                          milliseconds: 50,
                        ), // second comes later

                        child: StyledCardSection(
                          pageKey: 'sftwr_page',
                          cardIndex: 1,
                          imagePath: 'assets/4.webp',
                          title: 'Software Applications',
                          description:
                              'Our software solutions are tailored to meet the unique needs of your business. From desktop applications to enterprise-level systems, we deliver reliable, efficient, and scalable software that streamlines processes and drives productivity.',
                          onTap: () => context.go('/software'),
                          showLearnMore: true,
                        ),
                      ),
                    ),
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        playOnce: true,
                        key: const ValueKey('services_9'),
                        delay: const Duration(
                          milliseconds: 100,
                        ), // third comes last

                        child: StyledCardSection(
                          pageKey: 'hrdwr_page',
                          cardIndex: 2,
                          imagePath: 'assets/5.webp',
                          title: 'Hardware & Networking',
                          description:
                              'We provide end-to-end hardware and networking services, from installation to maintenance. Our team ensures that your IT infrastructure is fast, secure, and dependable, helping your business stay connected without downtime.',
                          onTap: () => context.go('/hardware'),
                          showLearnMore: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildWhyVedaSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final desktop = screenWidth > 800;

  return Container(
    padding: EdgeInsets.symmetric(vertical: desktop ? 40 : 20, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '// ',
                style: GoogleFonts.instrumentSans(
                  color: AppColors.primary,
                  fontSize: desktop ? 25 : 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                text: 'Why Veda',
                style: GoogleFonts.instrumentSans(
                  fontSize: desktop ? 22 : 16,
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
                  fontSize: desktop ? 46 : 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'Stay With Us',
                style: GoogleFonts.instrumentSans(
                  fontSize: desktop ? 46 : 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),

        // 🔥 Responsive layout
        !desktop
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RepaintBoundary(
                    child: FadeInOnScroll(
                      playOnce: true,
                      key: const ValueKey('services_10'),
                      delay: const Duration(milliseconds: 0),
                      child: _buildReasonItem(
                        '100%\nCustom Solutions',
                        'Tailored software, not templates. Built to match your business model.',
                        Icons.construction,
                        context,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomPaint(size: const Size(1, 60)),
                  ),
                  RepaintBoundary(
                    child: FadeInOnScroll(
                      playOnce: true,
                      key: const ValueKey('services_11'),
                      delay: const Duration(milliseconds: 50),

                      child: _buildReasonItem(
                        'Local Support,\nGlobal Standards',
                        'Serving Bahrain-based enterprises with ISO-grade quality.',
                        Icons.public,
                        context,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomPaint(size: const Size(1, 60)),
                  ),
                  RepaintBoundary(
                    child: FadeInOnScroll(
                      playOnce: true,
                      key: const ValueKey('services_12'),
                      delay: const Duration(milliseconds: 100),
                      child: _buildReasonItem(
                        'Fast\nTurnaround',
                        'Rapid development cycles with clear timelines and zero guesswork.',
                        Icons.speed,
                        context,
                      ),
                    ),
                  ),
                ],
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        playOnce: true,
                        key: const ValueKey('services_13'),
                        delay: const Duration(milliseconds: 0),
                        child: _buildReasonItem(
                          '100%\nCustom Solutions',
                          'Tailored software, not templates. Built to match your business model.',
                          Icons.construction,
                          context,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: CustomPaint(
                        size: const Size(100, 1),
                        painter: _DottedLinePainter(),
                      ),
                    ),
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        playOnce: true,
                        key: const ValueKey('services_14'),

                        child: _buildReasonItem(
                          'Local Support,\nGlobal Standards',
                          'Serving Bahrain-based enterprises with ISO-grade quality.',
                          Icons.public,
                          context,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: CustomPaint(
                        size: const Size(100, 1),
                        painter: _DottedLinePainter(),
                      ),
                    ),
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        playOnce: true,
                        key: const ValueKey('services_15'),
                        delay: const Duration(milliseconds: 100),
                        child: _buildReasonItem(
                          'Fast\nTurnaround',
                          'Rapid development cycles with clear timelines and zero guesswork.',
                          Icons.speed,
                          context,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    ),
  );
}

// Your existing _buildReasonItem widget
Widget _buildReasonItem(
  String title,
  String description,
  IconData icon,
  BuildContext context,
) {
  final screenWidth = MediaQuery.of(context).size.width;
  final desktop = screenWidth > 800;
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
              fontSize: desktop ? 22 : 20,
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
            fontSize: desktop ? 15 : 13,
            color: Colors.black.withOpacity(0.8),
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade800
      ..strokeWidth = 2;

    const dashWidth = 4;
    const dashSpace = 4;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

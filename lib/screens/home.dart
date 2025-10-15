import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/constants.dart';
import 'package:veda_main/popupanime.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/headercarousel.dart';
import 'package:veda_main/letstalk.dart';
import 'package:veda_main/topbar.dart';

class VedaHomePage extends StatefulWidget {
  const VedaHomePage({super.key});

  @override
  State<VedaHomePage> createState() => _VedaHomePageState();
}

class _VedaHomePageState extends State<VedaHomePage>
    with SingleTickerProviderStateMixin {
  // ✅ add this mixin
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this, // ✅ works now
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _scrollController.addListener(() {
      if (_scrollController.offset > 300) {
        _fadeController.forward();
      } else {
        _fadeController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1150;

    // GlobalKeys for smooth scrolling
    final GlobalKey aboutKey = GlobalKey();
    final GlobalKey servicesKey = GlobalKey();
    final GlobalKey contactKey = GlobalKey();

    return Scaffold(
      resizeToAvoidBottomInset: true, // 👈 important
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // TopBar
              SliverToBoxAdapter(
                child: TopBar(
                  isMenuOpen: _isMenuOpen, // ← IMPORTANT: pass the state here
                  onMenuPressed: () =>
                      setState(() => _isMenuOpen = !_isMenuOpen),
                  onMenuItemPressed: (title) {
                    setState(() => _isMenuOpen = false);
                    switch (title) {
                      case 'Home':
                        _scrollToTop();
                        break;
                      case 'About':
                        if (aboutKey.currentContext != null)
                          scrollToSection(aboutKey);
                        break;
                      case 'Services':
                        if (servicesKey.currentContext != null)
                          scrollToSection(servicesKey);
                        break;
                      case 'Contact':
                        scrollToSection(contactKey);
                        break;
                    }
                  },
                ),
              ),

              // Header + Services Grid
              SliverToBoxAdapter(
                child: isDesktop
                    ? Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const HeaderCarousel(),
                          Positioned(
                            bottom: -75,
                            left: 0,
                            right: 0,
                            child: _buildServicesGridSection(context),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const HeaderCarousel(),
                          const SizedBox(height: 40),
                          _buildServicesGridSection(context),
                        ],
                      ),
              ),

              // Spacer
              SliverToBoxAdapter(child: SizedBox(height: isDesktop ? 100 : 40)),

              // Sections with keys
              SliverToBoxAdapter(
                child: Container(
                  key: aboutKey,
                  child: _buildAboutUsSection(context),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  key: servicesKey,
                  child: _buildOurServicesSection(context),
                ),
              ),
              SliverToBoxAdapter(child: _buildWhyVedaSection(context)),
              SliverToBoxAdapter(
                child: Container(
                  key: contactKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const LetsTalkSection(),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: Footer()),
            ],
          ), // Sliding top menu
          AnimatedSlide(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            offset: _isMenuOpen ? Offset(0, 0) : const Offset(0, -1),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              opacity: _isMenuOpen ? 1.0 : 0.0,
              child: Container(
                margin: const EdgeInsets.only(top: kToolbarHeight),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _menuButton('Home', () {
                      setState(() => _isMenuOpen = false);
                      _scrollToTop();
                    }),
                    _menuButton('About', () {
                      setState(() => _isMenuOpen = false);
                      scrollToSection(aboutKey);
                    }),
                    _menuButton('Services', () {
                      setState(() => _isMenuOpen = false);
                      scrollToSection(servicesKey);
                    }),
                    _menuButton('Contact', () {
                      setState(() => _isMenuOpen = false);
                      scrollToSection(contactKey);
                    }),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            right: 30,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF0035FF),
                      width: 2,
                    ),
                    color: Colors.transparent,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_upward,
                      color: Color(0xFF0035FF),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(String title, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
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
              child: PopupOnScroll(
                onceId: 'grid_web',
                triggerFraction: 0.4,

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
              child: PopupOnScroll(
                onceId: 'grid_software',
                triggerFraction: 0.4,

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
              child: PopupOnScroll(
                onceId: 'grid_hardware',
                triggerFraction: 0.4,

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
              child: PopupOnScroll(
                onceId: 'grid_web',
                triggerFraction: 0.4,

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
              child: PopupOnScroll(
                onceId: 'grid_software',
                triggerFraction: 0.4,

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
              child: PopupOnScroll(
                onceId: 'grid_hardware',
                triggerFraction: 0.4,

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
    bool isMobile = screenWidth < 800;

    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          top: BorderSide(color: const Color(0xFF0035FF), width: 0.6),
          right: BorderSide(color: const Color(0xFF0035FF), width: 0.6),
          bottom: BorderSide(color: const Color(0xFF0035FF), width: 8),
          left: BorderSide(color: const Color(0xFF0035FF), width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue.shade800, size: 30),
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
                  textAlign: TextAlign.justify,
                  description,
                  style: AppTextStyles.servicedescription(isMobile: isMobile),
                ),
              ],
            ),
          ),
        ],
      ),
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
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 80),
          child: Center(
            // ✅ Center content horizontally
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1300, // ✅ keeps content from being too wide
              ),
              child: Wrap(
                spacing: 30, // space between image and text horizontally
                runSpacing: 20, // space vertically when wrapped
                alignment:
                    WrapAlignment.center, // ✅ centers children inside wrap
                children: [
                  SizedBox(
                    width: 600,
                    height: desktop ? 400 : 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        gaplessPlayback: true,
                        'assets/2.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 650,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: desktop ? 60 : 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '// ',
                                style: AppTextStyles.slash(isMobile: isMobile),
                              ),
                              TextSpan(
                                text: 'About Us',
                                style: AppTextStyles.slashTitle(
                                  isMobile: isMobile,
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
                                text: 'Where Experience Meets',
                                style: GoogleFonts.instrumentSans(
                                  fontSize: desktop ? 46 : 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: '\nInnovation',
                                style: GoogleFonts.instrumentSans(
                                  color: const Color(0xFF0035FF),
                                  fontSize: desktop ? 46 : 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi molestie aliquam odio aliquam pharetra tortor venenatis pulvinar proin.',
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
                          'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi molestie aliquam odio aliquam pharetra',
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
          color: Colors.grey.shade100,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: desktop ? 25 : 20,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: desktop ? 120 : 10,
            ),
            child: SizedBox(
              width: contentWidth,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // ✅ keep left aligned
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '// ',
                          style: GoogleFonts.instrumentSans(
                            color: const Color(0xFF0035FF),
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
                            color: const Color(0xFF0035FF),
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
                          child: PopupOnScroll(
                            onceId: 'web',
                            triggerFraction: 0.45,
                            delay: const Duration(
                              milliseconds: 0,
                            ), // shows immediately
                            child: _buildServiceCard(
                              'assets/3.webp',
                              'Web\nApplication',
                              'We design and develop powerful web applications with user-friendly interfaces and robust functionality. From business portals to custom platforms, our solutions are secure, scalable, and optimized to help your business grow online.',
                              context,
                              onPressed: () {
                                context.push('/webpage');
                              },
                            ),
                          ),
                        ),
                        RepaintBoundary(
                          child: PopupOnScroll(
                            onceId: 'sftwr',
                            triggerFraction: 0.45,
                            delay: const Duration(
                              milliseconds: 50,
                            ), // second comes later

                            child: _buildServiceCard(
                              'assets/4.webp',
                              'Software\nApplications',
                              'Our software solutions are tailored to meet the unique needs of your business. From desktop applications to enterprise-level systems, we deliver reliable, efficient, and scalable software that streamlines processes and drives productivity.',
                              context,
                              onPressed: () {
                                context.push('/softwarepage');
                              },
                            ),
                          ),
                        ),
                        RepaintBoundary(
                          child: PopupOnScroll(
                            onceId: 'hrdwr',
                            triggerFraction: 0.45,

                            delay: const Duration(
                              milliseconds: 100,
                            ), // third comes last

                            child: _buildServiceCard(
                              'assets/5.webp',
                              'Hardware &\nNetworking',
                              'We provide end-to-end hardware and networking services, from installation to maintenance. Our team ensures that your IT infrastructure is fast, secure, and dependable, helping your business stay connected without downtime.',
                              context,
                              onPressed: () {
                                context.push('/hardwarepage');
                              },
                            ),
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

  Widget _buildServiceCard(
    String imagePath,
    String title,
    String description,
    BuildContext context, {
    required VoidCallback onPressed,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Container(
      width: desktop ? 400 : 350, // keep width fixed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          bottom: BorderSide(color: Color(0xFF0035FF), width: 8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                gaplessPlayback: true,
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            // Title
            Text(
              title,
              style: GoogleFonts.instrumentSans(
                fontSize: desktop ? 22 : 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            // Description
            Text(
              textAlign: TextAlign.justify,
              description,
              style: GoogleFonts.poppins(
                fontSize: desktop ? 15 : 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16), // instead of Spacer
            // Button
            TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF0035FF),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Learn More',
                    style: GoogleFonts.instrumentSans(
                      fontSize: desktop ? 18 : 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_forward, size: desktop ? 24 : 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhyVedaSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Container(
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
                    color: Color(0xFF0035FF),
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
                      child: PopupOnScroll(
                        onceId: '100%',
                        triggerFraction: 0.6,

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
                      child: PopupOnScroll(
                        onceId: 'lclsprt',
                        triggerFraction: 0.6,

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
                      child: PopupOnScroll(
                        onceId: 'fst',
                        triggerFraction: 0.6,

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
                        child: PopupOnScroll(
                          onceId: '100%',
                          triggerFraction: 0.6,

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
                        child: PopupOnScroll(
                          onceId: 'lclsprt',
                          triggerFraction: 0.6,

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
                        padding: const EdgeInsets.only(top: 25),
                        child: CustomPaint(
                          size: const Size(100, 1),
                          painter: _DottedLinePainter(),
                        ),
                      ),
                      RepaintBoundary(
                        child: PopupOnScroll(
                          onceId: 'fst',
                          triggerFraction: 0.6,

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

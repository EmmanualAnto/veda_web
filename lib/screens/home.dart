import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/fadeInanime.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/screens/hardwareandnetworkingpg.dart';
import 'package:veda_main/letstalk.dart';
import 'package:veda_main/screens/softwarepg.dart';
import 'package:veda_main/topbar.dart';
import 'package:veda_main/screens/webapppg.dart';

class VedaHomePage extends StatefulWidget {
  const VedaHomePage({super.key});

  @override
  State<VedaHomePage> createState() => _VedaHomePageState();
}

class _VedaHomePageState extends State<VedaHomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 300 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
      } else if (_scrollController.offset <= 300 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

    // GlobalKeys for smooth scrolling
    final GlobalKey aboutKey = GlobalKey();
    final GlobalKey servicesKey = GlobalKey();
    final GlobalKey contactKey = GlobalKey();

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // TopBar with callback for menu taps
                TopBar(
                  onMenuItemPressed: (title) {
                    switch (title) {
                      case 'Home':
                        _scrollToTop();
                        break;
                      case 'About':
                        // Only scroll if key exists
                        if (aboutKey.currentContext != null) {
                          scrollToSection(aboutKey);
                        }
                        break;
                      case 'Services':
                        if (servicesKey.currentContext != null) {
                          scrollToSection(servicesKey);
                        }
                        break;
                      case 'Contact':
                        scrollToSection(contactKey);
                        break;
                    }
                  },
                ),

                if (isDesktop)
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _buildHeaderSection(context),
                      Positioned(
                        bottom: -75,
                        left: 0,
                        right: 0,
                        child: _buildServicesGridSection(context),
                      ),
                    ],
                  )
                else ...[
                  _buildHeaderSection(context),
                  const SizedBox(height: 40),
                  _buildServicesGridSection(context),
                ],

                SizedBox(height: isDesktop ? 100 : 40),

                // Sections with keys for smooth scrolling
                Container(key: aboutKey, child: _buildAboutUsSection(context)),
                Container(
                  key: servicesKey,
                  child: _buildOurServicesSection(context),
                ),
                Container(child: _buildWhyVedaSection(context)),

                Container(key: contactKey, child: const LetsTalkSection()),
                Footer(),
              ],
            ),
          ),

          // Scroll-to-top button
          Positioned(
            bottom: 30,
            right: 30,
            child: AnimatedOpacity(
              opacity: _showScrollToTop ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 400),
              child: IgnorePointer(
                ignoring: !_showScrollToTop,
                child: GestureDetector(
                  onTap: _scrollToTop,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade700, width: 2),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.grey.shade700,
                        size: 24,
                      ),
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

  Widget _buildHeaderSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        return SizedBox(
          width: double.infinity,
          height: 810,
          child: Stack(
            children: [
              // Background image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Gradient overlay
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(3, 9, 35, 0.879),
                      Color.fromRGBO(3, 9, 35, 0.867),
                      Color.fromRGBO(3, 9, 35, 0.85),
                      Color.fromRGBO(3, 9, 35, 0.67),
                      Color.fromRGBO(3, 9, 35, 0.6),
                    ],
                    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 5 : 120,
                  vertical: isMobile
                      ? 0
                      : 170, // remove vertical padding on mobile
                ),
                child: Align(
                  alignment: isMobile ? Alignment.center : Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // makes it shrink-wrap
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      // Title
                      RichText(
                        textAlign: isMobile
                            ? TextAlign.center
                            : TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '// ',
                              style: TextStyle(
                                color: const Color(0xFF0035FF),
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: 'Powering Innovation Through Technology',
                              style: GoogleFonts.instrumentSans(
                                color: Colors.white,
                                fontSize: isMobile ? 16 : 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: isMobile ? 20 : 15),

                      // Heading
                      Text(
                        'Future-Ready Software & Tech\nSolutions for Modern Businesses',
                        textAlign: isMobile
                            ? TextAlign.center
                            : TextAlign.start,
                        style: GoogleFonts.instrumentSans(
                          color: Colors.white,
                          fontSize: isMobile ? 26 : 46,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: isMobile ? 40 : 25),

                      // Subtitle
                      Text(
                        'Tailored software, powerful platforms, and reliable IT infrastructure everything your\nbusiness needs to scale, seamlessly.',
                        textAlign: isMobile
                            ? TextAlign.center
                            : TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: isMobile ? 14 : 20,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: isMobile ? 45 : 35),

                      // Buttons
                      isMobile
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildPrimaryButton(),
                                const SizedBox(height: 15),
                                _buildSecondaryButton(),
                              ],
                            )
                          : Row(
                              children: [
                                _buildPrimaryButton(),
                                const SizedBox(width: 15),
                                _buildSecondaryButton(),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrimaryButton() => ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        return states.contains(WidgetState.hovered)
            ? Colors.white
            : const Color(0xFF0035FF);
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        return states.contains(WidgetState.hovered)
            ? Colors.black
            : Colors.white;
      }),
      side: WidgetStateProperty.resolveWith<BorderSide>((states) {
        return BorderSide(
          color: states.contains(WidgetState.hovered)
              ? Colors.black
              : Colors.transparent,
        );
      }),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      elevation: WidgetStateProperty.all(0),
      minimumSize: WidgetStateProperty.all(const Size(205, 54)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Contact Now',
          style: GoogleFonts.instrumentSans(
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward, size: 24),
      ],
    ),
  );

  Widget _buildSecondaryButton() => OutlinedButton(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return states.contains(WidgetState.hovered)
            ? Colors.white
            : Colors.transparent;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        return states.contains(WidgetState.hovered)
            ? Colors.black
            : Colors.white;
      }),
      side: WidgetStateProperty.resolveWith<BorderSide>((states) {
        return BorderSide(
          color: states.contains(WidgetState.hovered)
              ? Colors.black
              : Colors.white,
        );
      }),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      minimumSize: WidgetStateProperty.all(const Size(205, 54)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Explore more',
          style: GoogleFonts.instrumentSans(
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.arrow_forward, size: 24), // inherits foregroundColor
      ],
    ),
  );

  Widget _buildServicesGridSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 800) {
      // Mobile: single column
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Mobile
            FadeInUpOnScroll(
              onceId: 'grid_web',
              triggerFraction: 0.4,
              offsetY: 100,
              delay: const Duration(milliseconds: 0),
              child: _buildServiceItem(
                context,
                'Web Applications',
                'Lorem ipsum...',
                Icons.web,
              ),
            ),
            const SizedBox(height: 20),
            FadeInUpOnScroll(
              onceId: 'grid_software',
              triggerFraction: 0.4,
              offsetY: 100,
              delay: const Duration(milliseconds: 200),
              child: _buildServiceItem(
                context,
                'Software Applications',
                'Lorem ipsum...',
                Icons.apps,
              ),
            ),
            const SizedBox(height: 20),
            FadeInUpOnScroll(
              onceId: 'grid_hardware',
              triggerFraction: 0.4,
              offsetY: 100,
              delay: const Duration(milliseconds: 400),
              child: _buildServiceItem(
                context,
                'Hardware & Networking',
                'Lorem ipsum...',
                Icons.settings_input_hdmi,
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
            FadeInUpOnScroll(
              onceId: 'grid_web',
              triggerFraction: 0.4,
              offsetY: 100,
              delay: const Duration(milliseconds: 0),
              child: _buildServiceItem(
                context,
                'Web Applications',
                'Lorem ipsum...',
                Icons.web,
                width: cardWidth,
              ),
            ),
            FadeInUpOnScroll(
              onceId: 'grid_software',
              triggerFraction: 0.4,
              offsetY: 100,
              delay: const Duration(milliseconds: 200),
              child: _buildServiceItem(
                context,
                'Software Applications',
                'Lorem ipsum...',
                Icons.apps,
                width: cardWidth,
              ),
            ),
            FadeInUpOnScroll(
              onceId: 'grid_hardware',
              triggerFraction: 0.4,
              offsetY: 100,
              delay: const Duration(milliseconds: 400),
              child: _buildServiceItem(
                context,
                'Hardware & Networking',
                'Lorem ipsum...',
                Icons.settings_input_hdmi,
                width: cardWidth,
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

    return Container(
      width: width,
      height: 130,
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
                  style: GoogleFonts.instrumentSans(
                    fontSize: screenWidth > 600 ? 22 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description, style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;
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
                        'assets/2.png',
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
                                style: GoogleFonts.instrumentSans(
                                  color: const Color(0xFF0035FF),
                                  fontSize: desktop ? 25 : 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: 'About Us',
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

                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      FadeInUpOnScroll(
                        onceId: 'web',
                        triggerFraction: 0.5,
                        offsetY: 100,
                        delay: const Duration(
                          milliseconds: 0,
                        ), // first appears immediately
                        child: _buildServiceCard(
                          'assets/3.png',
                          'Web\nApplication',
                          'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
                          context,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Webapppg(),
                              ),
                            );
                          },
                        ),
                      ),
                      FadeInUpOnScroll(
                        onceId: 'sftwr',
                        triggerFraction: 0.5,
                        offsetY: 100,
                        delay: const Duration(
                          milliseconds: 200,
                        ), // second comes later

                        child: _buildServiceCard(
                          'assets/4.png',
                          'Software\nApplications',
                          'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
                          context,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Softwarepg(),
                              ),
                            );
                          },
                        ),
                      ),
                      FadeInUpOnScroll(
                        onceId: 'hrdwr',
                        triggerFraction: 0.5,
                        offsetY: 100,
                        delay: const Duration(
                          milliseconds: 400,
                        ), // third comes last

                        child: _buildServiceCard(
                          'assets/5.png',
                          'Hardware &\nNetworking',
                          'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
                          context,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Hardwareandnetworkingpg(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
    required VoidCallback onPressed, // 👈 add callback
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return SizedBox(
      width: desktop ? 400 : 350,
      height: desktop ? 460 : 430,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border(
            bottom: BorderSide(color: const Color(0xFF0035FF), width: 8),
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
                description,
                style: GoogleFonts.poppins(
                  fontSize: desktop ? 14 : 12,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              // Button
              TextButton(
                onPressed: onPressed, // 👈 use callback
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
                    FadeInUpOnScroll(
                      onceId: '100%',
                      triggerFraction: 0.6,
                      offsetY: 100,
                      delay: const Duration(milliseconds: 0),
                      child: _buildReasonItem(
                        '100%\nCustom Solutions',
                        'Tailored software, not templates. Built to match your business model.',
                        Icons.construction,
                        context,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomPaint(size: const Size(1, 60)),
                    ),
                    FadeInUpOnScroll(
                      onceId: 'lclsprt',
                      triggerFraction: 0.6,
                      offsetY: 100,
                      delay: const Duration(milliseconds: 200),

                      child: _buildReasonItem(
                        'Local Support,\nGlobal Standards',
                        'Serving Bohrdin-based enterprises with ISO-grade quality.',
                        Icons.public,
                        context,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomPaint(size: const Size(1, 60)),
                    ),
                    FadeInUpOnScroll(
                      onceId: 'fst',
                      triggerFraction: 0.6,
                      offsetY: 100,
                      delay: const Duration(milliseconds: 400),
                      child: _buildReasonItem(
                        'Fast\nTurnaround',
                        'Rapid development cycles with clear timelines and zero guesswork.',
                        Icons.speed,
                        context,
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
                      FadeInUpOnScroll(
                        onceId: '100%',
                        triggerFraction: 0.6,
                        offsetY: 100,
                        delay: const Duration(milliseconds: 0),
                        child: _buildReasonItem(
                          '100%\nCustom Solutions',
                          'Tailored software, not templates. Built to match your business model.',
                          Icons.construction,
                          context,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: CustomPaint(
                          size: const Size(100, 1),
                          painter: _DottedLinePainter(),
                        ),
                      ),
                      FadeInUpOnScroll(
                        onceId: 'lclsprt',
                        triggerFraction: 0.6,
                        offsetY: 100,
                        delay: const Duration(milliseconds: 200),
                        child: _buildReasonItem(
                          'Local Support,\nGlobal Standards',
                          'Serving Bahrain-based enterprises with ISO-grade quality.',
                          Icons.public,
                          context,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: CustomPaint(
                          size: const Size(100, 1),
                          painter: _DottedLinePainter(),
                        ),
                      ),
                      FadeInUpOnScroll(
                        onceId: 'fst',
                        triggerFraction: 0.6,
                        offsetY: 100,
                        delay: const Duration(milliseconds: 400),
                        child: _buildReasonItem(
                          'Fast\nTurnaround',
                          'Rapid development cycles with clear timelines and zero guesswork.',
                          Icons.speed,
                          context,
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
              fontSize: desktop ? 14 : 12,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/footer.dart';

class VedaHomePage extends StatelessWidget {
  const VedaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final isDesktop = screenWidth >= 1150;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildtopbarSection(),

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

            _buildAboutUsSection(context),
            _buildOurServicesSection(context),
            _buildWhyVedaSection(context),
            _buildLetsTalkSection(context),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildtopbarSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left-side logo
          Image.asset(
            'logonew.png', // Your Veda logo
            height: 50,
            width: 150,
          ),

          // Right-side buttons
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Home',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'About',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Services',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Contact',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
            ],
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
          height: 800,
          child: Stack(
            children: [
              // Background image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('1.png'),
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

  // Keeping your same button styles
  Widget _buildPrimaryButton() => ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (states) => states.contains(WidgetState.hovered)
            ? Colors.transparent
            : const Color(0xFF0035FF),
      ),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      side: WidgetStateProperty.resolveWith<BorderSide>(
        (states) => states.contains(WidgetState.hovered)
            ? const BorderSide(color: Colors.white, width: 2)
            : BorderSide.none,
      ),
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
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) => states.contains(WidgetState.hovered)
            ? const Color(0xFF0035FF)
            : Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      side: WidgetStateProperty.resolveWith<BorderSide>(
        (states) => states.contains(WidgetState.hovered)
            ? BorderSide.none
            : const BorderSide(color: Colors.white),
      ),
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
        const Icon(Icons.arrow_forward, size: 24),
      ],
    ),
  );

  Widget _buildServicesGridSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 700) {
      // Mobile: single column
      return Column(
        children: [
          _buildServiceItem(
            context,
            'Web Applications',
            'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
            Icons.web,
          ),
          const SizedBox(height: 20),
          _buildServiceItem(
            context,
            'Software Applications',
            'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
            Icons.apps,
          ),
          const SizedBox(height: 20),
          _buildServiceItem(
            context,
            'Hardware & Networking',
            'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
            Icons.settings_input_hdmi,
          ),
        ],
      );
    } else {
      // Medium & Desktop: use Wrap for responsive layout
      double cardWidth = 370;
      if (screenWidth >= 600 && screenWidth < 1200) {
        // Medium screens: max 2 cards per row
        cardWidth = (screenWidth / 2) - 30;
        if (cardWidth > 370) cardWidth = 370; // max width
      }

      return Center(
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _buildServiceItem(
              context,
              'Web Applications',
              'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
              Icons.web,
              width: cardWidth,
            ),
            _buildServiceItem(
              context,
              'Software Applications',
              'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
              Icons.apps,
              width: cardWidth,
            ),
            _buildServiceItem(
              context,
              'Hardware & Networking',
              'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
              Icons.settings_input_hdmi,
              width: cardWidth,
            ),
          ],
        ),
      );
    }
  }

  // Update _buildServiceItem to accept width
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
                      child: Image.asset('2.png', fit: BoxFit.cover),
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
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: '\nInnovation',
                                style: GoogleFonts.instrumentSans(
                                  color: const Color(0xFF0035FF),
                                  fontSize: desktop ? 46 : 26,
                                  fontWeight: FontWeight.w800,
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
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: 'That Drive Results',
                          style: GoogleFonts.instrumentSans(
                            color: const Color(0xFF0035FF),
                            fontSize: desktop ? 46 : 26,
                            fontWeight: FontWeight.w800,
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
                      _buildServiceCard(
                        '3.png',
                        'Web\nApplication',
                        'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
                        context,
                      ),
                      _buildServiceCard(
                        '4.png',
                        'Software\nApplications',
                        'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
                        context,
                      ),
                      _buildServiceCard(
                        '5.png',
                        'Hardware &\nNetworking',
                        'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
                        context,
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
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;
    return SizedBox(
      width: desktop ? 400 : 350, // close to 386.6667
      height: desktop ? 460 : 420,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFF0035FF), // rgba(0,53,255,1)
              width: 8,
            ),
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
          padding: const EdgeInsets.all(16), // padding 16
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
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
                  fontSize: desktop ? 22 : 18,
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
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: Color(0xFF0035FF)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Contact Now',
                      style: GoogleFonts.instrumentSans(
                        fontSize: desktop ? 18 : 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
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
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: 'Stay With Us',
                  style: GoogleFonts.instrumentSans(
                    fontSize: desktop ? 46 : 26,
                    fontWeight: FontWeight.w800,
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
                    _buildReasonItem(
                      '100%\nCustom Solutions',
                      'Tailored software, not templates. Built to match your business model.',
                      Icons.construction,
                      context,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomPaint(size: const Size(1, 60)),
                    ),
                    _buildReasonItem(
                      'Local Support,\nGlobal Standards',
                      'Serving Bohrdin-based enterprises with ISO-grade quality.',
                      Icons.public,
                      context,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomPaint(size: const Size(1, 60)),
                    ),
                    _buildReasonItem(
                      'Fast\nTurnaround',
                      'Rapid development cycles with clear timelines and zero guesswork.',
                      Icons.speed,
                      context,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReasonItem(
                      '100%\nCustom Solutions',
                      'Tailored software, not templates. Built to match your business model.',
                      Icons.construction,
                      context,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: CustomPaint(
                        size: const Size(100, 1),
                        painter: _DottedLinePainter(),
                      ),
                    ),
                    _buildReasonItem(
                      'Local Support,\nGlobal Standards',
                      'Serving Bohrdin-based enterprises with ISO-grade quality.',
                      Icons.public,
                      context,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: CustomPaint(
                        size: const Size(100, 1),
                        painter: _DottedLinePainter(),
                      ),
                    ),
                    _buildReasonItem(
                      'Fast\nTurnaround',
                      'Rapid development cycles with clear timelines and zero guesswork.',
                      Icons.speed,
                      context,
                    ),
                  ],
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

  Widget _buildLetsTalkSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Container(
      width: double.infinity,
      height: desktop ? 700 : null, // mobile -> auto height
      constraints: BoxConstraints(minHeight: 500),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(child: Image.asset('last.png', fit: BoxFit.cover)),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(3, 9, 35, 0.94),
                    Color.fromRGBO(3, 9, 35, 0.90),
                    Color.fromRGBO(3, 9, 35, 0.85),
                    Color.fromRGBO(3, 9, 35, 0.80),
                    Color.fromRGBO(3, 9, 35, 0.75),
                  ],
                ),
              ),
            ),
          ),

          // Scrollable content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: desktop ? 130 : 20,
                vertical: desktop ? 100 : 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Title
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '// ',
                          style: GoogleFonts.instrumentSans(
                            color: const Color(0xFF0035FF),
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: "Let's Talk",
                          style: GoogleFonts.instrumentSans(
                            color: Colors.white,
                            fontSize: 22,
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
                          text: "Tell us what you're\n",
                          style: GoogleFonts.instrumentSans(
                            color: Colors.white,
                            fontSize: desktop ? 46 : 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: "Working on",
                          style: GoogleFonts.instrumentSans(
                            color: const Color(0xFF0035FF),
                            fontSize: desktop ? 46 : 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Responsive layout: Row (desktop) / Column (mobile)
                  desktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildContactInfo()),
                            const SizedBox(width: 30),
                            Expanded(child: _buildFormFields(isMobile: false)),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildContactInfo(),
                            const SizedBox(height: 30),
                            _buildFormFields(isMobile: true),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "We'll help you\nbuild the right solution",
        style: GoogleFonts.instrumentSans(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 30),
      ContactInfoItem(
        icon: Icons.email_outlined,
        text: 'info@vedabahrain.com',
        textColor: Colors.white,
      ),
      SizedBox(height: 20),
      ContactInfoItem(
        icon: Icons.location_on_outlined,
        text: 'Manama, Kingdom of Bahrain',
        textColor: Colors.white,
      ),
      SizedBox(height: 20),
      ContactInfoItem(
        icon: Icons.local_phone_outlined,
        text: '+973 17 374742',
        textColor: Colors.white,
      ),
    ],
  );

  Widget _buildFormFields({required bool isMobile}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildCustomTextField(label: 'Name', icon: Icons.person_4_outlined),
      const SizedBox(height: 12),
      _buildCustomTextField(label: 'Email', icon: Icons.email_outlined),
      const SizedBox(height: 12),
      _buildCustomTextField(label: 'Phone', icon: Icons.phone_outlined),
      const SizedBox(height: 12),
      SizedBox(
        height: 102,
        width: 564,
        child: TextField(
          style: GoogleFonts.poppins(color: Colors.white),
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Message',
            labelStyle: GoogleFonts.poppins(color: Colors.white70),
            filled: true,
            fillColor: Colors.white.withOpacity(0.16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            alignLabelWithHint: true,
          ),
          textAlignVertical: TextAlignVertical.top,
        ),
      ),
      const SizedBox(height: 12),
      Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 157,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 53, 255, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Submit', style: GoogleFonts.instrumentSans(fontSize: 16)),
                const Icon(Icons.arrow_forward_rounded),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildCustomTextField({
    required String label,
    IconData? icon, // optional icon
  }) {
    return SizedBox(
      width: 564, // fixed width
      height: 48, // fixed height
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.16), // translucent background
          contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          prefixIcon: icon != null
              ? Icon(icon, color: Colors.white70)
              : null, // add icon if provided
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.text,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 5),
        Icon(icon, color: Colors.white),
        SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.instrumentSans(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class FooterLink extends StatelessWidget {
  final String text;

  const FooterLink({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          decoration: TextDecoration.underline,
          decorationColor: Colors.white70,
        ),
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

import 'package:flutter/material.dart';

class VedaHomePage extends StatelessWidget {
  const VedaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildtopbarSection(),
            // Header + Services stacked together
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildHeaderSection(context),
                Positioned(
                  bottom: -110, // Push it down from header
                  left: 0,
                  right: 0,
                  child: _buildServicesGridSection(),
                ),
              ],
            ),
            const SizedBox(height: 100), // Space after overlapping section
            // About Us Section
            _buildAboutUsSection(),

            // Our Services Section
            _buildOurServicesSection(),

            // Why Veda Section
            _buildWhyVedaSection(),

            // Let's Talk Section
            _buildLetsTalkSection(),

            // Footer
            _buildFooterSection(),
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
            'logo.png', // Your Veda logo
            height: 50,
            width: 150,
          ),

          // Right-side buttons
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Home',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'About',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Services',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Contact',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 800,
      child: Stack(
        children: [
          // Image at the bottom of the stack
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('1.png'), // Your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay covering the entire image
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
                stops: [0.0, 0.25, 0.5, 0.75, 1.0], // <-- smooth stops
              ),
            ),
          ),
          // Content on top of the gradient
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 170),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),
                const Text(
                  'Future-Ready Software & Tech\nSolutions for Modern Businesses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Tailored software, powerful platforms, and reliable IT infrastructure everything your\nbusiness needs to scale, seamlessly.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            if (states.contains(WidgetState.hovered)) {
                              return Colors.transparent;
                            }
                            return const Color(0xFF0035FF);
                          },
                        ),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        side: WidgetStateProperty.resolveWith<BorderSide>((
                          Set<WidgetState> states,
                        ) {
                          if (states.contains(WidgetState.hovered)) {
                            return const BorderSide(
                              color: Colors.white,
                              width: 2,
                            );
                          }
                          return BorderSide.none;
                        }),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: WidgetStateProperty.all(0),
                        minimumSize: WidgetStateProperty.all(
                          const Size(205, 54),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Contact Now',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 24),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              if (states.contains(WidgetState.hovered)) {
                                return const Color(0xFF0035FF);
                              }
                              return Colors.transparent;
                            }),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        side: WidgetStateProperty.resolveWith<BorderSide>((
                          Set<WidgetState> states,
                        ) {
                          if (states.contains(WidgetState.hovered)) {
                            return BorderSide.none;
                          }
                          return const BorderSide(color: Colors.white);
                        }),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        minimumSize: WidgetStateProperty.all(
                          const Size(205, 54),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Explore more',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGridSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        // Center the entire row
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the items in the row
            children: [
              _buildServiceItem(
                'Web Applications',
                'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
                Icons.web,
              ),
              const SizedBox(width: 20),
              _buildServiceItem(
                'Software Applications',
                'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
                Icons.apps,
              ),
              const SizedBox(width: 20),
              _buildServiceItem(
                'Hardware & Networking',
                'Lorem ipsum dolor sit amet consectetur. Fringilla leo',
                Icons.settings_input_hdmi,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(String title, String description, IconData icon) {
    return Container(
      width: 370, // Figma exact width
      height: 130, // Figma exact height
      padding: const EdgeInsets.all(16), // from figma
      margin: const EdgeInsets.only(bottom: 12), // keeps spacing between items
      decoration: BoxDecoration(
        color: Colors.white, // same background as before
        borderRadius: BorderRadius.circular(14), // figma radius
        border: Border(
          top: BorderSide(color: const Color(0xFF0035FF), width: 0.6),
          right: BorderSide(color: const Color(0xFF0035FF), width: 0.6),
          bottom: BorderSide(
            color: const Color(0xFF0035FF),
            width: 8,
          ), // thick bottom
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
          const SizedBox(width: 8), // matches gap: 12px from figma
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(description, style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 100),
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
                    height: 400,
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
                        SizedBox(height: 60),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '// ',
                                style: TextStyle(
                                  color: const Color(0xFF0035FF),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: 'About Us',
                                style: TextStyle(
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
                                text: 'Where Experience Meets',
                                style: TextStyle(
                                  fontSize: 46,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: '\nInnovation',
                                style: TextStyle(
                                  color: const Color(0xFF0035FF),
                                  fontSize: 46,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi molestie aliquam odio aliquam pharetra tortor venenatis pulvinar proin.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi molestie aliquam odio aliquam pharetra',
                          style: TextStyle(
                            fontSize: 16,
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

  Widget _buildOurServicesSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define a fixed content width (e.g., 1140 or constraints.maxWidth - some margin)
        double contentWidth = constraints.maxWidth > 1200
            ? 1140
            : constraints.maxWidth * 0.9;

        return Container(
          width: double.infinity,
          color: Colors.grey.shade100,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 120),
            child: SizedBox(
              width: contentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '// ',
                          style: TextStyle(
                            color: const Color(0xFF0035FF),
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: 'Our Services',
                          style: TextStyle(
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
                          text: 'Smart Tech Services\n',
                          style: TextStyle(
                            fontSize: 46,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: 'That Drive Results',
                          style: TextStyle(
                            color: const Color(0xFF0035FF),
                            fontSize: 46,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Wrap starts exactly below the text, aligned left
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildServiceCard(
                        '3.png',
                        'Web\nApplication',
                        'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
                      ),
                      _buildServiceCard(
                        '4.png',
                        'Software\nApplications',
                        'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
                      ),
                      _buildServiceCard(
                        '5.png',
                        'Hardware &\nNetworking',
                        'Lorem ipsum dolor sit amet consectetur. Fringilla leo dolor turpis cursus. Tempor sit et ultricies consectetur amet. Donec nisi fusce nam velit enim. Morbi',
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

  Widget _buildServiceCard(String imagePath, String title, String description) {
    return SizedBox(
      width: 400, // close to 386.6667
      height: 460,
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
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              // Description
              Text(
                description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              const Spacer(),
              // Button
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: Color(0xFF0035FF)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Contact Now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Your existing _buildWhyVedaSection widget with dotted lines
  Widget _buildWhyVedaSection() {
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
                  style: TextStyle(
                    color: const Color(0xFF0035FF),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: 'Why Veda',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Reasons Our Clients\n',
                  style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: 'Stay With Us',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0035FF),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Row with dotted lines between items
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReasonItem(
                '100%\nCustom Solutions',
                'Tailored software, not templates. Built to match your business model.',
                Icons.construction,
              ),

              // Dotted line between first and second item
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: CustomPaint(
                  size: const Size(100, 1), // Adjust width as needed
                  painter: _DottedLinePainter(),
                ),
              ),

              _buildReasonItem(
                'Local Support,\nGlobal Standards',
                'Serving Bohrdin-based enterprises with ISO-grade quality.',
                Icons.public,
              ),

              // Dotted line between second and third item
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: CustomPaint(
                  size: const Size(100, 1), // Adjust width as needed
                  painter: _DottedLinePainter(),
                ),
              ),

              _buildReasonItem(
                'Fast\nTurnaround',
                'Rapid development cycles with clear timelines and zero guesswork.',
                Icons.speed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Your existing _buildReasonItem widget
  Widget _buildReasonItem(String title, String description, IconData icon) {
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
              style: const TextStyle(
                fontSize: 22,
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
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetsTalkSection() {
    return SizedBox(
      width: double.infinity,
      height: 700, // <-- give the section a height
      child: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity, // <-- expand to fill parent
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('last.png'),
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
                  Color.fromRGBO(3, 9, 35, 0.9),
                  Color.fromRGBO(3, 9, 35, 0.85),
                  Color.fromRGBO(3, 9, 35, 0.8),
                  Color.fromRGBO(3, 9, 35, 0.7),
                  Color.fromRGBO(3, 9, 35, 0.6),
                ],
                stops: [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
          ),
          // Content on top
          Padding(
            padding: const EdgeInsets.fromLTRB(130, 100, 130, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '// ',
                        style: TextStyle(
                          color: const Color(0xFF0035FF),
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: "Let's Talk",
                        style: TextStyle(
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: "Working on",
                        style: TextStyle(
                          color: const Color(0xFF0035FF),
                          fontSize: 46,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Two-column layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column - Contact Info
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "We'll help you\nbuild the right solution",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
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
                      ),
                    ),

                    // Right column - Form Fields
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCustomTextField(label: 'Name'),
                            const SizedBox(height: 12),
                            _buildCustomTextField(label: 'Email'),
                            const SizedBox(height: 12),
                            _buildCustomTextField(label: 'Phone'),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 564,
                              height: 102, // desired height
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                maxLines: 5,
                                decoration: InputDecoration(
                                  labelText: 'Message',
                                  labelStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.16),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                    16,
                                    12,
                                    16,
                                    12,
                                  ),
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
                                  alignLabelWithHint: true,
                                ),
                                textAlignVertical: TextAlignVertical.top,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 157,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(
                                    0,
                                    53,
                                    255,
                                    1,
                                  ),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.fromLTRB(
                                    30,
                                    15,
                                    30,
                                    15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Submit',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Icon(Icons.arrow_forward_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTextField({required String label}) {
    return SizedBox(
      width: 564, // fixed width
      height: 48, // fixed height
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.16), // translucent background
          contentPadding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            12,
          ), // padding inside
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // rounded corners
            borderSide: BorderSide.none, // remove default border
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

  Widget _buildFooterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.grey.shade900,
      child: Column(
        children: [
          Image.asset(
            'last.png', // Replace with your white logo asset
            height: 40,
          ),
          const SizedBox(height: 20),
          const Text(
            'Smart, secure, and scalable tech solutions — helping businesses in Bahrain and beyond grow through custom software, modern web apps, and strong IT infrastructure.',
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.6),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Company',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              FooterLink(text: 'About Us'),
              FooterLink(text: 'Our Services'),
              FooterLink(text: 'Why Us?'),
              FooterLink(text: 'Contact Us'),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          const Text(
            '© 2025 Veda Systems Solutions - Bahrain. All rights reserved.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;

  const ContactInfoItem({
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
          style: TextStyle(
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

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
    return Container(
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
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((
                              Set<MaterialState> states,
                            ) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.transparent;
                              }
                              return const Color(0xFF0035FF);
                            }),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        side: MaterialStateProperty.resolveWith<BorderSide>((
                          Set<MaterialState> states,
                        ) {
                          if (states.contains(MaterialState.hovered)) {
                            return const BorderSide(
                              color: Colors.white,
                              width: 2,
                            );
                          }
                          return BorderSide.none;
                        }),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(
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
                            MaterialStateProperty.resolveWith<Color?>((
                              Set<MaterialState> states,
                            ) {
                              if (states.contains(MaterialState.hovered)) {
                                return const Color(0xFF0035FF);
                              }
                              return Colors.transparent;
                            }),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        side: MaterialStateProperty.resolveWith<BorderSide>((
                          Set<MaterialState> states,
                        ) {
                          if (states.contains(MaterialState.hovered)) {
                            return BorderSide.none;
                          }
                          return const BorderSide(color: Colors.white);
                        }),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
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

  Widget _buildWhyVedaSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center titles
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

          // ✅ Three items in a row, centered
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildReasonItem(
                '100%\nCustom Solutions',
                'Tailored software, not templates. Built to match your business model.',
                Icons.construction,
              ),
              const SizedBox(width: 40),
              _buildReasonItem(
                'Local Support,\nGlobal Standards',
                'Serving Bahrain-based enterprises with ISO-grade quality.',
                Icons.public,
              ),
              const SizedBox(width: 40),
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

  Widget _buildReasonItem(String title, String description, IconData icon) {
    return SizedBox(
      width: 280, // Fixed width so all items align nicely
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
          const SizedBox(height: 16), // Space between icon and text
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Let's Talk",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Tell us what you're Working on",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "We'll help you build the right solution",
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 30),
          const ContactInfoItem(
            icon: Icons.email,
            text: 'info@vedabahrain.com',
          ),
          const SizedBox(height: 15),
          const ContactInfoItem(
            icon: Icons.location_on,
            text: 'Manama, Kingdom of Bahrain',
          ),
          const SizedBox(height: 15),
          const ContactInfoItem(icon: Icons.phone, text: '+973 17 374742'),
          const SizedBox(height: 30),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 15,
              ),
              alignLabelWithHint: true,
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Submit', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
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

  const ContactInfoItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue.shade800),
        const SizedBox(width: 15),
        Text(text, style: const TextStyle(fontSize: 16)),
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

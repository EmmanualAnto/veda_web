import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/autoscroll.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/letstalk.dart';
import 'package:veda_main/stylecard.dart';
import 'package:veda_main/topbar.dart';

class Webapppg extends StatelessWidget {
  const Webapppg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(title: const Text('Home'), onTap: () {}),
            ListTile(title: const Text('About'), onTap: () {}),
            ListTile(title: const Text('Services'), onTap: () {}),
            ListTile(title: const Text('Contact'), onTap: () {}),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            _buildHeaderSection(context),
            _buildFiveCardsSection(context),
            _buildClientsSection(context),
            const LetsTalkSection(),
            Footer(),
          ],
        ),
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
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
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
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 5 : 120,
                  vertical: isMobile ? 0 : 170,
                ),
                child: Align(
                  alignment: isMobile ? Alignment.center : Alignment.topLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: isMobile
                            ? TextAlign.center
                            : TextAlign.start,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: '// ',
                              style: TextStyle(
                                color: Color(0xFF0035FF),
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: 'We Offer',
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
                      Text(
                        'Smart Tech Solutions\nDesigned for Growth',
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
                      Text(
                        'We provide end-to-end digital services tailored to your business needs. From custom web applications to seamless system integrations, our solutions are built to optimize operations, enhance user experience, and drive measurable results.',
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
      backgroundColor: WidgetStateProperty.all(const Color(0xFF0035FF)),
      foregroundColor: WidgetStateProperty.all(Colors.white),
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
      foregroundColor: WidgetStateProperty.all(Colors.white),
      side: WidgetStateProperty.all(const BorderSide(color: Colors.white)),
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
  Widget _buildFiveCardsSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        return Padding(
          padding: EdgeInsets.all(isMobile ? 10 : 20),
          child: isMobile
              ? Column(
                  children: const [
                    StyledCardSection(
                      imagePath: "assets/web/1.jpg",
                      title: "Design & Development",
                      description:
                          "Insight-driven strategies to grow traffic, engagement, and conversions.",
                    ),
                    SizedBox(height: 20),
                    StyledCardSection(
                      imagePath: "assets/web/2.jpg",
                      title: "Marketing & Analysis",
                      description:
                          "Fast, secure, and reliable POS solutions for retail and restaurants.",
                    ),
                    SizedBox(height: 20),
                    StyledCardSection(
                      imagePath: "assets/web/4.jpg",
                      title: "Domain & Hosting Management",
                      description:
                          "Seamless domain registration, hosting, and long-term maintenance.",
                    ),
                    SizedBox(height: 20),
                    StyledCardSection(
                      imagePath: "assets/web/3.jpg",
                      title: "E-Commerce Development",
                      description:
                          "Custom online stores with secure transactions and smooth user experience.",
                    ),

                    SizedBox(height: 20),
                    StyledCardSection(
                      imagePath: "assets/web/6.png",
                      title: "Website Upgrades & Renovations",
                      description:
                          "Redesign and revamp outdated websites with modern UI/UX.",
                    ),
                    SizedBox(height: 20),
                    StyledCardSection(
                      imagePath: "assets/web/5.jpg",
                      title: "Application Development",
                      description:
                          "Interactive solutions like chatrooms, polls, message boards, and more.",
                    ),
                    SizedBox(height: 20),
                    StyledCardSection(
                      imagePath: "assets/web/7.png",
                      title: "Database Construction",
                      description:
                          "Powerful, scalable databases designed to handle business growth.",
                    ),
                  ],
                )
              : Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: const [
                    StyledCardSection(
                      imagePath: "assets/web/1.jpg",
                      title: "Design & Development",
                      description:
                          "Insight-driven strategies to grow traffic, engagement, and conversions.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/web/2.jpg",
                      title: "Marketing & Analysis",
                      description:
                          "Fast, secure, and reliable POS solutions for retail and restaurants.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/web/4.jpg",
                      title: "Domain & Hosting Management",
                      description:
                          "Seamless domain registration, hosting, and long-term maintenance.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/web/3.jpg",
                      title: "E-Commerce Development",
                      description:
                          "Custom online stores with secure transactions and smooth user experience.",
                    ),

                    StyledCardSection(
                      imagePath: "assets/web/5.jpg",
                      title: "Website Upgrades & Renovations",
                      description:
                          "Redesign and revamp outdated websites with modern UI/UX.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/web/6.png",
                      title: "Application Development",
                      description:
                          "Interactive solutions like chatrooms, polls, message boards, and more.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/web/7.png",
                      title: "Database Construction",
                      description:
                          "Powerful, scalable databases designed to handle business growth.",
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildClientsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    List<String> clients = [
      "Alsalam School Bahrain",
      "Haffadh Specialised Dental Hospital",
      "Rich n Healthy",
      "Laguitara Music Centre",
      "Ali A. Eleimat",
      "Al fateh Industrial Suppliers",
      "Shakeel Group Bahrain",
      "HP International Trading WLL",
      "DIJLAH & FURAT BANK.",
      "Nadmad",
      "Devine Food Co.",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 100,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '// ',
                  style: GoogleFonts.instrumentSans(
                    color: const Color(0xFF0035FF),
                    fontSize: isMobile ? 18 : 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: 'Our Clients',
                  style: GoogleFonts.instrumentSans(
                    fontSize: isMobile ? 16 : 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Partners Who Believe\n',
                  style: GoogleFonts.instrumentSans(
                    fontSize: isMobile ? 26 : 46,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: 'In Our Solutions',
                  style: GoogleFonts.instrumentSans(
                    color: const Color(0xFF0035FF),
                    fontSize: isMobile ? 26 : 46,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          AutoScrollClients(clients: clients, isMobile: isMobile),
        ],
      ),
    );
  }
}

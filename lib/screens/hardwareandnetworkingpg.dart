import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/autoscrolltext.dart';
import 'package:veda_main/constants.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/letstalk.dart';
import 'package:veda_main/popupanime.dart';
import 'package:veda_main/stylecard.dart';
import 'package:veda_main/topbar.dart';

class Hardwareandnetworkingpg extends StatefulWidget {
  const Hardwareandnetworkingpg({super.key});

  @override
  State<Hardwareandnetworkingpg> createState() =>
      _HardwareandnetworkingpgState();
}

class _HardwareandnetworkingpgState extends State<Hardwareandnetworkingpg>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: FadeInOnScroll(
                    delay: const Duration(milliseconds: 0),
                    child: _buildHeaderSection(context),
                  ),
                ),
              ),

              // Cards
              SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(8, (index) {
                    return FadeInOnScroll(
                      delay: Duration(milliseconds: index * 120), // stagger
                      child: _buildCardByIndex(index),
                    );
                  }),
                ),
              ),

              // Clients
              SliverToBoxAdapter(child: _buildClientsSection(context)),
              // LetsTalk
              const SliverToBoxAdapter(child: LetsTalkSection()),
              // Footer
              const SliverToBoxAdapter(child: Footer()),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ReusableMenu(
                menuRoutes: {
                  'Home': '/',
                  'About': '/aboutus',
                  'Services': '/ourservices',
                  'Contact': '/contactus',
                },
              ),
            ),
          ),

          // Scroll-to-top button
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
                    border: Border.all(color: AppColors.primary, width: 2),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardByIndex(int index) {
    List<String> images = [
      "assets/software/1.webp",
      "assets/software/2.webp",
      "assets/software/3.webp",
      "assets/software/4.webp",
      "assets/software/5.webp",
      "assets/software/5.webp",
      "assets/software/5.webp",
      "assets/software/5.webp",
    ];
    List<String> titles = [
      "Network Setup & Configuration",
      "Firewall & Network Security",
      "Computer & Server Installation",
      "Hardware Maintenance & AMC",
      "Remote Access & VPN Solutions",
      "Data Backup & Storage Solutions",
      "Cloud & Hybrid Network Integration",
      "IT Infrastructure Consulting",
    ];
    List<String> desc = [
      "Complete wired & wireless LAN/WAN setup for offices, including routers, switches, and structured cabling.",
      "Installation of firewalls, antivirus, and other cybersecurity solutions to protect client data and networks.",
      "Supply and setup of desktops, laptops, and servers tailored to business needs.",
      "Regular servicing, troubleshooting, and repair of IT hardware with flexible support plans.",
      "Secure remote connectivity for employees and branch offices via VPN setups.",
      "Setup of local and cloud-based backup systems, NAS devices, and secure storage management.",
      "Helping businesses connect and manage cloud platforms (like AWS, Azure) with their on-premise network.",
      "Tailored consultation for setting up or upgrading IT infrastructure based on client needs and budget.",
    ];

    return StyledCardSection(
      pageKey: 'hrdwr_page',
      cardIndex: index, // FIXED
      imagePath: images[index],
      title: titles[index],
      description: desc[index],
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
                    image: AssetImage('assets/carousel/hrdwr2.webp'),
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
                                color: AppColors.primary,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            TextSpan(
                              text: 'Hardware & Networking Services',
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
                      SizedBox(
                        width: 1000,
                        child: Text(
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
                      ),
                      SizedBox(height: isMobile ? 45 : 35),
                      isMobile
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [_buildPrimaryButton()],
                            )
                          : Row(children: [_buildPrimaryButton()]),
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
            : AppColors.primary;
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

  Widget _buildClientsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    List<String> clients = [
      "Memo Express",
      "Elie Jean",
      "Markwell International WLL",
      "Musthafa Muhammed Trading",
      "Madan Electrical Contracting",
      "Soccerscene",
      "Life line Document Clearance",
      "Palace Opticals",
      "Awali Stationaries",
      "Sadaret Food Stuff Center",
      "Atlas Stationaries",
      "K S Fashions",
      "Al Thawaouda Tailoring",
      "Art of Living Bahrain",
      "Ashraf Bicycle Store",
      "Ali Ajmal Building Materials",
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
                        color: AppColors.primary,
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
                        color: AppColors.primary,
                        fontSize: isMobile ? 26 : 46,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ClientReel(clients: clients),
        const SizedBox(height: 50),
      ],
    );
  }
}

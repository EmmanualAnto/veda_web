import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/autoscrolltext.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/letstalk.dart';
import 'package:veda_main/stylecard.dart';
import 'package:veda_main/topbar.dart';

class Softwarepg extends StatefulWidget {
  const Softwarepg({super.key});

  @override
  State<Softwarepg> createState() => _SoftwarepgState();
}

class _SoftwarepgState extends State<Softwarepg>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

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
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: Center(child: TopBar())),
              SliverToBoxAdapter(
                child: Center(child: _buildHeaderSection(context)),
              ),
              SliverToBoxAdapter(
                child: Center(child: _buildFiveCardsSection(context)),
              ),
              SliverToBoxAdapter(
                child: Center(child: _buildClientsSection(context)),
              ),
              const SliverToBoxAdapter(child: Center(child: LetsTalkSection())),
              SliverToBoxAdapter(child: Center(child: Footer())),
            ],
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
                    image: AssetImage('assets/1.webp'),
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
                        'Smart Software Solutions\nfor Every Business',
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
                        'At the heart of our services is a commitment to efficiency and customization. From wholesale inventory to personal accounting, we create intelligent software that reduces manual work, streamlines operations, and allows you to focus on what truly matters growing your business',
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

  Widget _buildFiveCardsSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        return Padding(
          padding: EdgeInsets.all(isMobile ? 10 : 20),
          child: isMobile
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: const [
                      StyledCardSection(
                        imagePath: "assets/software/1.webp",
                        title: "Customized Accounting Packages",
                        description:
                            "Streamline finances with tailored accounting software built for your business model.",
                      ),
                      SizedBox(height: 20),
                      StyledCardSection(
                        imagePath: "assets/software/2.webp",
                        title: "POS (Point of Sale) Systems",
                        description:
                            "Fast, secure, and reliable POS solutions for retail and restaurants.",
                      ),
                      SizedBox(height: 20),
                      StyledCardSection(
                        imagePath: "assets/software/3.webp",
                        title: "Wholesale & Retail Inventory Software",
                        description:
                            "Track, manage, and optimize your inventory with ease.",
                      ),
                      SizedBox(height: 20),
                      StyledCardSection(
                        imagePath: "assets/software/4.webp",
                        title: "Customized Software for Organizations",
                        description:
                            "Custom-built software designed to fit unique organizational needs.",
                      ),
                      SizedBox(height: 20),
                      StyledCardSection(
                        imagePath: "assets/software/5.webp",
                        title: "Softwares for Personal Accounting",
                        description:
                            "Simplify your personal finances with user-friendly accounting software.",
                      ),
                    ],
                  ),
                )
              : Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: const [
                    StyledCardSection(
                      imagePath: "assets/software/1.webp",
                      title: "Customized\nAccounting Packages",
                      description:
                          "Streamline finances with tailored accounting software built for your business model.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/software/2.webp",
                      title: "POS (Point of Sale) Systems",
                      description:
                          "Fast, secure, and reliable POS solutions for retail and restaurants.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/software/3.webp",
                      title: "Wholesale & Retail Inventory Software",
                      description:
                          "Track, manage, and optimize your inventory with ease.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/software/4.webp",
                      title: "Customized Software for Organizations",
                      description:
                          "Custom-built software designed to fit unique organizational needs.",
                    ),
                    StyledCardSection(
                      imagePath: "assets/software/5.webp",
                      title: "Softwares for Personal Accounting",
                      description:
                          "Simplify your personal finances with user-friendly accounting software.",
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
      "Memo express",
      "Elie Jean",
      "Markwell International WLL",
      "Musthafa Muhammed Trading",
      "Madan Electrical Contracting",
      "Paramount Binding Material",
      "4 Ways Decor Co WLL",
      "Black & White Laundry WLL",
      "Woodland Building Material WLL",
      "Alsoodan Electricals",
      "Soccerscene",
      "Life line Document Clearance",
      "Palace Opticals",
      "Awali Stationaries",
      "Sadaret Food Stuff Center",
      "Nowrooz Building Materials",
      "Alma Building Materials",
      "Al Sominar Decor WLL",
      "Atlas Stationaries",
      "K S Fashions",
      "Al Thawaouda Tailoring",
      "Art of Living Bahrain",
      "Ashraf Bicycle Store",
      "Ali Ajmal Building Materials",
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
          AutoScrollClients(
            clients: clients,
            isMobile: isMobile,
            topRowSpeedFactor: 1.0,
            bottomRowSpeedFactor: 1.0,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/autoscrolltext.dart';
import 'package:veda_main/constants.dart';
import 'package:veda_main/footer.dart';
import 'package:veda_main/letstalk.dart';
import 'package:veda_main/popupanime.dart';
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
              // Header with popup animation
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: FadeInOnScroll(
                    delay: const Duration(milliseconds: 0),
                    child: _buildHeaderSection(context),
                  ),
                ),
              ),

              // Five Cards with staggered popup
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(5, (index) {
                      return FadeInOnScroll(
                        delay: Duration(milliseconds: index * 100), // stagger
                        child: _buildCardByIndex(index),
                      );
                    }),
                  ),
                ),
              ),

              // Clients section
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: FadeInOnScroll(
                    delay: const Duration(milliseconds: 0),
                    child: _buildClientsSection(context),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: Center(child: LetsTalkSection())),

              // Footer with navigation
              SliverToBoxAdapter(child: Center(child: Footer())),
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
          // Scroll to top button
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
    ];
    List<String> titles = [
      "Customized Accounting Packages",
      "POS (Point of Sale) Systems",
      "Wholesale & Retail Inventory Software",
      "Customized Software for Organizations",
      "Softwares for Personal Accounting",
    ];
    List<String> desc = [
      "Streamline finances with tailored accounting software built for your business model.",
      "Fast, secure, and reliable POS solutions for retail and restaurants.",
      "Track, manage, and optimize your inventory with ease.",
      "Custom-built software designed to fit unique organizational needs.",
      "Simplify your personal finances with user-friendly accounting software.",
    ];

    return StyledCardSection(
      pageKey: 'sftwr_page',
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
                    image: AssetImage('assets/carousel/sftwr2.webp'),
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
                              text: 'Software Applications Services',
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
                      SizedBox(
                        width: 1000,
                        child: Text(
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
    onPressed: () => context.go('/contactus'),
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

  // Keep your existing _buildHeaderSection and _buildClientsSection methods here
}

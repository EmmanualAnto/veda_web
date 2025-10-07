import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderCarousel extends StatefulWidget {
  const HeaderCarousel({super.key});

  @override
  State<HeaderCarousel> createState() => _HeaderCarouselState();
}
// … keep your imports and HeaderCarousel class

class _HeaderCarouselState extends State<HeaderCarousel>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  Timer? _autoSlideTimer;

  late final AnimationController _textController;
  late final AnimationController _imageScaleController;
  late final Animation<double> _imageScaleAnimation;

  final List<Map<String, dynamic>> _banners = [
    {
      'imageMobile': 'assets/carousel/main1.webp', // 2:3 ratio
      'imageDesktop': 'assets/carousel/main2.webp', // 3:2 ratio
      'slash': 'Tech That Powers Growth',
      'title': 'Your Complete Digital Partner',
      'subtitle':
          'From web development to custom software and advanced networking, we provide end-to-end technology solutions tailored to scale your business with confidence.',
      'onPrimary': (BuildContext context) => context.go('/contactus'),
      'onSecondary': (BuildContext context) => context.go('/webpage'),
    },
    {
      'imageMobile': 'assets/carousel/web1.webp', // 2:3 ratio
      'imageDesktop': 'assets/carousel/web2.webp', // 3:2 ratio
      'slash': 'Websites That Wow',
      'title': 'Transform Clicks Into Customers',
      'subtitle':
          'We craft engaging and visually stunning web experiences that not only captivate your audience but also turn every click into measurable business growth.',
      'onPrimary': (BuildContext context) => context.go('/contactus'),
      'onSecondary': (BuildContext context) => context.go('/webpage'),
    },
    {
      'imageMobile': 'assets/carousel/sftwr1.webp', // 2:3 ratio
      'imageDesktop': 'assets/carousel/sftwr2.webp', // 3:2 ratio
      'slash': 'Software That Works Smarter',
      'title': 'Automate. Optimize. Excel.',
      'subtitle':
          'Our custom software solutions are designed to simplify complex processes, automate repetitive tasks, and boost overall efficiency across your business operations.',
      'onPrimary': (BuildContext context) => context.go('/contactus'),
      'onSecondary': (BuildContext context) => context.go('/softwarepage'),
    },
    {
      'imageMobile': 'assets/carousel/hrdwr1.webp', // 2:3 ratio
      'imageDesktop': 'assets/carousel/hrdwr2.webp', // 3:2 ratio
      'slash': 'Networks That Never Quit',
      'title': 'Fast. Secure. Reliable.',
      'subtitle':
          'We build top-notch IT infrastructure and networking systems that guarantee speed, security, and reliability—keeping your team and clients seamlessly connected 24/7.',
      'onPrimary': (BuildContext context) => context.go('/contactus'),
      'onSecondary': (BuildContext context) => context.go('/hardwarepage'),
    },
  ];

  @override
  void initState() {
    super.initState();

    // Precache all images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var banner in _banners) {
        precacheImage(AssetImage(banner['imageMobile']!), context);
        precacheImage(AssetImage(banner['imageDesktop']!), context);
      }
    });

    // Text animation
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Image scale animation (slow pop)
    _imageScaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    _imageScaleAnimation = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _imageScaleController, curve: Curves.easeOut),
    );
    _imageScaleController.forward();

    // Start animation after short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _textController.forward();
    });

    _startAutoSlide();
  }

  @override
  void dispose() {
    _textController.dispose();
    _imageScaleController.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _banners.length;
      });

      _imageScaleController.reset();
      _imageScaleController.forward();

      _textController.reset();
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) _textController.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    final height = isMobile ? 510.0 : 810.0;
    final String imagePath = isMobile
        ? _banners[_currentIndex]['imageMobile']!
        : _banners[_currentIndex]['imageDesktop']!;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          // Background image
          ClipRect(
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: ScaleTransition(
                scale: _imageScaleAnimation,
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
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

          // Replace the SlideTransition + FadeTransition in your build method with this calm animation
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 5 : 120,
              vertical: isMobile ? 0 : 170,
            ),
            child: Align(
              alignment: isMobile ? Alignment.center : Alignment.topLeft,
              child: AnimatedBuilder(
                animation: _textController,
                builder: (_, child) {
                  // Calm easing
                  final t = Curves.easeInOut.transform(_textController.value);
                  return Opacity(
                    opacity: t.clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - t)), // gently move up
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    // Slash + title
                    RichText(
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '// ',
                            style: GoogleFonts.instrumentSans(
                              fontSize: isMobile ? 25 : 25,
                              color: const Color(0xFF0035FF),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: _banners[_currentIndex]['slash'],
                            style: GoogleFonts.instrumentSans(
                              fontSize: isMobile ? 16 : 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 20 : 15),
                    // Heading
                    Text(
                      _banners[_currentIndex]['title']!,
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: GoogleFonts.instrumentSans(
                        color: Colors.white,
                        fontSize: isMobile ? 26 : 55,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: isMobile ? 40 : 25),
                    // Subtitle
                    SizedBox(
                      width: 1000,
                      child: Text(
                        _banners[_currentIndex]['subtitle']!,
                        textAlign: isMobile
                            ? TextAlign.center
                            : TextAlign.start,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: isMobile ? 14 : 25,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 45 : 35),
                    isMobile
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildPrimaryButton(
                                onPressed: () =>
                                    _banners[_currentIndex]['onPrimary'](
                                      context,
                                    ),
                              ),
                              const SizedBox(height: 15),
                              _buildSecondaryButton(
                                onPressed: () =>
                                    _banners[_currentIndex]['onSecondary'](
                                      context,
                                    ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              _buildPrimaryButton(
                                onPressed: () =>
                                    _banners[_currentIndex]['onPrimary'](
                                      context,
                                    ),
                              ),
                              const SizedBox(width: 15),
                              _buildSecondaryButton(
                                onPressed: () =>
                                    _banners[_currentIndex]['onSecondary'](
                                      context,
                                    ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton({required VoidCallback onPressed}) =>
      ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            return states.contains(MaterialState.hovered)
                ? Colors.white
                : const Color(0xFF0035FF);
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            return states.contains(MaterialState.hovered)
                ? Colors.black
                : Colors.white;
          }),
          side: MaterialStateProperty.resolveWith<BorderSide>((states) {
            return BorderSide(
              color: states.contains(MaterialState.hovered)
                  ? Colors.black
                  : Colors.transparent,
            );
          }),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          elevation: MaterialStateProperty.all(0),
          minimumSize: MaterialStateProperty.all(const Size(205, 54)),
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

  Widget _buildSecondaryButton({required VoidCallback onPressed}) =>
      OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
            return states.contains(MaterialState.hovered)
                ? Colors.white
                : Colors.transparent;
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            return states.contains(MaterialState.hovered)
                ? Colors.black
                : Colors.white;
          }),
          side: MaterialStateProperty.resolveWith<BorderSide>((states) {
            return BorderSide(
              color: states.contains(MaterialState.hovered)
                  ? Colors.black
                  : Colors.white,
            );
          }),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          minimumSize: MaterialStateProperty.all(const Size(205, 54)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Explore More',
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
}

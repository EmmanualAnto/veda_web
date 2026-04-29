import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          // Background Painter
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => CustomPaint(
              painter: ParticlePainter(_controller.value),
              size: Size.infinite,
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "404",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 140,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 0.9,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "PAGE NOT FOUND",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: 400,
                    child: Text(
                      "The link you followed might be broken, or the page may have been moved to a different galaxy.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.5),
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // FIXED BUTTON: Using GoRouter navigation
                  TextButton(
                    onPressed: () =>
                        context.go('/'), // GoRouter way to navigate home
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      "BACK TO REALITY",
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "ERROR_CODE: NULL_POINTER_TO_NOWHERE",
                style: GoogleFonts.spaceMono(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.2),
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ParticlePainter extends CustomPainter {
  final double animationValue;
  ParticlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.12);
    final random = Random(42);

    for (int i = 0; i < 65; i++) {
      double x = random.nextDouble() * size.width;
      double y =
          (random.nextDouble() * size.height - (animationValue * size.height)) %
          size.height;
      double radius = random.nextDouble() * 1.8;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

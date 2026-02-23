import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  double _dx1 = 0;
  double _dx2 = 0;

  // Primary color used for icon and button
  final Color primaryColor = const Color(0xFF017697);

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 600),
        )..addListener(() {
          setState(() {
            _dx1 = (_random.nextDouble() - 0.5) * 6;
            _dx2 = (_random.nextDouble() - 0.5) * 6;
          });
        });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _glitchText(Color color, double dx) {
    return Transform.translate(
      offset: Offset(dx, 0),
      child: Text(
        "404",
        style: GoogleFonts.vt323(
          fontSize: 120,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Big faded background icon using primary color
          Center(
            child: Icon(
              Icons.search_off_rounded,
              size: 250,
              color: primaryColor.withOpacity(0.1),
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Glitch 404 text
                Stack(
                  alignment: Alignment.center,
                  children: [
                    _glitchText(Colors.redAccent.withOpacity(0.7), _dx1),
                    _glitchText(Colors.blueAccent.withOpacity(0.7), _dx2),
                    Text(
                      "404",
                      style: GoogleFonts.vt323(
                        fontSize: 120,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Page Not Found!",
                  style: GoogleFonts.vt323(fontSize: 30, color: Colors.white70),
                ),
                const SizedBox(height: 30),

                // Button with primary color
                OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.resolveWith<BorderSide>((
                      states,
                    ) {
                      if (states.contains(MaterialState.hovered)) {
                        return const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ); // hover border
                      }
                      return const BorderSide(
                        color: Color.fromARGB(255, 126, 172, 252),
                        width: 2,
                      ); // default border
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>((
                      states,
                    ) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.white; // hover text color
                      }
                      return Colors.grey; // default text color
                    }),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Go Home",
                    style: GoogleFonts.shareTechMono(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

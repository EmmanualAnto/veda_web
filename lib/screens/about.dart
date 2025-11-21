import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/constants.dart';
import 'package:veda_main/veda_page_layout.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return VedaPageLayout(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 24,
          vertical: isDesktop ? 80 : 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title section
            Text(
              'About Us',
              style: GoogleFonts.instrumentSans(
                fontSize: isDesktop ? 48 : 34,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Where Experience Meets Innovation',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 20 : 16,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 50),

            // Image + Text
            Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Container(
                    height: isDesktop ? 400 : 250,
                    margin: EdgeInsets.only(
                      right: isDesktop ? 40 : 0,
                      bottom: isDesktop ? 0 : 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/2.webp',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: isDesktop ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Empowering Businesses with Smart Digital Solutions',
                        style: GoogleFonts.instrumentSans(
                          fontSize: isDesktop ? 28 : 20,
                          fontWeight: FontWeight.w700,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'We are a technology-driven team passionate about transforming ideas into impactful solutions. Our expertise spans software development, web applications, and IT infrastructure management, helping clients stay ahead in a fast-evolving digital world.',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 16 : 14,
                          height: 1.7,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'With years of experience and a commitment to innovation, we focus on delivering scalable, user-friendly, and future-ready solutions that empower businesses to grow confidently.',
                        style: GoogleFonts.poppins(
                          fontSize: isDesktop ? 16 : 14,
                          height: 1.7,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 80),

            // Feature cards
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                _buildFeatureCard(
                  icon: Icons.lightbulb_outline,
                  title: 'Innovation First',
                  desc:
                      'We combine creativity and technology to craft meaningful, future-ready digital experiences.',
                ),
                _buildFeatureCard(
                  icon: Icons.handshake_outlined,
                  title: 'Client-Centric Approach',
                  desc:
                      'We believe in strong partnerships and tailor our solutions to align perfectly with client goals.',
                ),
                _buildFeatureCard(
                  icon: Icons.security_outlined,
                  title: 'Reliable & Secure',
                  desc:
                      'Every project is built with robust security and long-term reliability at its core.',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.instrumentSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

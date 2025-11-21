import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/constants.dart';
import 'package:veda_main/popupanime.dart';
import 'package:go_router/go_router.dart';
import 'package:veda_main/veda_page_layout.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return VedaPageLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 30,
            horizontal: isDesktop ? 80 : 24,
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
                        fontSize: isDesktop ? 25 : 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextSpan(
                      text: 'Our Services',
                      style: GoogleFonts.instrumentSans(
                        fontSize: isDesktop ? 22 : 16,
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
                      style: GoogleFonts.instrumentSans(
                        fontSize: isDesktop ? 46 : 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'That Drive Results',
                      style: GoogleFonts.instrumentSans(
                        color: AppColors.primary,
                        fontSize: isDesktop ? 46 : 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Center(
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _serviceCardWrapper(
                      context,
                      'assets/3.webp',
                      'Web\nApplication',
                      'We design and develop powerful web applications with user-friendly interfaces and robust functionality. From business portals to custom platforms, our solutions are secure, scalable, and optimized to help your business grow online.',
                      '/webpage',
                      delayMs: 0,
                    ),
                    _serviceCardWrapper(
                      context,
                      'assets/4.webp',
                      'Software\nApplications',
                      'Our software solutions are tailored to meet the unique needs of your business. From desktop applications to enterprise-level systems, we deliver reliable, efficient, and scalable software that streamlines processes and drives productivity.',
                      '/softwarepage',
                      delayMs: 50,
                    ),
                    _serviceCardWrapper(
                      context,
                      'assets/5.webp',
                      'Hardware &\nNetworking',
                      'We provide end-to-end hardware and networking services, from installation to maintenance. Our team ensures that your IT infrastructure is fast, secure, and dependable, helping your business stay connected without downtime.',
                      '/hardwarepage',
                      delayMs: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceCardWrapper(
    BuildContext context,
    String image,
    String title,
    String desc,
    String route, {
    required int delayMs,
  }) {
    return FadeInOnScroll(
      delay: Duration(milliseconds: delayMs),
      child: _buildServiceCard(context, image, title, desc, route),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String image,
    String title,
    String desc,
    String route,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Container(
      width: isDesktop ? 400 : 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          bottom: BorderSide(color: AppColors.primary, width: 8),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                gaplessPlayback: true,
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: GoogleFonts.instrumentSans(
                fontSize: isDesktop ? 22 : 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              desc,
              textAlign: TextAlign.justify,
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 15 : 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.push(route),
              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Learn More',
                    style: GoogleFonts.instrumentSans(
                      fontSize: isDesktop ? 18 : 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.arrow_forward, size: isDesktop ? 24 : 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

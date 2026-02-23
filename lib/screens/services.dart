import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veda_main/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:veda_main/popupanime.dart';
import 'package:veda_main/stylecard.dart';
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
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        delay: const Duration(
                          milliseconds: 0,
                        ), // second comes later

                        child: StyledCardSection(
                          pageKey: 'web_page',
                          cardIndex: 0,
                          imagePath: 'assets/3.webp',
                          title: 'Web Application',
                          description:
                              'We design and develop powerful web applications with user-friendly interfaces and robust functionality. From business portals to custom platforms, our solutions are secure, scalable, and optimized to help your business grow online.',
                          onTap: () => context.go('/webapp'),
                          showLearnMore: true,
                        ),
                      ),
                    ),
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        delay: const Duration(
                          milliseconds: 50,
                        ), // second comes later

                        child: StyledCardSection(
                          pageKey: 'sftwr_page',
                          cardIndex: 1,
                          imagePath: 'assets/4.webp',
                          title: 'Software Applications',
                          description:
                              'Our software solutions are tailored to meet the unique needs of your business. From desktop applications to enterprise-level systems, we deliver reliable, efficient, and scalable software that streamlines processes and drives productivity.',
                          onTap: () => context.go('/software'),
                          showLearnMore: true,
                        ),
                      ),
                    ),
                    RepaintBoundary(
                      child: FadeInOnScroll(
                        delay: const Duration(
                          milliseconds: 100,
                        ), // second comes later

                        child: StyledCardSection(
                          pageKey: 'hrdwr_page',
                          cardIndex: 2,
                          imagePath: 'assets/5.webp',
                          title: 'Hardware & Networking',
                          description:
                              'We provide end-to-end hardware and networking services, from installation to maintenance. Our team ensures that your IT infrastructure is fast, secure, and dependable, helping your business stay connected without downtime.',
                          onTap: () => context.go('/hardware'),
                          showLearnMore: true,
                        ),
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
  }
}

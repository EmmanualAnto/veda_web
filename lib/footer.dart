import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veda_main/constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> launchWeb(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(13, 20, 45, 1)),
      padding: const EdgeInsets.all(40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 800;
          double contentWidth = constraints.maxWidth > 1200
              ? 1200
              : constraints.maxWidth;

          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildLeftSection(isMobile),
                            const SizedBox(height: 30),
                            _buildRightSection(isMobile, context),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildLeftSection(isMobile),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              flex: 1,
                              child: _buildRightSection(isMobile, context),
                            ),
                          ],
                        ),
                  const SizedBox(height: 40),
                  const Divider(color: Colors.white24, thickness: 1),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      '© 2025 Veda Systems Solutions – Bahrain.\nAll rights reserved.',
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(217, 217, 217, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeftSection(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/logo.webp',
          height: 80,
          width: 220,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? 400 : 600),
          child: Text(
            'Smart, secure, and scalable tech solutions — helping businesses in Bahrain and beyond grow through custom software, modern web apps, and strong IT infrastructure.',
            style: GoogleFonts.poppins(
              color: const Color.fromRGBO(238, 238, 238, 1),
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: isMobile
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            _buildSocialIcon(FontAwesomeIcons.instagram, () {
              launchWeb("https://instagram.com/vedasystems");
            }),
            const SizedBox(width: 15),
            _buildSocialIcon(FontAwesomeIcons.linkedin, () {
              launchWeb("https://linkedin.com/company/vedasystems");
            }),
            const SizedBox(width: 15),
            _buildSocialIcon(FontAwesomeIcons.facebook, () {
              launchWeb("https://facebook.com/vedasystems");
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildRightSection(bool isMobile, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: '// ',
                style: GoogleFonts.instrumentSans(
                  color: AppColors.primary,
                  fontSize: desktop ? 25 : 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                text: 'Company',
                style: GoogleFonts.instrumentSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(238, 238, 238, 1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FooterLink(
          text: 'About Us',
          onTap: () => context.go('/about'),
        ), // updated
        FooterLink(
          text: 'Our Services',
          onTap: () => context.go('/services'),
        ), // updated
        FooterLink(
          text: 'Why Us?',
          onTap: () => context.go('/why-us'),
        ), // updated
        FooterLink(
          text: 'Contact Us',
          onTap: () => context.go('/contact-us'),
        ), // updated
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onPressed) {
    final hover = ValueNotifier(false);

    return MouseRegion(
      onEnter: (_) => hover.value = true,
      onExit: (_) => hover.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: ValueListenableBuilder<bool>(
          valueListenable: hover,
          builder: (context, isHovering, _) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isHovering
                    ? AppColors.primary.withOpacity(0.75)
                    : AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            );
          },
        ),
      ),
    );
  }
}

class FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const FooterLink({super.key, required this.text, required this.onTap});

  @override
  State<FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<FooterLink> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: widget.onTap,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              color: hovering
                  ? AppColors.primary
                  : const Color.fromRGBO(238, 238, 238, 1),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

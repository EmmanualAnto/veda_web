import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LetsTalkSection extends StatelessWidget {
  const LetsTalkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Container(
      width: double.infinity,
      height: desktop ? 715 : null, // fixed height for desktop, auto for mobile
      constraints: const BoxConstraints(minHeight: 500),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset('assets/last.png', fit: BoxFit.cover),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(3, 9, 35, 0.94),
                    Color.fromRGBO(3, 9, 35, 0.90),
                    Color.fromRGBO(3, 9, 35, 0.85),
                    Color.fromRGBO(3, 9, 35, 0.80),
                    Color.fromRGBO(3, 9, 35, 0.75),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: desktop ? 130 : 30,
              vertical: desktop ? 100 : 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Section title
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '// ',
                        style: GoogleFonts.instrumentSans(
                          color: const Color(0xFF0035FF),
                          fontSize: desktop ? 25 : 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: "Let's Talk",
                        style: GoogleFonts.instrumentSans(
                          color: Colors.white,
                          fontSize: desktop ? 22 : 16,
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
                        text: "Tell us what you're\n",
                        style: GoogleFonts.instrumentSans(
                          color: Colors.white,
                          fontSize: desktop ? 46 : 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: "Working on",
                        style: GoogleFonts.instrumentSans(
                          color: const Color(0xFF0035FF),
                          fontSize: desktop ? 46 : 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Row for desktop / Column for mobile
                desktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Flexible(fit: FlexFit.loose, child: _ContactInfo()),
                          SizedBox(width: 30),
                          Flexible(
                            fit: FlexFit.loose,
                            child: _FormFields(isMobile: false),
                          ),
                        ],
                      )
                    : const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ContactInfo(),
                          SizedBox(height: 30),
                          _FormFields(isMobile: true),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------- Contact Info ----------------------
class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "We'll help you\nbuild the right solution",
          style: GoogleFonts.instrumentSans(
            fontSize: desktop ? 22 : 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 30),
        const ContactInfoItem(
          icon: Icons.email_outlined,
          text: 'info@vedabahrain.com',
          textColor: Colors.white,
        ),
        SizedBox(height: 20),
        const ContactInfoItem(
          icon: Icons.location_on_outlined,
          text: 'Manama, Kingdom of Bahrain',
          textColor: Colors.white,
        ),
        SizedBox(height: 20),
        const ContactInfoItem(
          icon: Icons.local_phone_outlined,
          text: '+973 17 374742',
          textColor: Colors.white,
        ),
      ],
    );
  }
}

// ---------------------- Form Fields ----------------------
class _FormFields extends StatelessWidget {
  final bool isMobile;
  const _FormFields({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CustomTextField(label: 'Name', icon: Icons.person_4_outlined),
        const SizedBox(height: 12),
        _CustomTextField(label: 'Email', icon: Icons.email_outlined),
        const SizedBox(height: 12),
        _CustomTextField(label: 'Phone', icon: Icons.phone_outlined),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          width: 564,
          child: TextField(
            style: GoogleFonts.poppins(color: Colors.white),
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: GoogleFonts.poppins(color: Colors.white70),
              filled: true,
              fillColor: Colors.white.withOpacity(0.16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              alignLabelWithHint: true,
            ),
            textAlignVertical: TextAlignVertical.top,
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 157,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(0, 53, 255, 1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Submit',
                    style: GoogleFonts.instrumentSans(fontSize: 16),
                  ),
                  const Icon(Icons.arrow_forward_rounded),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------- Custom Text Field ----------------------
class _CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  const _CustomTextField({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 564,
      height: 48,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.16),
          contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          prefixIcon: icon != null ? Icon(icon, color: Colors.white70) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

// ---------------------- Contact Info Item ----------------------
class ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.text,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Row(
      children: [
        const SizedBox(width: 5),
        Icon(icon, color: Colors.white),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.instrumentSans(
            color: textColor,
            fontSize: desktop ? 18 : 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:veda_main/veda_page_layout.dart';

// Assuming these are your custom internal imports
// import 'package:veda_main/main.dart';
// import 'package:veda_main/veda_page_layout.dart';

class AppColors {
  static const primary = Color(0xFF017697);
  static const surface = Color(0xFFFFFFFF);
  static const background = Color(0xFFF8FAFC);
  static const textPrimary = Color(0xFF0F172A);
  static const textSecondary = Color(0xFF64748B);
  static const border = Color(0xFFE2E8F0);
}

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage>
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 950;

    return VedaPageLayout(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Positioned.fill(
              child: CustomPaint(
                painter: _DynamicFluidPainter(_controller.value),
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(isDesktop),
                _buildUnifiedContainer(isDesktop),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 100 : 24,
        isDesktop ? 80 : 60,
        isDesktop ? 100 : 24,
        40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGlassBadge("CONTACT US"),
          const SizedBox(height: 16),
          Text(
            "Let’s build something\nexceptional together.",
            style: GoogleFonts.wittgenstein(
              fontSize: isDesktop ? 56 : 32,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -1.5,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1), // Subtle tint
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2), // Delicate border
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildUnifiedContainer(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 20),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 40,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        // Removed IntrinsicHeight to prevent unbounded height errors
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align to top
                children: [
                  Expanded(flex: 2, child: _buildInfoSide()),
                  Container(width: 1, color: AppColors.border.withOpacity(0.5)),
                  Expanded(flex: 3, child: _buildFormSide()),
                ],
              )
            : Column(
                children: [
                  _buildInfoSide(),
                  Divider(height: 1, color: AppColors.border.withOpacity(0.5)),
                  _buildFormSide(),
                ],
              ),
      ),
    );
  }

  Widget _buildInfoSide() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 950;
    return Container(
      padding: const EdgeInsets.all(50),
      color: const Color(0xFFF8FAFC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Tell column to only take needed space
        children: [
          Text(
            "Expertise & Solutions",
            style: GoogleFonts.poppins(
              fontSize: isDesktop ? 20 : 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Discuss your requirements with our technical specialists in Bahrain.",
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
          _buildServiceItem("Custom Software Development"),
          _buildServiceItem("Mobile App Solutions"),
          _buildServiceItem("Cloud Infrastructure & Security"),
          _buildServiceItem("Digital Transformation Consulting"),
          _buildServiceItem("Digital Transformation Consulting"),
          const SizedBox(height: 50),
          const _ContactInfoGrid(),

          // FIX: Removed Spacer() and replaced with SizedBox
          const SizedBox(height: 40),

          const Divider(),
          const SizedBox(height: 20),
          Text(
            "TRUSTED TECHNOLOGY PARTNER",
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 12 : 10,
              fontWeight: FontWeight.w800,
              color: AppColors.textSecondary.withOpacity(0.6),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String text) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 950;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: isDesktop ? 15 : 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSide() {
    return const Padding(padding: EdgeInsets.all(48), child: _FormFields());
  }
}

// ---------------------- CONTACT INFO GRID ----------------------
class _ContactInfoGrid extends StatelessWidget {
  const _ContactInfoGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _infoTile(
          Icons.alternate_email_rounded,
          "Email us",
          "info@vedabahrain.com",
          () => _launchEmail('info@vedabahrain.com'),
        ),
        _infoTile(
          Icons.map_outlined,
          "Visit us",
          "Manama, Kingdom of Bahrain",
          _launchMap,
        ),
        _infoTile(
          Icons.phone_iphone_rounded,
          "Call us",
          "+973 17 374742",
          () => _launchPhone('+97317374742'),
        ),
      ],
    );
  }

  Widget _infoTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- FORM LOGIC ----------------------
class _FormFields extends StatefulWidget {
  const _FormFields();

  @override
  State<_FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<_FormFields> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for data extraction
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  void _submitForm() async {
    // 1. Validate Form Fields
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      // 2. HTTP POST Request
      final response = await http
          .post(
            Uri.parse(
              "http://localhost:5000/send",
            ), // Update this for production
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "name": _nameController.text.trim(),
              "email": _emailController.text.trim(),
              "phone": _phoneController.text.trim(),
              "message": _messageController.text.trim(),
            }),
          )
          .timeout(const Duration(seconds: 10)); // Added timeout for better UX

      if (response.statusCode == 200) {
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();
        _showSnackBar("Message sent successfully!", isError: false);
      } else {
        _showSnackBar(
          "Server error (${response.statusCode}). Please try again.",
        );
      }
    } catch (e) {
      _showSnackBar("Connection error. Is the server running?");
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showSnackBar(String msg, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
        backgroundColor: isError ? Colors.redAccent : AppColors.primary,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CustomField(
            label: "Full Name",
            hint: "e.g. Abdullah Al-Sayed",
            controller: _nameController,
            validator: (value) => (value == null || value.isEmpty)
                ? "Please enter your name"
                : null,
          ),
          const SizedBox(height: 24),
          _CustomField(
            label: "Email Address",
            hint: "name@company.com",
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          _CustomField(
            label: "Phone Number",
            hint: "+973 ........",
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          _CustomField(
            label: "Your Message",
            hint: "How can we help you?",
            controller: _messageController,
            maxLines: 4,
            validator: (value) => (value == null || value.isEmpty)
                ? "Message cannot be empty"
                : null,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      "Send Message",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// Updated CustomField to support validation and keyboard types
class _CustomField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const _CustomField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: AppColors.textSecondary.withOpacity(0.7),
              fontSize: 14,
            ),
            filled: true,
            fillColor: AppColors.background,
            contentPadding: const EdgeInsets.all(16),
            errorStyle: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.redAccent,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _DynamicFluidPainter extends CustomPainter {
  final double animationValue;
  _DynamicFluidPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    final path = Path();
    final double yOffset = size.height * 0.20;
    path.moveTo(0, yOffset);
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i,
        yOffset +
            math.sin(
                  (i / size.width * 2 * math.pi) +
                      (animationValue * 2 * math.pi),
                ) *
                30,
      );
    }
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _DynamicFluidPainter oldDelegate) => true;
}

// ---------------------- HELPERS ----------------------
Future<void> _launchEmail(String email) async =>
    await launchUrl(Uri(scheme: 'mailto', path: email));
Future<void> _launchPhone(String num) async =>
    await launchUrl(Uri(scheme: 'tel', path: num));
Future<void> _launchMap() async =>
    await launchUrl(Uri.parse("https://maps.google.com"));

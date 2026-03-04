import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:veda_main/constants.dart';

class LetsTalkSection extends StatelessWidget {
  final double? height;
  const LetsTalkSection({super.key, this.height});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: desktop ? 100 : 20,
        vertical: 60,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 50,
              spreadRadius: -10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              // 1. BASE COLOR LAYER (Soft Lavender/Blue)
              Positioned.fill(child: Container(color: const Color(0xFFFBFBFF))),

              // 2. VIBRANT MESH COLOR BLOBS
              // Top Right Glow (Brand Color)
              Positioned(
                top: -150,
                right: -50,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.25),
                  ),
                ),
              ),

              // Bottom Left Glow (Warm Accent)
              Positioned(
                bottom: -100,
                left: -50,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.15),
                  ),
                ),
              ),

              // 3. BLUR LAYER (Creates the "Clean Mesh" look)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                  child: Container(color: Colors.transparent),
                ),
              ),
              // 5. THE CONTENT
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: desktop ? 60 : 25,
                  vertical: desktop ? 60 : 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Span
                    RichText(
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
                            text: "Let's Talk",
                            style: GoogleFonts.instrumentSans(
                              color: Colors.black87,
                              fontSize: desktop ? 22 : 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Main Heading
                    Text(
                      "Tell us what you're working on",
                      style: GoogleFonts.instrumentSans(
                        color: Colors.black,
                        fontSize: desktop ? 46 : 28,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Layout (Row/Column)
                    desktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Flexible(child: _ContactInfo()),
                              const SizedBox(width: 50),
                              Flexible(child: _FormFields(isMobile: false)),
                            ],
                          )
                        : Column(
                            children: [
                              const _ContactInfo(),
                              const SizedBox(height: 40),
                              _FormFields(isMobile: true),
                            ],
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

class DotMatrixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
          .withOpacity(0.12) // Subtle dots
      ..style = PaintingStyle.fill;

    const double spacing = 25.0; // Space between dots
    const double dotSize = 1.2; // Size of each dot

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
            color: Colors.black87, // Changed to Dark
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 30),

        ContactInfoItem(
          icon: Icons.email_outlined,
          text: 'info@vedabahrain.com',
          textColor: Colors.black87, // Changed to Dark
          onTap: () => _launchEmail('info@vedabahrain.com'),
        ),

        const SizedBox(height: 20),

        ContactInfoItem(
          icon: Icons.location_on_outlined,
          text: 'Manama, Kingdom of Bahrain',
          textColor: Colors.black87, // Changed to Dark
          onTap: _launchMap,
        ),

        const SizedBox(height: 20),

        ContactInfoItem(
          icon: Icons.local_phone_outlined,
          text: '+973 17 374742',
          textColor: Colors.black87, // Changed to Dark
          onTap: () => _launchPhone('+97317374742'),
        ),
      ],
    );
  }
}

// ---------------------- Contact Info Item (Updated Icon Colors) ----------------------
class ContactInfoItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final VoidCallback? onTap;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.text,
    this.textColor = Colors.black87, // Default to dark
    this.onTap,
  });

  @override
  State<ContactInfoItem> createState() => _ContactInfoItemState();
}

class _ContactInfoItemState extends State<ContactInfoItem> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: GoogleFonts.instrumentSans(
            color: hovering ? AppColors.primary : widget.textColor,
            fontSize: desktop ? 18 : 16,
            fontWeight: FontWeight.w500,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                child: Icon(
                  widget.icon,
                  color: hovering
                      ? AppColors.primary
                      : Colors.black54, // Icon visibility
                ),
              ),
              const SizedBox(width: 10),
              Text(widget.text),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------- Custom Text Field (Light Mode Look) ----------------------
class _CustomTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final int? minLines;
  final int? maxLines;
  final AutovalidateMode? autovalidateMode;

  const _CustomTextField({
    required this.label,
    this.icon,
    this.controller,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.minLines,
    this.maxLines,
    this.autovalidateMode,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
      keyboardType: widget.label == "Phone"
          ? TextInputType.phone
          : (widget.label == "Email"
                ? TextInputType.emailAddress
                : TextInputType.multiline),
      textInputAction: widget.textInputAction,
      style: const TextStyle(color: Colors.black), // Text color black
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines ?? 1,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: GoogleFonts.poppins(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.08), // Subtle grey background
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: Colors.black45)
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}

class _FormFields extends StatefulWidget {
  final bool isMobile;
  const _FormFields({required this.isMobile});

  @override
  State<_FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<_FormFields> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false; // 👈 track submit state
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onTextChanged);
    _emailController.addListener(_onTextChanged);
    _phoneController.addListener(_onTextChanged);
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true); // disable button

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final message = _messageController.text.trim();

    try {
      final response = await http.post(
        Uri.parse("http://localhost:5000/send"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "message": message,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        // Reset form state and clear warnings
        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();

        setState(() {
          _autoValidateMode =
              AutovalidateMode.disabled; // 👈 disable all warnings
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            content: Row(
              children: const [
                Icon(Icons.check_circle_outline, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Thank you for contacting us. We will get back to you soon.",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        // Show server error message if available
        String errorMsg = "Failed to send message. Please try again later.";
        try {
          final data = jsonDecode(response.body);
          if (data['message'] != null) {
            errorMsg = data['message'];
          }
        } catch (_) {}

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    errorMsg,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e, stack) {
      // Log exact error for debugging
      print('Error sending message: $e');
      print(stack);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          content: Row(
            children: const [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Error connecting to server.",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          duration: Duration(seconds: 4),
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() => _isSubmitting = false); // enable button
    }
  }

  void _onTextChanged() {
    if (_autoValidateMode != AutovalidateMode.onUserInteraction) {
      setState(() => _autoValidateMode = AutovalidateMode.onUserInteraction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, // shrink to content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CustomTextField(
            controller: _nameController,
            label: 'Name',
            icon: Icons.person_4_outlined,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name is required';
              }
              return null;
            },
            autovalidateMode: _autoValidateMode,
          ),
          const SizedBox(height: 12),
          _CustomTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
            autovalidateMode: _autoValidateMode,
          ),
          const SizedBox(height: 12),
          _CustomTextField(
            controller: _phoneController,
            label: 'Phone',
            icon: Icons.phone_outlined,
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }
              if (!RegExp(r'^\+?\d{7,15}$').hasMatch(value)) {
                return 'Enter a valid phone number';
              }
              return null;
            },
            autovalidateMode: _autoValidateMode,
          ),
          const SizedBox(height: 12),
          _CustomTextField(
            controller: _messageController,
            label: 'Message',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Message cannot be empty';
              }
              return null;
            },
            autovalidateMode: _autoValidateMode,
            maxLines: 6, // 👈 allows 6 lines
            minLines: 3, // 👈 minimum height
          ),

          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 157,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: GoogleFonts.instrumentSans(fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        if (!_isSubmitting)
                          const Icon(Icons.arrow_forward_rounded, size: 20),
                      ],
                    ),
                    if (_isSubmitting)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
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
}

Future<void> _launchEmail(String email) async {
  final uri = Uri(scheme: 'mailto', path: email);
  await launchUrl(uri);
}

Future<void> _launchPhone(String number) async {
  final uri = Uri(scheme: 'tel', path: number);
  await launchUrl(uri);
}

Future<void> _launchMap() async {
  final uri = Uri.parse("https://maps.app.goo.gl/c8Cvqdb1xNkZwYQHA");
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

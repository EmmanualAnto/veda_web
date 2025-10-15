import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LetsTalkSection extends StatelessWidget {
  const LetsTalkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;

    return Container(
      width: double.infinity,
      height: 750,
      constraints: const BoxConstraints(minHeight: 500),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              gaplessPlayback: true,
              'assets/last.webp',
              fit: BoxFit.cover,
            ),
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
                        children: [
                          Flexible(fit: FlexFit.loose, child: _ContactInfo()),
                          SizedBox(width: 30),
                          Flexible(
                            fit: FlexFit.loose,
                            child: _FormFields(isMobile: false),
                          ),
                        ],
                      )
                    : Column(
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
        // Reset form state first
        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color(0xFF0035FF),
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
        String errorMsg = "Failed to send message. Please try again.";
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 32,
        ),
        child: IntrinsicHeight(
          child: Form(
            key: _formKey,
            child: Column(
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
                    if (!emailRegex.hasMatch(value))
                      return 'Enter a valid email';
                    return null;
                  },
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
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 90,
                  child: TextFormField(
                    controller: _messageController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                    style: GoogleFonts.poppins(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return 'Message cannot be empty';
                      return null;
                    },
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
                  ),
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
                        backgroundColor: const Color.fromRGBO(0, 53, 255, 1),
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
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20,
                                ),
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
          ),
        ),
      ),
    );
  }
}

class _CustomTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  const _CustomTextField({
    required this.label,
    this.icon,
    this.controller,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // Rebuild field to remove validation error when user types
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.label == "Phone"
          ? TextInputType.phone
          : (widget.label == "Email"
                ? TextInputType.emailAddress
                : TextInputType.text),
      textInputAction: widget.textInputAction,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: GoogleFonts.poppins(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.16),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        prefixIcon: widget.icon != null
            ? Icon(widget.icon, color: Colors.white70)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
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

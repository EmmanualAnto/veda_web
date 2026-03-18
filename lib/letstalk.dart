import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:veda_main/constants.dart';
import 'package:veda_main/whatsapp.dart';

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
              // Background
              Positioned.fill(child: Container(color: const Color(0xFFFBFBFF))),

              // Top Right Glow
              Positioned(
                top: -150,
                right: -50,
                child: _GlowCircle(
                  size: 350,
                  color: AppColors.primary.withOpacity(0.10),
                  blur: 400,
                ),
              ),

              // Bottom Left Glow
              Positioned(
                bottom: -100,
                left: -50,
                child: _GlowCircle(
                  size: 300,
                  color: Colors.blue.withOpacity(0.15),
                  blur: 300,
                ),
              ),

              // Painter
              Positioned.fill(
                child: CustomPaint(painter: _LetsTalkBackgroundPainter()),
              ),

              // CONTENT
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: desktop ? 80 : 25,
                  vertical: desktop ? 60 : 40,
                ),
                child: desktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(flex: 5, child: _LetsTalkLeft()),
                          SizedBox(width: 20),
                          Expanded(flex: 5, child: _LetsTalkRight()),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _LetsTalkLeft(),
                          SizedBox(height: 40),
                          _LetsTalkRight(),
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

class _LetsTalkLeft extends StatelessWidget {
  const _LetsTalkLeft();

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.of(context).size.width > 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
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

        // Heading
        Text(
          "Tell us what you're working on",
          style: GoogleFonts.instrumentSans(
            color: Colors.black,
            fontSize: desktop ? 46 : 28,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),

        const SizedBox(height: 30),

        const _ContactInfo(),
      ],
    );
  }
}

class _LetsTalkRight extends StatelessWidget {
  const _LetsTalkRight();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 800;

    return _FormFields(isMobile: isMobile);
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double blur;

  const _GlowCircle({
    required this.size,
    required this.color,
    required this.blur,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color, blurRadius: blur, spreadRadius: 10),
        ],
      ),
    );
  }
}

class _LetsTalkBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = AppColors.primary.withOpacity(0.04);

    final double scale = math.min(size.width / 180, size.height / 180) * 0.9;

    canvas.save();
    canvas.translate(
      (size.width - (180 * scale)) / 2,
      (size.height - (180 * scale)) / 2,
    );
    canvas.scale(scale);

    // 1. HANDSET
    final handsetPath = Path()
      ..moveTo(15, 50)
      ..cubicTo(15, 5, 165, 5, 165, 50)
      ..moveTo(165, 50)
      ..cubicTo(175, 60, 140, 85, 135, 65)
      ..moveTo(15, 50)
      ..cubicTo(5, 60, 40, 85, 45, 65);
    canvas.drawPath(handsetPath, borderPaint);

    // 2. CRADLE HOOKS
    final hooks = Path()
      ..moveTo(58, 45)
      ..quadraticBezierTo(58, 65, 75, 65)
      ..moveTo(122, 45)
      ..quadraticBezierTo(122, 65, 105, 65);
    canvas.drawPath(hooks, borderPaint);

    // 3. BODY
    final bodyPath = Path()
      ..moveTo(70, 65)
      ..lineTo(110, 65)
      ..cubicTo(140, 65, 170, 130, 165, 155)
      ..quadraticBezierTo(162, 170, 135, 170)
      ..lineTo(45, 170)
      ..quadraticBezierTo(18, 170, 15, 155)
      ..cubicTo(10, 130, 40, 65, 70, 65);
    canvas.drawPath(bodyPath, borderPaint);

    // 4. ROTARY DIAL
    final Offset dialCenter = const Offset(90, 115);
    final List<double> dialRadii = [42, 42 * 0.85, 42 * 0.35, 42 * 0.12];
    for (double r in dialRadii) {
      canvas.drawCircle(dialCenter, r, borderPaint);
    }

    // 5. FINGER HOLES
    for (int i = 0; i < 10; i++) {
      double angle = (i * 0.52) + 0.85;
      canvas.drawCircle(
        Offset(
          dialCenter.dx + (dialRadii[1] * 0.78) * math.cos(angle),
          dialCenter.dy + (dialRadii[1] * 0.78) * math.sin(angle),
        ),
        5.5,
        borderPaint,
      );
    }

    // 6. STOPPER
    final stopper = Path()
      ..moveTo(
        dialCenter.dx + dialRadii[0] * math.cos(0.55),
        dialCenter.dy + dialRadii[0] * math.sin(0.55),
      )
      ..quadraticBezierTo(
        dialCenter.dx + (dialRadii[0] + 12) * math.cos(0.45),
        dialCenter.dy + (dialRadii[0] + 12) * math.sin(0.45),
        dialCenter.dx + (dialRadii[0] + 8) * math.cos(0.35),
        dialCenter.dy + (dialRadii[0] + 8) * math.sin(0.35),
      );
    canvas.drawPath(stopper, borderPaint);

    // 7. COILED WRISTED CABLE
    final cablePath = Path();
    final Offset p0 = const Offset(25, 72);
    final Offset p1 = const Offset(-5, 95);
    final Offset p2 = const Offset(5, 155);
    final Offset p3 = const Offset(20, 155);

    const int steps = 200;
    const double rotations = 30.0;
    const double radius = 3.5;

    for (int i = 0; i <= steps; i++) {
      double t = i / steps;
      double x =
          math.pow(1 - t, 3) * p0.dx +
          3 * math.pow(1 - t, 2) * t * p1.dx +
          3 * (1 - t) * math.pow(t, 2) * p2.dx +
          math.pow(t, 3) * p3.dx;
      double y =
          math.pow(1 - t, 3) * p0.dy +
          3 * math.pow(1 - t, 2) * t * p1.dy +
          3 * (1 - t) * math.pow(t, 2) * p2.dy +
          math.pow(t, 3) * p3.dy;

      double tx =
          3 * math.pow(1 - t, 2) * (p1.dx - p0.dx) +
          6 * (1 - t) * t * (p2.dx - p1.dx) +
          3 * math.pow(t, 2) * (p3.dx - p2.dx);
      double ty =
          3 * math.pow(1 - t, 2) * (p1.dy - p0.dy) +
          6 * (1 - t) * t * (p2.dy - p1.dy) +
          3 * math.pow(t, 2) * (p3.dy - p2.dy);

      double len = math.sqrt(tx * tx + ty * ty);
      double nx = -ty / len;
      double ny = tx / len;

      double angle = t * rotations * 2 * math.pi;

      double cx = x + (math.cos(angle) * nx * radius);
      double cy = y + (math.sin(angle) * ny * radius * 0.5);

      if (i == 0) {
        cablePath.moveTo(cx, cy);
      } else {
        cablePath.lineTo(cx, cy);
      }
    }
    canvas.drawPath(cablePath, borderPaint);

    canvas.restore();
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
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.white),
                    const SizedBox(width: 8),

                    Text(
                      "Error connecting to server. Reach us via ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    // Clickable WhatsApp text
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        WhatsAppHelper.openChat(
                          phoneNumber: '+919961320030',
                          message: 'Hello, I have a query!',
                          context: context,
                        );
                      },
                      child: const Text(
                        "WhatsApp",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
    final screenWidth = MediaQuery.of(context).size.width;
    final desktop = screenWidth > 800;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, // shrink to content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (desktop) SizedBox(height: 40),
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
                  backgroundColor: _isSubmitting
                      ? Colors.transparent
                      : AppColors.primary,
                  foregroundColor: _isSubmitting
                      ? AppColors.primary
                      : Colors.white,
                  elevation: 0,
                  side: BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _isSubmitting
                      // 🔄 LOADING STATE
                      ? SizedBox(
                          key: const ValueKey('loader'),
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        )
                      // ✅ NORMAL STATE
                      : Row(
                          key: const ValueKey('text'),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Submit',
                              style: GoogleFonts.instrumentSans(fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_rounded, size: 20),
                          ],
                        ),
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

class WhatsAppHelper {
  static Future<void> openChat({
    required String phoneNumber,
    required String message,
    required BuildContext context,
  }) async {
    final Uri url = Uri.parse(
      "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("WhatsApp not installed")));
    }
  }
}

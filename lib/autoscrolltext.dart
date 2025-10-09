import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutoScrollClients extends StatefulWidget {
  final List<String> clients;
  final bool isMobile;
  final double topRowSpeedFactor;
  final double bottomRowSpeedFactor;

  const AutoScrollClients({
    super.key,
    required this.clients,
    required this.isMobile,
    this.topRowSpeedFactor = 1.0,
    this.bottomRowSpeedFactor = 1.0,
  });

  @override
  State<AutoScrollClients> createState() => _AutoScrollClientsState();
}

class _AutoScrollClientsState extends State<AutoScrollClients>
    with TickerProviderStateMixin {
  late AnimationController _topController;
  late AnimationController _bottomController;

  // Constant scroll velocity in pixels per second
  static const double _pixelsPerSecond = 90;

  @override
  void initState() {
    super.initState();

    // Constant loop duration (arbitrary, we use elapsed time not value)
    const loopDuration = Duration(seconds: 1000);

    _topController = AnimationController(duration: loopDuration, vsync: this)
      ..repeat();

    _bottomController = AnimationController(duration: loopDuration, vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  Widget _buildScrollingRow({
    required List<String> clients,
    required AnimationController controller,
    required double speedFactor,
  }) {
    if (clients.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = GoogleFonts.poppins(
          fontSize: widget.isMobile ? 22 : 26,
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(13, 20, 45, 1),
        );

        const double itemSpacing = 50.0;
        const double dotWidthAndSpacing = 10.0 + 20.0;

        double totalContentWidth = 0;
        for (final client in clients) {
          final textPainter = TextPainter(
            text: TextSpan(text: client, style: textStyle),
            textDirection: TextDirection.ltr,
          )..layout();
          totalContentWidth +=
              textPainter.width + dotWidthAndSpacing + itemSpacing;
        }

        return SizedBox(
          height: 40,
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final elapsedMs =
                  controller.lastElapsedDuration?.inMilliseconds ?? 0;
              final pxPerSec = _pixelsPerSecond * speedFactor;
              final offset =
                  (elapsedMs / 1000.0 * pxPerSec) % totalContentWidth;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildRowContent(clients, -offset),
                  _buildRowContent(clients, totalContentWidth - offset),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDotAndSpacing() {
    const double halfSpacing = 12.5; // half of desired spacing (25px)
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: halfSpacing),
      child: SizedBox(
        width: 10,
        height: 10,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 53, 255, 1),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildRowContent(List<String> clients, double offset) {
    return Positioned(
      left: offset,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < clients.length; i++) ...[
            Text(
              clients[i],
              style: GoogleFonts.poppins(
                fontSize: widget.isMobile ? 20 : 26,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(13, 20, 45, 1),
              ),
            ),
            // Add dot + spacing only if not the last client in the list
            _buildDotAndSpacing(),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clients.isEmpty) return const SizedBox.shrink();

    if (!widget.isMobile) {
      return _buildScrollingRow(
        clients: widget.clients,
        controller: _topController,
        speedFactor: widget.topRowSpeedFactor,
      );
    }

    final mid = (widget.clients.length / 2).ceil();
    final firstRowClients = widget.clients.sublist(0, mid);
    final secondRowClients = widget.clients.sublist(mid);

    if (firstRowClients.isEmpty && secondRowClients.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        _buildScrollingRow(
          clients: firstRowClients,
          controller: _topController,
          speedFactor: widget.topRowSpeedFactor,
        ),
        const SizedBox(height: 10),
        _buildScrollingRow(
          clients: secondRowClients,
          controller: _bottomController,
          speedFactor: widget.bottomRowSpeedFactor,
        ),
      ],
    );
  }
}

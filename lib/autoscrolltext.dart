import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AutoScrollClients extends StatefulWidget {
  final List<String> clients;
  final bool isMobile;
  final double topRowSpeed; // e.g., 0.8 = normal
  final double bottomRowSpeed; // e.g., 1.2 = faster

  const AutoScrollClients({
    super.key,
    required this.clients,
    required this.isMobile,
    this.topRowSpeed = 0.8,
    this.bottomRowSpeed = 1.2,
  });

  @override
  State<AutoScrollClients> createState() => _AutoScrollClientsState();
}

class _AutoScrollClientsState extends State<AutoScrollClients>
    with TickerProviderStateMixin {
  late AnimationController _topController;
  late Animation<double> _topAnimation;

  late AnimationController _bottomController;
  late Animation<double> _bottomAnimation;

  @override
  void initState() {
    super.initState();

    const baseDuration = 20.0;

    _topController = AnimationController(
      duration: Duration(seconds: (baseDuration / widget.topRowSpeed).round()),
      vsync: this,
    )..repeat();

    _topAnimation = Tween<double>(begin: 0, end: 1).animate(_topController);

    _bottomController = AnimationController(
      duration: Duration(
        seconds: (baseDuration / widget.bottomRowSpeed).round(),
      ),
      vsync: this,
    )..repeat();

    _bottomAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_bottomController);
  }

  @override
  void dispose() {
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  Widget _buildScrollingRow(List<String> clients, Animation<double> animation) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = GoogleFonts.poppins(
          fontSize: widget.isMobile ? 22 : 26,
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(13, 20, 45, 1),
        );

        // calculate total width of items
        double totalContentWidth = 0;
        final List<double> itemWidths = [];
        for (final client in clients) {
          final textPainter = TextPainter(
            text: TextSpan(text: client, style: textStyle),
            textDirection: TextDirection.ltr,
          )..layout();
          final width = textPainter.width + 30; // add spacing
          itemWidths.add(width);
          totalContentWidth += width;
        }

        totalContentWidth += (clients.length) * 20; // dots
        totalContentWidth += 80; // horizontal padding

        return SizedBox(
          height: 40,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final offset = animation.value * totalContentWidth;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildRowContent(clients, itemWidths, -offset),
                  _buildRowContent(
                    clients,
                    itemWidths,
                    totalContentWidth - offset,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRowContent(
    List<String> clients,
    List<double> itemWidths,
    double offset,
  ) {
    return Positioned(
      left: offset,
      child: Row(
        children: List.generate(clients.length, (index) {
          final client = clients[index];
          final isLast = index == clients.length - 1;

          return Row(
            children: [
              Text(
                client,
                style: GoogleFonts.poppins(
                  fontSize: widget.isMobile ? 20 : 26,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(13, 20, 45, 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: isLast ? 0 : 20),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 53, 255, 1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isMobile) {
      return _buildScrollingRow(widget.clients, _topAnimation);
    }

    // split for mobile
    final mid = (widget.clients.length / 2).ceil();
    final firstRowClients = widget.clients.sublist(0, mid);
    final secondRowClients = widget.clients.sublist(mid);

    return Column(
      children: [
        _buildScrollingRow(firstRowClients, _topAnimation),
        const SizedBox(height: 10),
        _buildScrollingRow(secondRowClients, _bottomAnimation),
      ],
    );
  }
}

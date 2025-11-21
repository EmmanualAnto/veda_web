import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientReel extends StatefulWidget {
  final List<String> clients;
  final double speed; // pixels per second

  const ClientReel({super.key, required this.clients, this.speed = 50});

  @override
  State<ClientReel> createState() => _ClientReelState();
}

class _ClientReelState extends State<ClientReel> with TickerProviderStateMixin {
  late final ScrollController _topController;
  late final ScrollController _bottomController;

  @override
  void initState() {
    super.initState();
    _topController = ScrollController();
    _bottomController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final isMobile = screenWidth < 800;

      if (isMobile) {
        final mid = (widget.clients.length / 2).ceil();
        _startScrolling(_topController, widget.clients.sublist(0, mid));
        _startScrolling(_bottomController, widget.clients.sublist(mid));
      } else {
        _startScrolling(_topController, widget.clients);
      }
    });
  }

  void _startScrolling(
    ScrollController controller,
    List<String> clients,
  ) async {
    final extendedClients = [...clients, ...clients];
    while (mounted) {
      double listWidth = 0;
      for (var client in extendedClients) {
        final tp = TextPainter(
          text: TextSpan(
            text: client,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(13, 20, 45, 1),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        listWidth += tp.width + 8 * 2 + 10; // text + padding + dot
      }

      await controller.animateTo(
        listWidth,
        duration: Duration(seconds: (listWidth / widget.speed).round()),
        curve: Curves.linear,
      );
      if (!mounted) return;
      controller.jumpTo(0);
    }
  }

  Widget _buildScrollingRow(
    ScrollController controller,
    List<String> clients,
    bool isMobile,
  ) {
    final extendedClients = [...clients, ...clients];

    return SizedBox(
      height: 40,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent,
            ],
            stops: const [0.0, 0.08, 0.92, 1.0], // adjust width of fade
          ).createShader(Rect.fromLTWH(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: ListView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: extendedClients.length * 2 - 1,
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 10,
                  height: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 53, 255, 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            } else {
              final clientIndex = index ~/ 2;
              final client = extendedClients[clientIndex];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    client,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 20 : 26,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(13, 20, 45, 1),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    if (!isMobile) {
      return _buildScrollingRow(_topController, widget.clients, isMobile);
    }

    final mid = (widget.clients.length / 2).ceil();
    final firstRowClients = widget.clients.sublist(0, mid);
    final secondRowClients = widget.clients.sublist(mid);

    return Column(
      children: [
        _buildScrollingRow(_topController, firstRowClients, isMobile),
        const SizedBox(height: 10),
        _buildScrollingRow(_bottomController, secondRowClients, isMobile),
      ],
    );
  }
}

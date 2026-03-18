import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class ProfessionalBackgroundPainter extends CustomPainter {
  Picture? _cachedPicture;

  static const Color baseColor = Color.fromARGB(30, 1, 118, 151);
  double _s(Size size, double v) {
    return v; // fixed size for all screens
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_cachedPicture == null) {
      final recorder = PictureRecorder();
      final c = Canvas(recorder, Rect.fromLTWH(0, 0, size.width, size.height));

      _drawTechNodes(c, size);
      _drawBeams(c, size);
      _drawITEquipment(c, size);

      _cachedPicture = recorder.endRecording();
    }

    canvas.drawPicture(_cachedPicture!);
  }

  void _drawTechNodes(Canvas canvas, Size size) {
    final nodePaint = Paint()..color = baseColor;

    final linePaint = Paint()
      ..color = baseColor
      ..strokeWidth = _s(size, 0.6);

    final centers = [
      Offset(size.width * 0.2, size.height * 0.25),
      Offset(size.width * 0.75, size.height * 0.15),
      Offset(size.width * 0.5, size.height * 0.7),
      Offset(size.width * 0.15, size.height * 0.6),
      Offset(size.width * 0.85, size.height * 0.8),
    ];

    for (var center in centers) {
      for (int i = 0; i < 5; i++) {
        final offset =
            center +
            Offset(
              math.sin(i * 1.7) * _s(size, 25),
              math.cos(i * 1.7) * _s(size, 25),
            );

        canvas.drawCircle(offset, _s(size, 2), nodePaint);

        if (i > 0) {
          final prev =
              center +
              Offset(
                math.sin((i - 1) * 1.7) * _s(size, 25),
                math.cos((i - 1) * 1.7) * _s(size, 25),
              );

          canvas.drawLine(prev, offset, linePaint);
        }
      }
    }
  }

  void _drawBeams(Canvas canvas, Size size) {
    final beamPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.cyanAccent.withOpacity(0),
          Colors.cyanAccent.withOpacity(0.08),
          Colors.cyanAccent.withOpacity(0.12),
          Colors.cyanAccent.withOpacity(0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, 2))
      ..strokeWidth = _s(size, 1);

    canvas.drawLine(
      Offset(-_s(size, 50), size.height * 0.1),
      Offset(size.width * 0.7, size.height * 0.3),
      beamPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.6),
      Offset(size.width + _s(size, 50), size.height * 0.4),
      beamPaint,
    );
  }

  void _drawITEquipment(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _s(size, 1.1);

    _drawCloud(
      canvas,
      size,
      Offset(size.width * 0.10, size.height * 0.08),
      paint,
    );
    _drawMonitor(
      canvas,
      size,
      Offset(size.width * 0.35, size.height * 0.06),
      paint,
    );
    _drawLaptop(
      canvas,
      size,
      Offset(size.width * 0.60, size.height * 0.09),
      paint,
    );
    _drawCloud(
      canvas,
      size,
      Offset(size.width * 0.88, size.height * 0.07),
      paint,
    );

    _drawWifi(
      canvas,
      size,
      Offset(size.width * 0.06, size.height * 0.24),
      paint,
    );
    _drawChip(
      canvas,
      size,
      Offset(size.width * 0.25, size.height * 0.28),
      paint,
    );
    _drawRouter(
      canvas,
      size,
      Offset(size.width * 0.50, size.height * 0.22),
      paint,
    );
    _drawPhone(
      canvas,
      size,
      Offset(size.width * 0.72, size.height * 0.26),
      paint,
    );
    _drawMonitor(
      canvas,
      size,
      Offset(size.width * 0.94, size.height * 0.25),
      paint,
    );

    _drawDatabase(
      canvas,
      size,
      Offset(size.width * 0.08, size.height * 0.45),
      paint,
    );
    _drawSwitch(
      canvas,
      size,
      Offset(size.width * 0.30, size.height * 0.52),
      paint,
    );
    _drawServerRack(
      canvas,
      size,
      Offset(size.width * 0.55, size.height * 0.48),
      paint,
    );
    _drawLaptop(
      canvas,
      size,
      Offset(size.width * 0.80, size.height * 0.51),
      paint,
    );
    _drawChip(
      canvas,
      size,
      Offset(size.width * 0.96, size.height * 0.44),
      paint,
    );

    _drawPhone(
      canvas,
      size,
      Offset(size.width * 0.12, size.height * 0.72),
      paint,
    );
    _drawKeyboard(
      canvas,
      size,
      Offset(size.width * 0.38, size.height * 0.68),
      paint,
    );
    _drawMouse(
      canvas,
      size,
      Offset(size.width * 0.58, size.height * 0.75),
      paint,
    );
    _drawRouter(
      canvas,
      size,
      Offset(size.width * 0.78, size.height * 0.70),
      paint,
    );
    _drawWifi(
      canvas,
      size,
      Offset(size.width * 0.92, size.height * 0.68),
      paint,
    );

    _drawLaptop(
      canvas,
      size,
      Offset(size.width * 0.05, size.height * 0.83),
      paint,
    );
    _drawMouse(
      canvas,
      size,
      Offset(size.width * 0.18, size.height * 0.95),
      paint,
    );
    _drawDatabase(
      canvas,
      size,
      Offset(size.width * 0.28, size.height * 0.80),
      paint,
    );
    _drawCloud(
      canvas,
      size,
      Offset(size.width * 0.52, size.height * 0.94),
      paint,
    );
    _drawKeyboard(
      canvas,
      size,
      Offset(size.width * 0.75, size.height * 0.85),
      paint,
    );
    _drawPhone(
      canvas,
      size,
      Offset(size.width * 0.85, size.height * 0.95),
      paint,
    );
    _drawSwitch(
      canvas,
      size,
      Offset(size.width * 0.95, size.height * 0.92),
      paint,
    );

    _drawCable(canvas, size, paint);
  }

  void _drawLaptop(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawRect(
      Rect.fromCenter(center: c, width: _s(size, 55), height: _s(size, 35)),
      p,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: c.translate(0, _s(size, 25)),
        width: _s(size, 65),
        height: _s(size, 8),
      ),
      p,
    );
  }

  void _drawMonitor(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawRect(
      Rect.fromCenter(center: c, width: _s(size, 65), height: _s(size, 40)),
      p,
    );

    final stand = Path()
      ..moveTo(c.dx - _s(size, 10), c.dy + _s(size, 22))
      ..lineTo(c.dx + _s(size, 10), c.dy + _s(size, 22))
      ..lineTo(c.dx + _s(size, 5), c.dy + _s(size, 32))
      ..lineTo(c.dx - _s(size, 5), c.dy + _s(size, 32))
      ..close();

    canvas.drawPath(stand, p);

    canvas.drawRect(
      Rect.fromCenter(
        center: c.translate(0, _s(size, 37)),
        width: _s(size, 35),
        height: _s(size, 4),
      ),
      p,
    );
  }

  void _drawServerRack(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawRect(
      Rect.fromCenter(center: c, width: _s(size, 38), height: _s(size, 65)),
      p,
    );

    for (int i = -2; i <= 2; i++) {
      final y = c.dy + i * _s(size, 11);
      canvas.drawLine(
        Offset(c.dx - _s(size, 16), y),
        Offset(c.dx + _s(size, 16), y),
        p,
      );
    }
  }

  void _drawChip(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawRect(
      Rect.fromCenter(center: c, width: _s(size, 28), height: _s(size, 28)),
      p,
    );

    for (int i = -2; i <= 2; i++) {
      canvas.drawLine(
        Offset(c.dx - _s(size, 18), c.dy + i * _s(size, 6)),
        Offset(c.dx - _s(size, 14), c.dy + i * _s(size, 6)),
        p,
      );
      canvas.drawLine(
        Offset(c.dx + _s(size, 14), c.dy + i * _s(size, 6)),
        Offset(c.dx + _s(size, 18), c.dy + i * _s(size, 6)),
        p,
      );
    }
  }

  void _drawRouter(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawRect(
      Rect.fromCenter(center: c, width: _s(size, 40), height: _s(size, 14)),
      p,
    );
    canvas.drawLine(
      Offset(c.dx - _s(size, 8), c.dy - _s(size, 10)),
      Offset(c.dx - _s(size, 8), c.dy - _s(size, 2)),
      p,
    );
    canvas.drawLine(
      Offset(c.dx + _s(size, 8), c.dy - _s(size, 10)),
      Offset(c.dx + _s(size, 8), c.dy - _s(size, 2)),
      p,
    );
  }

  void _drawDatabase(Canvas canvas, Size size, Offset c, Paint p) {
    final rect = Rect.fromCenter(
      center: c,
      width: _s(size, 38),
      height: _s(size, 36),
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(c.dx, rect.top),
        width: _s(size, 38),
        height: _s(size, 10),
      ),
      p,
    );
    canvas.drawRect(
      Rect.fromLTRB(rect.left, rect.top, rect.right, rect.bottom),
      p,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(c.dx, rect.bottom),
        width: _s(size, 38),
        height: _s(size, 10),
      ),
      p,
    );
  }

  void _drawCloud(Canvas canvas, Size size, Offset c, Paint p) {
    final path = Path()
      ..addOval(
        Rect.fromCircle(
          center: c.translate(-_s(size, 10), 0),
          radius: _s(size, 9),
        ),
      )
      ..addOval(Rect.fromCircle(center: c, radius: _s(size, 11)))
      ..addOval(
        Rect.fromCircle(
          center: c.translate(_s(size, 10), 0),
          radius: _s(size, 9),
        ),
      );

    canvas.drawPath(path, p);
  }

  void _drawPhone(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: c, width: _s(size, 20), height: _s(size, 36)),
        Radius.circular(_s(size, 4)),
      ),
      p,
    );

    canvas.drawCircle(c.translate(0, _s(size, 13)), _s(size, 1.3), p);
  }

  void _drawKeyboard(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawRect(
      Rect.fromCenter(center: c, width: _s(size, 60), height: _s(size, 18)),
      p,
    );

    for (int i = -2; i <= 2; i++) {
      canvas.drawLine(
        Offset(c.dx - _s(size, 25), c.dy + i * _s(size, 3)),
        Offset(c.dx + _s(size, 25), c.dy + i * _s(size, 3)),
        p,
      );
    }
  }

  void _drawMouse(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawOval(
      Rect.fromCenter(center: c, width: _s(size, 16), height: _s(size, 24)),
      p,
    );
    canvas.drawLine(
      Offset(c.dx, c.dy - _s(size, 6)),
      Offset(c.dx, c.dy + _s(size, 2)),
      p,
    );
  }

  void _drawWifi(Canvas canvas, Size size, Offset c, Paint p) {
    p.style = PaintingStyle.stroke;
    p.strokeCap = StrokeCap.round;

    for (int i = 1; i <= 3; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: _s(size, i * 8)),
        -math.pi * 0.75,
        math.pi * 0.5,
        false,
        p,
      );
    }

    p.style = PaintingStyle.fill;
    canvas.drawCircle(c, _s(size, 1.8), p);
    p.style = PaintingStyle.stroke;
  }

  void _drawSwitch(Canvas canvas, Size size, Offset c, Paint p) {
    canvas.drawRect(
      Rect.fromCenter(center: c, width: _s(size, 40), height: _s(size, 14)),
      p,
    );

    for (int i = -2; i <= 2; i++) {
      canvas.drawCircle(Offset(c.dx + i * _s(size, 6), c.dy), _s(size, 1.5), p);
    }
  }

  void _drawCable(Canvas canvas, Size size, Paint p) {
    final path = Path();

    path.moveTo(size.width * 0.05, size.height * 0.9);

    for (
      double x = size.width * 0.05;
      x <= size.width * 0.95;
      x += _s(size, 20)
    ) {
      final y = size.height * 0.9 + math.sin(x / 30) * _s(size, 6);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

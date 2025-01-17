import 'package:flutter/material.dart';
import 'dart:math' as math;

class CryptoPricePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    var x = 0.0;
    final points = List.generate(100, (index) {
      final y = math.sin(index * 0.1) * 30 + size.height / 2;
      if (index == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      x += size.width / 100;
      return Offset(x, y);
    });

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 
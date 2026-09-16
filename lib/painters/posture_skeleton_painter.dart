import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/velmora_theme.dart';

class PostureSkeletonPainter extends CustomPainter {
  final double stretchProgress; // 0.0 to 1.0
  final String poseType; // 'Chest Opener', 'Neck Tilt', 'Spine Twist'

  PostureSkeletonPainter({
    required this.stretchProgress,
    required this.poseType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final centerX = w * 0.5;

    // Background card border
    final bgRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, w, h),
      const Radius.circular(16),
    );
    final bgPaint = Paint()
      ..color = VelmoraTheme.edge.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(bgRect, bgPaint);

    final bonePaint = Paint()
      ..color = VelmoraTheme.accent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    final jointPaint = Paint()
      ..color = VelmoraTheme.accentLight
      ..style = PaintingStyle.fill;

    // Head
    final headCenter = Offset(centerX, h * 0.22);
    canvas.drawCircle(headCenter, 14.0, jointPaint);
    canvas.drawCircle(headCenter, 14.0, bonePaint);

    // Neck to Spine
    final neck = Offset(centerX, h * 0.30);
    final midSpine = Offset(centerX + sin(stretchProgress * pi) * 12, h * 0.50);
    final pelvis = Offset(centerX, h * 0.70);

    final spinePath = Path()
      ..moveTo(neck.dx, neck.dy)
      ..quadraticBezierTo(midSpine.dx, midSpine.dy, pelvis.dx, pelvis.dy);
    canvas.drawPath(spinePath, bonePaint);

    // Shoulders
    final shoulderY = h * 0.35;
    final armExtend = 20.0 + stretchProgress * 15.0;
    final leftShoulder = Offset(centerX - 35, shoulderY);
    final rightShoulder = Offset(centerX + 35, shoulderY);

    canvas.drawLine(leftShoulder, rightShoulder, bonePaint);

    // Arms based on pose
    if (poseType == 'Chest Opener') {
      final leftHand = Offset(centerX - 35 - armExtend, shoulderY - 15 - (stretchProgress * 20));
      final rightHand = Offset(centerX + 35 + armExtend, shoulderY - 15 - (stretchProgress * 20));
      canvas.drawLine(leftShoulder, leftHand, bonePaint);
      canvas.drawLine(rightShoulder, rightHand, bonePaint);
      canvas.drawCircle(leftHand, 5, jointPaint);
      canvas.drawCircle(rightHand, 5, jointPaint);
    } else {
      final leftHand = Offset(centerX - 40, shoulderY + 35);
      final rightHand = Offset(centerX + 40, shoulderY + 35);
      canvas.drawLine(leftShoulder, leftHand, bonePaint);
      canvas.drawLine(rightShoulder, rightHand, bonePaint);
      canvas.drawCircle(leftHand, 5, jointPaint);
      canvas.drawCircle(rightHand, 5, jointPaint);
    }

    // Pelvis & Legs
    final leftHip = Offset(centerX - 22, pelvis.dy);
    final rightHip = Offset(centerX + 22, pelvis.dy);
    canvas.drawLine(leftHip, rightHip, bonePaint);

    final leftFoot = Offset(centerX - 24, h * 0.90);
    final rightFoot = Offset(centerX + 24, h * 0.90);
    canvas.drawLine(leftHip, leftFoot, bonePaint);
    canvas.drawLine(rightHip, rightFoot, bonePaint);

    canvas.drawCircle(neck, 4, jointPaint);
    canvas.drawCircle(pelvis, 5, jointPaint);
  }

  @override
  bool shouldRepaint(covariant PostureSkeletonPainter oldDelegate) {
    return oldDelegate.stretchProgress != stretchProgress ||
        oldDelegate.poseType != poseType;
  }
}

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  // static const String fontFamily = 'Pretendard';  // 주석 처리

  // 카드 스타일
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // 버튼 스타일
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // 텍스트 스타일
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );

  // 애니메이션 지속 시간
  static const Duration animationDuration = Duration(milliseconds: 300);
} 
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  // static const String fontFamily = 'Pretendard';  // 주석 처리

  // 카드 스타일
  static final cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // 버튼 스타일
  static final primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  // 텍스트 스타일
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Pretendard',
  );

  static const heading2 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Pretendard',
  );

  static const body1 = TextStyle(
    fontSize: 16,
    fontFamily: 'Pretendard',
  );

  static const body2 = TextStyle(
    fontSize: 14,
    fontFamily: 'Pretendard',
  );

  // 애니메이션 지속 시간
  static const animationDuration = Duration(milliseconds: 200);

  static final categoryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: AppColors.primary,
    elevation: 2,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

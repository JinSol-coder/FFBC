import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

class AppTypography {
  static const title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  
  static const subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  
  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.subtext,
  );
} 
import 'package:flutter/cupertino.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class MoodButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const MoodButton({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: AppColors.text.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            Icon(icon, color: AppColors.text, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTypography.body.copyWith(
                color: AppColors.text,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        onPressed: () {
          // TODO: 무드 선택 처리
        },
      ),
    );
  }
} 
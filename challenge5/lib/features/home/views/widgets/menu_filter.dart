import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class MenuFilter extends StatelessWidget {
  final bool showHotOnly;
  final bool showEventOnly;
  final VoidCallback onHotToggle;
  final VoidCallback onEventToggle;

  const MenuFilter({
    super.key,
    required this.showHotOnly,
    required this.showEventOnly,
    required this.onHotToggle,
    required this.onEventToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '추천 메뉴',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        FilterChip(
          label: const Text('핫한 메뉴'),
          selected: showHotOnly,
          onSelected: (_) => onHotToggle(),
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
        ),
        const SizedBox(width: 8),
        FilterChip(
          label: const Text('이벤트'),
          selected: showEventOnly,
          onSelected: (_) => onEventToggle(),
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
        ),
      ],
    );
  }
} 
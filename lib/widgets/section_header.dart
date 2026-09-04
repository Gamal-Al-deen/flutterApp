import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onActionTap;
  final IconData? icon;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onActionTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 6),
        ],
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        if (action != null)
          InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                action!,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

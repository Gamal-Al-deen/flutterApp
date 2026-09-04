import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;
  final Color? color;
  final int? count;

  const CategoryChip({
    super.key,
    required this.label,
    this.icon,
    this.selected = false,
    this.onTap,
    this.color,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? c : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? c : AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: selected ? AppColors.textOnPrimary : c,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.textOnPrimary : AppColors.textPrimary,
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.white.withValues(alpha: 0.25)
                      : AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: selected ? AppColors.textOnPrimary : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

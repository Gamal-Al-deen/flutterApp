import 'package:flutter/material.dart';
import '../theme/colors.dart';

enum AppButtonVariant { primary, secondary, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool loading;
  final double? height;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == AppButtonVariant.primary;
    final isGhost = variant == AppButtonVariant.ghost;
    final bg = isPrimary
        ? AppColors.primary
        : isGhost
            ? Colors.transparent
            : AppColors.surface;
    final fg = isPrimary
        ? AppColors.textOnPrimary
        : AppColors.primary;
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: isGhost ? Colors.transparent : AppColors.primary,
                    width: 1.4,
                  ),
          ),
        ),
        child: loading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation<Color>(fg),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: fg,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

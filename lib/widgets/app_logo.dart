import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool withBackground;
  const AppLogo({super.key, this.size = 96, this.withBackground = true});

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
    if (!withBackground) return image;
    return Container(
      width: size * 1.1,
      height: size * 1.1,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: image,
    );
  }
}

import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  final bool enabled;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4, bottom: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscure,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          maxLines: obscure ? 1 : maxLines,
          enabled: enabled,
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 15,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

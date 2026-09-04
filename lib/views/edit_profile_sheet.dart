import 'package:flutter/material.dart';
import '../controllers/profile_controller.dart';
import '../theme/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class EditProfileSheet extends StatefulWidget {
  const EditProfileSheet({super.key});

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  final _controller = ProfileController();
  final _formKey = GlobalKey<FormState>();
  late final _nameCtrl = TextEditingController(text: _controller.user.name);
  late final _emailCtrl = TextEditingController(text: _controller.user.email);
  late final _phoneCtrl = TextEditingController(text: _controller.user.phone);
  late final _cityCtrl = TextEditingController(text: _controller.user.city);

  @override
  Widget build(BuildContext context) {
    final user = _controller.user;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 42,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryLight],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      user.initials,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        color: AppColors.textOnPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'تعديل الملف الشخصي',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _nameCtrl,
                    label: 'الاسم الكامل',
                    prefixIcon: const Icon(Icons.person_outline),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'يرجى إدخال الاسم';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: _emailCtrl,
                    label: 'البريد الإلكتروني',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'يرجى إدخال البريد';
                      }
                      if (!RegExp(r'^[\w\.\-+]+@[\w\-]+(\.[\w\-]+)+$')
                          .hasMatch(v.trim())) {
                        return 'البريد الإلكتروني غير صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: _phoneCtrl,
                    label: 'رقم الجوال',
                    keyboardType: TextInputType.phone,
                    prefixIcon: const Icon(Icons.phone_outlined),
                    validator: (v) {
                      if (v == null || v.trim().length < 8) {
                        return 'رقم الجوال غير صحيح';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: _cityCtrl,
                    label: 'المدينة',
                    prefixIcon: const Icon(Icons.location_on_outlined),
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    label: 'حفظ التغييرات',
                    icon: Icons.save_rounded,
                    onPressed: () {
                      if (!(_formKey.currentState?.validate() ?? false)) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم حفظ التغييرات بنجاح')),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }
}

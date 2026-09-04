import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/signup_controller.dart';
import '../theme/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _controller = SignupController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppLogo(size: 70),
                  const SizedBox(height: 16),
                  const Text(
                    'إنشاء حساب جديد',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'انضم إلى منصة معاملات واستفد من الخدمات الرقمية',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          controller: _controller.nameController,
                          label: 'الاسم الكامل',
                          hint: 'أدخل اسمك الكامل',
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال الاسم الكامل';
                            }
                            if (value.trim().length < 3) {
                              return 'الاسم يجب أن يكون 3 أحرف على الأقل';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _controller.emailController,
                          label: 'البريد الإلكتروني',
                          hint: 'example@email.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال البريد الإلكتروني';
                            }
                            final email = value.trim();
                            if (!RegExp(
                                    r'^[\w\.\-+]+@[\w\-]+(\.[\w\-]+)+$')
                                .hasMatch(email)) {
                              return 'البريد الإلكتروني غير صحيح';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _controller.phoneController,
                          label: 'رقم الجوال',
                          hint: '+966 5X XXX XXXX',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'يرجى إدخال رقم الجوال';
                            }
                            if (value.trim().length < 8) {
                              return 'رقم الجوال غير صحيح';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.phone_outlined),
                        ),
                        const SizedBox(height: 16),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) => AppTextField(
                            controller: _controller.passwordController,
                            label: 'كلمة المرور',
                            hint: '6 أحرف على الأقل',
                            obscure: _controller.obscure,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'يرجى إدخال كلمة المرور';
                              }
                              if (value.length < 6) {
                                return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                              }
                              return null;
                            },
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: _controller.toggleObscure,
                              icon: Icon(
                                _controller.obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: _controller.confirmController,
                          label: 'تأكيد كلمة المرور',
                          hint: 'أعد إدخال كلمة المرور',
                          obscure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى تأكيد كلمة المرور';
                            }
                            if (value != _controller.passwordController.text) {
                              return 'كلمتا المرور غير متطابقتين';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        const SizedBox(height: 16),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) => InkWell(
                            onTap: () =>
                                _controller.toggleAccept(!_controller.accept),
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: Checkbox(
                                      value: _controller.accept,
                                      onChanged: _controller.toggleAccept,
                                      activeColor: AppColors.primary,
                                      checkColor: AppColors.textOnPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Expanded(
                                    child: Text(
                                      'أوافق على شروط الاستخدام وسياسة الخصوصية',
                                      style: TextStyle(
                                        fontFamily: 'Tajawal',
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) => AppButton(
                            label: 'إنشاء الحساب',
                            icon: Icons.person_add_alt_1_rounded,
                            loading: _controller.isLoading,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final ok = await _controller.signup();
                                if (!ok || !context.mounted) return;
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.main);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'لديك حساب بالفعل؟',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.login),
                        child: const Text('تسجيل الدخول'),
                      ),
                    ],
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
    _controller.dispose();
    super.dispose();
  }
}

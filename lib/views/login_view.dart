import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/login_controller.dart';
import '../theme/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_logo.dart';
import '../widgets/app_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const AppLogo(size: 80),
                  const SizedBox(height: 20),
                  const Text(
                    'مرحباً بعودتك',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'سجّل دخولك للوصول إلى خدماتك ومتابعة معاملاتك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) => AppTextField(
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
                        ),
                        const SizedBox(height: 16),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) => AppTextField(
                            controller: _controller.passwordController,
                            label: 'كلمة المرور',
                            hint: '••••••••',
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
                        const SizedBox(height: 12),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AppRoutes.forgotPassword),
                            child: const Text('نسيت كلمة المرور؟'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) => AppButton(
                            label: 'تسجيل الدخول',
                            icon: Icons.login_rounded,
                            loading: _controller.isLoading,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final ok = await _controller.login();
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
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.divider,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'أو',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            color: AppColors.textTertiary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.divider,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.signup),
                    child: const Text('إنشاء حساب جديد'),
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

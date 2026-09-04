import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/forgot_password_controller.dart';
import '../theme/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _controller = ForgotPasswordController();
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              if (_controller.sent) return _buildSentState();
              return _buildForm();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    color: AppColors.primary,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'نسيت كلمة المرور؟',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'لا تقلق، أدخل بريدك الإلكتروني المسجل وسنرسل لك خطوات إعادة تعيين كلمة المرور.',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
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
                const SizedBox(height: 24),
                AppButton(
                  label: 'إرسال رابط الإعادة',
                  icon: Icons.send_rounded,
                  loading: _controller.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _controller.submit();
                    }
                  },
                ),
                const SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('العودة إلى تسجيل الدخول'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSentState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mark_email_read_rounded,
              color: AppColors.success,
              size: 48,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'تم الإرسال بنجاح',
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني. يرجى التحقق من صندوق الوارد.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 28),
          AppButton(
            label: 'العودة إلى تسجيل الدخول',
            icon: Icons.arrow_back_rounded,
            onPressed: () {
              _controller.reset();
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

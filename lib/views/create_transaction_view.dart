import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/create_transaction_controller.dart';
import '../data/services_data.dart';
import '../data/users_data.dart';
import '../theme/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class CreateTransactionView extends StatefulWidget {
  final String serviceId;
  const CreateTransactionView({super.key, required this.serviceId});

  @override
  State<CreateTransactionView> createState() => _CreateTransactionViewState();
}

class _CreateTransactionViewState extends State<CreateTransactionView> {
  late final _controller = CreateTransactionController(widget.serviceId);
  final _nameCtrl = TextEditingController(text: UsersData.demo.name);
  final _phoneCtrl = TextEditingController(text: UsersData.demo.phone);

  @override
  Widget build(BuildContext context) {
    final service = ServicesData.findById(widget.serviceId);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('معاملة جديدة'),
      ),
      body: SafeArea(
        child: service == null
            ? const Center(child: Text('الخدمة غير موجودة'))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: _StepIndicator(
                      current: _controller.currentStep,
                      total: 3,
                      labels: const ['الخدمة', 'البيانات', 'المراجعة'],
                    ),
                  ),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                          child: _buildStep(service.title),
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        border: Border(
                          top: BorderSide(color: AppColors.border),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (_controller.currentStep > 0)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: _controller.back,
                                child: const Text('السابق'),
                              ),
                            ),
                          if (_controller.currentStep > 0)
                            const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: AppButton(
                              label: _controller.currentStep == 2
                                  ? 'إرسال الطلب'
                                  : 'التالي',
                              icon: _controller.currentStep == 2
                                  ? Icons.send_rounded
                                  : Icons.arrow_forward_rounded,
                              onPressed: () async {
                                if (_controller.currentStep < 2) {
                                  if (_controller.currentStep == 1) {
                                    if (!(_controller.formKey.currentState
                                            ?.validate() ??
                                        false)) {
                                      return;
                                    }
                                  }
                                  _controller.next();
                                } else {
                                  final tx = await _controller.submit(
                                    applicantName: _nameCtrl.text.trim(),
                                    applicantPhone: _phoneCtrl.text.trim(),
                                  );
                                  if (!context.mounted || tx == null) return;
                                  Navigator.of(context)
                                      .pushReplacementNamed(
                                    AppRoutes.transactionDetails,
                                    arguments: tx.id,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStep(String serviceTitle) {
    switch (_controller.currentStep) {
      case 0:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ملخص الخدمة',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.assignment_rounded,
                        color: AppColors.primary, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceTitle,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'تأكد من اختيار الخدمة الصحيحة قبل المتابعة',
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppColors.info, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'يمكنك متابعة حالة طلبك في أي وقت من خلال قائمة معاملاتي.',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 1:
        return Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _nameCtrl,
                label: 'الاسم الكامل',
                hint: 'أدخل اسمك الكامل',
                prefixIcon: const Icon(Icons.person_outline),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'يرجى إدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _phoneCtrl,
                label: 'رقم الجوال',
                hint: '+966 5X XXX XXXX',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined),
                validator: (v) {
                  if (v == null || v.trim().length < 8) {
                    return 'يرجى إدخال رقم جوال صحيح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _controller.notesController,
                label: 'ملاحظات إضافية (اختياري)',
                hint: 'أضف أي ملاحظات تساعد في معالجة طلبك',
                maxLines: 4,
                validator: (_) => null,
              ),
            ],
          ),
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'مراجعة الطلب',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _reviewRow('الخدمة', serviceTitle),
                  const Divider(height: 24),
                  _reviewRow('الاسم', _nameCtrl.text),
                  const Divider(height: 24),
                  _reviewRow('رقم الجوال', _phoneCtrl.text),
                  if (_controller.notesController.text.trim().isNotEmpty) ...[
                    const Divider(height: 24),
                    _reviewRow('ملاحظات', _controller.notesController.text.trim()),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.warning.withValues(alpha: 0.30),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: AppColors.warning, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'بإرسالك الطلب فإنك تقر بصحة البيانات المدخلة.',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }

  Widget _reviewRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? '—' : value,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }
}

class _StepIndicator extends StatelessWidget {
  final int current;
  final int total;
  final List<String> labels;
  const _StepIndicator({
    required this.current,
    required this.total,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final active = i <= current;
        return Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.surfaceAlt,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: active
                          ? const Icon(Icons.check_rounded,
                              color: AppColors.textOnPrimary, size: 14)
                          : Text(
                              '${i + 1}',
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textTertiary,
                              ),
                            ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 2,
                        color: i < current
                            ? AppColors.primary
                            : AppColors.surfaceAlt,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  labels[i],
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: active ? AppColors.textPrimary : AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import '../controllers/transaction_details_controller.dart';
import '../models/transaction_model.dart';
import '../theme/colors.dart';
import '../widgets/empty_state.dart';
import '../widgets/info_row.dart';
import '../widgets/transaction_card.dart';

class TransactionDetailsView extends StatefulWidget {
  final String transactionId;
  const TransactionDetailsView({super.key, required this.transactionId});

  @override
  State<TransactionDetailsView> createState() => _TransactionDetailsViewState();
}

class _TransactionDetailsViewState extends State<TransactionDetailsView> {
  late final _controller = TransactionDetailsController(widget.transactionId);

  @override
  Widget build(BuildContext context) {
    final tx = _controller.transaction;
    if (tx == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const EmptyState(
          icon: Icons.error_outline,
          title: 'المعاملة غير موجودة',
        ),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('تفاصيل المعاملة'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [tx.serviceColor, tx.serviceColor.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.20),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _iconFor(tx.serviceIconCode),
                          color: AppColors.textOnPrimary,
                          size: 24,
                        ),
                      ),
                      const Spacer(),
                      StatusChip(status: tx.status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tx.serviceTitle,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textOnPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'رقم المرجع: ${tx.referenceNumber}',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      color: AppColors.textOnPrimary.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'نسبة الإنجاز',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 11,
                                color: AppColors.textOnPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${tx.progress}%',
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textOnPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          tx.stage,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textOnPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: tx.progress / 100,
                      backgroundColor: Colors.white.withValues(alpha: 0.25),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.textOnPrimary),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const _SectionTitle(title: 'معلومات أساسية'),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.badge_rounded,
              label: 'رقم المرجع',
              value: tx.referenceNumber,
            ),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.calendar_today_rounded,
              label: 'تاريخ التقديم',
              value: tx.formattedDate,
            ),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.update_rounded,
              label: 'آخر تحديث',
              value: tx.updatedAt != null
                  ? _formatDateTime(tx.updatedAt!)
                  : '—',
            ),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.person_rounded,
              label: 'مقدم الطلب',
              value: tx.applicantName,
            ),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.phone_rounded,
              label: 'رقم الجوال',
              value: tx.applicantPhone,
            ),
            if (tx.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              InfoRow(
                icon: Icons.note_alt_rounded,
                label: 'ملاحظات',
                value: tx.notes,
              ),
            ],
            const SizedBox(height: 24),
            const _SectionTitle(title: 'مراحل المعالجة'),
            const SizedBox(height: 8),
            _Timeline(tx: tx),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('سيتم تنزيل نسخة من المعاملة قريباً')),
                      );
                    },
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('تحميل'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم التواصل مع الدعم')),
                      );
                    },
                    icon: const Icon(Icons.support_agent_rounded, size: 18),
                    label: const Text('الدعم'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String code) {
    switch (code) {
      case 'passport':
        return Icons.badge_rounded;
      case 'id':
        return Icons.account_balance_rounded;
      case 'license':
        return Icons.directions_car_rounded;
      case 'car':
        return Icons.directions_car_rounded;
      case 'school':
        return Icons.school_rounded;
      default:
        return Icons.receipt_long_rounded;
    }
  }

  String _formatDateTime(DateTime d) {
    return '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _Timeline extends StatelessWidget {
  final TransactionModel tx;
  const _Timeline({required this.tx});

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('تم استلام الطلب', 'تم تسجيل طلبك بنجاح', true),
      ('تجميع المتطلبات', 'تجميع الوثائق والمرفقات', tx.progress >= 25),
      ('مراجعة الطلب', 'الفحص والتحقق من البيانات', tx.progress >= 50),
      ('قيد المعالجة', 'جاري العمل على الطلب', tx.progress >= 75),
      (tx.status == TransactionStatus.rejected ? 'تم الرفض' : 'الانجاز', 'النتيجة النهائية', tx.progress >= 100),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(steps.length, (i) {
          final s = steps[i];
          final isLast = i == steps.length - 1;
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: s.$3
                            ? AppColors.success
                            : AppColors.surfaceAlt,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        s.$3 ? Icons.check_rounded : Icons.circle,
                        size: s.$3 ? 14 : 8,
                        color: s.$3
                            ? AppColors.textOnPrimary
                            : AppColors.textTertiary,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: AppColors.surfaceAlt,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.$1,
                          style: TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: s.$3
                                ? AppColors.textPrimary
                                : AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          s.$2,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

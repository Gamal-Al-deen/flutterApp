import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/service_details_controller.dart';
import '../theme/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/empty_state.dart';
import '../widgets/info_row.dart';

class ServiceDetailsView extends StatefulWidget {
  final String serviceId;
  const ServiceDetailsView({super.key, required this.serviceId});

  @override
  State<ServiceDetailsView> createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView> {
  late final _controller = ServiceDetailsController(widget.serviceId);

  @override
  Widget build(BuildContext context) {
    final s = _controller.service;
    if (s == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const EmptyState(
          icon: Icons.error_outline,
          title: 'الخدمة غير موجودة',
        ),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            expandedHeight: 220,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                onPressed: _controller.toggleFavorite,
                icon: Icon(
                  _controller.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: _controller.isFavorite
                      ? AppColors.secondary
                      : AppColors.textSecondary,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      s.color.withValues(alpha: 0.20),
                      s.color.withValues(alpha: 0.05),
                    ],
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: s.color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Icon(s.icon, color: s.color, size: 48),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.title,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s.shortDescription,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _meta(
                        Icons.star_rounded,
                        s.rating.toStringAsFixed(1),
                        'تقييم',
                        AppColors.warning,
                      ),
                      const SizedBox(width: 8),
                      _meta(
                        Icons.schedule_rounded,
                        '${s.estimatedDays} أيام',
                        'مدة',
                        AppColors.info,
                      ),
                      const SizedBox(width: 8),
                      _meta(
                        Icons.attach_money_rounded,
                        s.fee == 0 ? 'مجاناً' : '${s.fee.toStringAsFixed(0)} ر.س',
                        'الرسوم',
                        AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle(title: 'الوصف'),
                  const SizedBox(height: 8),
                  Text(
                    s.description,
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle(title: 'المتطلبات'),
                  const SizedBox(height: 8),
                  ...s.requirements.map(
                    (r) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 6),
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              r,
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 13,
                                color: AppColors.textPrimary,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _SectionTitle(title: 'الخطوات'),
                  const SizedBox(height: 8),
                  ...List.generate(s.steps.length, (i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: s.color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                color: AppColors.textOnPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              s.steps[i],
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 13,
                                color: AppColors.textPrimary,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  InfoRow(
                    icon: Icons.access_time_filled_rounded,
                    label: 'مدة المعالجة المتوقعة',
                    value: '${s.estimatedDays} أيام عمل',
                    iconColor: AppColors.warning,
                  ),
                  const SizedBox(height: 8),
                  InfoRow(
                    icon: Icons.payments_rounded,
                    label: 'رسوم الخدمة',
                    value: s.fee == 0
                        ? 'بدون رسوم'
                        : '${s.fee.toStringAsFixed(0)} ريال سعودي',
                    iconColor: AppColors.success,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: AppButton(
            label: 'تقديم طلب الآن',
            icon: Icons.assignment_turned_in_rounded,
            onPressed: () => Navigator.of(context)
                .pushNamed(AppRoutes.createTransaction, arguments: s.id),
          ),
        ),
      ),
    );
  }

  Widget _meta(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 11,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
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

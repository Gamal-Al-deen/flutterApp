import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/profile_controller.dart';
import '../data/notifications_data.dart';
import '../data/transactions_data.dart';
import '../models/transaction_model.dart';
import '../theme/colors.dart';
import '../widgets/app_button.dart';
import '../widgets/info_row.dart';
import '../widgets/transaction_card.dart';
import 'edit_profile_sheet.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _controller = ProfileController();

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  Widget build(BuildContext context) {
    final user = _controller.user;
    return SafeArea(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.20),
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
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textOnPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 12,
                              color: AppColors.textOnPrimary
                                  .withValues(alpha: 0.85),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.20),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified_rounded,
                                    color: AppColors.textOnPrimary, size: 12),
                                SizedBox(width: 4),
                                Text(
                                  'حساب موثّق',
                                  style: TextStyle(
                                    fontFamily: 'Tajawal',
                                    fontSize: 11,
                                    color: AppColors.textOnPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const EditProfileSheet(),
                      ),
                      icon: const Icon(Icons.edit_rounded,
                          color: AppColors.textOnPrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _stat(
                    'المعاملات',
                    TransactionsData.all.length.toString(),
                    Icons.receipt_long_rounded,
                    AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  _stat(
                    'قيد المعالجة',
                    TransactionsData.all
                        .where((t) =>
                            t.status == TransactionStatus.pending ||
                            t.status == TransactionStatus.processing)
                        .length
                        .toString(),
                    Icons.hourglass_top_rounded,
                    AppColors.warning,
                  ),
                  const SizedBox(width: 8),
                  _stat(
                    'الإشعارات',
                    NotificationsData.all.length.toString(),
                    Icons.notifications_active_rounded,
                    AppColors.secondary,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const _SectionTitle(title: 'معلومات الحساب'),
              const SizedBox(height: 8),
              InfoRow(
                icon: Icons.person_outline,
                label: 'الاسم',
                value: user.name,
              ),
              const SizedBox(height: 8),
              InfoRow(
                icon: Icons.email_outlined,
                label: 'البريد',
                value: user.email,
              ),
              const SizedBox(height: 8),
              InfoRow(
                icon: Icons.phone_outlined,
                label: 'الجوال',
                value: user.phone,
              ),
              const SizedBox(height: 8),
              InfoRow(
                icon: Icons.badge_outlined,
                label: 'رقم الهوية',
                value: user.nationalId,
              ),
              const SizedBox(height: 8),
              InfoRow(
                icon: Icons.location_on_outlined,
                label: 'المدينة',
                value: user.city,
              ),
              const SizedBox(height: 24),
              const _SectionTitle(title: 'الإعدادات'),
              const SizedBox(height: 8),
              _settingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'الوضع الداكن',
                trailing: Switch(
                  value: _controller.darkMode,
                  onChanged: _controller.setDarkMode,
                  activeThumbColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              _settingsTile(
                icon: Icons.notifications_outlined,
                title: 'الإشعارات',
                trailing: Switch(
                  value: _controller.notifications,
                  onChanged: _controller.setNotifications,
                  activeThumbColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              _settingsTile(
                icon: Icons.language_rounded,
                title: 'اللغة',
                trailing: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'العربية',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_left,
                        color: AppColors.textTertiary, size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _settingsTile(
                icon: Icons.help_outline,
                title: 'مركز المساعدة',
                trailing: const Icon(Icons.chevron_left,
                    color: AppColors.textTertiary, size: 18),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('مركز المساعدة قريباً')),
                  );
                },
              ),
              const SizedBox(height: 8),
              _settingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'سياسة الخصوصية',
                trailing: const Icon(Icons.chevron_left,
                    color: AppColors.textTertiary, size: 18),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('سياسة الخصوصية')),
                  );
                },
              ),
              const SizedBox(height: 8),
              _settingsTile(
                icon: Icons.info_outline,
                title: 'حول التطبيق',
                trailing: const Icon(Icons.chevron_left,
                    color: AppColors.textTertiary, size: 18),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: 'معاملات',
                    applicationVersion: '1.0.0',
                    applicationLegalese: 'منصة الخدمات الرقمية والمعاملات الإلكترونية',
                  );
                },
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'تسجيل الخروج',
                icon: Icons.logout_rounded,
                variant: AppButtonVariant.ghost,
                onPressed: () async {
                  await _controller.logout();
                  if (!context.mounted) return;
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(AppRoutes.login, (r) => false);
                },
              ),
              if (TransactionsData.all.isNotEmpty) ...[
                const SizedBox(height: 24),
                const _SectionTitle(title: 'آخر معاملة'),
                const SizedBox(height: 8),
                TransactionCard(
                  transaction: TransactionsData.all.first,
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.transactionDetails,
                    arguments: TransactionsData.all.first.id,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _stat(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 18,
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

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              trailing,
            ],
          ),
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

import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/home_controller.dart';
import '../data/transactions_data.dart';
import '../data/users_data.dart';
import '../models/service_model.dart';
import '../theme/colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/empty_state.dart';
import '../widgets/section_header.dart';
import '../widgets/service_card.dart';
import '../widgets/transaction_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = HomeController();
  final _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = UsersData.demo;
    return SafeArea(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryLight],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          user.initials,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            color: AppColors.textOnPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'مرحباً،',
                              style: TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 12,
                                color: AppColors.textTertiary,
                              ),
                            ),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(AppRoutes.notifications),
                        icon: const Icon(Icons.notifications_outlined),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: _controller.updateQuery,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        hintText: 'ابحث عن خدمة...',
                        prefixIcon: Icon(Icons.search_rounded),
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
              ),
              if (_controller.query.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: SectionHeader(
                      title: 'نتائج البحث',
                      action: 'مسح',
                      onActionTap: () {
                        _searchCtrl.clear();
                        _controller.clearQuery();
                      },
                    ),
                  ),
                ),
                if (_controller.searchResults.isEmpty)
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 240,
                      child: EmptyState(
                        icon: Icons.search_off_rounded,
                        title: 'لا توجد نتائج',
                        message: 'جرّب البحث بكلمة مختلفة أو تصفح الخدمات',
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final int columns = constraints.maxWidth < 600
                              ? 2
                              : constraints.maxWidth < 900
                                  ? 3
                                  : 4;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.78,
                            ),
                            itemCount: _controller.searchResults.length,
                            itemBuilder: (context, i) {
                              final s = _controller.searchResults[i];
                              return ServiceCard(
                                service: s,
                                onTap: () => Navigator.of(context).pushNamed(
                                    AppRoutes.serviceDetails,
                                    arguments: s.id),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
              ] else ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: const SectionHeader(
                      title: 'إجراءات سريعة',
                      icon: Icons.bolt_rounded,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 92,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _quickAction(
                          context,
                          icon: Icons.receipt_long_rounded,
                          label: 'معاملاتي',
                          color: AppColors.primary,
                          onTap: () {},
                        ),
                        _quickAction(
                          context,
                          icon: Icons.notifications_active_rounded,
                          label: 'الإشعارات',
                          color: AppColors.secondary,
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.notifications),
                        ),
                        _quickAction(
                          context,
                          icon: Icons.add_circle_rounded,
                          label: 'معاملة جديدة',
                          color: AppColors.success,
                          onTap: () => Navigator.of(context).pushNamed(
                              AppRoutes.serviceDetails,
                              arguments: 'srv_001'),
                        ),
                        _quickAction(
                          context,
                          icon: Icons.support_agent_rounded,
                          label: 'الدعم',
                          color: AppColors.warning,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('سيتم تفعيل الدعم قريباً')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: SectionHeader(
                      title: 'الخدمات المميزة',
                      action: 'عرض الكل',
                      onActionTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.serviceDetails,
                          arguments: 'srv_001'),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _controller.featured.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final s = _controller.featured[i];
                        return ServiceCard(
                          service: s,
                          horizontal: true,
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.serviceDetails, arguments: s.id),
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: const SectionHeader(
                      title: 'تصنيفات الخدمات',
                      icon: Icons.category_rounded,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _controller.featured.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        if (i == 0) {
                          return const CategoryChip(
                            label: 'الكل',
                            icon: Icons.apps_rounded,
                            selected: true,
                          );
                        }
                        final ServiceModel s = _controller.featured[i - 1];
                        return CategoryChip(
                          label: s.category.label,
                          icon: s.category.icon,
                          color: s.color,
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: SectionHeader(
                      title: 'آخر المعاملات',
                      action: 'الكل',
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final tx = TransactionsData.all[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TransactionCard(
                            transaction: tx,
                            onTap: () => Navigator.of(context).pushNamed(
                              AppRoutes.transactionDetails,
                              arguments: tx.id,
                            ),
                          ),
                        );
                      },
                      childCount:
                          TransactionsData.all.length > 3 ? 3 : TransactionsData.all.length,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _quickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 110,
      margin: const EdgeInsetsDirectional.only(end: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _controller.dispose();
    super.dispose();
  }
}

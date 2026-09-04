import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/services_controller.dart';
import '../data/services_data.dart';
import '../models/service_model.dart';
import '../theme/colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/empty_state.dart';
import '../widgets/service_card.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  final _controller = ServicesController();
  final _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'الخدمات',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune_rounded),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
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
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  hintText: 'ابحث في الخدمات...',
                  prefixIcon: Icon(Icons.search_rounded),
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 42,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: ServicesData.categories.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return CategoryChip(
                        label: 'الكل',
                        icon: Icons.apps_rounded,
                        count: ServicesData.all.length,
                        selected: _controller.selected == null,
                        onTap: () => _controller.select(null),
                      );
                    }
                    final c = ServicesData.categories[i - 1];
                    return CategoryChip(
                      label: c.label,
                      icon: c.icon,
                      count: _controller.countOf(c),
                      selected: _controller.selected == c,
                      onTap: () => _controller.select(c),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final list = _controller.filtered;
                if (list.isEmpty) {
                  return EmptyState(
                    icon: Icons.search_off_rounded,
                    title: 'لا توجد خدمات',
                    message: 'لم يتم العثور على خدمات تطابق بحثك',
                    actionLabel: 'إعادة تعيين الفلتر',
                    onAction: () {
                      _searchCtrl.clear();
                      _controller.clear();
                    },
                  );
                }
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final int columns = constraints.maxWidth < 600
                        ? 2
                        : constraints.maxWidth < 900
                            ? 3
                            : 4;
                    return GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      itemCount: list.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, i) {
                        final ServiceModel s = list[i];
                        return ServiceCard(
                          service: s,
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.serviceDetails,
                                  arguments: s.id),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
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

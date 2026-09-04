import 'package:flutter/material.dart';
import '../app/routes.dart';
import '../controllers/transactions_controller.dart';
import '../models/transaction_model.dart';
import '../theme/colors.dart';
import '../widgets/category_chip.dart';
import '../widgets/empty_state.dart';
import '../widgets/transaction_card.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  final _controller = TransactionsController();
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
                    'معاملاتي',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.serviceDetails, arguments: 'srv_001'),
                  icon: const Icon(Icons.add_circle_rounded),
                  color: AppColors.primary,
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
                  hintText: 'ابحث برقم المعاملة...',
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
                  itemCount: _statusFilters.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return CategoryChip(
                        label: 'الكل',
                        icon: Icons.list_alt_rounded,
                        count: _controller.countOf(null),
                        selected: _controller.filter == null,
                        onTap: () => _controller.setFilter(null),
                      );
                    }
                    final s = _statusFilters[i - 1];
                    return CategoryChip(
                      label: s.label,
                      icon: s.icon,
                      color: s.color,
                      count: _controller.countOf(s),
                      selected: _controller.filter == s,
                      onTap: () => _controller.setFilter(s),
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
                    icon: Icons.inbox_outlined,
                    title: 'لا توجد معاملات',
                    message: 'لم يتم العثور على معاملات تطابق الفلتر المحدد',
                    actionLabel: 'إعادة التعيين',
                    onAction: () {
                      _searchCtrl.clear();
                      _controller.clear();
                    },
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final TransactionModel t = list[i];
                    return TransactionCard(
                      transaction: t,
                      onTap: () => Navigator.of(context).pushNamed(
                        AppRoutes.transactionDetails,
                        arguments: t.id,
                      ),
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

  static const _statusFilters = [
    TransactionStatus.pending,
    TransactionStatus.processing,
    TransactionStatus.approved,
    TransactionStatus.completed,
    TransactionStatus.rejected,
  ];

  @override
  void dispose() {
    _searchCtrl.dispose();
    _controller.dispose();
    super.dispose();
  }
}

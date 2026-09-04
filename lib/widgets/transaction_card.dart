import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../theme/colors.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onTap;
  const TransactionCard({super.key, required this.transaction, this.onTap});

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

  @override
  Widget build(BuildContext context) {
    final tx = transaction;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: tx.serviceColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _iconFor(tx.serviceIconCode),
                  color: tx.serviceColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.serviceTitle,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tx.referenceNumber,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 11,
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            size: 12, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Text(
                          tx.formattedDate,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 11,
                            color: AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatusChip(status: tx.status),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left,
                  color: AppColors.textTertiary, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final TransactionStatus status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: 12, color: status.color),
          const SizedBox(width: 4),
          Text(
            status.label,
            style: TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: status.color,
            ),
          ),
        ],
      ),
    );
  }
}

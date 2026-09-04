import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../theme/colors.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  const NotificationCard({super.key, required this.notification, this.onTap});

  @override
  Widget build(BuildContext context) {
    final n = notification;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: n.isRead ? AppColors.surface : AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: n.isRead ? AppColors.border : AppColors.primary.withValues(alpha: 0.20),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: n.type.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(n.type.icon, color: n.type.color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            n.title,
                            style: const TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (!n.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.unreadDot,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      n.body,
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatDate(n.date),
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 11,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inMinutes < 60) return 'قبل ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'قبل ${diff.inHours} ساعة';
    if (diff.inDays < 7) return 'قبل ${diff.inDays} يوم';
    return '${d.year}/${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}';
  }
}

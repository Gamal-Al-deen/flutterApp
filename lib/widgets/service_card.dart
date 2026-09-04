import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../theme/colors.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final VoidCallback? onTap;
  final bool horizontal;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const ServiceCard({
    super.key,
    required this.service,
    this.onTap,
    this.horizontal = false,
    this.isFavorite = false,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    if (horizontal) return _horizontal(context);
    return _vertical(context);
  }

  Widget _vertical(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: service.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(service.icon, color: service.color, size: 24),
                  ),
                  const Spacer(),
                  if (onFavoriteTap != null)
                    InkWell(
                      onTap: onFavoriteTap,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: isFavorite ? AppColors.secondary : AppColors.textTertiary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                service.title,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                service.shortDescription,
                style: const TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.schedule, size: 14, color: AppColors.textTertiary),
                  const SizedBox(width: 4),
                  Text(
                    '${service.estimatedDays} يوم',
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.attach_money, size: 14, color: AppColors.textTertiary),
                  const SizedBox(width: 2),
                  Text(
                    service.fee == 0 ? 'مجاناً' : '${service.fee.toStringAsFixed(0)} ر.س',
                    style: const TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _horizontal(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Material(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: service.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(service.icon, color: service.color, size: 22),
                    ),
                    const Spacer(),
                    if (onFavoriteTap != null)
                      InkWell(
                        onTap: onFavoriteTap,
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: isFavorite
                                ? AppColors.secondary
                                : AppColors.textTertiary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  service.title,
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
                  service.shortDescription,
                  style: const TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

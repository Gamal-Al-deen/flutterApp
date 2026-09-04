import '../models/notification_model.dart';

class NotificationsData {
  NotificationsData._();

  static final List<NotificationModel> all = [
    NotificationModel(
      id: 'n_001',
      title: 'تم تحديث حالة المعاملة',
      body: 'معاملتك TRX-2026-00184 تنتقل الآن إلى مرحلة المراجعة.',
      date: DateTime(2026, 9, 3, 14, 20),
      type: NotificationType.transaction,
      isRead: false,
      relatedId: 'tx_001',
    ),
    NotificationModel(
      id: 'n_002',
      title: 'معاملة مكتملة',
      body: 'تم إصدار الهوية الوطنية بنجاح، يمكنك استلامها من الفرع.',
      date: DateTime(2026, 7, 17, 11, 32),
      type: NotificationType.success,
      isRead: true,
      relatedId: 'tx_002',
    ),
    NotificationModel(
      id: 'n_003',
      title: 'تذكير بموعد',
      body: 'لديك موعد لإجراء الفحص الطبي خلال 48 ساعة.',
      date: DateTime(2026, 9, 2, 9, 0),
      type: NotificationType.reminder,
      isRead: false,
      relatedId: 'tx_003',
    ),
    NotificationModel(
      id: 'n_004',
      title: 'إعلان جديد',
      body: 'تم إطلاق خدمة جديدة لإصدار الوثائق الإلكترونية.',
      date: DateTime(2026, 8, 28, 10, 0),
      type: NotificationType.announcement,
      isRead: true,
    ),
    NotificationModel(
      id: 'n_005',
      title: 'إجراء مطلوب',
      body: 'يرجى إعادة إرفاق تقرير الفحص لإكمال معاملة نقل الملكية.',
      date: DateTime(2026, 6, 28, 16, 5),
      type: NotificationType.reminder,
      isRead: true,
      relatedId: 'tx_004',
    ),
    NotificationModel(
      id: 'n_006',
      title: 'مرحباً بك في معاملات',
      body: 'نشكرك على انضمامك إلى منصة الخدمات الرقمية الأولى.',
      date: DateTime(2026, 6, 1, 8, 0),
      type: NotificationType.announcement,
      isRead: true,
    ),
  ];
}

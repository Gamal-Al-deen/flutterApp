import 'package:flutter/material.dart';
import '../controllers/notifications_controller.dart';
import '../theme/colors.dart';
import '../widgets/empty_state.dart';
import '../widgets/notification_card.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final _controller = NotificationsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('الإشعارات'),
        actions: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              if (_controller.unreadCount == 0) return const SizedBox.shrink();
              return TextButton(
                onPressed: _controller.markAllAsRead,
                child: const Text('تعليم الكل كمقروء'),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final list = _controller.items;
            if (list.isEmpty) {
              return EmptyState(
                icon: Icons.notifications_off_outlined,
                title: 'لا توجد إشعارات',
                message: 'ستظهر إشعاراتك هنا فور وصولها',
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final n = list[i];
                return NotificationCard(
                  notification: n,
                  onTap: () => _controller.toggleRead(n.id),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

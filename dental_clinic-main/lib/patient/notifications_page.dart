import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.check_circle_rounded,
        'color': AppColors.neonTeal,
        'title': 'Appointment Confirmed',
        'body': 'Dr. Ahmed Benali confirmed your appointment for Apr 5',
        'time': '2h ago',
        'read': false,
      },
      {
        'icon': Icons.access_time_rounded,
        'color': AppColors.neonCyan,
        'title': 'Reminder',
        'body': 'You have an appointment tomorrow at 10:00 AM',
        'time': '5h ago',
        'read': false,
      },
      {
        'icon': Icons.cancel_rounded,
        'color': Colors.redAccent,
        'title': 'Appointment Cancelled',
        'body': 'Your appointment on Mar 20 was cancelled',
        'time': 'Yesterday',
        'read': true,
      },
      {
        'icon': Icons.folder_rounded,
        'color': const Color(0xFF26A69A),
        'title': 'Medical Record Updated',
        'body': 'Dr. Sara Meziane added a new diagnosis to your file',
        'time': '2 days ago',
        'read': true,
      },
      {
        'icon': Icons.stars_rounded,
        'color': const Color(0xFFFFC107),
        'title': 'You earned 50 points!',
        'body': 'Thank you for your visit. Keep collecting to reach Gold!',
        'time': '3 days ago',
        'read': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.bgGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final n = items[i];
                  final unread = !(n['read'] as bool);

                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: unread
                          ? AppColors.panel
                          : AppColors.panel.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: unread
                            ? (n['color'] as Color).withValues(alpha: 0.35)
                            : AppColors.stroke.withValues(alpha: 0.4),
                        width: unread ? 1 : 0.5,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                (n['color'] as Color).withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            n['icon'] as IconData,
                            color: n['color'] as Color,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      n['title'] as String,
                                      style: TextStyle(
                                        color: AppColors.text,
                                        fontWeight: unread
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  if (unread)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.neonCyan,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                n['body'] as String,
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                n['time'] as String,
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
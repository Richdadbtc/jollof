import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String description;
  final String timeAgo;
  final bool hasUnread;

  NotificationModel({
    required this.title,
    required this.description,
    required this.timeAgo,
    this.hasUnread = false,
  });
}

class NotificationScreen extends StatelessWidget {
  final List<NotificationModel> notifications = List.generate(
    8,
        (index) => NotificationModel(
      title: 'Notification title',
      description: 'Notification description that will be reall...',
      timeAgo: '8 hours ago',
      hasUnread: index % 3 == 0, // Every third notification is unread
    ),
  );

  NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationTile(notification: notification);
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.amber[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.rocket,
            color: Colors.amber[400],
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                notification.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (notification.hasUnread)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              notification.timeAgo,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
        onTap: () {
          // Handle notification tap
          print('Notification tapped: ${notification.title}');
        },
      ),
    );
  }
}
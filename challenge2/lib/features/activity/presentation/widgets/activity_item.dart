import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/activity_model.dart';
import 'package:intl/intl.dart';

class ActivityItem extends StatelessWidget {
  final ActivityModel activity;

  const ActivityItem({
    required this.activity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: activity.user.profileImage != null
            ? CachedNetworkImageProvider(activity.user.profileImage!)
            : null,
        child: activity.user.profileImage == null
            ? Text(activity.user.displayName[0])
            : null,
      ),
      title: Row(
        children: [
          Text(
            activity.user.displayName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (activity.user.isVerified) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.verified,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(activity.typeText),
          if (activity.content != null) ...[
            const SizedBox(height: 4),
            Text(
              activity.content!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 4),
          Text(
            _getTimeAgo(activity.createdAt),
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
      trailing: _buildActivityIcon(context),
    );
  }

  Widget _buildActivityIcon(BuildContext context) {
    IconData iconData;
    Color? color;

    switch (activity.type) {
      case ActivityType.follow:
        iconData = Icons.person_add;
        break;
      case ActivityType.like:
        iconData = Icons.favorite;
        color = Colors.red;
        break;
      case ActivityType.reply:
        iconData = Icons.chat_bubble;
        break;
      case ActivityType.mention:
        iconData = Icons.alternate_email;
        break;
    }

    return Icon(
      iconData,
      color: color ?? Theme.of(context).colorScheme.secondary,
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }
} 
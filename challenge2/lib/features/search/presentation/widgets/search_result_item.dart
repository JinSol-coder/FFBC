import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../home/data/models/user_model.dart';

class SearchResultItem extends StatelessWidget {
  final UserModel user;

  const SearchResultItem({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: user.profileImage != null
            ? CachedNetworkImageProvider(user.profileImage!)
            : null,
        child: user.profileImage == null ? Text(user.displayName[0]) : null,
      ),
      title: Row(
        children: [
          Text(
            user.displayName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (user.isVerified) ...[
            const SizedBox(width: 4),
            Icon(
              Icons.verified,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ],
      ),
      subtitle: Text(
        '@${user.username}',
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      trailing: OutlinedButton(
        onPressed: () {},
        child: const Text('팔로우'),
      ),
    );
  }
} 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: Theme.of(context).colorScheme.surface,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 8.0),
            _buildContent(context),
            if (post.images != null && post.images!.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              _buildImage(),
            ],
            const SizedBox(height: 12.0),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: post.user.profileImage != null
              ? CachedNetworkImageProvider(post.user.profileImage!)
              : null,
          child: post.user.profileImage == null
              ? Text(post.user.displayName[0])
              : null,
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    post.user.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (post.user.isVerified) ...[
                    const SizedBox(width: 4.0),
                    Icon(
                      Icons.verified,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ],
              ),
              Text(
                '@${post.user.username}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          _getTimeAgo(post.createdAt),
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Text(
      post.content,
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: post.images!.first,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 200,
          color: Colors.grey[800],
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        _buildIconButton(
          context,
          icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
          count: post.likesCount,
          color: post.isLiked ? Colors.red : null,
        ),
        const SizedBox(width: 16),
        _buildIconButton(
          context,
          icon: Icons.chat_bubble_outline,
          count: post.repliesCount,
        ),
      ],
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    required int count,
    Color? color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color ?? Theme.of(context).colorScheme.secondary,
        ),
        if (count > 0) ...[
          const SizedBox(width: 4),
          Text(
            NumberFormat.compact().format(count),
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}

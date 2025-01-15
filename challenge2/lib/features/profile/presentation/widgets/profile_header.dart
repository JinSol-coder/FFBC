import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onFollowTap;

  const ProfileHeader({
    required this.profile,
    required this.onFollowTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: profile.user.profileImage != null
                        ? CachedNetworkImageProvider(profile.user.profileImage!)
                        : null,
                    child: profile.user.profileImage == null
                        ? Text(
                            profile.user.displayName[0],
                            style: const TextStyle(fontSize: 24),
                          )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              profile.user.displayName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (profile.user.isVerified) ...[
                              const SizedBox(width: 4),
                              Icon(
                                Icons.verified,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          ],
                        ),
                        Text(
                          '@${profile.user.username}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (profile.bio != null) ...[
                const SizedBox(height: 16),
                Text(profile.bio!),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildStat(context, '게시글', profile.postsCount),
                  const SizedBox(width: 24),
                  _buildStat(context, '팔로워', profile.followersCount),
                  const SizedBox(width: 24),
                  _buildStat(context, '팔로잉', profile.followingCount),
                ],
              ),
              const SizedBox(height: 16),
              if (!profile.isCurrentUser)
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onFollowTap,
                    style: FilledButton.styleFrom(
                      backgroundColor: profile.isFollowing
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      profile.isFollowing ? '팔로잉' : '팔로우',
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildStat(BuildContext context, String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

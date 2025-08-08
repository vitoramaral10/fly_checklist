import 'package:flutter/material.dart';

import 'components.dart';

class AvatarWithShimmer extends StatelessWidget {
  final String? imageUrl;
  final double size; // diameter
  final IconData fallbackIcon;

  const AvatarWithShimmer({
    super.key,
    required this.imageUrl,
    this.size = 64,
    this.fallbackIcon = Icons.person_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: theme.colorScheme.secondary,
        child: Icon(
          fallbackIcon,
          color: theme.colorScheme.onSecondary,
          size: size * 0.5,
        ),
      );
    }

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return ShimmerContainer(
              width: size,
              height: size,
              borderRadius: size / 2,
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return CircleAvatar(
              radius: size / 2,
              backgroundColor: theme.colorScheme.secondary,
              child: Icon(
                fallbackIcon,
                color: theme.colorScheme.onSecondary,
                size: size * 0.5,
              ),
            );
          },
        ),
      ),
    );
  }
}

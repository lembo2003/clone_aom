import 'dart:convert';

import 'package:flutter/material.dart';

class ResourceListTile extends StatelessWidget {
  final String? fullName;
  final String? position;
  final String? email;
  final String? avatar; // base64 string
  final VoidCallback? onTap;
  final VoidCallback? onActionPressed;

  const ResourceListTile({
    super.key,
    this.fullName,
    this.position,
    this.email,
    this.avatar,
    this.onTap,
    this.onActionPressed,
  });

  ImageProvider? _getAvatarImage(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      // Remove data:image/xyz;base64, prefix if present
      final cleanBase64 =
          base64String.contains(',')
              ? base64String.split(',')[1]
              : base64String;
      return MemoryImage(base64Decode(cleanBase64));
    } catch (e) {
      debugPrint('Error decoding base64 image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarImage = _getAvatarImage(avatar);

    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.deepPurple.shade50,
                backgroundImage: avatarImage,
                child:
                    avatarImage == null
                        ? Text(
                          (fullName ?? 'U')[0].toUpperCase(),
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                        : null,
              ),
              const SizedBox(width: 16),
              // Resource Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName ?? 'Unknown User',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      position ?? 'No Position',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    if (email != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        email!,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Actions
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: onActionPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

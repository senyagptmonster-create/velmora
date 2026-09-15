import 'package:flutter/material.dart';
import '../services/stretch_routine_service.dart';
import '../theme/velmora_theme.dart';

class StretchPoseCard extends StatelessWidget {
  final StretchPose pose;
  final bool isSelected;
  final VoidCallback onTap;

  const StretchPoseCard({
    super.key,
    required this.pose,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isSelected ? VelmoraTheme.calmingSage : VelmoraTheme.cardOutline,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: VelmoraTheme.calmingSage.withValues(alpha: 0.15),
          child: const Icon(Icons.accessibility_new, color: VelmoraTheme.calmingSage),
        ),
        title: Text(pose.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(pose.targetArea, style: const TextStyle(fontSize: 12, color: VelmoraTheme.softLavender, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(pose.instructions, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: VelmoraTheme.warmCream,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('${pose.holdDurationSeconds}s', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        onTap: onTap,
      ),
    );
  }
}

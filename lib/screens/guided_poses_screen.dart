import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/stretch_routine_service.dart';
import '../components/stretch_pose_card.dart';

class GuidedPosesScreen extends StatelessWidget {
  const GuidedPosesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<StretchRoutineService>();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: service.poses.length,
      itemBuilder: (context, idx) {
        final pose = service.poses[idx];
        return StretchPoseCard(
          pose: pose,
          isSelected: idx == service.currentPoseIndex,
          onTap: () {
            service.selectPose(idx);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected ${pose.title}')),
            );
          },
        );
      },
    );
  }
}

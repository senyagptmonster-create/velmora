import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/stretch_routine_service.dart';
import '../theme/velmora_theme.dart';

class RoutineTimerScreen extends StatelessWidget {
  const RoutineTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<StretchRoutineService>();
    final pose = service.currentPose;
    final progress = (pose.holdDurationSeconds - service.timerSeconds) / pose.holdDurationSeconds;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: VelmoraTheme.cardOutline),
            ),
            child: Column(
              children: [
                Text(pose.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 6),
                Text('Target: ${pose.targetArea}',
                    style: const TextStyle(color: VelmoraTheme.softLavender, fontWeight: FontWeight.bold, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 36),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 220,
                height: 220,
                child: CircularProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  strokeWidth: 10,
                  backgroundColor: VelmoraTheme.cardOutline,
                  valueColor: const AlwaysStoppedAnimation(VelmoraTheme.calmingSage),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${service.timerSeconds}s',
                    style: const TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.w900,
                      color: VelmoraTheme.darkSlate,
                    ),
                  ),
                  Text(
                    service.isTimerRunning ? 'HOLD POSE' : 'READY',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: service.isTimerRunning ? VelmoraTheme.calmingSage : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                onPressed: () => service.resetTimer(),
                icon: const Icon(Icons.replay),
                iconSize: 26,
              ),
              const SizedBox(width: 20),
              FilledButton.icon(
                onPressed: () => service.toggleTimer(),
                icon: Icon(service.isTimerRunning ? Icons.pause : Icons.play_arrow),
                label: Text(service.isTimerRunning ? 'Pause Hold' : 'Begin Stretch Hold'),
                style: FilledButton.styleFrom(
                  backgroundColor: VelmoraTheme.calmingSage,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              pose.instructions,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

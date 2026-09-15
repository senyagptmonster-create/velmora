import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/stretch_routine_service.dart';
import '../theme/velmora_theme.dart';

class StretchHistoryScreen extends StatelessWidget {
  const StretchHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<StretchRoutineService>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: VelmoraTheme.cardOutline),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Desk Breaks Completed Today', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 6),
                      Text(
                        '${service.completedStretchesToday} Micro-Routines',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: VelmoraTheme.calmingSage,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.spa, color: VelmoraTheme.calmingSage, size: 36),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Recommended Cadence', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          _CadenceItem(
            interval: 'Every 30 Minutes',
            action: '20-second 20-20-20 eye refocus & chin retraction',
          ),
          const SizedBox(height: 8),
          _CadenceItem(
            interval: 'Every 60 Minutes',
            action: 'Stand up, thoracic spine extension, shoulder blade pinches',
          ),
          const SizedBox(height: 8),
          _CadenceItem(
            interval: 'Mid-Day Lunch',
            action: '5-minute brisk walk and full pectoral stretch hold',
          ),
        ],
      ),
    );
  }
}

class _CadenceItem extends StatelessWidget {
  final String interval;
  final String action;

  const _CadenceItem({required this.interval, required this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: VelmoraTheme.cardOutline),
      ),
      child: ListTile(
        leading: const Icon(Icons.alarm_on, color: VelmoraTheme.calmingSage),
        title: Text(interval, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(action, style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
      ),
    );
  }
}

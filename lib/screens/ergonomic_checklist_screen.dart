import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/stretch_routine_service.dart';
import '../theme/velmora_theme.dart';

class ErgonomicChecklistScreen extends StatelessWidget {
  const ErgonomicChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<StretchRoutineService>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text('Desk Posture Audit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        ...service.ergonomics.entries.map((entry) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: const BorderSide(color: VelmoraTheme.cardOutline),
            ),
            child: CheckboxListTile(
              title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              value: entry.value,
              activeColor: VelmoraTheme.calmingSage,
              onChanged: (_) => service.toggleErgonomic(entry.key),
            ),
          );
        }),
      ],
    );
  }
}

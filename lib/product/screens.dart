import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/theme.dart';
import 'velmora_store.dart';

class VelmoraHome extends StatefulWidget {
  const VelmoraHome({super.key});
  @override
  _VelmoraHomeState createState() => _VelmoraHomeState();
}

class _VelmoraHomeState extends State<VelmoraHome> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const GuidedPoseScreen(),
    const RoutineTimerScreen(),
    const ErgonomicChecklistScreen(),
    const StretchHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Velmora', style: AppTheme.display(context))),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: Text('Guided Pose Carousel', style: AppTheme.text(context)), onTap: () { setState(() { _currentIndex = 0; Navigator.pop(context); }); }),
            ListTile(title: Text('Routine Timer', style: AppTheme.text(context)), onTap: () { setState(() { _currentIndex = 1; Navigator.pop(context); }); }),
            ListTile(title: Text('Ergonomic Checklist', style: AppTheme.text(context)), onTap: () { setState(() { _currentIndex = 2; Navigator.pop(context); }); }),
            ListTile(title: Text('Daily Stretch History', style: AppTheme.text(context)), onTap: () { setState(() { _currentIndex = 3; Navigator.pop(context); }); }),
          ],
        ),
      ),
      body: _screens[_currentIndex],
    );
  }
}

class GuidedPoseScreen extends StatelessWidget {
  const GuidedPoseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<VelmoraStore>();
    return PageView.builder(
      itemCount: store.stretches.length,
      itemBuilder: (context, index) {
        final pose = store.stretches[index];
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(pose['name'], style: AppTheme.display(context)),
              const SizedBox(height: 16),
              Text(pose['duration'], style: AppTheme.text(context)),
            ],
          ),
        );
      },
    );
  }
}

class RoutineTimerScreen extends StatelessWidget {
  const RoutineTimerScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Text('Routine Timer', style: AppTheme.display(context)));
}

class ErgonomicChecklistScreen extends StatelessWidget {
  const ErgonomicChecklistScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Text('Ergonomic Checklist', style: AppTheme.display(context)));
}

class StretchHistoryScreen extends StatelessWidget {
  const StretchHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(child: Text('Daily Stretch History', style: AppTheme.display(context)));
}

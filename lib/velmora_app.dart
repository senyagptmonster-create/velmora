import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/velmora_theme.dart';
import 'services/stretch_routine_service.dart';
import 'screens/guided_poses_screen.dart';
import 'screens/routine_timer_screen.dart';
import 'screens/ergonomic_checklist_screen.dart';
import 'screens/stretch_history_screen.dart';

class VelmoraApp extends StatelessWidget {
  const VelmoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StretchRoutineService(),
      child: MaterialApp(
        title: 'Velmora Micro Stretch',
        theme: VelmoraTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const VelmoraHomeScaffold(),
      ),
    );
  }
}

class VelmoraHomeScaffold extends StatefulWidget {
  const VelmoraHomeScaffold({super.key});

  @override
  State<VelmoraHomeScaffold> createState() => _VelmoraHomeScaffoldState();
}

class _VelmoraHomeScaffoldState extends State<VelmoraHomeScaffold> {
  int _currentIndex = 0;

  final _titles = ['Guided Poses', 'Stretch Timer', 'Ergonomic Audit', 'Daily Activity'];
  final _screens = const [
    GuidedPosesScreen(),
    RoutineTimerScreen(),
    ErgonomicChecklistScreen(),
    StretchHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.self_improvement_outlined), selectedIcon: Icon(Icons.self_improvement), label: 'Poses'),
          NavigationDestination(icon: Icon(Icons.timer_outlined), selectedIcon: Icon(Icons.timer), label: 'Hold'),
          NavigationDestination(icon: Icon(Icons.chair_outlined), selectedIcon: Icon(Icons.chair), label: 'Ergonomics'),
          NavigationDestination(icon: Icon(Icons.history_outlined), selectedIcon: Icon(Icons.history), label: 'Daily'),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'theme/velmora_theme.dart';
import 'painters/posture_skeleton_painter.dart';

class VelmoraApp extends StatelessWidget {
  const VelmoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Velmora Micro-Stretch',
      debugShowCheckedModeBanner: false,
      theme: VelmoraTheme.themeData,
      home: const VelmoraShell(),
    );
  }
}

class VelmoraShell extends StatefulWidget {
  const VelmoraShell({super.key});

  @override
  State<VelmoraShell> createState() => _VelmoraShellState();
}

class _VelmoraShellState extends State<VelmoraShell>
    with SingleTickerProviderStateMixin {
  int _navIndex = 0;
  late AnimationController _animController;
  Timer? _timer;

  int _stretchSeconds = 30;
  int _remainingSeconds = 30;
  bool _isTiming = false;
  String _selectedPose = 'Chest Opener';

  final List<Map<String, dynamic>> _poses = [
    {
      'name': 'Chest Opener',
      'target': 'Pectorals & Anterior Deltoids',
      'benefit': 'Counteracts forward-head computer slouching.',
      'duration': 30,
    },
    {
      'name': 'Upper Trapezius Release',
      'target': 'Neck & Shoulder Cervical Spine',
      'benefit': 'Relieves desk tension headaches and tightness.',
      'duration': 25,
    },
    {
      'name': 'Seated Spinal Twist',
      'target': 'Thoracic & Lumbar Mobility',
      'benefit': 'Restores rotational fluid to spinal discs.',
      'duration': 40,
    },
    {
      'name': 'Wrist & Forearm Flexor',
      'target': 'Carpal Tunnel Tendons',
      'benefit': 'Prevents RSI from repetitive mouse & keyboard usage.',
      'duration': 20,
    },
  ];

  final List<Map<String, String>> _history = [
    {'pose': 'Chest Opener', 'duration': '30s', 'time': '09:45 AM'},
    {'pose': 'Upper Trapezius Release', 'duration': '25s', 'time': '11:15 AM'},
    {'pose': 'Seated Spinal Twist', 'duration': '40s', 'time': '02:30 PM'},
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTimer() {
    setState(() {
      if (_isTiming) {
        _timer?.cancel();
        _isTiming = false;
      } else {
        _isTiming = true;
        _timer = Timer.periodic(const Duration(seconds: 1), (t) {
          if (_remainingSeconds > 0) {
            setState(() => _remainingSeconds--);
          } else {
            t.cancel();
            setState(() {
              _isTiming = false;
              _remainingSeconds = _stretchSeconds;
              _history.insert(0, {
                'pose': _selectedPose,
                'duration': '${_stretchSeconds}s',
                'time': 'Just now',
              });
            });
          }
        });
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isTiming = false;
      _remainingSeconds = _stretchSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getTitle(_navIndex),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: VelmoraTheme.ink,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                color: VelmoraTheme.bg,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.self_improvement_rounded, size: 36, color: VelmoraTheme.accent),
                    SizedBox(height: 12),
                    Text(
                      'VELMORA POSTURE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: VelmoraTheme.ink,
                      ),
                    ),
                    Text(
                      'Desk Worker Micro-Mobility',
                      style: TextStyle(fontSize: 12, color: VelmoraTheme.muted),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: VelmoraTheme.edge),
              _buildDrawerItem(0, 'Guided Posture Stretch', Icons.accessibility_new_rounded),
              _buildDrawerItem(1, 'Pose Library', Icons.fitness_center_rounded),
              _buildDrawerItem(2, 'Ergonomic Desk Guide', Icons.chair_rounded),
              _buildDrawerItem(3, 'Mobility History', Icons.history_rounded),
            ],
          ),
        ),
      ),
      body: _buildCurrentBody(),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0: return 'Guided Posture Stretch';
      case 1: return 'Pose Library';
      case 2: return 'Ergonomic Desk Guide';
      case 3: return 'Mobility History';
      default: return 'Velmora Posture';
    }
  }

  Widget _buildDrawerItem(int index, String title, IconData icon) {
    final isSel = _navIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSel ? VelmoraTheme.accent : VelmoraTheme.muted),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
          color: isSel ? VelmoraTheme.accent : VelmoraTheme.ink,
        ),
      ),
      selected: isSel,
      selectedTileColor: VelmoraTheme.edge.withValues(alpha: 0.3),
      onTap: () {
        setState(() => _navIndex = index);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildCurrentBody() {
    switch (_navIndex) {
      case 0: return _buildGuidedScreen();
      case 1: return _buildPoseLibraryScreen();
      case 2: return _buildErgonomicsScreen();
      case 3: return _buildHistoryScreen();
      default: return _buildGuidedScreen();
    }
  }

  Widget _buildGuidedScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Visual Skeleton Painter Card
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        _selectedPose,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: VelmoraTheme.accent),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: CustomPaint(
                          painter: PostureSkeletonPainter(
                            stretchProgress: _isTiming ? _animController.value : 0.2,
                            poseType: _selectedPose,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '$_remainingSeconds SECONDS',
                        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: VelmoraTheme.ink),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: VelmoraTheme.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  _isTiming ? 'PAUSE STRETCH' : 'START STRETCH',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
              ),
              const SizedBox(width: 16),
              IconButton.filledTonal(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: _resetTimer,
                style: IconButton.styleFrom(
                  backgroundColor: VelmoraTheme.edge,
                  foregroundColor: VelmoraTheme.ink,
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Pose selector chips
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            children: _poses.map((p) {
              final name = p['name'] as String;
              final isSel = _selectedPose == name;
              return ChoiceChip(
                label: Text(name, style: TextStyle(color: isSel ? Colors.white : VelmoraTheme.ink, fontSize: 12)),
                selected: isSel,
                selectedColor: VelmoraTheme.accent,
                backgroundColor: VelmoraTheme.surface,
                onSelected: (_) {
                  setState(() {
                    _selectedPose = name;
                    _stretchSeconds = p['duration'] as int;
                    _remainingSeconds = _stretchSeconds;
                    _isTiming = false;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPoseLibraryScreen() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _poses.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final p = _poses[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(p['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text('${p['duration']}s', style: const TextStyle(fontWeight: FontWeight.bold, color: VelmoraTheme.accent)),
                  ],
                ),
                const SizedBox(height: 6),
                Text('Target: ${p['target']}', style: const TextStyle(fontSize: 12, color: VelmoraTheme.accentLight, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(p['benefit'] as String, style: const TextStyle(fontSize: 12, color: VelmoraTheme.muted)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErgonomicsScreen() {
    final rules = [
      {'title': 'Eye Line at Top 1/3 of Screen', 'desc': 'Keep neck neutral. Screen distance should equal your arm length.'},
      {'title': 'Elbows at 90 - 100 Degrees', 'desc': 'Armrests must support forearms without shrugging shoulders.'},
      {'title': 'Feet Flat or on Footrest', 'desc': 'Avoid crossing ankles to preserve pelvic alignment and venous return.'},
      {'title': '20-20-20 Vision Rule', 'desc': 'Every 20 minutes, gaze at an object 20 feet away for at least 20 seconds.'},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: rules.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final r = rules[i];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: VelmoraTheme.edge,
              child: Text('${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: VelmoraTheme.accent)),
            ),
            title: Text(r['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Text(r['desc']!, style: const TextStyle(fontSize: 12, color: VelmoraTheme.muted)),
          ),
        );
      },
    );
  }

  Widget _buildHistoryScreen() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _history.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, i) {
        final h = _history[i];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: VelmoraTheme.edge,
              child: Icon(Icons.done_all_rounded, color: VelmoraTheme.accent),
            ),
            title: Text(h['pose']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(h['time']!),
            trailing: Text(h['duration']!, style: const TextStyle(fontWeight: FontWeight.bold, color: VelmoraTheme.accent)),
          ),
        );
      },
    );
  }
}

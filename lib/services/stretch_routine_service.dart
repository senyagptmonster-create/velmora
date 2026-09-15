import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StretchPose {
  final String id;
  final String title;
  final String targetArea;
  final int holdDurationSeconds;
  final String instructions;

  const StretchPose({
    required this.id,
    required this.title,
    required this.targetArea,
    required this.holdDurationSeconds,
    required this.instructions,
  });
}

class StretchRoutineService extends ChangeNotifier {
  final List<StretchPose> _poses = [
    const StretchPose(
      id: 'p1',
      title: 'Cervical Retraction (Chin Tuck)',
      targetArea: 'Cervical Spine / Neck',
      holdDurationSeconds: 20,
      instructions: 'Draw head straight backwards without tilting chin down. Align ears directly over shoulders.',
    ),
    const StretchPose(
      id: 'p2',
      title: 'Seated Thoracic Extension',
      targetArea: 'Upper Back / Ribcage',
      holdDurationSeconds: 30,
      instructions: 'Interlock fingers behind head. Gently arch upper back backwards over chair edge while inhaling.',
    ),
    const StretchPose(
      id: 'p3',
      title: 'Forearm & Wrist Flexor Opener',
      targetArea: 'Wrists & Typing Tendons',
      holdDurationSeconds: 25,
      instructions: 'Extend arm with elbow straight. Gently pull fingers back toward forearm to stretch anterior wrist.',
    ),
    const StretchPose(
      id: 'p4',
      title: 'Doorway Pectoral Stretch',
      targetArea: 'Chest & Anterior Deltoids',
      holdDurationSeconds: 30,
      instructions: 'Place forearm on door frame at 90 degrees. Step forward gently until mild chest stretch is felt.',
    ),
  ];

  final Map<String, bool> _ergonomics = {
    'Monitor top level with eyes': true,
    'Elbows resting at 90-100 degrees': true,
    'Feet flat on floor or footrest': false,
    'Lumbar curve supported by chair': true,
    'Shoulders relaxed and dropped': true,
  };

  int _completedStretchesToday = 4;
  int _currentPoseIndex = 0;
  int _timerSeconds = 30;
  bool _isTimerRunning = false;

  StretchRoutineService() {
    _loadPrefs();
  }

  List<StretchPose> get poses => _poses;
  Map<String, bool> get ergonomics => _ergonomics;
  int get completedStretchesToday => _completedStretchesToday;
  int get currentPoseIndex => _currentPoseIndex;
  int get timerSeconds => _timerSeconds;
  bool get isTimerRunning => _isTimerRunning;

  StretchPose get currentPose => _poses[_currentPoseIndex];

  void selectPose(int index) {
    if (index >= 0 && index < _poses.length) {
      _currentPoseIndex = index;
      _timerSeconds = _poses[index].holdDurationSeconds;
      _isTimerRunning = false;
      notifyListeners();
    }
  }

  void toggleTimer() {
    _isTimerRunning = !_isTimerRunning;
    notifyListeners();
  }

  void tick() {
    if (_isTimerRunning && _timerSeconds > 0) {
      _timerSeconds--;
      if (_timerSeconds == 0) {
        _isTimerRunning = false;
        _completedStretchesToday++;
        _savePrefs();
      }
      notifyListeners();
    }
  }

  void resetTimer() {
    _isTimerRunning = false;
    _timerSeconds = currentPose.holdDurationSeconds;
    notifyListeners();
  }

  void toggleErgonomic(String key) {
    if (_ergonomics.containsKey(key)) {
      _ergonomics[key] = !_ergonomics[key]!;
      notifyListeners();
    }
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _completedStretchesToday = prefs.getInt('velmora_stretches') ?? 4;
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('velmora_stretches', _completedStretchesToday);
  }
}

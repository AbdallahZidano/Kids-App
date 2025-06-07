import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kids_learning/models/month_model.dart';

class MonthProvider extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String? _currentMonth;

  bool get isSpeaking => _isSpeaking;
  String? get currentMonth => _currentMonth;

  MonthProvider() {
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5); // Slower rate for better clarity
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speakMonth(MonthModel month) async {
    if (_isSpeaking) return;

    try {
      _isSpeaking = true;
      _currentMonth = month.name;
      notifyListeners();

      await _flutterTts.speak(month.name);

      await Future.delayed(const Duration(seconds: 2));
      _isSpeaking = false;
      _currentMonth = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error speaking month: $e');
      _isSpeaking = false;
      _currentMonth = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

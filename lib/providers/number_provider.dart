import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/number_model.dart';

class NumberProvider extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String? _currentNumber;

  NumberProvider() {
    _initializeTts();
  }

  bool get isSpeaking => _isSpeaking;
  String? get currentNumber => _currentNumber;

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speakNumber(NumberModel number) async {
    if (_isSpeaking) return;

    _isSpeaking = true;
    _currentNumber = number.number;
    notifyListeners();

    try {
      await _flutterTts.speak(number.word);
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      debugPrint('Error speaking number: $e');
    } finally {
      _isSpeaking = false;
      _currentNumber = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/alphabet_model.dart';

class AlphabetProvider extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String? _currentLetter;

  bool get isSpeaking => _isSpeaking;
  String? get currentLetter => _currentLetter;

  AlphabetProvider() {
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  Future<void> speakLetter(AlphabetModel letter) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
    }

    _currentLetter = letter.letter;
    _isSpeaking = true;
    notifyListeners();

    await _flutterTts.speak('${letter.letter} is for ${letter.example}');
  }

  Future<void> stopSpeaking() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

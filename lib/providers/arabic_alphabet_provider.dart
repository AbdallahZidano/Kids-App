import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/arabic_alphabet_model.dart';

class ArabicAlphabetProvider with ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String? _currentLetter;

  bool get isSpeaking => _isSpeaking;
  String? get currentLetter => _currentLetter;

  ArabicAlphabetProvider() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage('ar-SA');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speakLetter(ArabicAlphabetModel letter) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      _currentLetter = null;
      notifyListeners();
      return;
    }

    _isSpeaking = true;
    _currentLetter = letter.letter;
    notifyListeners();

    await _flutterTts.speak("${letter.letter} ${letter.example}");

    _isSpeaking = false;
    _currentLetter = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

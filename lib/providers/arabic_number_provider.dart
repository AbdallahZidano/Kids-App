import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/arabic_number_model.dart';

class ArabicNumberProvider with ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String? _currentNumber;

  bool get isSpeaking => _isSpeaking;
  String? get currentNumber => _currentNumber;

  ArabicNumberProvider() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage('ar-SA');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speakNumber(ArabicNumberModel number) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      _currentNumber = null;
      notifyListeners();
      return;
    }

    _isSpeaking = true;
    _currentNumber = number.number;
    notifyListeners();

    await _flutterTts.speak(number.number);

    _isSpeaking = false;
    _currentNumber = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/arabic_color_model.dart';

class ArabicColorProvider with ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String? _currentColor;

  bool get isSpeaking => _isSpeaking;
  String? get currentColor => _currentColor;

  ArabicColorProvider() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.stop();
    await _flutterTts.setLanguage('ar-SA');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speakColor(ArabicColorModel color) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      _currentColor = null;
      notifyListeners();
      return;
    }

    try {
      await _initTts(); // Reinitialize TTS before speaking
      _isSpeaking = true;
      _currentColor = color.name;
      notifyListeners();

      await _flutterTts.speak(color.arabicName);

      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
        _currentColor = null;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Error speaking Arabic color: $e');
      _isSpeaking = false;
      _currentColor = null;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

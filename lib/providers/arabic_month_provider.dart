import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kids_learning/models/arabic_month_model.dart';

class ArabicMonthProvider with ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  String? _currentMonth;

  bool get isSpeaking => _isSpeaking;
  String? get currentMonth => _currentMonth;

  ArabicMonthProvider() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.stop();
    await _flutterTts.setLanguage('ar-SA');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speakMonth(ArabicMonthModel month) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      _isSpeaking = false;
      _currentMonth = null;
      notifyListeners();
      return;
    }

    try {
      await _initTts(); // Reinitialize TTS before speaking
      _isSpeaking = true;
      _currentMonth = month.name;
      notifyListeners();

      await _flutterTts.speak(month.name);

      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
        _currentMonth = null;
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Error speaking Arabic month: $e');
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

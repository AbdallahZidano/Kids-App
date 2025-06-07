import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GameSoundProvider extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  GameSoundProvider() {
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

  Future<void> playCorrectAnswer() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
    }

    _isSpeaking = true;
    notifyListeners();

    await _flutterTts.speak('Great job! That\'s correct!');
  }

  Future<void> playWrongAnswer() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
    }

    _isSpeaking = true;
    notifyListeners();

    await _flutterTts.speak('Try again! You can do it!');
  }

  Future<void> playGameOver(int score) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
    }

    _isSpeaking = true;
    notifyListeners();

    await _flutterTts.speak('Game over! Your score is $score!');
  }

  Future<void> playNewQuestion(String question) async {
    if (_isSpeaking) {
      await _flutterTts.stop();
    }

    _isSpeaking = true;
    notifyListeners();

    await _flutterTts.speak(question);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

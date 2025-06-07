import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/alphabet_model.dart';

class AlphabetGameProvider extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;
  int _score = 0;
  int _level = 1;
  bool _isGameOver = false;
  AlphabetModel? _currentLetter;
  AlphabetModel? _selectedOption;
  List<AlphabetModel> _options = [];

  AlphabetGameProvider() {
    _initializeTts();
    startNewGame();
  }

  bool get isSpeaking => _isSpeaking;
  int get score => _score;
  int get level => _level;
  bool get isGameOver => _isGameOver;
  AlphabetModel get currentLetter => _currentLetter!;
  AlphabetModel? get selectedOption => _selectedOption;
  List<AlphabetModel> get options => _options;

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  void startNewGame() {
    _score = 0;
    _level = 1;
    _isGameOver = false;
    _selectedOption = null;
    _generateQuestion();
    notifyListeners();
  }

  void _generateQuestion() {
    final random = Random();
    _currentLetter =
        AlphabetModel.letters[random.nextInt(AlphabetModel.letters.length)];

    // Generate options
    _options = List.from(AlphabetModel.letters);
    _options.shuffle();
    _options = _options.take(4).toList();

    // Ensure the correct answer is in the options
    if (!_options.contains(_currentLetter)) {
      _options[0] = _currentLetter!;
      _options.shuffle();
    }
  }

  Future<void> checkAnswer(AlphabetModel selectedLetter) async {
    if (_isSpeaking || _isGameOver) return;

    _selectedOption = selectedLetter;
    notifyListeners();

    if (selectedLetter == _currentLetter) {
      _score += 10;
      _level = (_score ~/ 50) + 1;
      await _speakCorrect();
    } else {
      await _speakIncorrect();
      _isGameOver = true;
    }

    if (!_isGameOver) {
      _selectedOption = null;
      _generateQuestion();
    }

    notifyListeners();
  }

  Future<void> _speakCorrect() async {
    if (_isSpeaking) return;
    _isSpeaking = true;
    notifyListeners();

    try {
      await _flutterTts.speak(
        'Correct! ${_currentLetter!.letter} is for ${_currentLetter!.example}',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error speaking: $e');
      }
    } finally {
      _isSpeaking = false;
      notifyListeners();
    }
  }

  Future<void> _speakIncorrect() async {
    if (_isSpeaking) return;
    _isSpeaking = true;
    notifyListeners();

    try {
      await _flutterTts.speak(
        'Game Over! Your score is $_score. The correct letter was ${_currentLetter!.letter} for ${_currentLetter!.example}',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error speaking: $e');
      }
    } finally {
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

import 'package:flutter/material.dart';

import '../models/game_model.dart';

class GameProvider extends ChangeNotifier {
  GameModel? _currentGame;
  int _score = 0;
  int _level = 1;
  int? _selectedAnswer;
  bool _showResult = false;
  bool _isCorrect = false;

  GameModel? get currentGame => _currentGame;
  int get score => _score;
  int get level => _level;
  int? get selectedAnswer => _selectedAnswer;
  bool get showResult => _showResult;
  bool get isCorrect => _isCorrect;
  List<int> get options => _currentGame?.options ?? [];
  String get currentQuestion =>
      _currentGame != null
          ? '${_currentGame!.firstNumber} ${_currentGame!.operationSymbol} ${_currentGame!.secondNumber} = ?'
          : '';

  GameProvider() {
    generateNewQuestion();
  }

  void generateNewQuestion() {
    _currentGame = GameModel.generateQuestion(_level);
    _selectedAnswer = null;
    _showResult = false;
    notifyListeners();
  }

  bool checkAnswer(int answer) {
    if (_currentGame == null) return false;
    _selectedAnswer = answer;
    _isCorrect = answer == _currentGame!.correctAnswer;
    _showResult = true;

    if (_isCorrect) {
      _score += 10;
      if (_score % 50 == 0) {
        _level++;
      }
    }

    notifyListeners();
    return _isCorrect;
  }

  bool isAnswerCorrect(int answer) {
    return _currentGame?.correctAnswer == answer;
  }

  void nextQuestion() {
    generateNewQuestion();
  }

  void selectAnswer(int answer) {
    _selectedAnswer = answer;
    notifyListeners();
  }

  void resetGame() {
    _score = 0;
    _level = 1;
    _selectedAnswer = null;
    _showResult = false;
    _isCorrect = false;
    generateNewQuestion();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _userName;
  bool _isFirstTime = true;
  final FlutterTts _flutterTts = FlutterTts();

  String? get userName => _userName;
  bool get isFirstTime => _isFirstTime;

  UserProvider() {
    _loadUserName();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5); // Slower rate for better clarity
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> _loadUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _userName = prefs.getString('user_name');
      _isFirstTime = _userName == null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user name: $e');
    }
  }

  Future<void> saveUserName(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      _userName = name;
      _isFirstTime = false;
      notifyListeners();

      // Play welcome message
      await _playWelcomeMessage(name);
    } catch (e) {
      debugPrint('Error saving user name: $e');
      rethrow;
    }
  }

  Future<void> _playWelcomeMessage(String name) async {
    try {
      await _flutterTts.speak(
        "Welcome to Kids Learning, $name! Let's start learning together!",
      );
    } catch (e) {
      debugPrint('Error playing welcome message: $e');
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/color_model.dart';

class ColorProvider extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();
  ColorModel? _selectedColor;
  bool _isPlaying = false;

  ColorModel? get selectedColor => _selectedColor;
  bool get isPlaying => _isPlaying;

  ColorProvider() {
    _selectedColor = ColorModel.colors.first;
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5); // Slower rate for better clarity
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  void selectColor(ColorModel color) {
    _selectedColor = color;
    notifyListeners();
  }

  Future<void> playColorAudio() async {
    if (_selectedColor == null) return;

    try {
      _isPlaying = true;
      notifyListeners();

      await _flutterTts.speak(_selectedColor!.name);

      // Listen for completion
      _flutterTts.setCompletionHandler(() {
        _isPlaying = false;
        notifyListeners();
      });
    } catch (e) {
      _isPlaying = false;
      notifyListeners();
      debugPrint('Error playing audio: $e');
    }
  }

  void nextColor() {
    final currentIndex = ColorModel.colors.indexOf(_selectedColor!);
    final nextIndex = (currentIndex + 1) % ColorModel.colors.length;
    selectColor(ColorModel.colors[nextIndex]);
  }

  void previousColor() {
    final currentIndex = ColorModel.colors.indexOf(_selectedColor!);
    final previousIndex =
        (currentIndex - 1 + ColorModel.colors.length) %
        ColorModel.colors.length;
    selectColor(ColorModel.colors[previousIndex]);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

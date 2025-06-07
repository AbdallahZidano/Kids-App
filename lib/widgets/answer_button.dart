import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final int number;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;

  const AnswerButton({
    super.key,
    required this.number,
    required this.onPressed,
    this.isSelected = false,
    this.isCorrect = false,
    this.showResult = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.blue;

    if (showResult) {
      if (isCorrect) {
        backgroundColor = Colors.green.shade100;
        borderColor = Colors.green;
      } else if (isSelected) {
        backgroundColor = Colors.red.shade100;
        borderColor = Colors.red;
      }
    } else if (isSelected) {
      backgroundColor = Colors.blue.shade100;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: showResult ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: borderColor, width: 2),
          ),
        ),
        child: Text(
          number.toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

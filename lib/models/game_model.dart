import 'dart:math';

enum OperationType { addition, subtraction, multiplication, division }

class GameModel {
  final int firstNumber;
  final int secondNumber;
  final String operationSymbol;
  final int correctAnswer;
  final List<int> options;

  const GameModel({
    required this.firstNumber,
    required this.secondNumber,
    required this.operationSymbol,
    required this.correctAnswer,
    required this.options,
  });

  factory GameModel.generateNewQuestion(int level) {
    final random = Random();
    OperationType operation;

    // Determine operation based on level
    if (level <= 2) {
      operation = OperationType.addition;
    } else if (level <= 4) {
      operation =
          random.nextBool()
              ? OperationType.addition
              : OperationType.subtraction;
    } else if (level <= 6) {
      operation =
          random.nextBool()
              ? OperationType.multiplication
              : OperationType.addition;
    } else {
      final operations = OperationType.values;
      operation = operations[random.nextInt(operations.length)];
    }

    // Generate numbers based on level
    int maxNumber = 5 + (level * 2);
    int firstNumber = random.nextInt(maxNumber) + 1;
    int secondNumber = random.nextInt(maxNumber) + 1;

    // Ensure subtraction doesn't result in negative numbers
    if (operation == OperationType.subtraction && secondNumber > firstNumber) {
      final temp = firstNumber;
      firstNumber = secondNumber;
      secondNumber = temp;
    }

    // Calculate correct answer
    int correctAnswer;
    switch (operation) {
      case OperationType.addition:
        correctAnswer = firstNumber + secondNumber;
        break;
      case OperationType.subtraction:
        correctAnswer = firstNumber - secondNumber;
        break;
      case OperationType.multiplication:
        correctAnswer = firstNumber * secondNumber;
        break;
      case OperationType.division:
        // Ensure clean division
        correctAnswer = firstNumber;
        firstNumber = firstNumber * secondNumber;
        break;
    }

    // Generate options
    List<int> options = [correctAnswer];
    while (options.length < 4) {
      int option = correctAnswer + random.nextInt(5) - 2;
      if (option >= 0 && !options.contains(option)) {
        options.add(option);
      }
    }
    options.shuffle();

    return GameModel(
      firstNumber: firstNumber,
      secondNumber: secondNumber,
      operationSymbol: operation.toString(),
      correctAnswer: correctAnswer,
      options: options,
    );
  }

  static GameModel generateQuestion(int level) {
    final random = Random();
    final maxNumber = 10 + (level * 5);

    final firstNumber = random.nextInt(maxNumber) + 1;
    final secondNumber = random.nextInt(maxNumber) + 1;
    final operation = random.nextInt(2); // 0 for addition, 1 for subtraction

    final operationSymbol = operation == 0 ? '+' : '-';
    final correctAnswer =
        operation == 0
            ? firstNumber + secondNumber
            : firstNumber - secondNumber;

    // Generate wrong options
    final options = <int>{correctAnswer};
    while (options.length < 4) {
      final wrongAnswer = correctAnswer + random.nextInt(10) - 5;
      if (wrongAnswer >= 0 && wrongAnswer != correctAnswer) {
        options.add(wrongAnswer);
      }
    }

    return GameModel(
      firstNumber: firstNumber,
      secondNumber: secondNumber,
      operationSymbol: operationSymbol,
      correctAnswer: correctAnswer,
      options: options.toList()..shuffle(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/alphabet_model.dart';
import '../providers/alphabet_game_provider.dart';

class AlphabetGameScreen extends StatelessWidget {
  const AlphabetGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alphabet Game'), centerTitle: true),
      body: Consumer<AlphabetGameProvider>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade100, Colors.white],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildScoreBoard(provider),
                  Expanded(child: _buildGameArea(context, provider)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScoreBoard(AlphabetGameProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildScoreItem('Score', provider.score.toString()),
          _buildScoreItem('Level', provider.level.toString()),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.blue.shade300),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameArea(BuildContext context, AlphabetGameProvider provider) {
    if (provider.isGameOver) {
      return _buildGameOver(context, provider);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildQuestion(provider),
          const SizedBox(height: 32),
          _buildOptions(context, provider),
        ],
      ),
    );
  }

  Widget _buildQuestion(AlphabetGameProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Find the letter:',
            style: TextStyle(fontSize: 20, color: Colors.blue.shade300),
          ),
          const SizedBox(height: 16),
          Text(
            provider.currentLetter.pronunciation,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions(BuildContext context, AlphabetGameProvider provider) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: provider.options.length,
      itemBuilder: (context, index) {
        final letter = provider.options[index];
        final isCorrect = letter == provider.currentLetter;
        final isSelected = provider.selectedOption == letter;

        return _buildOptionCard(
          context,
          letter,
          isCorrect,
          isSelected,
          () => provider.checkAnswer(letter),
        );
      },
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    AlphabetModel letter,
    bool isCorrect,
    bool isSelected,
    VoidCallback onTap,
  ) {
    Color backgroundColor = Colors.white;
    if (isSelected) {
      backgroundColor = isCorrect ? Colors.green.shade100 : Colors.red.shade100;
    }

    return Card(
      elevation: isSelected ? 8 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  isSelected
                      ? [backgroundColor, backgroundColor.withOpacity(0.8)]
                      : [Colors.white, Colors.blue.shade50],
            ),
          ),
          child: Center(
            child: Text(
              letter.letter,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color:
                    isSelected
                        ? (isCorrect
                            ? Colors.green.shade700
                            : Colors.red.shade700)
                        : Colors.blue.shade500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameOver(BuildContext context, AlphabetGameProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Game Over!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Final Score: ${provider.score}',
            style: const TextStyle(fontSize: 24, color: Colors.blue),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => provider.startNewGame(),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Play Again', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

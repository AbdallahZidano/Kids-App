import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/alphabet_model.dart';
import '../providers/alphabet_provider.dart';

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn Alphabet'), centerTitle: true),
      body: Consumer<AlphabetProvider>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade100, Colors.white],
              ),
            ),
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: AlphabetModel.letters.length,
              itemBuilder: (context, index) {
                final letter = AlphabetModel.letters[index];
                final isSpeaking =
                    provider.isSpeaking &&
                    provider.currentLetter == letter.letter;

                return _buildLetterCard(context, letter, isSpeaking, provider);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLetterCard(
    BuildContext context,
    AlphabetModel letter,
    bool isSpeaking,
    AlphabetProvider provider,
  ) {
    return Card(
      elevation: isSpeaking ? 8 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => provider.speakLetter(letter),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors:
                  isSpeaking
                      ? [Colors.blue.shade200, Colors.blue.shade100]
                      : [Colors.white, Colors.blue.shade50],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  'assets/images/${letter.letter.toLowerCase()}.jpeg',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                letter.letter,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color:
                      isSpeaking ? Colors.blue.shade700 : Colors.blue.shade500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                letter.example,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isSpeaking ? Colors.blue.shade700 : Colors.blue.shade300,
                ),
              ),
              if (isSpeaking) ...[
                const SizedBox(height: 8),
                const Icon(Icons.volume_up, color: Colors.blue, size: 24),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

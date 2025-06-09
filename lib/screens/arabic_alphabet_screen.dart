import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/arabic_alphabet_model.dart';
import '../providers/arabic_alphabet_provider.dart';

class ArabicAlphabetScreen extends StatelessWidget {
  const ArabicAlphabetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعلم الحروف العربية'),
        centerTitle: true,
      ),
      body: Consumer<ArabicAlphabetProvider>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.green.shade100, Colors.white],
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
              itemCount: ArabicAlphabetModel.letters.length,
              itemBuilder: (context, index) {
                final letter = ArabicAlphabetModel.letters[index];
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
    ArabicAlphabetModel letter,
    bool isSpeaking,
    ArabicAlphabetProvider provider,
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
                      ? [Colors.green.shade200, Colors.green.shade100]
                      : [Colors.white, Colors.green.shade50],
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
                  letter.imagePath,
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

                  color:
                      isSpeaking
                          ? Colors.green.shade700
                          : Colors.green.shade500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                letter.example,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isSpeaking
                          ? Colors.green.shade700
                          : Colors.green.shade300,
                ),
              ),
              if (isSpeaking) ...[
                const SizedBox(height: 8),
                const Icon(Icons.volume_up, color: Colors.green, size: 24),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

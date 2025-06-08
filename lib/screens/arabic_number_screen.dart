import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/arabic_number_model.dart';
import '../providers/arabic_number_provider.dart';

class ArabicNumberScreen extends StatelessWidget {
  const ArabicNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعلم الارقام العربية'),
        centerTitle: true,
      ),
      body: Consumer<ArabicNumberProvider>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple.shade100, Colors.white],
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
              itemCount: ArabicNumberModel.numbers.length,
              itemBuilder: (context, index) {
                final number = ArabicNumberModel.numbers[index];
                final isSpeaking =
                    provider.isSpeaking &&
                    provider.currentNumber == number.number;

                return _buildNumberCard(context, number, isSpeaking, provider);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNumberCard(
    BuildContext context,
    ArabicNumberModel number,
    bool isSpeaking,
    ArabicNumberProvider provider,
  ) {
    return Card(
      elevation: isSpeaking ? 8 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                isSpeaking
                    ? [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ]
                    : [
                      Theme.of(context).colorScheme.surface,
                      Theme.of(context).colorScheme.surface,
                    ],
          ),
        ),
        child: InkWell(
          onTap: () => provider.speakNumber(number),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  number.number,
                  style: TextStyle(
                    fontSize: 48,

                    color:
                        isSpeaking
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  number.word,
                  style: TextStyle(
                    fontSize: 24,
                    color:
                        isSpeaking
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

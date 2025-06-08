import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/number_model.dart';
import '../providers/number_provider.dart';

class NumberScreen extends StatelessWidget {
  const NumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn Numbers'), centerTitle: true),
      body: Consumer<NumberProvider>(
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
              itemCount: NumberModel.numbers.length,
              itemBuilder: (context, index) {
                final number = NumberModel.numbers[index];
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
    NumberModel number,
    bool isSpeaking,
    NumberProvider provider,
  ) {
    return Card(
      elevation: isSpeaking ? 8 : 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => provider.speakNumber(number),
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
              Text(
                number.number,
                style: TextStyle(
                  fontSize: 64,

                  color:
                      isSpeaking ? Colors.blue.shade700 : Colors.blue.shade500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                number.word,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color:
                      isSpeaking ? Colors.blue.shade700 : Colors.blue.shade400,
                ),
              ),
              if (isSpeaking) ...[
                const SizedBox(height: 12),
                const Icon(Icons.volume_up, color: Colors.blue, size: 28),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

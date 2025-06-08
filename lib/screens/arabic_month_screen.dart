import 'package:flutter/material.dart';
import 'package:kids_learning/models/arabic_month_model.dart';
import 'package:kids_learning/providers/arabic_month_provider.dart';
import 'package:provider/provider.dart';

class ArabicMonthScreen extends StatelessWidget {
  const ArabicMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعلم الاشهر العربية'),
        centerTitle: true,
      ),
      body: Consumer<ArabicMonthProvider>(
        builder: (context, provider, child) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: ArabicMonthModel.months.length,
            itemBuilder: (context, index) {
              final month = ArabicMonthModel.months[index];
              final isSpeaking =
                  provider.isSpeaking && provider.currentMonth == month.month;
              return _buildMonthCard(context, month, isSpeaking, provider);
            },
          );
        },
      ),
    );
  }

  Widget _buildMonthCard(
    BuildContext context,
    ArabicMonthModel month,
    bool isSpeaking,
    ArabicMonthProvider provider,
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
          onTap: () => provider.speakMonth(month),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  month.month,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color:
                        isSpeaking
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  month.name,
                  style: TextStyle(
                    fontSize: 28,
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

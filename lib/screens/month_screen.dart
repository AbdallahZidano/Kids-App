import 'package:flutter/material.dart';
import 'package:kids_learning/models/month_model.dart';
import 'package:kids_learning/providers/month_provider.dart';
import 'package:provider/provider.dart';

class MonthScreen extends StatelessWidget {
  const MonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn Months'), centerTitle: true),
      body: Consumer<MonthProvider>(
        builder: (context, provider, child) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: MonthModel.months.length,
            itemBuilder: (context, index) {
              final month = MonthModel.months[index];
              final isSpeaking =
                  provider.isSpeaking && provider.currentMonth == month.name;

              return _buildMonthCard(context, month, isSpeaking, provider);
            },
          );
        },
      ),
    );
  }

  Widget _buildMonthCard(
    BuildContext context,
    MonthModel month,
    bool isSpeaking,
    MonthProvider provider,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => provider.speakMonth(month),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.withOpacity(0.7), Colors.blue],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                month.number,
                style: const TextStyle(fontSize: 32, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                month.name,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              if (isSpeaking) ...[
                const SizedBox(height: 16),
                const Icon(Icons.volume_up, color: Colors.white, size: 32),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

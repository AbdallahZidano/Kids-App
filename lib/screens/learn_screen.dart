import 'package:flutter/material.dart';
import 'package:kids_learning/screens/alphabet_screen.dart';
import 'package:kids_learning/screens/arabic_alphabet_screen.dart';
import 'package:kids_learning/screens/arabic_month_screen.dart';
import 'package:kids_learning/screens/arabic_number_screen.dart';
import 'package:kids_learning/screens/color_learning_screen.dart';
import 'package:kids_learning/screens/month_screen.dart';
import 'package:kids_learning/screens/number_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildActivityButton(
                context,
                'Learn Alphabet',
                Icons.abc,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlphabetScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildActivityButton(
                context,
                'تعلم الحروف العربية',
                Icons.translate,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArabicAlphabetScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildActivityButton(
                context,
                'Learn Numbers',
                Icons.numbers,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NumberScreen()),
                ),
              ),
              const SizedBox(height: 20),
              _buildActivityButton(
                context,
                'تعلم الارقام العربية',
                Icons.translate,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArabicNumberScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildActivityButton(
                context,
                'Learn Colors',
                Icons.palette,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ColorLearningScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildActivityButton(
                context,
                'Learn Months',
                Icons.calendar_month,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MonthScreen()),
                ),
              ),
              const SizedBox(height: 20),
              _buildActivityButton(
                context,
                'تعلم الاشهر بالعربية',
                Icons.translate,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ArabicMonthScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,

                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLearnCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.7), color],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 32, color: Colors.white),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,

                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

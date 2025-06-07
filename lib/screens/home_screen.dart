import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'alphabet_screen.dart';
import 'color_learning_screen.dart';
import 'games_screen.dart';
import 'number_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<UserProvider>().userName;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome, $userName!',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 50),
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
                      'Learn Numbers',
                      Icons.numbers,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NumberScreen(),
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
                      'Games',
                      Icons.games,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GamesScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64, color: Colors.blue),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

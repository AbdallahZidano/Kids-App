import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/arabic_color_model.dart';
import '../providers/arabic_color_provider.dart';

class ArabicColorScreen extends StatelessWidget {
  const ArabicColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ArabicColorProvider>(
          builder: (context, provider, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Theme.of(context).primaryColor.withOpacity(0.2),
                  ],
                ),
              ),
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildColorDisplay(provider),
                          const SizedBox(height: 40),
                          _buildColorGrid(provider),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'تعلم الالوان بالعربية',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 40), // For balance
        ],
      ),
    );
  }

  Widget _buildColorDisplay(ArabicColorProvider provider) {
    final currentColor =
        provider.currentColor != null
            ? ArabicColorModel.colors.firstWhere(
              (color) => color.name == provider.currentColor,
            )
            : ArabicColorModel.colors.first;

    return GestureDetector(
      onTap: () => provider.speakColor(currentColor),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Color(currentColor.colorValue),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(currentColor.colorValue).withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentColor.arabicName,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currentColor.name,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorGrid(ArabicColorProvider provider) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children:
          ArabicColorModel.colors.map((color) {
            final isSelected = color.name == provider.currentColor;
            return GestureDetector(
              onTap: () => provider.speakColor(color),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(color.colorValue),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(color.colorValue).withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}

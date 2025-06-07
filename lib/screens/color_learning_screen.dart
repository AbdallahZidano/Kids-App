import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/color_model.dart';
import '../providers/color_provider.dart';

class ColorLearningScreen extends StatelessWidget {
  const ColorLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ColorProvider>(
          builder: (context, colorProvider, child) {
            final selectedColor = colorProvider.selectedColor;
            if (selectedColor == null) return const SizedBox.shrink();

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, selectedColor.color.withOpacity(0.2)],
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
                          _buildColorDisplay(selectedColor, colorProvider),
                          const SizedBox(height: 40),
                          _buildColorGrid(colorProvider),
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
            'Learn Colors',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 40), // For balance
        ],
      ),
    );
  }

  Widget _buildColorDisplay(ColorModel color, ColorProvider provider) {
    return GestureDetector(
      onTap: provider.playColorAudio,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: color.color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.color.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            color.name,
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
        ),
      ),
    );
  }

  Widget _buildColorGrid(ColorProvider provider) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children:
          ColorModel.colors.map((color) {
            final isSelected = color == provider.selectedColor;
            return GestureDetector(
              onTap: () => provider.selectColor(color),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: color.color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.color.withOpacity(0.3),
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

import 'package:flutter/material.dart';

class ColorModel {
  final String name;
  final Color color;

  const ColorModel({required this.name, required this.color});

  static List<ColorModel> get colors => [
    ColorModel(name: 'Red', color: Colors.red),
    ColorModel(name: 'Blue', color: Colors.blue),
    ColorModel(name: 'Green', color: Colors.green),
    ColorModel(name: 'Yellow', color: Colors.yellow),
    ColorModel(name: 'Purple', color: Colors.purple),
    ColorModel(name: 'Orange', color: Colors.orange),
    ColorModel(name: 'Pink', color: Colors.pink),
    ColorModel(name: 'Brown', color: Colors.brown),
  ];
}

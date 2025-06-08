class ArabicColorModel {
  final String name;
  final String arabicName;
  final int colorValue;

  const ArabicColorModel({
    required this.name,
    required this.arabicName,
    required this.colorValue,
  });

  static const List<ArabicColorModel> colors = [
    ArabicColorModel(name: 'Red', arabicName: 'أحمر', colorValue: 0xFFFF0000),
    ArabicColorModel(name: 'Blue', arabicName: 'أزرق', colorValue: 0xFF0000FF),
    ArabicColorModel(name: 'Green', arabicName: 'أخضر', colorValue: 0xFF00FF00),
    ArabicColorModel(
      name: 'Yellow',
      arabicName: 'أصفر',
      colorValue: 0xFFFFFF00,
    ),
    ArabicColorModel(
      name: 'Purple',
      arabicName: 'بنفسجي',
      colorValue: 0xFF800080,
    ),
    ArabicColorModel(
      name: 'Orange',
      arabicName: 'برتقالي',
      colorValue: 0xFFFFA500,
    ),
    ArabicColorModel(name: 'Pink', arabicName: 'وردي', colorValue: 0xFFFFC0CB),
    ArabicColorModel(name: 'Brown', arabicName: 'بني', colorValue: 0xFFA52A2A),
    ArabicColorModel(name: 'Black', arabicName: 'أسود', colorValue: 0xFF000000),
    ArabicColorModel(name: 'White', arabicName: 'أبيض', colorValue: 0xFFFFFFFF),
  ];
}

class MonthModel {
  final String number;
  final String name;
  final String imagePath;

  const MonthModel({
    required this.number,
    required this.name,
    required this.imagePath,
  });

  static List<MonthModel> get months => [
    const MonthModel(
      number: '1',
      name: 'January',
      imagePath: 'assets/images/months/1.jpeg',
    ),
    const MonthModel(
      number: '2',
      name: 'February',
      imagePath: 'assets/images/months/2.jpeg',
    ),
    const MonthModel(
      number: '3',
      name: 'March',
      imagePath: 'assets/images/months/3.jpeg',
    ),
    const MonthModel(
      number: '4',
      name: 'April',
      imagePath: 'assets/images/months/4.jpeg',
    ),
    const MonthModel(
      number: '5',
      name: 'May',
      imagePath: 'assets/images/months/5.jpeg',
    ),
    const MonthModel(
      number: '6',
      name: 'June',
      imagePath: 'assets/images/months/6.jpeg',
    ),
    const MonthModel(
      number: '7',
      name: 'July',
      imagePath: 'assets/images/months/7.jpeg',
    ),
    const MonthModel(
      number: '8',
      name: 'August',
      imagePath: 'assets/images/months/8.jpeg',
    ),
    const MonthModel(
      number: '9',
      name: 'September',
      imagePath: 'assets/images/months/9.jpeg',
    ),
    const MonthModel(
      number: '10',
      name: 'October',
      imagePath: 'assets/images/months/10.jpeg',
    ),
    const MonthModel(
      number: '11',
      name: 'November',
      imagePath: 'assets/images/months/11.jpeg',
    ),
    const MonthModel(
      number: '12',
      name: 'December',
      imagePath: 'assets/images/months/12.jpeg',
    ),
  ];
}

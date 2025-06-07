class AlphabetModel {
  final String letter;
  final String pronunciation;
  final String example;

  const AlphabetModel({
    required this.letter,
    required this.pronunciation,
    required this.example,
  });

  static List<AlphabetModel> get letters => [
    const AlphabetModel(letter: 'A', pronunciation: 'A', example: 'Apple'),
    const AlphabetModel(letter: 'B', pronunciation: 'B', example: 'Ball'),
    const AlphabetModel(letter: 'C', pronunciation: 'C', example: 'Cat'),
    const AlphabetModel(letter: 'D', pronunciation: 'D', example: 'Dog'),
    const AlphabetModel(letter: 'E', pronunciation: 'E', example: 'Elephant'),
    const AlphabetModel(letter: 'F', pronunciation: 'F', example: 'Fish'),
    const AlphabetModel(letter: 'G', pronunciation: 'G', example: 'Goat'),
    const AlphabetModel(letter: 'H', pronunciation: 'H', example: 'Hat'),
    const AlphabetModel(letter: 'I', pronunciation: 'I', example: 'Ice cream'),
    const AlphabetModel(letter: 'J', pronunciation: 'J', example: 'Jump'),
    const AlphabetModel(letter: 'K', pronunciation: 'K', example: 'Kite'),
    const AlphabetModel(letter: 'L', pronunciation: 'L', example: 'Lion'),
    const AlphabetModel(letter: 'M', pronunciation: 'M', example: 'Monkey'),
    const AlphabetModel(letter: 'N', pronunciation: 'N', example: 'Nest'),
    const AlphabetModel(letter: 'O', pronunciation: 'O', example: 'Orange'),
    const AlphabetModel(letter: 'P', pronunciation: 'P', example: 'Pizza'),
    const AlphabetModel(letter: 'Q', pronunciation: 'Q', example: 'Queen'),
    const AlphabetModel(letter: 'R', pronunciation: 'R', example: 'Rainbow'),
    const AlphabetModel(letter: 'S', pronunciation: 'S', example: 'Sun'),
    const AlphabetModel(letter: 'T', pronunciation: 'T', example: 'Tree'),
    const AlphabetModel(letter: 'U', pronunciation: 'U', example: 'Umbrella'),
    const AlphabetModel(letter: 'V', pronunciation: 'V', example: 'Violin'),
    const AlphabetModel(letter: 'W', pronunciation: 'W', example: 'Water'),
    const AlphabetModel(letter: 'X', pronunciation: 'X', example: 'Xylophone'),
    const AlphabetModel(letter: 'Y', pronunciation: 'Y', example: 'Yellow'),
    const AlphabetModel(letter: 'Z', pronunciation: 'Z', example: 'Zebra'),
  ];
}

class StoryModel {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String category;
  final Duration duration;

  const StoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.category,
    required this.duration,
  });

  static List<StoryModel> get stories => [
    // Letters Videos
    StoryModel(
      id: '1',
      title: 'Letter A',
      description: 'Learn about the letter A and its sound',
      videoUrl: 'assets/videos/letters/a.mp4',
      category: 'Letters',
      duration: const Duration(minutes: 2, seconds: 30),
    ),
    StoryModel(
      id: '2',
      title: 'Letter B',
      description: 'Learn about the letter B and its sound',
      videoUrl: 'assets/videos/letters/b.mp4',
      category: 'Letters',
      duration: const Duration(minutes: 2, seconds: 15),
    ),
    StoryModel(
      id: '3',
      title: 'Letter C',
      description: 'Learn about the letter C and its sound',
      videoUrl: 'assets/videos/letters/c.mp4',
      category: 'Letters',
      duration: const Duration(minutes: 2, seconds: 45),
    ),
    StoryModel(
      id: '4',
      title: 'Letter D',
      description: 'Learn about the letter D and its sound',
      videoUrl: 'assets/videos/letters/d.mp4',
      category: 'Letters',
      duration: const Duration(minutes: 2, seconds: 45),
    ),
    StoryModel(
      id: '5',
      title: 'Letter E',
      description: 'Learn about the letter E and its sound',
      videoUrl: 'assets/videos/letters/e.mp4',
      category: 'Letters',
      duration: const Duration(minutes: 2, seconds: 45),
    ),
    // Numbers Videos
    StoryModel(
      id: '6',
      title: 'Number o To 5',
      description: 'Learn about the numbers from 0 To 5',
      videoUrl: 'assets/videos/numbers/zero_to_five.mp4',
      category: 'Numbers',
      duration: const Duration(minutes: 2, seconds: 0),
    ),
    StoryModel(
      id: '7',
      title: 'Number 6 To 10',
      description: 'Learn about the numbers 6 To 10',
      videoUrl: 'assets/videos/numbers/six_to_ten.mp4',
      category: 'Numbers',
      duration: const Duration(minutes: 2, seconds: 15),
    ),
    StoryModel(
      id: '8',
      title: 'Number 11 To 15',
      description: 'Learn about the numbers  11 To 15',
      videoUrl: 'assets/videos/numbers/11_to_15.mp4',
      category: 'Numbers',
      duration: const Duration(minutes: 2, seconds: 30),
    ),
    StoryModel(
      id: '9',
      title: 'Number 16 To 20',
      description: 'Learn about the numbers form 16 to 20',
      videoUrl: 'assets/videos/numbers/16_to_20.mp4',
      category: 'Numbers',
      duration: const Duration(minutes: 2, seconds: 30),
    ),
  ];
}

class ArabicMonthModel {
  final String month;
  final String name;

  const ArabicMonthModel({required this.month, required this.name});

  static List<ArabicMonthModel> months = [
    const ArabicMonthModel(month: '١', name: 'يناير'),
    const ArabicMonthModel(month: '٢', name: 'فبراير'),
    const ArabicMonthModel(month: '٣', name: 'مارس'),
    const ArabicMonthModel(month: '٤', name: 'أبريل'),
    const ArabicMonthModel(month: '٥', name: 'مايو'),
    const ArabicMonthModel(month: '٦', name: 'يونيو'),
    const ArabicMonthModel(month: '٧', name: 'يوليو'),
    const ArabicMonthModel(month: '٨', name: 'أغسطس'),
    const ArabicMonthModel(month: '٩', name: 'سبتمبر'),
    const ArabicMonthModel(month: '١٠', name: 'أكتوبر'),
    const ArabicMonthModel(month: '١١', name: 'نوفمبر'),
    const ArabicMonthModel(month: '١٢', name: 'ديسمبر'),
  ];
}

class Note {
  final String id;
  String title;
  String description;
  final DateTime timeCreated;
  bool isPinned;
  bool isFavorite;

  Note(
      {required this.id,
      required this.title,
      required this.description,
      required this.timeCreated,
      required this.isPinned,
      required this.isFavorite});
}

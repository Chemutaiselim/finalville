class PostModel {
  final String description;
  final String title;
  final String location;
  final String image;
  final String type;
  PostModel({
    required this.description,
    required this.title,
    required this.location,
    required this.image,
    required this.type,
  });
  factory PostModel.fromRTDB(Map<String, dynamic> data) {
    return PostModel(
      description: data['description'] ?? 'waste',
      title: data['title']?? 'waste',
      location: data['location'] ?? 'Nyeri',
      image: data['image'] ??  'image',
      type: data['type'] ?? 'type',
      
    );
  }
}
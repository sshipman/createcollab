class Request {
  String title;
  String type;
  String description;
  String? imageUrl;

  Request({
    required this.title,
    required this.type,
    required this.description,
    this.imageUrl,
  });
}

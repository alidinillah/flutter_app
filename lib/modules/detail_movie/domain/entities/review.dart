class Review {
  final String author;
  final String content;
  final double? rating;
  final String? avatarPath;
  final String createdAt;

  Review({
    required this.author,
    required this.content,
    this.rating,
    this.avatarPath,
    required this.createdAt,
  });
}

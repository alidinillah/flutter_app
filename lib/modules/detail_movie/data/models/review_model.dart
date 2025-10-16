class ReviewModel {
  final String author;
  final String content;
  final double? rating;
  final String? avatarPath;
  final String createdAt;

  ReviewModel({
    required this.author,
    required this.content,
    this.rating,
    this.avatarPath,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      author: json['author'] ?? 'Anonymous',
      content: json['content'] ?? '',
      rating: (json['author_details']?['rating'] as num?)?.toDouble(),
      avatarPath: json['author_details']?['avatar_path'],
      createdAt: json['created_at'] ?? '',
    );
  }
}
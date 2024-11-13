class Feed {
  final int id;
  final String title;
  final String body;
  final int userId;

  const Feed({
    required this.id,
    required this.title,
    required this.body,
    required this.userId
  });

  factory Feed.fromJson(Map<String, dynamic> json){
    return Feed(
      id: json['id'] as int,
      title: json['title'] as String, 
      body: json['body'] as String,
      userId: json['userId'] as int,
      );
  }
}
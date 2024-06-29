class WordPressPost {
  final int id;
  final String title;
  final String content;
  final String link;

  WordPressPost({
    required this.id,
    required this.title,
    required this.content,
    required this.link,
  });

  factory WordPressPost.fromJson(Map<String, dynamic> json) {
    return WordPressPost(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      link: json['link'],
    );
  }
}

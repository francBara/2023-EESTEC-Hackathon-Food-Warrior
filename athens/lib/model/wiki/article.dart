class Article {
  late final String id;
  late final String title;
  late final String content;
  String? imageLink;

  Article(Map<String, dynamic> articleMap) {
    id = articleMap['id'];
    title = articleMap['title'];
    content = articleMap['content'];
    imageLink = articleMap['imageLink'];
  }
  Article.manual(this.title, this.content, this.id);
}

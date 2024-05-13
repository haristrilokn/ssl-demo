// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class News {
  String? author;
  String? title;
  String? description;
  String? content;
  News({
    this.author,
    this.title,
    this.description,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'author': author,
      'title': title,
      'description': description,
      'content': content,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      author: map['author'] != null ? map['author'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) =>
      News.fromMap(json.decode(source) as Map<String, dynamic>);
}

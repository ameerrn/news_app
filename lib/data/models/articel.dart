import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Articel extends Equatable {
  int? id;
  final String title;
  final String imageUrl;
  final String articalUrl;
  final String description;
  final String content;
  Map<String, dynamic>? countryData;
  String? category;

  Articel({
    this.id,
    required this.content,
    required this.title,
    required this.imageUrl,
    required this.articalUrl,
    required this.description,
    this.countryData,
    this.category,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        title,
        imageUrl,
        articalUrl,
        description,
        countryData,
        category,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'articalUrl': articalUrl,
      'description': description,
      'content': content,
    };
  }

  factory Articel.fromJson(Map<String, dynamic> map) {
    // int counter = 0;
    return Articel(
      // id: counter,
      title: map['title'] ?? '',
      imageUrl: map['urlToImage'] ?? '',
      articalUrl: map['url'] ?? '',
      description: map['description'] ?? '',
      content: map['content'] ?? '',
    );
  }
}

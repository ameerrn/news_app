// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Articels extends Equatable {
  final List<dynamic> articels;
  final String selectedCategory;
  factory Articels.fromJson(Map<String, dynamic> jsonData) {
    return Articels(
      articels: jsonData['articles'],
      selectedCategory: 'general',
    );
  }

  const Articels({
    required this.articels,
    required this.selectedCategory,
  });

  @override
  List<Object?> get props => [articels, selectedCategory];
}

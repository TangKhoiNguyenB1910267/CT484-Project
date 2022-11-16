import 'package:flutter/foundation.dart';
class Comic {
  final String? id;
  final String title;
  final String description;
  final String imageUrl;
  final ValueNotifier<bool> _isFavorite;
  Comic({
  this.id,
  required this.title,
  required this.description,
  required this.imageUrl,
  isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue){
    _isFavorite.value = newValue;
  }
  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Comic copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    bool? isFavorite,
  }){
    return Comic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  static Comic fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
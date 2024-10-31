import 'dart:convert';

class PostModel {
  final DateTime createdAt;
  final String uid;
  final String id;
  final String title;
  final String image;
  final String description;
  PostModel({
    required this.createdAt,
    required this.uid,
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  PostModel copyWith({
    DateTime? createdAt,
    String? uid,
    String? id,
    String? title,
    String? image,
    String? description,
  }) {
    return PostModel(
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt.millisecondsSinceEpoch,
      'uid': uid,
      'id': id,
      'title': title,
      'image': image,
      'description': description,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      uid: map['uid'] as String,
      id: map['_id'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(createdAt: $createdAt, uid: $uid, id: $id, title: $title, image: $image, description: $description)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.uid == uid &&
        other.id == id &&
        other.title == title &&
        other.image == image &&
        other.description == description;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        uid.hashCode ^
        id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        description.hashCode;
  }
}

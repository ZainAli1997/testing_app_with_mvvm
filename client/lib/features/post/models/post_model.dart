import 'dart:convert';

class PostModel {
  final DateTime createdAt;
  final String uid;
  final String id;
  final String title;
  final String description;
  PostModel({
    required this.createdAt,
    required this.uid,
    required this.id,
    required this.title,
    required this.description,
  });

  PostModel copyWith({
    DateTime? createdAt,
    String? uid,
    String? id,
    String? title,
    String? description,
  }) {
    return PostModel(
      createdAt: createdAt ?? this.createdAt,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt.millisecondsSinceEpoch,
      'uid': uid,
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      uid: map['uid'] ?? '',
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(createdAt: $createdAt, uid: $uid, id: $id, title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PostModel &&
      other.createdAt == createdAt &&
      other.uid == uid &&
      other.id == id &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
      uid.hashCode ^
      id.hashCode ^
      title.hashCode ^
      description.hashCode;
  }
}

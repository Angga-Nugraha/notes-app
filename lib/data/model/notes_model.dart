import 'package:hive_flutter/hive_flutter.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String body;
  @HiveField(2)
  final int colorValue;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  int? id;

  NoteModel({
    this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.colorValue,
  });

  // factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
  //       id: map['id'],
  //       title: map['title'],
  //       body: map['body'],
  //       createdAt: map['createdAt'],
  //       colorValue: map['colorValue'],
  //     );

  // factory NoteModel.fromDTO(NoteModel note) => NoteModel(
  //       id: note.id,
  //       title: note.title,
  //       body: note.body,
  //       createdAt: note.createdAt,
  //       colorValue: note.colorValue,
  //     );

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'title': title,
  //       'body': body,
  //       'createdAt': createdAt,
  //       'colorValue': colorValue,
  //     };
}

import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  Note({required this.content, required this.creationDate});

  @HiveField(0)
  final String content;
  @HiveField(1)
  final DateTime creationDate;
}
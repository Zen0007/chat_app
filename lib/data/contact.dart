import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  final String friendName;

  @HiveField(1)
  final String friendId;

  Contact({required this.friendName, required this.friendId});
}

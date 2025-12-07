import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String email;

  UserProfile({required this.name, required this.email, required this.userId});
}

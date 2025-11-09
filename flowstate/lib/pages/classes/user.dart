import 'package:hive/hive.dart';

part 'user.g.dart'; 

//Definition of a user for the Hive database box
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String? username;

  @HiveField(1)
  String? hashedPassword;

  @HiveField(2)
  List<String>? tags;

  @HiveField(3)
  int? streak;

  @HiveField(4)
  String? lastLogin;

  //Make sure a user can never be added with incomplete info
  User({required this.username, required this.hashedPassword, this.tags, this.streak, this.lastLogin});
}
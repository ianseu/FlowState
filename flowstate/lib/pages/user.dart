import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class User extends HiveObject {

  @HiveField(0)
  String? username;

  @HiveField(1)
  String? hashedPassword;
}
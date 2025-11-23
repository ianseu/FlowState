import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'classes/user.dart';
import 'classes/color_manager.dart';

class NotificationSettings extends StatefulWidget {
  final String user;
  const NotificationSettings({super.key, required this.user});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {

  //Hive storage 'box'
  var box = Hive.box('Users');
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = box.get(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(
        ColorManager.secondary,
        ColorManager.primary,
        0.07,
      ),
      appBar: AppBar(
        title: Text(
          "Back",
          style: TextStyle(
            color: ColorManager.textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Color.lerp(
          ColorManager.secondary,
          ColorManager.primary,
          0.07,
        ),
      )
    );
  }
}
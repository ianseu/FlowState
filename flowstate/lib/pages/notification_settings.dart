import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'classes/notification_manager.dart';
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
  late DateTime? userNotificationTime;
  late TimeOfDay notificationTime;
  late String hour;
  late String minute;
  
  @override
  void initState() {
    super.initState();
    currentUser = box.get(widget.user);
    userNotificationTime = currentUser.notificationTime;
    if (userNotificationTime != null) {
      notificationTime = TimeOfDay(hour: userNotificationTime!.hour, minute: userNotificationTime!.minute,);
    } 
    else {
      notificationTime = TimeOfDay(hour: 12, minute: 0);
    }
    hour = notificationTime.hour.toString();
    minute = notificationTime.minute.toString();
  }

  String _formatMinute(String minute) {
    if(minute == '0') {
      return '00';
    }
    else if(int.parse(minute) < 10) {
      return '0' + minute.toString();
    }
    
    else {
      return minute;
    }
  }
  String _formatHour(String hour) {
    if(hour == '0') {
      return '12';
    }
    else if(int.parse(hour) > 12) {
      return (int.parse(hour) - 12).toString();
    }
    else {
      return hour;
    }
  }

  String _getAMPM(int hour) {
    if (hour >= 12) {
      return 'PM';
    } 
    else {
      return 'AM';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Back",
          style: TextStyle(
            color: ColorManager.textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: ColorManager.backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications,
                  color: ColorManager.primary,
                  size: 40,
                ),
                Text(
                  ' Notification Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You\'ll receive notifications at ',
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorManager.textColor,
                  ),
                ),
                
                Text(
                  '${_formatHour(hour)}:${_formatMinute(minute)} ${_getAMPM(notificationTime.hour)}',
                  style: TextStyle(
                    fontSize: 24,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
        
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: notificationTime,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        timePickerTheme: TimePickerThemeData(
                          dialHandColor: ColorManager.primary,
                          dialBackgroundColor: ColorManager.backgroundColor,
                          dayPeriodColor: ColorManager.primary,
                        ),
                        colorScheme: ColorScheme.light(
                          primary: ColorManager.primary,
                          onPrimary: ColorManager.secondary,
                          onSurface: ColorManager.textColor,
                        ),
                      ),
                      child: child!
                    );
                  },
                );
                if (pickedTime != null) {
                  setState(() {
                    notificationTime = pickedTime;
                    hour = notificationTime.hour.toString();
                    minute = notificationTime.minute.toString();
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500.0),
                  side: BorderSide(color: ColorManager.primary),
                ),
              ),
              child: Text(
                'Select Time',
                style: TextStyle(
                  color: ColorManager.secondary,
                ),
              ),
            ),
            SizedBox(height: 10),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    currentUser.notificationTime = DateTime(1, 1, 1, notificationTime.hour, notificationTime.minute,);
                    currentUser.save();
                    NotificationManager().cancelAllNotifications();
                    NotificationManager().scheduleNotifications(
                      title: 'Flow State', 
                      body: 'Mindfulness awaits! 🧘', 
                      hour: notificationTime.hour, 
                      minute: notificationTime.minute
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 15, 165, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500.0),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: ColorManager.secondary,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                
                ElevatedButton(
                  onPressed: () {
                    currentUser.notificationTime = null;
                    currentUser.save();
                    NotificationManager().cancelAllNotifications();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 115, 105),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500.0),
                    ),
                  ),
                  child: Text(
                    'Disable Notifications',
                    style: TextStyle(
                      color: ColorManager.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
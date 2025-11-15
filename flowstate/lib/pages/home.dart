import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'classes/technique.dart';
import 'classes/color_manager.dart';

class Home extends StatefulWidget {
  final String user;
  final List<String> userTags;
  final int? streak;
  const Home({super.key, required this.user, required this.userTags, required this.streak});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(
        ColorManager.secondary,
        ColorManager.primary,
        0.1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          
          //Profile Tab
          Container(
            padding: EdgeInsets.all(2),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border(
                bottom: BorderSide(
                  color: ColorManager.primary,
                  width: 3.0,
                )
              ),
              color: ColorManager.secondary,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(179, 178, 178, 1),
                  offset: Offset(2, 4.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                //Profile Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary, 
                    shape: CircleBorder(),
                  ),
                  onPressed: () {},
                  child: Icon(
                    Icons.person_4,
                    size: 25,
                    color: ColorManager.secondary,
                  ),
                ),

                //Username
                Expanded(
                  child: Text(
                    widget.user,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: ColorManager.primary,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                
                // Streak + Settings Button
                Row(
                  children: [
                    // Streak 
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          ColorManager.secondary,
                          Color.fromRGBO(226, 149, 48, 1),
                          0.2,
                        ),
                        border: Border.all(
                          color: Color.fromRGBO(238, 174, 89, 1),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Streak Icon
                          Image.asset(
                            'assets/icons/streak_fire.png',
                            width: 28,
                            height: 36,
                          ),
                          SizedBox(width: 6),
                          // Streak Number
                          Text(
                            widget.streak.toString(),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(238, 174, 89, 1),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Settings Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  Color.fromARGB(255, 71, 71, 71),
                        shape: CircleBorder(),
                       
                      ),
                      onPressed: () {},
                      child: Icon(
                        Icons.settings,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),             
              ],
            ),
          ),
          SizedBox(height: 8),

          //Recommended Text
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'Recommended for you:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: ColorManager.textColor
              ),
            ),
          ),
          
          //Horizontal Scrollable ListView of Techniques
          SizedBox(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allTechniques.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => allTechniques[index].destination,
                      ),
                    );
                  },
                  onLongPress: () => {},
                  //Technique Card
                  child: Container(
                    width: 350,
                    height: 350,
                    margin: EdgeInsets.all(8),             
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorManager.secondary,
                      border: Border.all(
                        width: 3,
                        color: ColorManager.primary,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(179, 178, 178, 1),
                          offset: Offset(4.2, 4.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        //Technique Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(9),
                            topRight: Radius.circular(9),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            allTechniques[index].image,
                            width: 350,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //Technique Name
                          children: [
                            SizedBox(height: 15),
                            Text(
                              allTechniques[index].name.toUpperCase(),
                              style: TextStyle(
                                color: ColorManager.primary,
                                fontSize: 28,                              
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.1,   
                              ),
                              textAlign: TextAlign.center
                            ),
                            SizedBox(height: 8),
                            //Technique Short Description
                            Text(
                              allTechniques[index].description,
                              style: TextStyle(
                                color: ColorManager.textColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),       
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ]
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'classes/technique.dart';

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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(84, 125, 194, 1),
                  width: 3.0,
                )
              ),
              color: Color.fromRGBO(255, 255, 255, 1),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(202, 202, 202, 1),
                  offset: Offset(0.0, 4.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(width: 20),

                Expanded(
                  child: Text(
                    widget.user,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(84, 125, 194, 1),
                    ),
                  ),
                ),
                
                SizedBox(width: 20),
                
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/streak_fire.png',
                          width: 30,
                          height: 40,
                        ),
                        SizedBox(width: 5),
                    
                        Text(
                          widget.streak.toString(),
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(238, 174, 89, 1),
                          ),
                        ),
                      ]
                    ),

                    SizedBox(width: 5),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 77, 77, 77), 
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

          SizedBox(height: 30),

          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Recommended for you:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          
          SizedBox(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allTechniques.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 350,
                  height: 350,
                  margin: EdgeInsets.all(8),             
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(255, 255, 255, 1),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(131, 131, 131, 1),
                        offset: Offset(-1.0, 1.0),
                        spreadRadius: 3,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
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
                    Spacer(
                      flex: 1
                    ), 
                    Container(
                      width: 350,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        width: 5,
                      ),
                        color: Color.fromRGBO(84, 125, 194, 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            allTechniques[index].name.toUpperCase(),
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 30,                              
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.1,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            allTechniques[index].description,
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),        
                  ],
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
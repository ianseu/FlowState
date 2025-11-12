import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'classes/technique.dart';

class Home extends StatefulWidget {
  final String user;
  final List<String> userTags;
  const Home({super.key, required this.user, required this.userTags});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [          
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
        ]),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'classes/technique.dart';
import 'classes/color_manager.dart';

class Home extends StatefulWidget {
  final String user;
  final List<String> userTags;
  final int? streak;
  final DateTime? userLastLogin;
  const Home({super.key, required this.user, required this.userTags, required this.streak, required this.userLastLogin});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Set<String> getUserTags() {
    return widget.userTags.toSet();
  }

  //default: Meditation View
  int currentView = 0;

  bool showAllTechniques = false;

  void _switchView(int index) {
    setState(() {
      currentView = index;
    });
  }

  //Flow AI View
  Widget _flowAIView() {
    return Center(child: Text('Flow AI'),);
  }

  //Meditation View
  Widget _meditationView() {
    return Padding(
      padding: EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
            
          //Profile Tab
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
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
                    onPressed: () {
                      _switchView(0);
                    },
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
                    
                  // Streak
                  Row(
                    children: [
                      // Streak 
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            ColorManager.secondary,
                            ColorManager.streakColor,
                            0.2,
                          ),
                          border: Border.all(
                            color: ColorManager.streakColor,
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
                                color: ColorManager.streakColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),         
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
      
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              'Recommended:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: ColorManager.textColor
              ),
            ),
          ),
          SizedBox(height: 5),

          //Horizontal Scrollable ListView of Techniques
          SizedBox(
            height: 400,
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
                    height: 400,
                    margin: EdgeInsets.only(left: 6, right: 12),           
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
                          offset: Offset(4.2, 6.2),
                          spreadRadius: 1,
                          blurRadius: 3,
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
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                        ),
      
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //Technique Name
                            children: [
                              SizedBox(height: 45),
                              Text(
                                allTechniques[index].name.toUpperCase(),
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: 30,                              
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
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),       
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

         
          Row(
            children: [
              //Show All Checkbox
              Checkbox(
                value: showAllTechniques,
                onChanged:(bool? value) {
                  setState(() {
                    showAllTechniques = value!;
                  });
                },
                activeColor: ColorManager.primary,
                side: BorderSide(
                  color: ColorManager.primary,
                  width: 2.0,
                )
              ),
          
              //Show All Text
              Text(
                'Show all',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: ColorManager.primary
                ),
              ),
            
            ],
          ),
          SizedBox(height: 70),

          //App Logo Image
          Center(
            child: Image.asset(
              'assets/icons/app_icon_blank.png',
              width: 120,
              height: 120,
            ),
          )
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> views = [
      _meditationView(),
      _flowAIView(),
    ];

    return Scaffold(
      backgroundColor: Color.lerp(
        ColorManager.secondary,
        ColorManager.primary,
        0.07,
      ),
      body: views[currentView],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentView,
        onTap: _switchView,
        backgroundColor: ColorManager.secondary,
        selectedItemColor: ColorManager.primary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.spa),
            label: 'Meditation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Flow AI',
          ),
        ],
      ),
    );
  }
}
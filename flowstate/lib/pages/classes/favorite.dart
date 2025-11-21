import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'technique.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Favorite extends StatefulWidget {
  final Technique technique;

  const Favorite({super.key, required this.technique});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var user = Hive.box('Users').getAt(0);
  
  IconData _toggleFavoriteIcon() {
    if(user.favoriteTechniques.contains(widget.technique)) {
      return Icons.favorite;
    }
    else {
      return Icons.favorite_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (user.favoriteTechniques.contains(widget.technique)) {
              user.favoriteTechniques.remove(widget.technique);
            } 
            else {
              user.favoriteTechniques.add(widget.technique);
            }
            user.save();
          });
        },
        child: Icon(
          _toggleFavoriteIcon(),
          color: ColorManager.primary,
          size: 50,
        ),
      ),
    );
  }
}
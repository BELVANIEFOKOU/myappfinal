import 'package:flutter/material.dart';
import 'package:myappfinal/favorisPage.dart';
import 'package:myappfinal/homePage.dart';
import 'package:myappfinal/notifcation.dart';
import 'package:myappfinal/search.dart';
import 'package:myappfinal/signInPage.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  CustomBottomNavBar({this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color.fromARGB(255, 255, 98, 0),
      unselectedItemColor: Colors.black,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } 
        else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        }
        else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FavoritesPage()),
          );
        }
        else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NotifcationPage()),
          );
        }
        else if (index == 4) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Recherche'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoris'),
        BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: 'alertes'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Compte'),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myappfinal/bottom_nav_bar.dart';
import 'package:myappfinal/publishPage.dart';
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:myappfinal/bottom_nav_bar.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
    );
  }
}

import 'package:flutter/material.dart';
 import 'package:myappfinal/bottom_nav_bar.dart';
class NotifcationPage extends StatelessWidget {
  const NotifcationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: CustomBottomNavBar(currentIndex: 3),
    );
  }
}
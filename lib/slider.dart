import 'package:flutter/material.dart';
import 'package:myappfinal/publishPage.dart';
import 'package:myappfinal/signInPage.dart';
import 'package:myappfinal/signUpPage.dart';

class Slider extends StatefulWidget {
  const Slider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    SignUpPage(), // Replace HomeContent with your actual home page content
    SignInPage(),
    const PublishPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche Immobilière'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.publish),
            label: 'Publish',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your logic to navigate to the next page using the arrow icon
          if (_currentIndex < _pages.length - 1) {
            setState(() {
              _currentIndex++;
            });
          }
        },
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

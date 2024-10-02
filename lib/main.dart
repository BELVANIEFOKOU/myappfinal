import 'package:flutter/material.dart';
import 'package:myappfinal/homePage.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
// void main(){
//   runApp(MyApp());
//  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recherche Immobilière',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SliderPages()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 255, 98, 0),
       
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/logoRemove.png',
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
            ),
          ),
          Column(
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[300]!),
              ),
              SizedBox(height: 50),
            ],
          ),
        ],
      ),);
  }
}

class SliderPages extends StatefulWidget {
  @override
  _SliderPagesState createState() => _SliderPagesState();
}

class _SliderPagesState extends State<SliderPages> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              
              SliderPage(
                title: 'Rechercher un logement',
                description: 'Trouvez le logement de vos rêves en un click',
                imagePath: 'assets/imageRecherche.png',
                isFirstPage: true,
              ),
              SliderPage(
                title: 'Publier vos annonces',
                description: 'Publiez facilement vos annonces immobilières',
                imagePath: 'assets/annonces.png',
                isFirstPage: true,
              ),
              SliderPage(
                title: 'Notifications',
                description: 'Recevez des nouvelles notifications',
                imagePath: 'assets/notifs.png',
                isFirstPage: true,
              ),
            ],
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
            // bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => buildDot(index)),
            ),
          ),
          Positioned(
            bottom: 20,
            // left: 0,
            right: 10,
            child: SizedBox(
              //  width: 150,
              child: _currentPage < 2
                  ? ElevatedButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Adjust this value as needed
            ),
                       
                      ),
                      child: Text(
                        'Suivant',
                        style: TextStyle(
                             color: Color.fromARGB(255, 255, 98, 0),
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Adjust this value as needed
            ),
                      ),
                      child: Text(
                        'Commencer',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 98, 0),
                         
                          fontSize: 18,
                        ),
                      ),
                    ),
            ),
          ),
          
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 10,
      width: 10,
  
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.white : Colors.grey,
      ),
    );
  }
}
class SliderPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isFirstPage;

  const SliderPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.isFirstPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isFirstPage
          ? BoxDecoration(

              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                Color.fromARGB(252, 169, 117, 0),
                  Color.fromARGB(255, 255, 98, 0),
                ],
              ),
            )
          : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // Image.asset(
          //   imagePath,
          //   width: 200,
          //   height: 200,
          //   fit: BoxFit.contain,
          // ),
          ClipRRect(
  borderRadius: BorderRadius.circular(20), // Ajustez cette valeur pour plus ou moins d'arrondi
  child: Image.asset(
    imagePath,
    width: MediaQuery.of(context).size.width * 0.8, // 80% de la largeur de l'écran
    height: MediaQuery.of(context).size.height * 0.4, // 40% de la hauteur de l'écran
    fit: BoxFit.cover,
  ),
),


          SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

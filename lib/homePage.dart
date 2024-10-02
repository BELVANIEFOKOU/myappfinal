import 'package:flutter/material.dart';
import 'package:myappfinal/bottom_nav_bar.dart';
import 'package:myappfinal/search.dart';
import 'package:myappfinal/signInPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedChip = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Color.fromARGB(255, 255, 98, 0)),
          onPressed: () {
            // Action pour le menu hamburger
          },
        ),
        title: Text('MonPiol237', style: TextStyle(color: Color.fromARGB(255, 255, 98, 0))),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color.fromARGB(255, 255, 98, 0), width: 2),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color.fromARGB(255, 255, 98, 0)),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip('Appartements'),
                  SizedBox(width: 10),
                  _buildChip('Chambres'),
                  SizedBox(width: 10),
                  _buildChip('Studio'),
                  SizedBox(width: 10),
                  _buildChip('Bureau'),
                  SizedBox(width: 10),
                  _buildChip('Terrain'),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 2,
                mainAxisSpacing: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildPropertyCard(),
                childCount: 4,
              ),
            ),
          ),
        ],
      ),

 bottomNavigationBar: CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildChip(String label) {
    bool isSelected = selectedChip == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedChip = label;
        });
      },
      child: Chip(
        label: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.grey),
        ),
        backgroundColor: isSelected
            ? Color.fromARGB(255, 255, 98, 0)
            : Colors.grey.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.transparent, width: 1),
        ),
      ),
    );
  }

  Widget _buildPropertyCard() {
    return Card(
      margin: EdgeInsets.all(8),
      child: SizedBox(
        width: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/maison.jpg',width: 150,height: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Emombo 2e, Yaounde',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text('70 000 Fcfa', style: TextStyle(color: Color.fromARGB(255, 255, 98, 0))),
                  Text('Appartement Meublé'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureColumn(Icons.living_outlined, '02', 'salons'),
                      _buildFeatureColumn(Icons.bed, '02', 'chambres'),
                      _buildFeatureColumn(Icons.kitchen, '01', 'cuisines'),
                    ],
                 ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureColumn(IconData icon, String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: Color.fromARGB(255, 255, 98, 0)),
        SizedBox(height: 4),
        Text(count, style: TextStyle(fontSize: 16,)),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

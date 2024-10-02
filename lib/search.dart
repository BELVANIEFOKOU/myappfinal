import 'package:flutter/material.dart';
import 'package:myappfinal/bottom_nav_bar.dart';
import 'package:myappfinal/search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String? ville;
  String? quartier;
  String? typeHabitat;
  String? statuse;
  String? prix;

  final List<String> villes = ['Yaoundé', 'Douala', 'Baffoussam', 'Kribi'];
  final List<String> quartiers = ['Odza', 'Bastos', 'Ngousso', 'Etoudi', 'Mvan'];
  final List<String> typesHabitat = ['Appartement', 'Maison', 'Studio', 'Loft'];
 final List<String> status = ['louer', 'acheter'];
  // final List<String> cout = ['50000f à 80000f', '80000 à 100000, 'plus de 100000'];
  // Définissez la largeur des champs ici
  final double fieldWidth = 400;

  @override
  Widget build(BuildContext context) {
    var dropdownButtonFormField = DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Ville',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      value: ville,
      items: villes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          ville = value;
        });
      },
    );

    var dropdownButtonFormField2 = dropdownButtonFormField;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('trouve ta maison ici',
            style: TextStyle(
              fontSize: 20,
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              children: [
                SizedBox(
                  width: fieldWidth,
                  child: dropdownButtonFormField2,
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: fieldWidth,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Quartier',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                    value: quartier,
                    items: quartiers.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        quartier = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: fieldWidth,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Type d'habitat",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                    value: typeHabitat,
                    items: typesHabitat.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        typeHabitat = value;
                      });
                    },
                  ),
                ),
                 SizedBox(height: 16),
                SizedBox(
                  width: fieldWidth,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "status",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                    value: statuse,
                    items: status.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                       statuse = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: fieldWidth,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Prix maximum',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => prix = value,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print('Recherche : $ville, $quartier, $typeHabitat, $prix');
                    }
                  },
                  child: const Text('Rechercher'),
                ),
              ],
            ),
          ),
        ),
      ),
       bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
    );
  }
}

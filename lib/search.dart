import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchService {
  final String baseUrl = 'http://10.1.19.2:3000';

  Future<List<dynamic>> searchProperties({
    String? ville,
    String? quartier,
    String? typeHabitat,
    String? statut,
    String? prixMax,
  }) async {
    final queryParameters = {
      if (ville != null) 'ville': ville,
      if (quartier != null) 'quartier': quartier,
      if (typeHabitat != null) 'type': typeHabitat,
      if (statut != null) 'statut': statut,
      if (prixMax != null) 'prixMax': prixMax,
    };

    final uri = Uri.parse('$baseUrl/rechercheLogementAvancee').replace(queryParameters: queryParameters);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Échec de la recherche');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  final SearchService _searchService = SearchService();
  final TextEditingController _prixController = TextEditingController();

  String? ville;
  String? quartier;
  String? typeHabitat;
  String? statut;
  List<dynamic> searchResults = [];
  bool isLoading = false;
  String? errorMessage;

  final List<String> villes = ['Yaoundé', 'Douala', 'Baffoussam', 'Kribi'];
  final List<String> quartiers = ['Odza', 'Bastos', 'Ngousso', 'Etoudi', 'Mvan'];
  final List<String> typesHabitat = ['Appartement', 'Maison', 'Studio', 'Loft'];
  final List<String> statuts = ['louer', 'acheter'];

  final double fieldWidth = 400;

  Future<void> _performSearch() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final results = await _searchService.searchProperties(
        ville: ville,
        quartier: quartier,
        typeHabitat: typeHabitat,
        statut: statut,
        prixMax: _prixController.text,
      );

      setState(() {
        searchResults = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Trouve ta maison ici', style: TextStyle(fontSize: 20)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDropdownField('Ville', ville, villes, (value) => setState(() => ville = value)),
                    const SizedBox(height: 16),
                    _buildDropdownField('Quartier', quartier, quartiers, (value) => setState(() => quartier = value)),
                    const SizedBox(height: 16),
                    _buildDropdownField(
                        'Type d\'habitat', typeHabitat, typesHabitat, (value) => setState(() => typeHabitat = value)),
                    const SizedBox(height: 16),
                    _buildDropdownField('Statut', statut, statuts, (value) => setState(() => statut = value)),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: fieldWidth,
                      child: TextFormField(
                        controller: _prixController,
                        decoration: const InputDecoration(
                          labelText: 'Prix maximum',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isLoading ? null : _performSearch,
                      child: isLoading ? const CircularProgressIndicator() : const Text('Rechercher'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            ),
          Expanded(
            child: searchResults.isEmpty
                ? const Center(child: Text('Aucun résultat'))
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final property = searchResults[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(property['libellePropriete'] ?? 'Sans titre'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${property['typePropriete']} - ${property['villePropriete']}'),
                              Text('${property['prixPropriete']} FCFA'),
                            ],
                          ),
                          onTap: () {
                            // Navigation vers les détails de la propriété
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> items, Function(String?) onChanged) {
    return SizedBox(
      width: fieldWidth,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

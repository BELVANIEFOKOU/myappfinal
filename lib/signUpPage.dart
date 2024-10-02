import 'package:flutter/material.dart';
import 'package:myappfinal/signInPage.dart';
import 'package:myappfinal/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  final AuthService _authService = AuthService();
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = await widget._authService.signUp(
          nom!,
          emailCompte!,
          mdpCompte!,
          telephone!,
          TypeCompte!,
          villeAgent!,
          businessRegistrationNumber!,
          cniAgent!);

      if (success) {
        // Navigate to the next page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'inscription')),
        );
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  String? nom,
      emailCompte,
      mdpCompte,
      telephone,
      TypeCompte,
      villeAgent,
      businessRegistrationNumber,
      cniAgent;
  List<String> userTypes = ['Particulier', 'Professionnel', 'Entreprise'];
  List<String> cities = [
    'Yaoundé',
    'Douala',
    'Bafoussam',
    'Maroua',
    'Nkongsamba'
  ];
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;
  late AnimationController _welcomeTextController;
  late Animation<double> _welcomeTextAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
      ),
    );

    _animations = List.generate(
      5,
      (index) => Tween<Offset>(
        begin: index.isEven ? Offset(-1, 0) : Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOut,
      )),
    );

    for (var controller in _controllers) {
      controller.forward();
    }

    _welcomeTextController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );

    _welcomeTextAnimation = CurvedAnimation(
      parent: _welcomeTextController,
      curve: Curves.easeInOut,
    );

    _welcomeTextController.forward();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _welcomeTextController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      suffixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide:
            BorderSide(color: Color.fromARGB(255, 255, 98, 0), width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(width: 0.5),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Créer votre compte',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 98, 0),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                _buildWelcomeText(),
                _buildSignUpForm(),
                _buildLoginPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return FadeTransition(
      opacity: _welcomeTextAnimation,
      child: Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Text(
          "Bienvenue sur MonPiol237 ! ",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 98, 0),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildAnimatedFormField(
              0, 'Nom', Icons.person,
              (value) {
             telephone = value;
              if (value != null && value.length < 8) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('le nom   ne doit pas etre vide')),
                );
              }
            },),
          SizedBox(height: 16),
          _buildAnimatedFormField(
            1,
            'Email',
            Icons.email,
            (value) {
              emailCompte = value;
              if (value != null &&
                  !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Adresse email invalide')),
                );
              }
            },
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),
          _buildAnimatedFormField(
            2,
            'Mot de passe',
            Icons.lock,
            (value) {
              mdpCompte = value;
              if (value != null && value.length < 8) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Mot de passe trop court')),
                );
              }
            },
            obscureText: true,
          ),
          SizedBox(height: 16),
         
          _buildAnimatedFormField(
              3, 'Téléphone', Icons.phone,  (value) {
             telephone = value;
              if (value != null && value.length < 8) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('numero de telephone  trop court')),
                );
              }
            },
              keyboardType: TextInputType.phone),
          SizedBox(height: 16),
          _buildUserTypeDropdown(),
          if (TypeCompte == 'Professionnel' || TypeCompte == 'Entreprise') ...[
            SizedBox(height: 16),
            _buildCityDropdown(),
            SizedBox(height: 16),
            _buildBusinessRegistrationField(),
            SizedBox(height: 16),
            _buildcniperson()
          ],
          SizedBox(height: 24),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  Widget _buildAnimatedFormField(
      int index, String label, IconData icon, Function(String?) onSaved,
      {TextInputType? keyboardType, bool obscureText = false}) {
    return SlideTransition(
      position: _animations[index],
      child: TextFormField(
        decoration: _inputDecoration(label, icon),
        keyboardType: keyboardType,
        obscureText: obscureText,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildUserTypeDropdown() {
    return SlideTransition(
      position: _animations[4],
      child: DropdownButtonFormField<String>(
        decoration: _inputDecoration('Type d\'utilisateur', Icons.category),
        value: TypeCompte,
        items: userTypes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            TypeCompte = newValue;
          });
        },
      ),
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      decoration: _inputDecoration('Ville', Icons.location_city),
      value: villeAgent,
      items: cities.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          villeAgent = newValue;
        });
      },
    );
  }

 Widget _buildcniperson() {
  return TextFormField(
    decoration: _inputDecoration('Numéro de cni', Icons.business),
    onSaved: (value) => cniAgent = value,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Numéro de CNI ne peut pas être vide';
      }
      // Add additional validation logic if needed
      return null;
    },
  );
}

Widget _buildBusinessRegistrationField() {
  return TextFormField(
    decoration: _inputDecoration('Numéro de registre du commerce', Icons.business),
    onSaved: (value) => businessRegistrationNumber = value,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Numéro de registre du commerce ne peut pas être vide';
      }
      // Add additional validation logic if needed
      return null;
    },
  );
}

  Widget _buildSignUpButton() {
    return ElevatedButton(
      child: Text(
        'S\'inscrire',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 255, 98, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      onPressed: _handleSignUp,
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Êtes-vous déjà inscrit ?',
          style: TextStyle(color: Colors.grey[600]),
        ),
        TextButton(
          child: Text(
            'Se connecter',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 98, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
        ),
      ],
    );
  }
}

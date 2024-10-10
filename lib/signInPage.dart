import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myappfinal/bottom_nav_bar.dart';
import 'package:myappfinal/homePage.dart';
import 'package:myappfinal/signUpPage.dart';
import 'package:myappfinal/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  final AuthService _authService = AuthService();

  SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = await widget._authService.signIn(emailCompte!, mdpCompte!);
      if (success) {
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Échec de la connexion')),
        );
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  String? emailCompte, mdpCompte;
  late AnimationController _formController;
  late Animation<Offset> _formAnimation;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _formController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _formAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _formController,
      curve: Curves.easeInOut,
    ));

    _formController.forward();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      suffixIcon: label == 'Mot de passe'
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
          : Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(width: 0.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(width: 0.5),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  // String? _validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Veuillez entrer votre email';
  //   }
  //   if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
  //     return 'Veuillez entrer un email valide';
  //   }
  //   return null;
  // }

  // String? _validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Veuillez entrer votre mot de passe';
  //   }
  //   if (value.length < 8) {
  //     return 'Votre mot de passe doit contenir au moins 8 caractères';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Comment souhaitez-vous vous connecter ?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 98, 0),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SlideTransition(
                  position: _formAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: _inputDecoration('Email', Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) => emailCompte = value,
                          // validator: _validateEmail,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: _inputDecoration('Mot de passe', Icons.lock),
                          obscureText: _obscureText,
                          onSaved: (value) => mdpCompte = value,
                          // validator: _validatePassword,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 98, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 15,
                            ),
                          ),
                          onPressed: _handleSignIn,
                          child: Text(
                            'Se connecter',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: Image.network(
                            "https://imagepng.org/wp-content/uploads/2019/08/google-icon-1024x1024.png",
                            width: 20,
                            height: 20,
                          ),
                          label: const Text('Connectez-vous via Google'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(
                              double.infinity,
                              50,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                              if (googleUser != null) {
                                // Sign in successful, use the Google user information
                                print("Connected successfully: ${googleUser.displayName}");
                                // Navigate to the home page or update the app state
                              }
                            } catch (error) {
                              print("Error signing in with Google: $error");
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 98, 0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );
                          },
                          child: Text('S\'inscrire'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 4),
    );
  }
}

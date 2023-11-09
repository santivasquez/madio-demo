import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:te_regalo/data/registry_repository.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final RegistryRepository repository = RegistryRepository();

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 52, 32, 84),
            Color.fromARGB(255, 18, 0, 46),
          ], begin: Alignment.bottomLeft, end: Alignment.topLeft),
        ),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.network(
                    'https://madio-express-admin.web.app/assets/images/logo/logo_cdb.png'),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 78, 228),
                  ),
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 200,
                child: TextField(
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 78, 228),
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: Text('Ingresar'),
              ),
              const SizedBox(height: 55),
              FloatingActionButton.extended(
                onPressed: () {
                  _signInWithGoogle();
                },
                label: Text('Sign in with Google'),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                icon: Icon(Icons.security),
              ),
              const SizedBox(height: 40),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Crear nuevo usuario',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Recordar contraseña',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        )),
      ),
    );
  }

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);

      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final token = await user.getIdToken(false);
        print('token: ' + token!);

        if (await repository.getUser(user.uid) != null) {
          // Navega a app
        } else {
          //Completar datos
          repository.createUser(user);
        }
      } else {
        print("No se recibió usuario de GoogleSign ....................");
      }
    } catch (e) {
      print(e.toString() + "Problemas con  GoogleSign ....................");
    }
  }
}

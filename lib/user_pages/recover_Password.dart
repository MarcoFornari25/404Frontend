import 'package:flutter/material.dart';
import 'package:frontend_404dungeon/user_pages/register_page.dart';
import 'package:frontend_404dungeon/user_pages/forgot_password.dart';
import 'package:frontend_404dungeon/user_pages/login_page.dart';
import '../game_page.dart';
import 'package:frontend_404dungeon/services/auth_service.dart';

//Create Form Widget
class Recoverpage extends StatefulWidget {
  const Recoverpage({super.key}); //costruttore del widget
  //serve per identificare il widget nel grafo ad albero
  @override
  RecoverpageState createState() {
    return RecoverpageState();
  }
}

//create class
class RecoverpageState extends State<Recoverpage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Vertical Axis
              children: [
                Image.asset('assets/images/logo.png'),

                const SizedBox(height: 16),

                //password
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    //toggle hidden pwd
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),

                  //obscure || visibile pwd
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    if (value.length < 8) {
                      return 'At least 8 characters';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                //spazio tra email e pwd
                const SizedBox(height: 16),

                //confirm password
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    //toggle hidden pwd
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),

                  //obscure || visibile pwd
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    }
                    if (value.length < 8) {
                      return 'At Least 8 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16), //spazio tra pwd e login button

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(227, 0, 58, 1),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Leggo token ed email dal link (# fragment)
                        final fragment = Uri.base.fragment;
                        final fragmentUri = Uri.parse(fragment);

                        final token = fragmentUri.queryParameters['token'];
                        final emailFromLink =
                            fragmentUri.queryParameters['email'];

                        if (token == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Token mancante o non valido"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Se NON passi email nel link, usa quella scritta nel campo
                        final emailToUse =
                            emailFromLink ?? emailController.text.trim();


                        bool success = await _authService.resetPassword(
                          emailToUse,
                          passwordController.text.trim(),
                          confirmPasswordController.text.trim(),
                          token,
                        );

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password aggiornata con successo"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Token non valido o scaduto"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                //back to sign in 
                    TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const userLogin(),
                      ),
                    );
                  },
                  child: const Text('Back to sign in'),
                ),

                const SizedBox(height: 5),

            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

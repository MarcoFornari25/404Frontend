import 'package:flutter/material.dart';
import 'package:frontend_404dungeon/user_pages/loginPage.dart';
import '../GamePage.dart';
import '/services/auth_service.dart';

// Create Form Widget
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  ForgotPasswordState createState() {
    return ForgotPasswordState();
  }
}

// Create State
class ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final _authService = AuthService();
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

                Text(
                  'FORGOT PASSWORD',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(227, 0, 58, 1),
                  ),
                ),

                const SizedBox(height: 16),
                //email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),

                  //validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ao movite';
                    }
                    //controllo per i caratteri
                    bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value);
                    if (!emailValid) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(227, 0, 58, 1),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text.trim();

                        final success = await _authService.forgotPassword(
                          email,
                        );

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Se l'email è registrata, riceverai un link per il reset.",
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Errore del server. Riprova più tardi.",
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'SEND',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //create an Account
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

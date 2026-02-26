import 'package:flutter/material.dart';
import 'package:frontend_404dungeon/user_pages/register_page.dart';
import 'package:frontend_404dungeon/user_pages/forgot_password.dart';
import '../game_page.dart';
import '../services/auth_service.dart';

//Create Form Widget
class userLogin extends StatefulWidget {
  const userLogin({super.key}); //costruttore del widget
  //serve per identificare il widget nel grafo ad albero
  @override
  userLoginState createState() {
    return userLoginState();
  }
}

//create class
class userLoginState extends State<userLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

                //email
                TextFormField(
                  controller: emailController,
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
                      return 'Enter your email';
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

                //spazio tra email e pwd
                const SizedBox(height: 16),

                //password
                TextFormField(
                  controller: _passwordController,
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
                        String? token = await _authService.login(
                          emailController.text,
                          _passwordController.text,
                        );

                        if (token != null) {
                          // se login corretto vado a GamePage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => GamePage()),
                          );
                        } else {
                          // ERROR -> login fallito
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Email o password non valide"),
                            ),
                          );
                        }
                      }
                    },

                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                //create an Account
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text('or create an Account'),
                ),

                const SizedBox(height: 5),

                //forgot pwd
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    );
                  },
                  child: const Text('Forgot Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

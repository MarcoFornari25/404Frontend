import 'package:flutter/material.dart';
import 'homePage.dart';

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

                //email
                TextFormField(
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

                const SizedBox(height: 16), //spazio tra email e pwd
                //password
                TextFormField(
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // redirect to homePage
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('Submit', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

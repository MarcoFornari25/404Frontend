import 'package:flutter/material.dart';

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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Vertical Axis
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                //email
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please return scrivi qualcosa AO';
                    }
                    return null;
                  },
                ),

                //password
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                  labelText:
                  'Password',
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
                      return 'Please return scrivi qualcosa AO';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // login ok
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Login premuto')));
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

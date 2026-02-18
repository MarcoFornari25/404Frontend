import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://localhost:7016/api/v1";

  //Register

  Future<bool> register(
    String FirstName,
    String LastName,
    String Email,
    String Password,
  ) async {
    final url = Uri.parse("$baseUrl/Account/Registration");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "FirstName": FirstName,
        "LastName": LastName,
        "Email": Email,
        "Password": Password,
        "AcceptTos": true,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  //Login
  Future<String?> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/Account/Login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"Email": email, "Password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["token"];
    } else if (response.statusCode == 401) {
      return null;
    } else {
      print(response.body);


      return null;
    }
  }
}

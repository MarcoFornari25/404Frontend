import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "https://localhost:7016/api/v1";

  //Registration
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

  //Metodo per richiamare il token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt_token");
  }

  //Login
  Future<String?> login(String Email, String Password) async {
    final url = Uri.parse("$baseUrl/Account/Login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"Email": Email, "Password": Password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //estraggo token di autenticazione dal json
      final token = data["data"]?["token"];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("jwt_token", token);
      }
      return token;
    } else if (response.statusCode == 401) {
      return null;
    } else {
      return null;
    }
  }

  //Logout
  Future<void> logout() async {
    final token = await getToken();
    final url = Uri.parse("$baseUrl/Account/Logout");

    if (token != null) {
      await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"Token": token}),
      );
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt_token");
  }
}

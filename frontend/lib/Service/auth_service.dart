import 'dart:convert';
import 'package:frontend/Constants/api.dart';
// import 'package:frontend/Pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future loginUser(String email, String name, String pass1, String pass2) async {
    String url = base + register;
    var response = await http.post(Uri.parse(url), body: {
      'email': email,
      'name': name,
      'password': pass1,
      'password2': pass2,
      'tc': "True",
    });
    try {
      if (response.statusCode == 200) {
        var loginArr = jsonDecode(response.body.toString());
        var tokens = loginArr['token']['access'];
        var refreshs = loginArr['token']['refresh'];
        var msg = loginArr['msg'];
        if (msg == 'Registration Successful') {
          // Store the tokens in shared preferences
          saveTokens(tokens, refreshs);

          // Redirect to the home page or perform any other actions after successful login
        }

        print(loginArr);
        print('Refresh Token: $refreshs');
        print('Access Token: $tokens');
        print('Message: $msg');
      } else {
        print('Server Error');
        var loginArrr = jsonDecode(response.body.toString());
        print(loginArrr);
      }
    } catch (e) {
      print(response.body);
      // TODO
    }
  }

  static Future signIn(String email, String pass) async {
    String url = base + login;
    var response = await http.post(Uri.parse(url), body: {
      'email': email,
      'password': pass,
    });
    try {
      if (response.statusCode == 200) {
        var login = jsonDecode(response.body.toString());
        var tokenl = login['token']['access'];
        var refreshl = login['token']['refresh'];
        var msg = login['msg'];

        // Store the tokens in shared preferences
        saveTokens(tokenl, refreshl);

        print(login);
        print('Refresh Token: $refreshl');
        print('Access Token: $tokenl');
        print('Message: $msg');
      } else {
        print('Server Error');
        var loginArrr = jsonDecode(response.body.toString());
        print(loginArrr);
        return 'Server Error';
      }
    } catch (e) {
      print(response.body);
      return response.body.toString();
    }
  }

  static Future<int> signInthroughEmail(String email) async {
    String url = '${api}profile/?search_email=$email' ;
    var response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var login = jsonDecode(response.body.toString());
    // List<Map<String, dynamic>> parsedData =jsonDecode(response.body);
        // return login['id'];

        // Store the tokens in shared preferences
        print(login);
        var id=login[0]['id'];
        // String idddd=parsedData[0]['id'];

        print('idddd = ${login[0]}');
        print('iddd = $id');
        return id;
        // print(parsedData[0]['id']);
        // print(login['id']);
        // print(login['email']);
      } else {
        print('Server Error');
        var loginArrr = jsonDecode(response.body.toString());
        print(loginArrr);
        return -1;
      }
    } catch (e) {
      print(response.body);
      return -1;
      // return response.body.toString();
    }
  }


  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken);
    prefs.setString('refresh_token', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  static Future<void> refreshAccessToken() async {
    String? refreshToken = await getRefreshToken();
    if (refreshToken != null) {
      String url = base + tokenRefresh;
      var response = await http.post(Uri.parse(url), body: {
        'refresh': refreshToken,
      }
      );
      if (response.statusCode == 200) {
        var tokenData = jsonDecode(response.body.toString());
        String newAccessToken = tokenData['access'];
        // Store the new access token
        saveTokens(newAccessToken, refreshToken);
        print('New Access Token: $newAccessToken');
      } else {
        print('Failed to refresh access token');
      }
    } else {
      print('Refresh token not found');
    }
  }
}

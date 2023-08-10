import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

 class UserProfile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String about;
  final String profilePictureUrl;

   UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.about,
    required this.profilePictureUrl,
  });
}

 Future<UserProfile?> fetchUserProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final profileId = prefs.getInt('profile_id');
  print('profileid profile page ki $profileId');
  // final profileId = 1;

  if (profileId == null) {
    print('No profile_id found in SharedPreferences.');
    return null;
  }

  final url = Uri.parse('${api}profile/$profileId/');
  // final url = Uri.parse('http://192.168.29.131:8000/profile/4/');
print('fetchuser ki profile id hai $profileId');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      return UserProfile(
        id: data['id'],
        name: data['name']??'Enter Your Name',
        email: data['email']??'Enter Your Email',
        phone: data['phone_number']??'Enter Your Phone Number',
        about: data['about']??'Write about yourself',
        profilePictureUrl: data['profile_picture'] !=null?data['profile_picture']:'assets/images/profile.png',

      );
      //   globalemail= data['email'] ?? '';
      // prefs.setString('user_email', globalemail);
    } else {
      print('Failed to fetch profile: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching profile: $e');
  }
  // return null;
}

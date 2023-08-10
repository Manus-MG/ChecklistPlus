import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/api.dart';

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

// Future<UserProfile?> fetchUserProfile() async {
//   final url = Uri.parse('http://192.168.29.131:8000/profile/<profile_id>/');
//   // Replace <profile_id> with the specific profile ID you want to fetch.
//
//   try {
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return UserProfile(
//         id: data['id'],
//         name: data['name']??'Enter Your Name',
//         email: data['email']??'Enter Your Email',
//         phone: data['phone_number']??'Enter Your Phone Number',
//         about: data['about']??'Write about yourself',
//         profilePictureUrl: data['profile_picture'] !=null?data['profile_picture']:'assets/images/profile.png',
//       );
//     } else {
//       print('Failed to fetch profile: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error fetching profile: $e');
//   }
//
//   return null;
// }

// Future<int?> createNewUserProfile({
//   required String name,
//   required String email,
//   required String phone,
//   required String about,
//   required String profilePictureUrl,
// }) async {
//   final url = Uri.parse('http://192.168.29.131:8000/profile/4');
//
//   try {
//     var response = await http.post(
//       url,
//       body: {
//         'name': name,
//         'email': email,
//         'phone_number': phone,
//         'about': about,
//         // 'profile_picture': profilePictureUrl,
//       },
//     );
//
//     final requestI = http.MultipartRequest('POST', Uri.parse('http://192.168.29.131:8000/profile/'));
//
//     requestI.files.add(await http.MultipartFile.fromPath('profile_picture', profilePictureUrl));
//
//     // var responseI = await requestI.send();
//     // print("image response aaraha hai $requestI");
//     // var responsed = await http.Response.fromStream(responseI);
//     // final responseData = json.decode(responsed.body);
//     // print(responsed.statusCode);
//
//     // if (response.statusCode == 201) {
//     final data = json.decode(response.body);
//     print(data);
//     // final profileId = data['id'];
//
//     // Store the profile_id locally using SharedPreferences
//     // final prefs = await SharedPreferences.getInstance();
//     // prefs.setInt('profile_id', profileId);
//
//     // }
//     // else {
//     print('Failed to create profile: ${response.statusCode}');
//     return null;
//     // }
//   } catch (e) {
//     print('Error creating profile: $e');
//   }
//
//   return null;
// }

Future<int?> createNewUserProfile({
      required String name,
   required String email,
   required String phone,
   required String about,
   required String profilePictureUrl,
}
    ) async {
  final url = Uri.parse('${api}profile/'); // Replace with your Django API endpoint
  final request = http.MultipartRequest('POST', url);
  request.fields['name'] = name;
  request.fields['email'] = email;
  request.fields['phone_number'] = phone;
  request.fields['about'] = about;

  if (profilePictureUrl != null) {
    request.files.add(await http.MultipartFile.fromPath('profile_picture', profilePictureUrl));
  }

  try {
    final response = await request.send();
    if (response.statusCode == 201) {
      print('Profile created successfully!');
      print('body  ');
      final responseData = await response.stream.bytesToString(); // Get the response body
      final data = json.decode(responseData);
      final profileId = data['id'];
      print("Profile hai jo backend mein aarahi hai $profileId");

      // final prefs = await SharedPreferences.getInstance();
      // prefs.setInt('profile_id', profileId);
      return profileId;
    }

    else {
      print('Failed to create profile: ${response.statusCode}');
    }
  } catch (e) {
    print('Error creating profile: $e');
  }
}
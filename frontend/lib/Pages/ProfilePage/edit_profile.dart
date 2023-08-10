// import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/Constants/api.dart';
import 'package:frontend/Pages/ProfilePage/profile_page.dart';
import 'package:frontend/Pages/UI/widget/button.dart';
import 'package:frontend/Pages/UI/widget/input_field.dart';
import 'package:frontend/Pages/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CreateNewProfile.dart';

class EditProfile extends StatefulWidget {
  String name;
  String email;

  EditProfile({required this.name,required this.email});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _aboutController = TextEditingController();

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;
      final imageTemp = File(image.path);
      // print(image.path);
      // final ProfilePath=image.path;
      // print(imageTemp);
      final imagePerm = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePerm;
      });
    } on PlatformException catch (e) {
      print('Failed to pick an image: $e');
    }
  }

  Future<File> saveImagePermanently(String imgPath) async {
    final diretory = await getApplicationDocumentsDirectory();
    final name = basename(imgPath);
    final image = File('${diretory.path}/$name');
    // print('Pathhhhhh: ${diretory.path}/$name');
    return File(imgPath).copy(image.path);
  }

  Future<ImageSource?> showImageSourceOptions(BuildContext context) async {
    return await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context, ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override

  void initState() {
    _nameController.text = widget.name.toString();
    _emailController.text = widget.email.toString();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemIndigo.highContrastColor,
        leading: IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => navbar())),
            icon: Icon(CupertinoIcons.back)),
        title: Text('User Profile Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3), blurRadius: 40)
                  ]),
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(image != null ? 200 : 50),
                            onTap: () async {
                              ImageSource? selectedSource =
                                  await showImageSourceOptions(context);
                              pickImage(selectedSource!);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                                child: image != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                        child: Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 200,
                                        ),
                                      )
                                    : ClipRRect(
                                        child: Image.asset(
                                          'assets/images/profile.jpg',
                                          width: 46,
                                          height: 46,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MyInputField(
                  title: 'Name', hint: "Enter your Name",
                  controller: _nameController,
                ),
                MyInputField(
                  title: 'Email', hint: "Enter your Email",
                  controller: _emailController,
                ),
                MyInputField(
                  title: 'Phone', hint: "Enter Your Phone Number",
                  controller: _phoneController,
                  // decoration: InputDecoration(labelText: 'Phone'),
                ),
                MyInputField(
                  title: 'About',
                  hint: "Write about Yourself",
                  controller: _aboutController,
                ),
                SizedBox(
                  height: 15,
                ),
                MyButton(
                  label: 'Create Profile',
                  onTap: () async {
                    final profileId = await createNewUserProfile(
                      name: _nameController.text.toString(),
                      email: _emailController.text.toString(),
                      phone: _phoneController.text.toString(),
                      about: _aboutController.text.toString(),
                      profilePictureUrl: image!.path,
                    );
                    // print(image?.path.toString());
                    // print(_nameController.text.toString());
                    // print(_emailController.text.toString());
                    // print(_phoneController.text.toString());
                    // print(_aboutController.text.toString());
                    print(profileId);

                    if (profileId != null) {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setInt('profile_id', profileId);
                      prefs.setString('user_email', _emailController.text.toString());
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => navbar()));
                      print("button working !!!!!!");
                      // Successfully created a profile, you can do further actions here.
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

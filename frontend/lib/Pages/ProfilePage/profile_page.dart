import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/Pages/ProfilePage/EditPutProfile.dart';
import 'package:frontend/Pages/ProfilePage/UserprofileData.dart';
import 'package:frontend/Pages/ProfilePage/edit_profile.dart';
import 'package:frontend/Pages/UI/widget/button.dart';
import 'package:frontend/Pages/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = 10;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CupertinoColors.systemIndigo.highContrastColor,
          // leading: IconButton(
          //   onPressed: () {
          //     // Navigator.push(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (context) => EditPutProfile()));
          //   },
          //   icon: Icon(
          //     CupertinoIcons.back,
          //     color: Colors.white,
          //   ),
          // ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Profile",
            style: TextStyle(color: CupertinoColors.white, fontSize: 25),
          ),
        ),
        body: FutureBuilder<UserProfile?>(
            future: fetchUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final userProfile = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: defaultSize * 24, // 240
                        child: Stack(
                          children: <Widget>[
                            ClipPath(
                              clipper: CustomShape(),
                              child: Container(
                                height: defaultSize * 19, //150
                                color: CupertinoColors
                                    .systemIndigo.highContrastColor,
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: defaultSize * 3), //10
                                    height: defaultSize * 18, //140
                                    width: defaultSize * 18,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: defaultSize * 0.8, //8
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: userProfile.profilePictureUrl !=
                                                'file:///assets/images/profile.png'
                                            ? NetworkImage(userProfile
                                                    .profilePictureUrl)
                                                as ImageProvider
                                            : AssetImage(
                                                    'assets/images/profile.jpg')
                                                as ImageProvider, // Replace with your camera placeholder image asset
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          userProfile.name,
                          style: TextStyle(
                            fontSize: defaultSize * 2.8, // 22
                            color: CupertinoColors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: defaultSize / 2), //5
                      Text(
                        userProfile.email,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8492A2),
                        ),
                      ),
                      SizedBox(height: defaultSize / 3), //5
                      Text(
                        userProfile.phone,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8492A2),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 0.5,
                      ),
                      Container(
                        width: 80,
                        height: 50,
                        child: MyButton(
                          label: 'Edit Profile',
                          onTap: () {
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPutProfile(
                                          image: userProfile.profilePictureUrl,
                                          name: userProfile.name,
                                          email: userProfile.email,
                                          phone_number: userProfile.phone,
                                          about: userProfile.about)));
                            }
                          },
                        ),
                      )
                      // ElevatedButton(
                      //   onPressed: () {},
                      //   style: ElevatedButton.styleFrom(
                      //       backgroundColor: CupertinoColors.activeBlue,
                      //       side: BorderSide.none,
                      //       shape: StadiumBorder()),
                      //   child: Text(
                      //     'Edit Profile',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // )
                      ,
                      Container(
                        padding: EdgeInsets.all(defaultSize * 1.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'About',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              userProfile.about,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 45,
                        child: MyButton(
                          label: 'Logout',
                          onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.remove('user_email');
                            prefs.remove('profile_id');
                            clearSharedPreferences();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => splash()));
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text('No data found. Please create a profile.')),
                    SizedBox(
                      height: 20,
                    )
                    ,Container(
                      width: 70,
                      height: 45,
                      child: MyButton(
                        label: 'Create a Fresh Profile',
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove('user_email');
                          prefs.remove('profile_id');
                          clearSharedPreferences();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => splash()));
                        },
                      ),
                    )

                    // ,Center(
                    //   child: MyButton(
                    //     label: "Create Profile",
                    //     onTap: () => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => EditProfile())),
                    //   ),
                    // )
                  ],
                );
              }
            }),
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

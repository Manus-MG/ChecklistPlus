import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/Pages/ProfilePage/edit_profile.dart';
import 'package:frontend/Pages/UI/home_page.dart';
import 'package:frontend/Service/auth_service.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  var email = TextEditingController();
  var name = TextEditingController();
  var pass1 = TextEditingController();
  var pass2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 20,
            color: CupertinoColors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an Account. Its Free",
                    style: TextStyle(
                        fontSize: 15, color: CupertinoColors.systemGrey2),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  makeInput(lable: "Email", textController: email),
                  makeInput(lable: "Name", textController: name),
                  makeInput(
                      lable: "Password",
                      obscureText: true,
                      textController: pass1),
                  makeInput(
                      lable: "Confirm Password",
                      obscureText: true,
                      textController: pass2)
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                        bottom: BorderSide(color: Color(0xFF000000)),
                        top: BorderSide(color: Color(0xFF000000)),
                        left: BorderSide(color: Color(0xFF000000)),
                        right: BorderSide(
                          color: Color(0xFF000000),
                        ))),
                child: MaterialButton(
                  onPressed: () {
                    // print(email.text.toString());
                    // print(name.text.toString());
                    // print(pass1.text.toString());
                    // print(pass2.text.toString());
                    AuthService.loginUser(
                        email.text.toString(),
                        name.text.toString(),
                        pass1.text.toString(),
                        pass2.text.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile(
                                  email: email.text.toString(),
                                  name: name.text.toString(),
                                )));
                  },
                  minWidth: double.infinity,
                  height: 60,
                  color: Colors.lightGreen[300],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: CupertinoColors.systemGreen),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput(
      {lable,
      obscureText = false,
      required TextEditingController textController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          lable,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: CupertinoColors.black),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          controller: textController,
          decoration: InputDecoration(
              hintText: 'Enter ' + lable,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CupertinoColors.systemGrey4)),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CupertinoColors.systemGrey4),
              )),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}

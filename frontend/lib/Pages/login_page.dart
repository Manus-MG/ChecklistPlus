import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/Pages/navbar.dart';
import 'package:frontend/Pages/register_page.dart';
import 'package:frontend/Pages/splash_page.dart';
import 'package:frontend/Service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  var email = TextEditingController();
  var pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CupertinoColors.white,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          // onPressed: () {
          //   Navigator.pop(context);
          // },
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 20,
            color: CupertinoColors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                            fontSize: 15, color: CupertinoColors.systemGrey2),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        makeInput(lable: "Email", textController: email),
                        makeInput(
                            lable: "Password",
                            obscureText: true,
                            textController: pass),
                        // makeInput(lable: "Confirm Password", obscureText: true)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
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
                        onPressed: () async {
                          final iddd = await AuthService.signInthroughEmail(
                              email.text.toString());
                          print('Login page ki id $iddd');
                          if (iddd == -1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => splash()));
                          }
                          else {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setInt('profile_id', iddd);
                            prefs.setString(
                                'user_email', email.text.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => navbar()));
                          }
                          // var snackBar = SnackBar(
                          //   /// need to set following properties for best effect of awesome_snackbar_content
                          //   elevation: 0,
                          //   behavior: SnackBarBehavior.floating,
                          //   backgroundColor: Colors.transparent,
                          //   content: AwesomeSnackbarContent(
                          //     title: 'On Snap!',
                          //     message:'msg',
                          //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          //     contentType: ContentType.success,
                          //   ),
                          // );
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.lightGreen[300],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: CupertinoColors.systemGreen),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
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

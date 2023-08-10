import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/Constants/colors.dart';
import 'package:frontend/Pages/login_page.dart';
import 'package:frontend/Pages/register_page.dart';
import '../Constants/colors.dart';
import 'package:flutter/cupertino.dart';

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "WELCOME",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sign up for our to-do list app today and start getting things done!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF616161),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/checklist.jpg'),
                  )
                  ),
                ),
                Column(
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      minWidth: double.infinity,
                      height: 60,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xDD000000)),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.lightGreen[500],
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xDD000000)),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

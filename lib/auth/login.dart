// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/components/rounded_textField.dart';
import 'package:sanad_software_project/theme.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/login_top_right.png",
                    width: size.width * 0.42,
                  )),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/login_bottom_left.png",
                    width: size.width,
                  )),
              Container(
                width: double.infinity,
                height: size.height,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70),
                    Text(
                      "تـسـجـيـل الــدخــول",
                      style: TextStyle(
                          fontFamily: 'myFont',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,color:primaryColor),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Image.asset("assets/images/down.png",
                        width: size.width * 0.8),
                    SizedBox(
                      height: 40,
                    ),
                    RoundedTextField(
                        child: TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: "الـبريد الالـكترونـي أو هـويـة الـطفـل",
                        hintStyle: TextStyle(fontFamily: 'myFont'),
                        suffixIcon: Icon(
                          Icons.person_2,
                          color: primaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
                    RoundedTextField(
                        child: TextField(
                      obscureText: true,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: "كــلـمـة الــسـر",
                        hintStyle: TextStyle(fontFamily: 'myFont',),
                        suffixIcon: Icon(
                          Icons.lock,
                          color: primaryColor,
                        ),
                        icon: Icon(
                          Icons.visibility,
                          color: primaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(children: [
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              "هـل نـســيـت كـلمـة الـسـر؟",
                              style: TextStyle(
                                  fontFamily: 'myFont',
                                  fontSize: 18,
                                  color: primaryColor,
                                  decoration: TextDecoration.underline
                                  ),
                            )
                          ])),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(text: "تـسـجـيـل الــدخــول", press: () {}),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              "أنـشـئ حـسـاب",
                              style: TextStyle(
                                  fontFamily: 'myFont',
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                        Text("  لـيس لـديـك حـساب؟",
                            style: TextStyle(
                                fontFamily: 'myFont',
                                fontSize: 18,
                                color: primaryColor)),
                      ],
                    ),
                  ],
                )),
              )
            ],
          )),
    );
  }
}
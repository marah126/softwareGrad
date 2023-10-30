// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sanad_software_project/auuth/login.dart';
import 'package:sanad_software_project/components/radioButtonWithImage.dart';
import 'package:sanad_software_project/components/rounded_button.dart';
import 'package:sanad_software_project/components/rounded_textField.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;


class signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _signupState();
  }
}

class _signupState extends State<signup> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  String result = "";

///////////////////////////////////////////////////////////////////////////////////////////////
  Image image1 = Image.asset(
    "assets/images/nurse.png",
    width: 150,
    height: 120,
  );
  Image image2 = Image.asset(
    "assets/images/girl.png",
    width: 150,
    height: 120,
  );

  int selectedValue = 1;
/////////////////////////////////////////////////////////////////////////////////////////////
  void handleRadioValueChanged(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  Future<void> signupfun() async {
    print("inside signup fun");
    final response = await http
          .post(Uri.parse(ip+"/sanad/signup"), body: {
        'id': idController.text.trim(),
        'email': emailController.text.trim(),
        'password':passwordController.text.trim()
      });
      if(response.statusCode==200){
        var mass = jsonDecode(response.body.toString());
        print("mass");
      }
      else{
        var mass = jsonDecode(response.body.toString());
        print(mass);
      }
  }

  void check(){
    print("inside check fun");
    print("ssss");
    if (idController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || confirmController.text.isEmpty) {
      setState(() {
        result = "يـجــب تــعبـئــة جــمـيـع الــحـقــول";
      });
      
    } else if (idController.text.length < 9) {
      setState(() {
        result = "رقــم الــهـويــة أقـل مــن 9 أرقــام";

      });      
    } else if (passwordController.text!=confirmController.text) {
      setState(() {
        result="تـأكــيـد كــلـمـة الـمرور لا تـسـاوي كـلـمـة الــمرور";

      });
    }
    else{
      signupfun();
    }
    
    print("mmm");
  }

  void passwordStrength(String? pass) {
    bool hasUppercase = false;
    bool hasLowercase = false;
    bool hasDigits = false;
    bool hasSpecialCharacters = false;

    for (int i = 0; i < pass!.length; i++) {
      final char = pass[i];
      if (char == char.toUpperCase() && char != char.toLowerCase()) {
        hasUppercase = true;
      } else if (char == char.toLowerCase() && char != char.toUpperCase()) {
        hasLowercase = true;
      } else if (char.contains(RegExp(r'\d'))) {
        hasDigits = true;
      } else {
        hasSpecialCharacters = true;
      }
    }
    if (hasUppercase &&
        hasLowercase &&
        hasDigits &&
        hasSpecialCharacters &&
        pass.length > 8) {
      result = " ";
    } else {
      result =
          "كـلـمة الـمرور ضـعـيـفـة،يـجب أن تـحتـوي عـلى رمـوز و أرقـام وأحـرف";
    }
  }

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
                        SizedBox(height: 50),
                        Text(
                          "إنــشـــاء حــســاب  ",
                          style: TextStyle(
                              fontFamily: 'myFont',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff800080)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: CustomImageRadioButton(
                                text: "أخــصـائـيـة",
                                value: 1,
                                groupValue: selectedValue,
                                onChanged: handleRadioValueChanged,
                                image: image1, // Replace with your image path
                              ),
                            ),
                            Expanded(
                              child: CustomImageRadioButton(
                                text: "طــفــل",
                                value: 2,
                                groupValue: selectedValue,
                                onChanged: handleRadioValueChanged,
                                image: image2, // Replace with your image path
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          result,
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'myFont',fontWeight: FontWeight.bold),
                        ),
                        RoundedTextField(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            controller: idController,
                            onChanged: (value) {
                              setState(() {
                                  result=" ";
                              });
                            },
                            decoration: InputDecoration(
                              hintText: " رقــم الـهــويــة ",
                              hintStyle: TextStyle(fontFamily: 'myFont'),
                              suffixIcon: Icon(
                                Icons.numbers,
                                color: Color(0xff800080),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        ///////////////////////////////////////////////////////
                        RoundedTextField(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.right,
                            controller: emailController,
                            onChanged: (value) {
                              setState(() {
                                  result=" ";
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "  البـريــد الإلــكـتـرونــي ",
                              hintStyle: TextStyle(fontFamily: 'myFont'),
                              suffixIcon: Icon(
                                Icons.email,
                                color: Color(0xff800080),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        //////////////////////////////////////////////////
                        RoundedTextField(
                          child: TextField(
                            textAlign: TextAlign.right,
                            controller: passwordController,
                            onSubmitted: (value)=>passwordStrength(value),
                            onChanged: (value) {
                              setState(() {
                                  result=" ";
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "  كــلـمــة الــمـرور ",
                              hintStyle: TextStyle(fontFamily: 'myFont'),
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Color(0xff800080),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        //////////////////////////////////////////////////////////////////
                        RoundedTextField(
                          child: TextField(
                            textAlign: TextAlign.right,
                            controller: confirmController,
                            onChanged: (value) {
                              setState(() {
                                  result=" ";
                              });
                            },
                            decoration: InputDecoration(
                              hintText: " تـأكــيـد كــلـمــة الــمـرور ",
                              hintStyle: TextStyle(fontFamily: 'myFont'),
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Color(0xff800080),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RoundedButton(
                          text: " إنــشــاء حــســاب",
                          press: () => {check()},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Login();
                              }));
                            },
                            child: Text(
                              "لــديــك حــســاب بـالفـعـل؟",
                              style: TextStyle(
                                  fontFamily: 'myFont',
                                  fontSize: 18,
                                  color: Color(0xff800080),
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}

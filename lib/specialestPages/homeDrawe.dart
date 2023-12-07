// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/adminPages/addNewChild.dart';
import 'package:sanad_software_project/adminPages/addNewSpecialest.dart';
import 'package:sanad_software_project/adminPages/adminHome.dart';
import 'package:sanad_software_project/adminPages/c.dart';
import 'package:sanad_software_project/adminPages/chat.dart';
import 'package:sanad_software_project/adminPages/showAllChildren.dart';
import 'package:sanad_software_project/adminPages/showAllEmployee.dart';
import 'package:sanad_software_project/specialestPages/homePage.dart';
import 'package:sanad_software_project/specialestPages/viewChildren.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;


class spHomeDrawer extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _spHomeDrawerState();
  }
}

class _spHomeDrawerState extends State<spHomeDrawer> {
  final auth=FirebaseAuth.instance;
  void getUser(){
    try{
      final user=auth.currentUser;
      if(user != null){
        print(user.email);
      }
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Color hoveredColor = primaryLightColor;
   Widget container=spHomePage(id: "1478523690",name: "فطوم دريني",);
  @override
  Widget build(BuildContext context) {
   Size size=MediaQuery.of(context).size;               
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: primaryLightColor,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
               Container(
              color: primaryColor,
              width: double.infinity,
              height: 250,
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/admin.png'),
                      ),
                    ),
                  ),
                  Text(
                    "الـإدارة",
                    style: TextStyle(color: Colors.white, fontSize: 24,fontFamily: 'myFont'),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=spHomePage(id: "",name: "",);
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "الصـفـحـة الرئـسـيـة",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.home, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=myChildren();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "الأطـــفــال",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.child_care, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=viewChildren();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "الأطـــفـــال",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.child_care, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=viewSpecialest();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "الأخــصــائــيـيـن",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.person, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=newChild();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "إضـافـة طــفـل جـديـد",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.face_retouching_natural, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                width: size.width,
                height: size.width * 0.2,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        container=newSpecialest();
                      });
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: primaryColor,
                        padding: EdgeInsets.all(10),
                        backgroundColor: hoveredColor,
                        elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "إضـافـة أخـصـائـي جـديـد",
                          style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'myFont',
                            fontSize: 20,
                          ),
                        ),SizedBox(
                            width: 8),
                        Icon(
                          Icons.person_add, // Replace with the desired icon
                          color: primaryColor, // Set the color of the icon
                        ),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
            ]),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
         Builder(
          builder: (BuildContext context) {
           return IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }
         ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context){return ChatScreen();}));
            },
          ),
         ],
       ),
       body: container,
      // Container(
      //   width: size.width,
      //   height: size.height,
      //   child: Stack(children: [
      //     Positioned(
      //         bottom: 0,
      //         right: 0,
      //         child: Image.asset("assets/images/welcome_bottom_right.png")),
      //     Column(
      //       children: [
      //         Container(
      //           child: SfCalendar(
      //             view: CalendarView.schedule,
      //         ),)
      //       ],)
      //   ]),
      //),
    );
  }
  
}


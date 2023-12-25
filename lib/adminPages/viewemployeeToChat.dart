// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sanad_software_project/adminPages/chat.dart';
import 'package:http/http.dart' as http;
import 'package:sanad_software_project/theme.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TestPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class chat extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<chat> {
  List<Map<String, String>> Freinds = [
    {
      'date': 'أمس',
      'name': 'سارة حنو',
      'message': ' اوك',
      'image': 'assets/images/person1.png'
    },
    {
      'date': 'أمس',
      'name': '   نـغـم دريـنـي',
      'message': ' تـمـام',
      'image': 'assets/images/person1.png'
    },
    {
      'date': '13/12',
      'name': ' شـام دريـنـي  ',
      'message': ' الجلسة',
      'image': 'assets/images/person1.png'
    },
    {
      'date': '13/12',
      'name': '   مـيـس دريـنـي',
      'message': ' نفس الموعد',
      'image': 'assets/images/person1.png'
    },
    {
      'date': '12/12',
      'name': '   لـولـو دريـنـي',
      'message': 'الاحد  ',
      'image': 'assets/images/person1.png'
    },
    {
      'date': '5/12',
      'name': ' رنـا دريـنـي  ',
      'message': ' مسج',
      'image': 'assets/images/person1.png'
    },
    {
      'date': 'أمس',
      'name': 'أحـمـد أحـمـد',
      'message': ' بكرا',
      'image': 'assets/images/person1.png'
    },
   
  
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        backgroundColor: Color(0xff6f35a5),
        title: Text('الـدردشـات',style: TextStyle(fontFamily: 'myfont'),),
      ),
      
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4),
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
           SizedBox(height: 20),
           
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Freinds.length,
              itemBuilder: (context, index) {
                  return GestureDetector(
                  onTap: () {
                //    Navigate to a new page when card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen()
                      ),
                    );
                  },
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Color.fromARGB(255, 237, 234, 240),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            Freinds[index]['date'] ?? '',
                            style: TextStyle(fontFamily: 'myFont',fontSize: 16),
                          ),
                          Spacer(),
                          
                            
                             Column(
                              children: <Widget>[
                                Text(
                            Freinds[index]['name'] ?? '',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200),
                                ),
                                SizedBox(height: 5),
                                Text(
                            Freinds[index]['message'] ?? '',
                                  style: TextStyle(
                                      fontSize: 15, fontFamily: 'myfont'),
                                ),
                              ],
                            ),
                          
                          //  Spacer(),
                          Image.asset(
                            Freinds[index]['image'] ?? '',
                            width: 60,
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                    
                  ],

                ),
                  );  
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sanad_software_project/adminPages/chat.dart';
import 'package:http/http.dart' as http;
import 'package:sanad_software_project/theme.dart';



class chat extends StatefulWidget {
  @override
  _chatState createState() => _chatState();
}

class _chatState extends State<chat> {

   late final List<dynamic> data;
  List<String> imagePath = [];
  List<String> imageID = [];
  List<String> EMP = [];

  final auth=FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance;
  late User? user;

  void getUser(){
    try{
        final currentUser = auth.currentUser;
      if (currentUser != null) {
        setState(() {
          user = currentUser;
        });
        print("email firestore ");
        print(user!.email);
      }
    }catch(e){
      print(e);
    }
  }

   Future<void> getEmployeeName() async {
    // print("childrenssssssssssss");
    final EmployeeNamesResponse =
        await http.get(Uri.parse(ip + "/sanad/getspname"));
    if (EmployeeNamesResponse.statusCode == 200) {
      EMP.clear();
      String EmployeeName;
      data = jsonDecode(EmployeeNamesResponse.body);

      for (int i = 0; i < data.length; i++) {
        print(data[i]['Fname'] + " " + data[i]['Lname']);
        EmployeeName = data[i]['Fname'] + " " + data[i]['Lname'];
        setState(() {
          EMP.add(EmployeeName);
        });
      }
      for (int i = 0; i < EMP.length; i++) {
        print("ch" + data[i]['id']);
      }
    } else {
      print("errrrrrrrror");
    }
  }

  Future<void> getSPImages()async{
    String path;
    String id;
    final images = await http.get(Uri.parse(ip+"/sanad/getAllSPImages"));
    if(images.statusCode==200){
      print(images.body);
    final List<dynamic> image = jsonDecode(images.body);
      for(int i=0;i<image.length;i++){
        path=image[i]['path'];
        id=image[i]['spID'];
        print(path);
        print(id);
        imagePath.add(path);
        imageID.add(id);
      }
      
    }
  }


  Future<DateTime?> getLastMessageTime(String sender, String receiver) async {
  try {
    // Reference to your Firestore collection
    CollectionReference messagesCollection = FirebaseFirestore.instance.collection('messages');

    // Query to get messages where (sender is sender and receiver is receiver) OR (sender is receiver and receiver is sender),
    // ordered by time in descending order, and limit to 1 document
    QuerySnapshot querySnapshot = await messagesCollection
        .where('(sender == $sender && receiver == $receiver) || (sender == $receiver && receiver == $sender)')
        .orderBy('time', descending: true)
        .limit(1)
        .get();

    // Check if there is any document in the result
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document (latest message)
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      // Access the 'time' field from the document
      Timestamp timestamp = documentSnapshot['time'] as Timestamp;

      // Convert the timestamp to a DateTime object
      DateTime dateTime = timestamp.toDate().toUtc();
      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

      print('Last message time: $formattedDateTime');
      return dateTime;
    } else {
      // No messages found in both cases
      return null;
    }
  } catch (e) {
    print('Error getting last message time: $e');
    return null;
  }
}

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getEmployeeName();
    getSPImages();
  }
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
              itemCount: EMP.length,
              itemBuilder: (context, index) {
                  String employee = EMP[index];
                  return GestureDetector(
                  onTap: () async{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(receiverID: data[index]['id'],receiverName: data[index]['Fname'],)
                      ),
                    );
                    DateTime? lastMessageTime = await getLastMessageTime('admin', data[index]['id']);
                    if (lastMessageTime != null) {
                      print('Last message time: $lastMessageTime');
                    } else {
                      print('No messages found.');
                    }

                  },
                child: Column(
                  children: <Widget>[
                    Card(
                      color: Color.fromARGB(255, 237, 234, 240),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(width: 5,),
                          Text(
                            Freinds[index]['date'] ?? '',
                            style: TextStyle(fontFamily: 'myFont',fontSize: 16),
                          ),
                          Spacer(),                           
                             Column(
                              children: <Widget>[
                                Text(
                                  employee ?? '',
                                  style: TextStyle(
                                      fontFamily: 'myfont',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w200),
                                ),
                                SizedBox(height: 5),
                            //     Text(
                            // Freinds[index]['message'] ?? '',
                            //       style: TextStyle(
                            //           fontSize: 15, fontFamily: 'myfont'),
                            //     ),
                              ],
                            ),
                            SizedBox(width: 10,),
                            ClipOval(
                              child: imageID.contains(data[index]['id'])
                                  ? Image.network(
                                      'http://192.168.1.19:3000/sanad/getSPImage?id=${imageID[imageID.indexOf(data[index]['id'])]}',
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/profileImage.jpg',
                                      width: 70,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          SizedBox(width: 5,),
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

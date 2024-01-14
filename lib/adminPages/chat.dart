// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sanad_software_project/theme.dart';

class ChatScreen extends StatefulWidget {
  final String receiverID;
  final String receiverName;

  const ChatScreen({
    Key? key,
    required this.receiverID,
    required this.receiverName,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String receiverID;
  late String receiverName;

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  late User? user;

  TextEditingController messageText = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  


  void getUser() {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        setState(() {
          user = currentUser;
        });
        print(user!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    receiverID = widget.receiverID;
    print("rec chat id "+receiverID);
    receiverName = widget.receiverName;
    getUser();
  }

// Stream<List<messageContainer>> getMessagesStream(String recID) async* {
//   print("rec id from func $recID");

//   List<messageContainer> allMessages = [];

//   // Execute the first query
//   List<messageContainer> adminMessages = await getAdminMessages(recID);
//   print("aaaaaaaaaaaaa"+adminMessages.length.toString());

//   for(int i=0;i<adminMessages.length;i++){
//     print("****index "+i.toString()+adminMessages[i].text!+"***");
//     allMessages.add(adminMessages[i]);
//   }
//   for(int i=0;i<allMessages.length;i++){
//     print("/////"+allMessages[i].text!+"/////");
//   }
//   print("///////////////////////////////////////////////////////////////////////////////////////////////////////");

//   // Execute the second query
//   List<messageContainer> recIDMessages = await getRecIDMessages(recID);

//   for(int i=0;i<recIDMessages.length;i++){
//     print("==="+recIDMessages[i].text!+"====");
//     allMessages.add(recIDMessages[i]);

//   }
//   // Sort all messages based on time in descending order
//   //allMessages.sort((a, b) => b.time!.compareTo(a.time!));

//     for(int i=0;i<allMessages.length;i++){
//       print("/////"+allMessages[i].text!+"/////");
//     }
//     allMessages.sort((a, b) {
//     if (a.time == null && b.time == null) {
//       return 0;
//     } else if (a.time == null) {
//       return 1;
//     } else if (b.time == null) {
//       return -1;
//     } else {
//       Timestamp aTimestamp = a.time!;
//       Timestamp bTimestamp = b.time!;
//       return bTimestamp.compareTo(aTimestamp);
//     }
//     });
//   // Add this line to yield allMessages
//  // yield allMessages;
//   // Yield the combined and sorted list
//   yield allMessages;
// }


Stream<List<messageContainer>> getMessagesStream(String recID) async* {
  print("rec id from func $recID");

  List<messageContainer> allMessages = [];

  // Execute the first query
  List<messageContainer> adminMessages = await getAdminMessages(recID);
  allMessages.addAll(adminMessages);

  // Execute the second query
  List<messageContainer> recIDMessages = await getRecIDMessages(recID);
  allMessages.addAll(recIDMessages);
  

  for(int i=0; i<allMessages.length ; i++){
    print(allMessages[i].text!+" **** "+allMessages[i].time!.toDate().toString());
  }
  // Sort all messages based on time in descending order
   allMessages.sort((a, b) => a.time!.compareTo(b.time!));



  // Yield the combined and sorted list
  yield allMessages;
}

// ... (other functions remain unchanged)


Future<List<messageContainer>> getAdminMessages(String recID) async {
  print("Querying admin messages");

  Stream<QuerySnapshot> adminSentStream = firestore
    .collection('messages')
    .where('sender', isEqualTo: 'admin')
    .where('receiver', isEqualTo: recID)
    .orderBy('time')
    .snapshots();

  QuerySnapshot adminSnapshot = await adminSentStream.first;

  print("Admin sent stream data: ${adminSnapshot.docs.length}");

  adminSnapshot.docs.forEach((doc) {
    print("Document data: ${doc.data()}");
  });

  List<messageContainer> adminMessages = getMessageContainers(adminSnapshot);
  return adminMessages;
}

Future<List<messageContainer>> getRecIDMessages(String recID) async {
  print("Querying recID messages");
  Stream<QuerySnapshot> recIDSentStream = firestore
    .collection('messages')
    .where('sender', isEqualTo: recID)
    .where('receiver', isEqualTo: 'admin')
    .orderBy('time')
    .snapshots();

  QuerySnapshot recIDSnapshot = await recIDSentStream.first;

  print("RecID sent stream data: ${recIDSnapshot.docs.length}");

  recIDSnapshot.docs.forEach((doc) {
    print("Document data: ${doc.data()}");
  });

  List<messageContainer> recIDMessages = getMessageContainers(recIDSnapshot);

  return recIDMessages;
}




  List<messageContainer> getMessageContainers(QuerySnapshot snapshot) {
    return snapshot.docs.map((message) {
      final mText = message['text'];
      final sender = message['sender'];
       final time = message['time'] as Timestamp?;
      // Convert the timestamp to a DateTime object
      

      return messageContainer(
        sender: receiverName,
        text: mText,
        isME: sender == 'admin',
        time: time,
      );
    }).toList();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(Icons.chat_bubble),
            SizedBox(width: 10),
            Text('الــمـحـادثــات',style: TextStyle(fontFamily: 'myFont',fontWeight: FontWeight.bold,fontSize: 20),),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Add logout function here
            },
            icon: Icon(Icons.close),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<List<messageContainer>>(
              stream: getMessagesStream(receiverID),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  print("sssssssssssss No messages available");
                  return CircularProgressIndicator();
                } else {
                  final messages = snapshot.data!;
                  return Expanded(
                    child: ListView(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      children: messages,
                    ),
                  );
                }
                return Container();
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageText,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (messageText.text.trim().isNotEmpty) {
                        await firestore.collection('messages').add({
                          'text': messageText.text,
                          'sender': 'admin',
                          'receiver': receiverID,
                          'time': FieldValue.serverTimestamp(),
                        });

                        messageText.clear();

                        // _scrollController.animateTo(
                        //   duration: Duration(milliseconds: 300),
                        //   curve: Curves.easeInOut,
                        //   _scrollController.position.maxScrollExtent,
                        // );
                      }
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messageContainer extends StatelessWidget{
  final String? text;
  final String? sender;
  final bool? isME;
    final Timestamp? time; // Add this line


  const messageContainer({super.key, this.text,this.isME, this.sender, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isME! ? CrossAxisAlignment.end :CrossAxisAlignment.start, 
        children: [
        Text(isME! ? "You": '$sender'),
        Material(
          elevation: 5,
            borderRadius: isME! ?
             BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),topLeft: Radius.circular(30))
             : BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),topRight: Radius.circular(30)),
            color: isME! ? primaryLightColor:secondaryColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                '$text',
                style: TextStyle(color: Colors.black),
              ),
            )),
      ]),
    );
    
  }

}
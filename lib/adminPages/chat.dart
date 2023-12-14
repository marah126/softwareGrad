// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  //const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final auth=FirebaseAuth.instance;
  final firestore=FirebaseFirestore.instance;
  late User? user;

  TextEditingController messageText= TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void getUser(){
    try{
        final currentUser = auth.currentUser;
      if (currentUser != null) {
        setState(() {
          user = currentUser;
        });
        print(user!.email);
      }
    }catch(e){
      print(e);
    }
  }

  // void getMessages()async{
  //   final messages= await firestore.collection('messages').get();
  //   for(var message in messages.docs){
  //     print(message.data());
  //   }
  // }

  void messageStreams() async{
    await for (var snapshot in firestore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(Icons.chat_bubble,color: primaryLightColor,),
            SizedBox(width: 10),
            Text('MessageMe')
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // add here logout function
              messageStreams();
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
            //Container(),
            StreamBuilder<QuerySnapshot>(stream: firestore.collection('messages').orderBy('time').snapshots(), builder: (context,snapshot){
              List<messageContainer>messageWidget=[];
              if(!snapshot.hasData){
                //
              }
              final messages=snapshot.data!.docs;
              for(var message in messages){
                final mText=message.get('text');
                final sender=message.get('sender');
                final currentUser=user!.email;

                final widget=messageContainer(sender: sender,text: mText,isME: currentUser==sender,);
                messageWidget.add(widget);

              }
              return Expanded(child:
               ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: messageWidget,));
            }),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: secondaryColor,
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
                    onPressed: () {
                      firestore.collection('messages').add({
                        'text':messageText.text,
                        'sender':user!.email,
                        'time':FieldValue.serverTimestamp(),
                      });
                      messageText.clear();
                      _scrollController.animateTo(duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,_scrollController.position.maxScrollExtent);
                    },
                    child: Text(
                      'send',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )
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

  const messageContainer({super.key, this.text,this.isME, this.sender});

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
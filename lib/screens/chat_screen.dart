import 'package:flutter/material.dart';
import 'package:flash_chat/resources/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? messageText;
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        print(loggedInUser?.email);
      }
    }catch(e){
      print(e);
    }
  }

  /*
  void getMessages() async{
    final messages = await _firestore.collection('messages').get().then((messages){
      for(var messages in messages.docs){
        print(messages.data());
      }
    });
  */
  void messagesStream() async{
   await for( var snapshot in _firestore.collection('messages').snapshots()){
    for(var message in snapshot.docs){
      print(message.data());
    }
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                messagesStream();
                /*
                 _auth.signOut();
                 Navigator.pop(context);
              */
              }),
        ],
        title: const Text('❣️ L’amour'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text' : messageText,
                        'sender' : loggedInUser?.email,
                      });
                    },
                    child: Icon(
                        Icons.send
                    ),

                    /*
                    const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                    */

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

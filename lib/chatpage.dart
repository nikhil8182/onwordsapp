import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:onwordsapp/main.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import'package:firebase_core/firebase_core.dart';




class chatpage extends StatefulWidget {
 final String text1;
   chatpage(
      {Key key, this.text1})
      : super(key: key);


  @override
  _chatpageState createState() => _chatpageState(
      text1:this.text1,
  );
}

final _firestore =Firestore.instance;



class _chatpageState extends State<chatpage> {
   final String text1;
  _chatpageState({this.text1});



  @override
  final messageTextController = TextEditingController();
  final _firestore =Firestore.instance;

  String messageText;
  String messageSender;
  bool isMe;




  Widget build(BuildContext context) {


    return
      MaterialApp(
      home: Container(
        color: Colors.lightBlueAccent,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Let's chat "),
            centerTitle: true ,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(text1:text1),
              Container(
                //decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[


                    Expanded(


                      child: TextField(
                        cursorColor: Colors.blue,
                        controller: messageTextController ,
                        onChanged: (value) {
                         messageText = value;
                          //Do something with the user input.
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter the text',
                          fillColor:Colors.lightBlue,
                        ),

                      ),
                    ),
                    FlatButton(

                      onPressed: () {
                        print(text1);
                         messageTextController.clear() ;
                        _firestore.collection('messages').add({
                         'text':messageText,
                          'sender': text1,
                       });


                        //Implement send functionality.
                      },
                      child: Text(
                        'Send',
                      //  style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),

              ),

            ],

          ),
        ),
      ),
    );
  }
}


class MessagesStream extends StatelessWidget {

  final _firestore =Firestore.instance;

  final String text1;
  MessagesStream({this.text1});





  @override

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:_firestore.collection('messages').snapshots(),
      builder: (context,snapshot){
        if (!snapshot.hasData){
          return Center(
            child:CircularProgressIndicator(
              backgroundColor:Colors.blue,
            ),
          );

        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles =[];

        for (var message in messages){
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];

            final messageBubble = MessageBubble(
                sender: messageSender,
                text: messageText,
                isMe: text1 == messageSender,);
            messageBubbles.add(messageBubble);



         }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical:20),
            children: messageBubbles,

          ),
        );

      },
    );  }
}




class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender,this.text,this.isMe} );
  final String text;
  final String sender;
   final bool isMe;
  String endorstart;
  final _firestore =Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(10),
        child: Column(

            crossAxisAlignment:isMe?CrossAxisAlignment.end :CrossAxisAlignment.start,
            children:<Widget>[
              Text(sender,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight:Radius.circular(30),
                  topLeft: isMe?Radius.circular(30):Radius.circular(0),
                  topRight: isMe?Radius.circular(0):Radius.circular(30),

                ),
                color: isMe? Colors.lightBlueAccent : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal:20 ),
                  child: Text(text ,
                    style: TextStyle(
                      color: isMe?Colors.white:Colors.black54,
                      fontSize: 15,
                    ),),
                ),
              ),
            ]
        ),
      );
  }
}


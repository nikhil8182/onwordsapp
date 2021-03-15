import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onwordsapp/chatpage.dart';
import'chatpage.dart';



void main()
{
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Myapp(),
    );
  }
}



class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  //TextEditingController textFieldController = TextEditingController();


  var id1='nikhil';
  var pa1='8182';
  var id2='shailesh';
  var pa2='8183';
  var id3='sam';
  var pa3='8184';
  var id4='kavin';
  var pa4='8185';

  String a;
  var userid1;
  var password1;
  final passwordcon = new TextEditingController();
  final useridcon = new TextEditingController();


  void verify(userid ,password){

    userid1 = userid;
    password1 = password;
    if(id1==userid1 ) {
      if (pa1 == password1) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>chatpage(text1: userid1,),),);
         }
    }
    if(id2==userid1 ) {
      if (pa2 == password1) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>chatpage(text1: userid1,),),);
      }
    }
    if(id3==userid1 ) {
      if (pa3 == password1) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>chatpage(text1: userid1,),),);
      }
    }
    if(id4==userid1 ) {
      if (pa4 == password1) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>chatpage(text1: userid1,),),);
      }
    }

  }


  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
        padding: EdgeInsets.all(10),
    child: Column(

    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget> [

    Text('Onwords chat',
    style: Theme.of(context).textTheme.headline5,),
    SizedBox(height: 10),
    new TextField(

    controller: useridcon,
    decoration: InputDecoration(border: OutlineInputBorder(borderRadius:
    BorderRadius.all(Radius.circular(5))),
    hintText: 'Enter your User Id',
    icon: Icon(Icons.account_circle_rounded),

    ),


    ),

    SizedBox(height: 10),

    new TextField(
    obscureText: true ,
    controller: passwordcon,
    decoration: InputDecoration(border: OutlineInputBorder(borderRadius:
    BorderRadius.all(Radius.circular(5))),
    hintText: 'Enter your Password',
    icon: Icon(Icons.lock,)
    //suffixIcon:Icon(
    //Icons.visibility,
    //),
    ),
    ),

      SizedBox(height: 20),

    RaisedButton(
    child: Text('Login'),
    color: Colors.lightBlueAccent,
    onPressed: ()
    {
     setState(() {
     userid1 = useridcon.text;
     password1 = passwordcon.text;

     });
      verify(userid1, password1);

    },

    ),
    ],
      ),
    ),
    ),
    );
  }
}

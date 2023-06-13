import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../adminstration/chatadmistration.dart';
import 'GroupChat.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  TextEditingController name = TextEditingController();
  var uuid =Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Goup Chat App'),
      ),
      body:Center(
        child: TextButton(
          onPressed:()=>showDialog(
            context:context,
            builder:(BuildContext context){
              return AlertDialog(
                title:Text("Please Entre Your Name"),
                content:TextFormField(
                  controller: name,
                ),
                actions: [
                  TextButton(onPressed:(){
                    Navigator.pop(context);
                  }, child:Text('Cancel')),
                  TextButton(onPressed:(){
                    name.clear();
                    print(name.text);
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>GroupePage(name: 'gfgf', userId: 'gg',)));
                  }, child:Text('Entrer'))
                ],
              );
            }
          ),
          child:Text("Initial Group chat"),
        ),
      )
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

import 'ApiChat/ChatroomEtudiant.dart';
import 'MsgModel.dart';
import 'othermsgWidget.dart';
import 'ownMsgWidget.dart';

class GroupePage extends StatefulWidget {
  final String name;
  final String userId;

  const GroupePage({
    Key? key,
    required this.name,
    required this.userId,
  }) : super(key: key);

  @override
  State<GroupePage> createState() => _GroupePageState();
}

class _GroupePageState extends State<GroupePage> {
  IO.Socket? socket;
  List<MsgModel> listmsg = [];
  TextEditingController _msgController = TextEditingController();
  ApiChatEtudiantt ch =ApiChatEtudiantt();

  @override
  void initState() {
    super.initState();
    connect();


  }







  /* void connect() {
    socket = IO.io('http://192.168.1.13:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    print("we are here ");
    socket!.onConnect((_) {
      print("connected frontend");
      socket!.on("SendMsgServer", (msg) {
        print(msg);
        setState(() {
          listmsg.add(MsgModel(
              type: msg["type"],
              msg: msg["msg"] ?? "",
              sender: msg["senderName"]));
        });
      });
    });
  }
  void sendMsg(String msg, String sender) {
    MsgModel ownMsg = MsgModel(type: "ownMsg", msg: msg, sender: sender);
    setState(() {
      listmsg.add(ownMsg);
    });
    socket!.emit('sendMsg', {
      "type": "ownMsg",
      "msg": msg,
      "userid": widget.userId
    });
    _msgController.clear();
  }*/
  void connect() {
    // Connexion à l'instance Socket.io du serveur
    socket = IO.io('http://192.168.1.13:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    print("Connecté au serveur Socket.io");

    socket!.onConnect((_) {
      socket!.on("SendMsgServer", (msg) {
        print("ahmed");
        print(msg);
        print(msg['msg']);
        if (msg["userid"] == widget.userId) {
          setState(() {
            listmsg.add(MsgModel(
              type: msg["type"],
              msg: msg["msg"],
              sender: msg["senderName"],
            ));
          });
          if (msg["type"] == "otherMsg") {
            print("Message complet: $msg");
          }
        }
      });
    });
  }
  
  void sendMsg(String msg, String sender) {
    if (msg.trim().isEmpty) return; // Vérifiez que le message n'est pas vide

    MsgModel ownMsg = MsgModel(
      type: "ownMsg",
      msg: msg.trim(),
      sender: sender,
    );

    MsgModel otherMsg = MsgModel(
      type: "otherMsg",
      msg: msg.trim(),
      sender: sender,
    );

    // Ajouter le message à la liste pour l'expéditeur
    setState(() {
      listmsg.add(ownMsg);
    });

    // Envoi du message au serveur via Socket.io
    socket!.emit('sendMsg', {
      "type": "otherMsg", // Correction du type de message à "otherMsg"
      "msg": msg,
      "senderName": sender,
      "userid": widget.userId ?? 1,
      "access_token": '34|5swDq3pxoOYX1ZuAeCovj2DW10pjUyr73BXh9uXC',
      "chat_id": 1,
    });

    // Efface le champ de saisie de message
    _msgController.clear();
  }

  Future<Map<String,dynamic>> getMsg() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 34|5swDq3pxoOYX1ZuAeCovj2DW10pjUyr73BXh9uXC',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/messages/4'),
      headers: headers,
    );
    final jsonData = json.decode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print('1');
      print(jsonData);
      print("1");
      return jsonData;
    } else {
      return jsonData;
      throw Exception('Failed to load data');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF012869),
      body: Column(
        children: [
          Container(
            height: 30,
            color: Colors.white,
          ),
          Container(
            height: 43,
            width:double.infinity,
            color:Color(0xFF012869),
            child:Padding(
              padding: const EdgeInsets.only(top:5.0),
              child: Row(
                children: [
                  IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,color:Color(0xFF012869),size: 30,)),
                  CircleAvatar(
                    backgroundImage:AssetImage('lib/chat/135397796_1171775189945124_3258220724117022209_n.jpg'),
                  ),
                  SizedBox(width: 10,),
                  Text('L3 Génie Logiciel',textAlign: TextAlign.center,style:TextStyle(fontSize: 22,color:Colors.white,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
              ),
              child: StreamBuilder<Map<String,dynamic>>(
                stream:Stream.fromFuture(getMsg()),
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {

    if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Text("${snapshot.error}");
    } else {
      List<dynamic> measget = snapshot.data!['messages'];
      print("o5");
      print(measget);
      print("o5");
                  return  ListView.builder(
                    itemCount:snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final msg = listmsg[index];
                      final response =  getMsg();
                      print(response);
                      if (measget[index]['user_id'] == 8) {
                        print("ownMsg: ${msg.msg}");
                        return OwnMsgWidget(msg:measget[index]['text']);
                      } else if (msg.type == "otherMsg") {
                        print("otherMsg: ${msg.msg}");
                        return OtherMsgWidget(msg:measget[index]['text']);
                      }

                      return SizedBox();
                    },
                  );}
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:15,bottom: 15,left: 10),
            padding: EdgeInsets.symmetric(horizontal: 8),
            width: 350,
            height: 50,
            decoration:BoxDecoration(
                color:Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)
            ),
            child:Row(
              children: [
                Icon(Icons.face,color: Colors.white,),
                SizedBox(width: 15,),
                Container(
                    width: 240,
                    child: TextFormField(
                      controller: _msgController,
                      decoration:InputDecoration(
                        hintText:"Envoyer Votre Message",
                        hintStyle:TextStyle(color: Colors.white),
                        border:InputBorder.none
                      ),
                    )),
                SizedBox(width: 5,),
                IconButton(onPressed:(){
                 sendMsg(_msgController.text, "a");
                 ch.enregistrerMsg(_msgController.text, 4);
                }, icon:Icon(Icons.send,color: Colors.white,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

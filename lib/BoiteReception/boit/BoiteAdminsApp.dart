/*
import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../adminstration/Api/chatApi.dart';
import '../../chat/MsgModel.dart';
import '../../chat/othermsgWidget.dart';
import '../../chat/ownMsgWidget.dart';

class chteste extends StatefulWidget {
  final String name;
  final String userId;

  const chteste({
    Key? key,
    required this.userId,
    required this.name,
  }) : super(key: key);

  @override
  State<chteste> createState() => _chtesteState();
}

class _chtesteState extends State<chteste> {
  TextEditingController _msgController = TextEditingController();
  var uuid =Uuid();
  int selectedIndex = 0;
  IO.Socket? socket;
  List<MsgModel> listmsg = [];
  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  ApiChat com = ApiChat();



  Future<Map<String, dynamic>> getChatEtudiant() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };



    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/list_chats_etudiants'),
      headers: headers,
    );
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      print(jsonData);
      return jsonData;

    } else {
      print(jsonData);

      throw Exception('Failed to load data');
    }
  }

  enregistrerMsgEnseignant(String msg, int chatId) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 36|ugNikWUQdUZE4VsqM5GMknB0QIjd9vHZyTAnIHL4',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/messages'),
      headers: headers,
      body: json.encode({
        'chat_id': 4,
        'text':msg,
      }),
    );

    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      print("enregistre");
      print(jsonData);
    } else {
      print(" non enregistre");
      print(jsonData);
    }
  }


  Future<Map<String, dynamic>> getMsgEtudient(int selectedindex)async{

    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    http.Response response = await http.get(Uri.parse('https://192.168.1.13/ISIMM_eCampus/public/api/messages/4'),
        headers: headers);
    var data = jsonDecode(response.body) as Map<String,dynamic>;

    if(response.statusCode==200){
      print(data);
      return data ;
    }else{
      print(data);
      return jsonDecode(response.body);
    }
  }

  var s=1;
  Future<Map<String, dynamic>> fetchChatData() async {

    final chatEtudiantFuture = getChatEtudiant();
    final msgEtudientFuture = getMsgEtudient(s);

    final chatEtudiant = await chatEtudiantFuture;
    final msgEtudiant = await msgEtudientFuture;

    return {

      'chatEtudiant': chatEtudiant,
    };
  }




  List<Map<String, dynamic>> combinedList = [];


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
    socket?.emit('sendMsg', {
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
  @override
  void initState() {
    super.initState();
    getChatEtudiant();
    getMsgEtudient(s!);
    setState(() {
      _streamController =  StreamController.broadcast();
      getChatEtudiant();
      getMsgEtudient(s!);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xc4d1f2),
      body:Container(
        child:Column(children: [
          Container(
            height: 32,
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20, left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 0.5,
                    offset: Offset(1, 1),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 0,
                    blurRadius: 0.5,
                    offset: Offset(-1, -1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration:BoxDecoration(
                        color: Colors.white,
                        boxShadow:[
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(0,3),
                              color: Colors.black.withOpacity(0.07)
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('lib/chat/135397796_1171775189945124_3258220724117022209_n.jpg'),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Adminstration',style:TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 3),
                            Text(
                              'Connecté...',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                      ],
                    ),
                  ),

                  /*Expanded(
                                  child: Container(
                                    child: StreamBuilder<Map<String,dynamic>>(
                                      stream: Stream.fromFuture(getMsgEtudient()),
                                      builder:(context,AsyncSnapshot<Map<String,dynamic>> snapshot){
                                        return ListView.builder(
                                          itemCount: listmsg.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            if (listmsg[index].type == "ownMsg") {
                                              return OwnMsgWidget(msg: listmsg[index].msg);
                                            } else {
                                              return OtherMsgWidget(msg: listmsg[index].msg);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),*/
                  Expanded(
                    child: Container(
                      child: StreamBuilder<Map<String, dynamic>>(
                        stream: Stream.fromFuture(getMsgEtudient(selectedIndex)),
                        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {

                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else {
                            List<dynamic> msg = snapshot.data!['messages'];
                            int i = 0;
                            return ListView.builder(
                              itemCount: msg.length + listmsg.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < msg.length) {
                                  if (i <= msg.length) {
                                    if (msg[index]['sender_id'] == 7) {
                                      i++;
                                      print(i);
                                      return OwnMsgWidget(msg: msg[index]['text']);
                                    } else {
                                      i++;
                                      print(i);
                                      return OtherMsgWidget(msg: msg[index]['text']);
                                    }
                                  }
                                } else {
                                  int listMsgIndex = index - msg.length;
                                  if (listmsg[listMsgIndex].type == "ownMsg") {
                                    return OwnMsgWidget(msg: listmsg[listMsgIndex].msg);
                                  } else {
                                    return OtherMsgWidget(msg: listmsg[listMsgIndex].msg);
                                  }
                                }
                                return SizedBox.shrink();
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.add_circle, color: Color(0xFF3d5ee1)),
                        Container(
                          width: 80,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: _msgController,
                            decoration: InputDecoration(
                              hintText: "Ecrire un message...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3d5ee1)),
                          ),
                          onPressed: () {
                            setState(() {
                              enregistrerMsgEnseignant(_msgController.text,7);
                              print('ahla');
                              sendMsg(_msgController.text, "ahmed");
                              _msgController.clear();
                            }); // Clear the text field after sending the message
                          },
                          child: Text(
                            'Envoyer',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],),
      ),
    );

  }
}

*/




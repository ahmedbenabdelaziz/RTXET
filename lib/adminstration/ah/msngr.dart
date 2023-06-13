
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

class admiense extends StatefulWidget {
  final String name;
  final String image;
  final String token;
  final int chatid;
  final int userId;

  const admiense({
    Key? key,
    required this.image,
    required this.name, required this.token, required this.chatid, required this.userId,
  }) : super(key: key);

  @override
  State<admiense> createState() => _admienseState();
}

class _admienseState extends State<admiense> {
  TextEditingController _msgController = TextEditingController();
  var uuid =Uuid();
  int selectedIndex = 0;
  IO.Socket? socket;
  List<MsgModel> listmsg = [];
  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  ApiChat com = ApiChat();

  late int chatidd=15;
  Future<void> getChatid()async{

    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/chat_classes'),
        headers: headers);
    var data = jsonDecode(response.body)['chat_Room'] as Map<String,dynamic>;
print(data);
    if(response.statusCode==200){
      print(data);
      setState(() {
        print(data['id']);
        chatidd=chatidd;
      });
    }else{
      print(response.statusCode);
      print(data);

    }
  }


  Future<Map<String, dynamic>> getMsgEtudient(token,idchat)async{

    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/messages/${chatidd}'),
        headers: headers);
    var data = jsonDecode(response.body) as Map<String,dynamic>;

    if(response.statusCode==200){
      print(data);
      return data ;
    }else{
      print(response.statusCode);
      print(data);
      return jsonDecode(response.body);
    }
  }







  List<Map<String, dynamic>> combinedList = [];
  late String token;
  late int userId;


  late String imf;
  late String namechat;
late int chatid;
  @override
  void initState() {
    token=widget.token;
    imf=widget.image;
    namechat=widget.name;
    userId=widget.userId;
    chatidd=widget.chatid;
    getChatid();
    super.initState();
    getMsgEtudient(token,chatidd);
    connect();
    setState(() {
      _streamController =  StreamController.broadcast();
      getMsgEtudient(token,chatidd);
    });
  }
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
        if (msg["userid"]== widget.userId) {
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

  void sendMsg(String msg, String sender,token) {
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
      "content": msg,
      "senderName": sender,
      "userid": 1 ?? 4,
      "access_token": '${token}',
      "chat_id": chatidd,
    });

    // Efface le champ de saisie de message
    _msgController.clear();
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
                        Image.asset(imf,height: 40,),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(namechat,style:TextStyle(fontWeight: FontWeight.bold),),
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
                        stream: Stream.fromFuture(getMsgEtudient(token,chatidd)),
                        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {

                          if (!snapshot.hasData) {
                            return Center(child: Text('chat vide'),);
                          } else if (snapshot.data!['messages']=='Rien à afficher') {
                            return Center(child: Text("Rien à afficher"));
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
                                    if (msg[index]['sender_id'] !=msg[index]['user_id']) {
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
                          }},
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
                              print('ahla');
                              sendMsg(_msgController.text, "ahmed",token);
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

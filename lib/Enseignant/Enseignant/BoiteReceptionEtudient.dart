/*import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

import '../../chat/MsgModel.dart';
import '../../chat/othermsgWidget.dart';
import '../../chat/ownMsgWidget.dart';



class BoiteReceptionEtudient extends StatefulWidget {
  final String name;
  final String userId;

  const BoiteReceptionEtudient({
    Key? key,
    required this.name,
    required this.userId,
  }) : super(key: key);

  @override
  State<BoiteReceptionEtudient> createState() => _BoiteReceptionEtudientState();
}

class _BoiteReceptionEtudientState extends State<BoiteReceptionEtudient> {
  IO.Socket? socket;
  List<MsgModel> listmsg = [];
  TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }


  void connect() {
    // Connexion à l'instance Socket.io du serveur
    socket = IO.io('http://192.168.1.13:3000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    print("Connecté au serveur Socket.io");

    socket!.onConnect((_){
      print("hello");
      socket!.on("SendMsgServer", (msg) {
        print(msg);
        if (msg["userid"] != widget.userId) {
          setState(() {
            listmsg.add(MsgModel(
                type: msg["type"],
                msg: msg["msg"],
                sender: msg["senderName"]));
          });
        }
      });
    });

  }

  void sendMsg(String msg, String sender) {
    if (msg.trim().isEmpty) return; // Vérifiez que le message n'est pas vide
    MsgModel ownMsg =
    MsgModel(type: "ownMsg", msg: msg.trim(), sender: sender);
    setState(() {
      listmsg.add(ownMsg);
    });

    // Envoi du message au serveur via Socket.io
    socket!.emit('message', {
      "type": "ownMsg",
      "msg": _msgController.text,
      "senderName":"fawzi",
      "userid": widget.userId ?? 1, // utilise une valeur par défaut de 1 si l'identifiant de l'utilisateur n'est pas défini
      "access_token": '${token}',
      "chat_id": 1 // utilise une valeur par défaut de 1 pour l'identifiant du chat
    });

    // Efface le champ de saisie de message
    _msgController.clear();
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
              padding: EdgeInsets.symmetric(horizontal:7),
              decoration:BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomRight:Radius.circular(50),bottomLeft:Radius.circular(50))
              ),
              child: ListView.builder(
                itemCount: listmsg.length,
                itemBuilder: (BuildContext context, int index) {
                  if (listmsg[index].type == "ownMsg") {
                    return OwnMsgWidget(msg: listmsg[index].msg);
                  } else {
                    return OtherMsgWidget(msg: listmsg[index].msg);
                  }
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
                  sendMsg(_msgController.text, "ahmed");
                }, icon:Icon(Icons.send,color: Colors.white,))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
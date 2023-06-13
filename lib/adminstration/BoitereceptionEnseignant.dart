/*import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../chat/MsgModel.dart';
import '../chat/othermsgWidget.dart';
import 'package:uuid/uuid.dart';

import '../chat/ownMsgWidget.dart';
import 'Api/chatApi.dart';
class ChatAdminEnseignant extends StatefulWidget {
  final String name;
  final String userId;

  const ChatAdminEnseignant({
    Key? key,
    required this.userId,
    required this.name,
  }) : super(key: key);

  @override
  State<ChatAdminEnseignant> createState() => _ChatAdminEnseignantState();
}

class _ChatAdminEnseignantState extends State<ChatAdminEnseignant> {
  TextEditingController _msgController = TextEditingController();
  var uuid =Uuid();
  int selectedIndex = 0;
  IO.Socket? socket;
  List<MsgModel> listmsg = [];
  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  ApiChat com = ApiChat();

  Future<Map<String, dynamic>> getChatEnseignant() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/list_chats_enseignants'),
      headers: headers,
    );
    final jsonData = json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      print('1');
      print(jsonData);
      print("1");
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }



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


  Future<Map<String, dynamic>> getMsgEnseignant(int selectedindex)async{
   if(selectedIndex==0){
     setState(() {
       selectedIndex=6;
     });
   }

    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/chat_messages_enseignant/${selectedIndex}'),
        headers: headers);
    var data = jsonDecode(response.body) as Map<String,dynamic>;

    if(response.statusCode==200){
      print('23');
      return data ;
    }else{
      print(data);
      return jsonDecode(response.body);
    }
  }

  var s=1;
  Future<Map<String, dynamic>> fetchChatData() async {
    final chatEnseignantFuture = getChatEnseignant();
    final chatEtudiantFuture = getChatEtudiant();
    final msgEtudientFuture = getMsgEnseignant(s);
    final chatEnseignant = await chatEnseignantFuture;
    final chatEtudiant = await chatEtudiantFuture;
    final msgEtudiant = await msgEtudientFuture;

    return {
      'chatEnseignant': chatEnseignant,
      'chatEtudiant': chatEtudiant,
      'getMsgEtudient':msgEtudiant,
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
      socket!.on("sendMsgServer", (msg) {
        print("ahmed");
        print(msg);
        print(msg['msg']);
        if (msg["userid"] != widget.userId) {
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

  void sendMsg(String msg, String sender,ids) {
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
      "sender": sender,
      "userid": widget.userId ?? 1,
      "access_token": '${token}',
      "chat_id": idchat,
    });

    // Efface le champ de saisie de message
    _msgController.clear();
  }

  @override
  void initState() {
    super.initState();
    getChatEnseignant();
    connect();
    setState(() {
      _streamController =  StreamController.broadcast();
      getChatEnseignant();
    });
  }
var nom ="Ahmed ";
 var idchat=9;
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFff7f7fa),
      body:Container(
        child:Column(children: [
          Container(
            height: 50,
            padding:EdgeInsets.symmetric(horizontal: 0),
            width: double.infinity,
            color: Colors.white,
            child:Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child:Image.asset('lib/adminstration/img/téléchargement (2).png'),
                ),
                Row(
                  children: [
                    Text('ISIMM',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF26519e)),),
                    Text('_eCAMPUS',style:TextStyle(fontSize: 20),),
                  ],
                ),
                SizedBox(width: 40,),
                Container(
                  width: 40,
                  height: 40,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                  child:Center(
                    child:Icon(Icons.dashboard,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius:BorderRadius.circular(10)
                    )
                    ,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "search..."
                    ),
                  ),
                )),
                Expanded(child:Container()),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.1),
                        ),

                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5
                          ,child:CircleAvatar(
                        backgroundImage:AssetImage('lib/adminstration/img/tunisie.png'),
                      ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                          child:CircleAvatar(
                            backgroundColor:Colors.black.withOpacity(0.05),
                            child: Icon(Icons.notifications_none,color: Colors.black,),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.03),
                        ),
                      ),
                      Positioned(
                          child:CircleAvatar(
                            backgroundColor:Colors.black.withOpacity(0.03),

                            child:Icon(Icons.email_outlined,color: Colors.black,),
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius:20,
                          child:Image.asset('lib/ISIM_LOGO_ar.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ISIMM',style:TextStyle(fontWeight: FontWeight.bold),),
                          Text('Adminstration',style:TextStyle(color: Colors.blue),)

                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                height: 530,
                width: 200,
                color:Colors.white,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Menu principal',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                            decoration: BoxDecoration(
                                color: Color(0xFF3d5ee1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                children: [
                                  Icon(Icons.home,color: Colors.white,),
                                  SizedBox(width: 20,),
                                  Text('Acceuille',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                                  Expanded(child: Container()),
                                  SizedBox(width:10,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/prof.png')),
                                SizedBox(width: 20,),
                                Text('enseignants',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('Extra',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    Text('Managment',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.dashboard),
                                SizedBox(width: 25,),
                                Text('Students',style:TextStyle(color:Colors.black38,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_back)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                padding: EdgeInsets.only(top: 20,right: 20,left: 20),
                width: 1080,
                height: 551,
                color:Color(0xFff7f7fa),
                child:Column(
                  children: [
                    Row(
                      children: [
                        Text('Boite de Reception',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w800),)
                        ,Expanded(child: Container()),
                        Text('Home   /'),
                        Text('   Chat',style:TextStyle(color: Colors.black38),)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          height: 472,
                          width:280,
                          decoration:BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow:[
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    spreadRadius: 0,
                                    blurRadius:0.5,
                                    offset:Offset(1,1)
                                ),
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    spreadRadius: 0,
                                    blurRadius:0.5,
                                    offset:Offset(-1,-1)
                                )

                              ]
                          ),
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  decoration:InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.search),
                                      )
                                      ,hintText: "Recherche ...",
                                      hintStyle:TextStyle(color: Colors.black.withOpacity(0.5))
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 4,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: StreamBuilder<Map<String, dynamic>>(
                                    stream: Stream.fromFuture(getChatEnseignant()),
                                    builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text("${snapshot.error}");
                                      } else {
                                        List<dynamic> enseignants =snapshot.data!['chats'];
                                        print("02");
                                        print(enseignants);
                                        print("02");
                                        return ListView.builder(
                                          itemCount:enseignants.length,
                                          itemBuilder: (context, id) {
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedIndex = enseignants[id]['id'];
                                                      nom = enseignants[id]['nom'];
                                                      idchat=enseignants[id]['id'];
                                                    });
                                                  },
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        CircleAvatar(),
                                                        SizedBox(width: 10),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              enseignants[id]['nom'],
                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(height: 3),
                                                            Text(
                                                             // enseignants[id]['lastmessage']['text'], // Handle null value for messages
                                                              "ssdddd",
                                                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(child: Container()),
                                                        Text(
                                                          '3.15 PM',
                                                          style: TextStyle(
                                                            color: Colors.black.withOpacity(0.6),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 8,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                  color: Colors.black.withOpacity(0.1),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )


                            ],
                          ),
                        ),

                        SizedBox(width: 10,),
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 10, top: 8),
                          height: 472,
                          width: 750,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage('lib/chat/135397796_1171775189945124_3258220724117022209_n.jpg'),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(nom,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
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
                              Divider(),
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
                                    stream: Stream.fromFuture(getMsgEnseignant(selectedIndex)),
                                    builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {

                                      if (!snapshot.hasData) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text("${snapshot.error}");
                                      } else {
                                        List<dynamic> msg = snapshot.data!['messages'];
                                        print(msg);
                                        int i = 0;
                                        return ListView.builder(
                                          itemCount: msg.length + listmsg.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            if (index < msg.length) {
                                              if (i <= msg.length) {
                                                if (msg[index]['sender_id'] != selectedIndex) {
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
                                      width: 400,
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
                                    SizedBox(
                                      width: 100,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3d5ee1)),
                                        ),
                                        onPressed: () {
                                          sendMsg(_msgController.text,'${token}','f' );
                                          print('ahla');
                                          _msgController.clear(); // Clear the text field after sending the message
                                        },
                                        child: Text(
                                          'Envoyer',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

            ],
          )
        ],),
      ),
    );

  }
}



*/
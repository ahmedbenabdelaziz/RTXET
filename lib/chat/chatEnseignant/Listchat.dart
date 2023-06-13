import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ChatUiEnseignant extends StatefulWidget {
  const ChatUiEnseignant({Key? key}) : super(key: key);

  @override
  State<ChatUiEnseignant> createState() => _ChatUiEnseignantState();
}

class _ChatUiEnseignantState extends State<ChatUiEnseignant> {

  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();

  Future<Map<String, dynamic>> getListChat() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 18|rNKdpqCzFl0R1gYiVh5CndtaIJfQWIHyoSkv8kSN',
      'Accept': 'application/json',

    };

    final response = await http.get(
      Uri.parse('https://192.168.1.13/ISIMM_eCampus/public/api/chat_rooms'),
      headers: headers,
    );
    print("k");
    var data = jsonDecode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print('z');
      print(data);
      return data;
    } else {
      return data;
    }
  }

  @override
  void initState() {
    super.initState();
    getListChat();

    setState(() {
      _streamController =  StreamController.broadcast();
      getListChat();
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
      backgroundColor:Color(0xFF012869),
      body:Column(
        children: [
          Container(height: 32,
            color: Colors.white,),
          SizedBox(
            height: 140,
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed:(){},icon:Icon(Icons.arrow_back,color: Colors.white,size:25,))
                          ,CircleAvatar(
                            radius:20,
                            backgroundImage:AssetImage('lib/chat/téléchargement.jpg'),
                          )
                        ],
                      ),
                      SizedBox(height:30,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Chat Messages',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration:BoxDecoration(
                borderRadius:BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(20))
                ,color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                      ,  color: Colors.white,
                    ),
                    child:ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 10
                        ,itemBuilder:(context,id){
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0,top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage:AssetImage('lib/annonce/343101852_761963091991078_3927862018311633401_n.jpg'),
                            ),
                            SizedBox(height: 5,),
                            Text('L3 Info Tp1',style:TextStyle(fontWeight:FontWeight.w500))
                          ],
                        ),
                      );
                    }),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Expanded(
                    child: Container(
                      child: StreamBuilder(
                        stream:Stream.fromFuture(getListChat()),
                        builder:(context,AsyncSnapshot<Map<String,dynamic>> snapshot){
                          var  data = snapshot.data!;
                          List<dynamic> Listchat = snapshot.data!['chat_Room'];
                          print(Listchat);
                          return  ListView.builder(
                              itemCount: Listchat.length
                              ,itemBuilder:(context,id){
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20,right: 20,bottom: 0),
                                  child:Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundImage:AssetImage('lib/chat/135397796_1171775189945124_3258220724117022209_n.jpg'),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(Listchat[id]['name'],style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                                          ,SizedBox(height: 4,),
                                          Text('ahla cv wnk',style:TextStyle(fontWeight:FontWeight.bold,color:Colors.grey,fontSize: 15),)
                                          ,
                                        ],
                                      ),
                                      Expanded(child:Container()),
                                      Column(
                                        children: [
                                          Text('14.30',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                          SizedBox(height: 5,),
                                          CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.green,
                                            child:Text('2'),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Divider(thickness: 0.8,
                                ),
                              ],
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFF012869),
        selectedItemColor: Colors.red,
        unselectedItemColor: Color(0xFF385b9f),
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.message),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: "Home"),
          BottomNavigationBarItem(icon:Icon(Icons.notifications),label: "Home"),

        ],
      ),

    );
  }
}

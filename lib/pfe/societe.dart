import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
class nomsoc extends StatefulWidget {
  const nomsoc({Key? key}) : super(key: key);

  @override
  State<nomsoc> createState() => _nomsocState();
}

class _nomsocState extends State<nomsoc> {


  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  Future<Map<String, dynamic>> getSoc() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer 36|ugNikWUQdUZE4VsqM5GMknB0QIjd9vHZyTAnIHL4',
      'Accept': 'application/json',

    };

    HttpClient client = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    final response = await http.get(
      Uri.parse('https://192.168.1.13/ISIMM_eCampus/public/api/societes'),
      headers: headers,
    );
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
    getSoc();
    setState(() {
      _streamController =  StreamController.broadcast();
      getSoc();
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
      backgroundColor: Colors.white,

      body:Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF9b73ef),Color(0xFF6763d5)]
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0,),
              child: Row(
                children: [
                  IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,size:30,color: Colors.white,))
                  ,Container(
                    height: 45,
                    width: 285,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 0.5,
                            offset: Offset(3,3)
                        ),
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 0.5,
                            offset: Offset(-3,-3)
                        )
                      ],
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search,color: Colors.white,),
                          hintText: "Recherche Rapport ..",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  CircleAvatar(
                    backgroundImage:AssetImage('lib/societe/téléchargementt.png'),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 700,
            child: ListView.builder(itemBuilder:(context,id){
              return Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow:[
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(1,1)
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child:Text('Conception et realisation dune application web de gestion des stagiaires :',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                      Row(
                        children: [
                          Text('Societe :',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          SizedBox(width: 7,)
                          ,Text('ACTIA',style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),

                        ],
                      )
                      ,SizedBox(height: 5,),
                      Row(
                        children: [
                          Text('Au :',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          SizedBox(width: 7,)
                          ,Text('16-5-2023',style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),

                        ],
                      ),
                      SizedBox(height: 7,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Technologies utilisés :',style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          Container(
                            height: 100,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      child: Image.asset('lib/imagsoc/téléchargement (2).png'),
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Angular')
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Image.asset('lib/imagsoc/téléchargement.png'),
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Laravel')
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          child: Image.asset('lib/imagsoc/téléchargement (3).png'),
                                        ),
                                        SizedBox(height: 5,),
                                        Text('Java Script')
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:AssetImage('lib/imagsoc/téléchargement (1).png',),
                                    ),
                                    SizedBox(height: 5,),
                                    Text('Flutter')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Color(0xFF9b73ef),Color(0xFF6763d5)]
                                    ),
                                    borderRadius: BorderRadius.circular(20)
                                ),child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Afficher',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                                  SizedBox(width: 5,),
                                  Icon(Icons.add_circle_outline,color: Colors.white,)
                                ],
                              ),
                                width: 150,
                                height: 50,
                              ),
                              SizedBox(width: 5,),
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [Color(0xFF9b73ef),Color(0xFF6763d5)]
                                    ),
                                    borderRadius: BorderRadius.circular(20)
                                ),child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Telecharger',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                                  SizedBox(width: 5,),
                                  Icon(Icons.download,color: Colors.white,)
                                ],
                              ),
                                width: 150,
                                height: 50,
                              )
                            ],
                          )
                        ],
                      ),


                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

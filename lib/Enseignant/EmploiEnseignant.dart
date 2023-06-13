import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled62/adminstration/DateExamen.dart';

import '../presence/pre.dart';
import '../presence/presenece.dart';
class EmploiEns extends StatefulWidget {
  final int id;
  final String token;

  const EmploiEns({Key? key, required this.id, required this.token}) : super(key: key);

  @override
  State<EmploiEns> createState() => _EmploiEnsState();
}

class _EmploiEnsState extends State<EmploiEns> {
  Future<Map<String, dynamic>> getEmploi(token) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',

    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/mes_seances'),
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


  List<Color> list =[
    Colors.yellow,
    Colors.green,
    Colors.pink,
    Colors.blue,
    Colors.red,
    Colors.purple
  ];



  Future<Map<String, dynamic>> DateExamen(token) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',
    };

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/mes_seances'),
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

  Color couleur=Colors.white;
 late String token;
  @override
  void initState() {
    token=widget.token;
    DateExamen(token);
    getEmploi(token);
    super.initState();
  }
  late String jours ="seancesLundi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFeaeaeb),
      body:Column(
        children: [
          Container(height: 32,color: Colors.white,),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xFF012869),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 0,
                      offset: Offset(2,2),
                      color: Colors.black.withOpacity(0.05)
                  )
                ]
            ),
            child: Row(
              children: [
                IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                Text('Emploi Du Temps',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),

              ],
            ),
          ),
          SizedBox(height: 30,
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child:Column(
                  children: [
                    Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white
                      ),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  jours = "seancesLundi";
                                  couleur = Colors.green;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                margin: EdgeInsets.all(2),
                                width: 40,
                                decoration: BoxDecoration(
                                  color: jours == "seancesLundi" ? couleur : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Lun',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  jours = "seancesMardi";
                                  couleur = Colors.green;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                margin: EdgeInsets.all(2),
                                width: 40,
                                decoration: BoxDecoration(
                                  color: jours == "seancesMardi" ? couleur : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Mar',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  jours = "seancesMercredi";
                                  couleur = Colors.green;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                margin: EdgeInsets.all(2),
                                width: 40,
                                decoration: BoxDecoration(
                                  color: jours == "seancesMercredi" ? couleur : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Mer',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                  ),
                                ),
                              ),
                            )
                            ,   GestureDetector(
                              onTap: () {
                                setState(() {
                                  jours = "seancesJeudi";
                                  couleur = Colors.green;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                margin: EdgeInsets.all(2),
                                width: 40,
                                decoration: BoxDecoration(
                                  color: jours == "seancesJeudi" ? couleur : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Jeu',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  jours = "seancesVendredi";
                                  couleur = Colors.green;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                margin: EdgeInsets.all(2),
                                width: 40,
                                decoration: BoxDecoration(
                                  color: jours == "seancesVendredi" ? couleur : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Ven',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  jours = "seancesSamedi";
                                  couleur = Colors.green;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                margin: EdgeInsets.all(2),
                                width: 40,
                                decoration: BoxDecoration(
                                  color: jours == "seancesSamedi" ? couleur : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Sam',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                            child: StreamBuilder<Map<String, dynamic>>(
                                stream: Stream.fromFuture(DateExamen(token)),
                                builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                  var data = snapshot.data;
                                  print(data);
                                  //  List<dynamic> annonces = snapshot.data!['annonces'];
                                  //  List<dynamic> proprietaires = snapshot.data!['proprietaires'];
                                  List<dynamic> seancesLundi = snapshot.data?[jours] ?? [];
                                  print(seancesLundi);
                                  print("ddd");
                                  print(seancesLundi.length);
                                  if (seancesLundi.isEmpty) {
                                    return Center(
                                      child: Text("Aucune séance disponible"),
                                    );
                                  }
                                  return ListView.builder(
                                      itemCount: seancesLundi.length,
                                      itemBuilder: (context, id) {
                                        if(id==2){
                                          return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(13),
                                              height: 85,
                                              width: 200,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Repas du midi",
                                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Text(
                                                        "12:00h-14:00h",
                                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 70,
                                                            child: Divider(
                                                              thickness: 4,
                                                              color: list[id],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: 150,
                                                    child: Image.asset('lib/Enseignant/images (11).png',),
                                                  )
                                                ],
                                              ));
                                        }
                                        else{
                                          return InkWell(
                                            onTap:(){
                                              Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Presence(token: token,)));
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                margin: EdgeInsets.all(10),
                                                padding: EdgeInsets.all(13),
                                                height: 85,
                                                width: 200,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          seancesLundi[id]['matiere']['nom'],
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Text(
                                                          seancesLundi[id]['startTime'].substring(0, 5) + "h-" + seancesLundi[id]['endTime'].substring(0, 5),
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                thickness: 4,
                                                                color: list[id],
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Text(
                                                      "Salle: " + seancesLundi[id]['salle']['nom'] + " , TP2",
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                                    ),
                                                  ],
                                                )),
                                          );
                                        }
                                      });})))],
                ),
              )),
        ],
      ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:Color(0xFF012869),
          selectedItemColor: Colors.red,
          unselectedItemColor: Color(0xFF385b9f),
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.home),label: "Acceuil"),
            BottomNavigationBarItem(icon:IconButton(onPressed: (){
             // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChatUi()));
            },icon:Icon(Icons.message)),label: "chat"),
            BottomNavigationBarItem(icon:IconButton(onPressed: (){
          //    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Screen()));
            },icon:Icon(Icons.info_outline)),label: "About"),
            BottomNavigationBarItem(icon:IconButton(onPressed: (){
           //   Navigator.of(context).push(MaterialPageRoute(builder:(context)=>EditProfile(img: image, nom: nom, token: token, prenom: prenom, email: email, date_de_naissance: date_de_naissance, telephone: telephone, image: image,)));
            },icon:Icon(Icons.settings)),label: "settings"),

          ],
        ));

  }
}

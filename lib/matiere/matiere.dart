import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../pfe/pa.dart';
import 'Cours/AcceuilCours.dart';
class Matieres extends StatefulWidget {
  final String token;
  final String type;
  const Matieres({Key? key, required this.token, required this.type}) : super(key: key);
  @override
  State<Matieres> createState() => _MatieresState();
}
class _MatieresState extends State<Matieres> {
  List listimg =[
    'lib/matiere/intelligence-artificielle.png',
    'lib/matiere/algorithme.png',
    'lib/matiere/algebre.png',
    'lib/matiere/conception-graphique.png',
    'lib/matiere/python.png',
    'lib/matiere/java.png',
    'lib/Views/matieres/machine-learning (1).png',
    'lib/Views/matieres/multimedia.png',
  ];
  List listmat =[
    'Fawzi khethr',
    'Ahmed Berrich',
    'Wassef khlifa',
    'Samir benjima',
    'Mohamed Jnayh',
    'Youssef Said',
    'Cheker Yakoubi',
    'Multimedia'
  ];


  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  Future<Map<String,dynamic>> GetMatieresList()async{
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/list_matieres'),
        headers: {
          'Authorization': 'Bearer ${token}',
          'Accept': 'application/json',
        });
    var data =jsonDecode(response.body) as Map<String,dynamic>;
    if(response.statusCode==200){
      print(data);
      return data;
    }else{
      print(data);
      return data;
    }

  }

late String token;
  late String typee;
  @override
  void initState() {
    super.initState();
    GetMatieresList();
    token=widget.token;
    typee=widget.type;
    print(typee);

    setState(() {
      _streamController =  StreamController.broadcast();
      GetMatieresList();
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
        backgroundColor:Color(0xFFeef1fa),
        body: Column(
          children: [
            Container(height: 34,
              color: Colors.white,),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 50,
              color: Color(0xFF012869),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed:(){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
                  Text('Matiéres',style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,letterSpacing: 1),)
                  , IconButton(onPressed:(){}, icon: Icon(Icons.notifications,color: Colors.white,)),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF012869),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(150))
              ),
              height: 100,
              child: Center(
                  child: Container(
                    width: 280,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Semestre  1',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                        Text('Semestre 2',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )),
            ),

            Expanded(
              child: Container(
                color: Color(0xFF012869),
                child: Container(
                  padding: EdgeInsets.only(left: 10,right: 16),
                  decoration: BoxDecoration(
                      color: Color(0xFFeef1fa),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(100),)
                  ),
                  child: StreamBuilder<Map<String,dynamic>>(
                    stream: Stream.fromFuture(GetMatieresList()),
                    builder:(context,AsyncSnapshot<Map<String,dynamic>> snapshot){
                         if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Text("${snapshot.error}");
    } else {
                           var data = snapshot.data;
                           List<dynamic> matieres = snapshot.data!['matières'];
                           List<dynamic> abscence = snapshot.data!['abscence'];
                           print(abscence);
                           return  GridView.builder(
          itemCount: matieres.length,
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
          ),
          itemBuilder:(context,id){
            return GestureDetector(
              onTap:(){
                print(typee);
                Navigator.of(context).push(MaterialPageRoute(builder:(context)=>page22(ide: matieres[id]['id'],token: token, type:typee, matid:matieres[id]['id'] ,)));
              },
              child: Card(
                color: Color(0xFFf7f9fa),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // augmente la taille des coins de la carte
                ),
                elevation: 5,
                child: Center(
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child:Image.asset(listimg[id]),
                      ),
                      SizedBox(height: 10,),
                      Text(listmat[id],style:TextStyle(color: Colors.grey),),
                      SizedBox(height: 2,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(matieres[id]['nom'],style:TextStyle(fontWeight: FontWeight.w800,fontSize: 22),textAlign: TextAlign.center,),
                            SizedBox(width: 5,),
                            abscence[id]>=1? Container(
                              width: 18,
                              height: 18,
                              decoration:BoxDecoration(
                                  color: Colors.red,

                                  shape: BoxShape.circle
                              ),
                              child:Center(child: Text(abscence[id].toString(),style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                            ):Container(
                              width: 18,
                              height: 18,
                              decoration:BoxDecoration(
                                  color: Colors.blue,

                                  shape: BoxShape.circle
                              ),
                              child:Center(child: Text(abscence[id].toString(),style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
                    },
                  ),
                ),
              ),
            ),
            /*   GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
            ),
              itemCount: 10
              ,itemBuilder:(context,id){
            return Padding(
              padding: const EdgeInsets.all( 10.0),
              child: Container(
                color: Colors.red,
                height: 50,
                child:Text('dd'),
              )
            );
          },),*/
          ],
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFF012869),
        selectedItemColor: Colors.red,
        unselectedItemColor: Color(0xFF385b9f),
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: "Acceuil"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChatUi()));
          },icon:Icon(Icons.message)),label: "chat"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //   Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Screen()));
          },icon:Icon(Icons.info_outline)),label: "About"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            //Navigator.of(context).push(MaterialPageRoute(builder:(context)=>EditProfile(img: 'f', nom: nom, token: token, prenom: prenom, email: email, date_de_naissance: date_de_naissance, telephone: telephone, image: image,)));
          },icon:Icon(Icons.settings)),label: "settings"),

        ],
      ),
    );
  }
}

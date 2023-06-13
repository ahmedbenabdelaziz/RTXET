import 'dart:async';
import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:untitled62/Enseignant/EmploiEnseignant.dart';
import 'package:untitled62/adminstration/ah/RapportPfe.dart';
import 'package:untitled62/adminstration/ah/pfebbok.dart';
import 'package:untitled62/adminstration/ah/soc.dart';
import 'package:untitled62/annonce/annonce.dart';
import 'package:untitled62/chat/uichat.dart';

import '../Apropos.dart';
import '../BoiteReception/boit/BoiteAdminsApp.dart';
import '../matiere/Cours/AcceuilCours.dart';
import '../pfe/pa.dart';
import '../students/EditProfile.dart';
import 'ChatEnseignant.dart';
import 'Enseignant/admiens.dart';
class AcceuilPof extends StatefulWidget {
  final String token;
   final String nom;
   final String prenom;
   final String email;
   final String date_de_naissance;
   final String telephone;
   final String image;
   final String type;
  const AcceuilPof({Key? key, required this.token, required this.nom, required this.prenom, required this.email, required this.date_de_naissance, required this.telephone, required this.image, required this.type}) : super(key: key);

  @override
  State<AcceuilPof> createState() => _AcceuilPofState();
}

class _AcceuilPofState extends State<AcceuilPof> {

late String token;
late String type;
  Future<Map<String,dynamic>>getMatieres()async{
    http.Response response = await http.get(Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/mes_matieres'),
    headers: {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',
    }
    );
    var data = jsonDecode(response.body) as Map<String,dynamic>;
    if(response.statusCode==200){
      print(data);
     return data;
    }else{
      print(response.statusCode);
      return jsonDecode(response.body);
    }
  }
  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
late final String nom;
late final String prenom;
late final String email;
late final String date_de_naissance;
late final String telephone;
late final String image;

  bool isSelected = true;
  @override
  void initState() {
    super.initState();
     nom=widget.nom;
     prenom=widget.prenom;
     email=widget.email;
     type=widget.type;
    date_de_naissance=widget.date_de_naissance;
     telephone=widget.telephone;
     image=widget.image;
    getMatieres();
    token=widget.token;
    setState(() {
      _streamController =  StreamController.broadcast();
      getMatieres();
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
List im =[
  'lib/Enseignant/imgprof/Capture d’écran 2023-05-29 174521.png',
  'lib/Enseignant/imgprof/Capture d’écran 2023-05-29 174548.png'
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6, // Définissez la largeur souhaitée du drawer (60% de la largeur de l'écran)
              child: SizedBox(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 32,color: Colors.white,),
                    UserAccountsDrawerHeader(
                      decoration:BoxDecoration(
                        
                        color: Color(0xFF012869),
                        image: DecorationImage(
                          image:AssetImage('lib/sqsd.png'),
                          fit: BoxFit.cover,
                          
                        )
                      ),
                      accountName: Text(nom+' '+prenom),
                      accountEmail: Text(email),
                      currentAccountPicture: InkWell(
                        onTap:(){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile(img: image, nom: nom, token: token, prenom: prenom, email: email, date_de_naissance: date_de_naissance, telephone: telephone, image: image,)));
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("http://192.168.1.13/ISIMM_eCampus/storage/app/public/${image}"), // Remplacez par le chemin de votre image
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                      child: Text('Principale',style:TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                    ),
                    Card(
                      child: ListTile(
                        leading:Image.asset('lib/Enseignant/imgprof/images (10).png',height: 40,),
                        title: Text('Annonces'),
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Annonce(img: image,token: token, type: 'enseignant', nom: nom, prenom: prenom,)));
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading:Image.asset('lib/students/iconacceuil/blogger.png',height: 40,),
                        title: Text('Boite de Reception'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>admiens(userId: 'f', name: 'fd', token: token,)));
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading:Image.asset('lib/students/iconacceuil/schedule.png',height: 40,),
                        title: Text('Emploi Du Temps'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EmploiEns(id: 1, token: token,)));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                      child: Text('A Propos PFE :',style:TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                    ),
                    Card(
                      child: ListTile(
                        leading:Image.asset('lib/Enseignant/imgprof/images (9).png',height: 40,),
                        title: Text('PFE BOOK'),
                        onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>pfebook(token:token,)));
                        },
                      ),
                    ),
                    Card(
                      color: Colors.blue,
                      child: ListTile(
                        leading:Image.asset('lib/students/iconacceuil/report.png',height: 40,),
                        title: Text('Rapport PFE'),

                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>rappfebook(token: token,)));
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading:Image.asset('lib/students/iconacceuil/buildings.png',height: 40,),
                        title: Text('Societes'),
                        onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>societtttttttttt(token: token,)));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                      child: Text('Autre :',style:TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                    ),
                    Card(
                      child: ListTile(
                        leading: Image.asset('lib/Enseignant/imgprof/Capture d’écran 2023-05-28 190421.png',height: 40,),
                        title: Text('A Propos'),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen()));
                          },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Déconnexion'),
                        onTap: () {
                          // Action pour la déconnexion
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar:AppBar(
        backgroundColor: Color(0xFF012869),
        elevation: 0,

        actions: [
          Container(
            height: 50,
            margin: EdgeInsets.only(right: 5),
            width: 50,
            decoration:BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
            ),
            child: Stack(
              children: [
                Positioned(
                    top: 1,
                    left: 1,
                    right:1,
                    bottom:1,
                    child:CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage("http://192.168.1.13/ISIMM_eCampus/storage/app/public/${image}"), // Remplacez par le chemin de votre image
                      child:InkWell(
                        onTapDown: (TapDownDetails details) {
                          showMenu(
                            color:Colors.white,
                            context: context,
                            position: RelativeRect.fromLTRB(
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                              details.globalPosition.dx,
                              details.globalPosition.dy,
                            ),
                            items: [
                              PopupMenuItem(
                                child: Text('Edit Profile',style:TextStyle(color: Colors.black),),
                                value: 'edit',
                              ),
                              PopupMenuItem(
                                child: Text('Déconnexion'),
                                value: 'logout',
                              ),
                            ],
                            elevation: 8.0,
                          ).then((value) {
                            if (value == 'edit') {
                              // Action pour l'option "Edit"
                            } else if (value == 'logout') {
                              // Action pour l'option "Déconnexion"
                            }
                          });
                        },
                      ),
                    )

                ),

              ],
            ),
          ),

        ],
      ),
        body:Column(
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF012869),Color(0xFF012869),]
                  )
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bienvenue ',style: TextStyle(color: Colors.white,fontSize: 20),),
                            Text(nom+" "+prenom+' ...',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child:DatePicker(
                        DateTime.now(),
                        height: 80,
                        initialSelectedDate:DateTime.now(),
                        dateTextStyle:TextStyle(fontWeight: FontWeight.bold,fontSize:25),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 20),
              height: 150,
              color: Color(0xFFfffeff),
              child: Center(
                child: Container(
                  height: 60,
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
                    color: Colors.white,
                  ),
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintText: "Recherche.."
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 50,
              color: Color(0xFFfffeff),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Matières',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                  TextButton(onPressed:(){},child:Text('Voir toutes les matières',style:TextStyle(fontSize: 15,color: Color(0xFFbab1d9))),
                  )],
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0,top: 10,left: 5),
                  child: StreamBuilder<Map<String,dynamic>>(
                    stream:Stream.fromFuture(getMatieres()),
                    builder: (context, snapshot) {

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      else if(snapshot.data!['message']=="Les matieres sont en cours de traitement"){
                        return Center(child: Text('Les matieres sont en cours de traitement'));
                      }
                      else {
                        var matieres = snapshot.data!['matieres'];

                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.5,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:matieres.length,itemBuilder:(context,id){
                        return  InkWell(
                          onTap:(){
                            print(matieres[id]['id']);
                           Navigator.push(context,MaterialPageRoute(builder:(context)=>page22(ide: matieres[id]['id'], token: token, type:type, matid: matieres[id]['id'],)));
                          },
                          child: GestureDetector(
                            child: Container(
                                margin: EdgeInsets.only(bottom: 20,left: 10),
                                padding: EdgeInsets.only(top: 20,),
                                height: 200,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 3,
                                          blurRadius: 10,
                                          offset: Offset(8,8)
                                      ),
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(-2,-2)
                                      ),
                                    ]
                                ),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      child: Text(matieres[id]['nom'],style:TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                        height: 250,
                                        child: Image.asset(im[id],fit: BoxFit.cover,))
                                  ],
                                )
                            ),
                          ),
                        );

                      });}
                    }
                  ),
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
    BottomNavigationBarItem(icon:Icon(Icons.home),label: "Acceuil"),
    BottomNavigationBarItem(icon:IconButton(onPressed: (){
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChatUi(token: token, image:image,)));
    },icon:Icon(Icons.message)),label: "chat"),
    BottomNavigationBarItem(icon:IconButton(onPressed: (){
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Screen()));
    },icon:Icon(Icons.info_outline)),label: "About"),
    BottomNavigationBarItem(icon:IconButton(onPressed: (){
    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>EditProfile(img: image, nom: nom, token: token, prenom: prenom, email: email, date_de_naissance: date_de_naissance, telephone: telephone, image: image,)));
    },icon:Icon(Icons.settings)),label: "settings"),

    ],
    ));
  }
}

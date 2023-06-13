import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:untitled62/Apropos.dart';
import 'package:untitled62/annonce/annonce.dart';

import '../BoiteReception/Etudient/BoiteReceptionEtudient.dart';
import '../BoiteReception/boit/BoiteAdminsApp.dart';
import '../Emploi/Emploi.dart';
import '../Enseignant/ChatEnseignant.dart';
import '../Enseignant/Enseignant/admiens.dart';
import '../Enseignant/Enseignant/boiteetudiant.dart';
import '../ResultatEtudiant/DateExamen.dart';
import '../ResultatEtudiant/resultatExam.dart';
import '../adminstration/ah/RapportPfe.dart';
import '../adminstration/ah/pfebbok.dart';
import '../adminstration/ah/soc.dart';
import '../chat/uichat.dart';
import '../chat/uichatetudiantt.dart';
import '../matiere/matiere.dart';
import 'EditProfile.dart';
class AcceilEtudiant extends StatefulWidget {
  final String nom;
  final String prenom;
  final String email;
  final String date_de_naissance;
  final String telephone;
  final String image;
   final String token;
   final String type;
  const AcceilEtudiant({Key? key, required this.nom, required this.prenom, required this.email, required this.date_de_naissance, required this.telephone, required this.image, required this.token, required this.type}) : super(key: key);

  @override
  State<AcceilEtudiant> createState() => _AcceilEtudiantState();
}

class _AcceilEtudiantState extends State<AcceilEtudiant> {
  late final String nom;
  late final String token;
  late final String prenom;
  late final String email;
  late final String date_de_naissance;
  late final String telephone;
  late final String image;
  late final String type;
  @override
  void initState() {
   nom=widget.nom;
  prenom=widget.prenom;
    email=widget.email;
   date_de_naissance=widget.date_de_naissance;
    telephone=widget.telephone;
     image=widget.image;
     token=widget.token;
     type=widget.type;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              height: 32,
            ),
            Container(
              height:830,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF012869)
              ),
              child:Stack(
                children: [
                  Positioned(
                  top: 250
                  ,child:Container(color: Color(0xFFf7f7f7),
                  height: 578,
                  width:393,)),
                  Positioned(
                    top: 210,
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          height: 70,
                          width:335,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow:[
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset:Offset(1,1)
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset:Offset(-1,-1)
                              )
                            ]
                          ),
                          child:Center(
                            child: TextFormField(
                              decoration:InputDecoration(
                                prefixIcon:Icon(Icons.search),
                                hintText:"Rechercher des cours...",
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text('Bienvenue',style:TextStyle(fontSize: 25,fontWeight: FontWeight.w400),),
                      SizedBox(height: 10,),
                    ],
                  ),
                      )),
                  Positioned(
                  child:Container(color: Colors.white,
                  height: 32,
                  width: 392,)),
                  Positioned(
                  top: 100,
                  height: 100,
                  width: 380
                  ,child:  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:DatePicker(
                      DateTime.now(),
                      selectedTextColor: Colors.white,
                      selectionColor: Colors.white.withOpacity(.1),
                      height: 100,
                      initialSelectedDate:DateTime.now(),
                      dateTextStyle:TextStyle(fontWeight: FontWeight.bold,fontSize:25),
                    ),
                  )),
                  Positioned(
                      top: 32
                      ,child:Container(padding: EdgeInsets.only(right: 3,top: 10,left: 12),
                    width: 392,
                    height: 80,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bienvenue',style:TextStyle(color:Colors.white,fontSize: 20),),
                            Text(nom+" "+prenom+"...",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                          ],
                        ),
                        Container(
                          height: 50,
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
                                  radius: 20,
                                  backgroundImage: NetworkImage("http://192.168.1.13/ISIMM_eCampus/storage/app/public/${image}"),
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
                  ),
                  ),
                  Positioned(
                    top: 345,
                    left: 15,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: Color(0xFFf7f7f7),
                        width: 370,
                        height: 470,
                        child:ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context,MaterialPageRoute(builder:(context)=>Matieres(token: token, type:type,)));
                                  }
                                  ,
                                  child: Container(
                                    height: 140,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(1,1)
                                          ),
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(-1,-1)
                                          )
                                        ]
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child:Image.asset('lib/students/iconacceuil/book.png'),
                                        ),
                                        SizedBox(height:15,),
                                        Text('Matiéres',style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>Emploi(token:token,)));
                                  }
                                  ,
                                  child: Container(
                                    height: 140,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(1,1)
                                          ),
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(-1,-1)
                                          )
                                        ]
                                    ),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child:Image.asset('lib/students/iconacceuil/schedule.png'),
                                        ),
                                        SizedBox(height:10,),
                                        Text('Emploi',style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>DateEX(token: token)));
                                  }
                                  , child: Container(
                                  height: 140,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow:[
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset:Offset(1,1)
                                        ),
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset:Offset(-1,-1)
                                        )
                                      ]
                                  ),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 25,
                                        child:Image.asset('lib/students/3301545.png'),
                                      ),
                                      SizedBox(height:10,),
                                      Text('Horaire Examen',textAlign: TextAlign.center,style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                    ],
                                  ),
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>resulEtudi(token:token,)));
                                  },
                                  child: Container(
                                    height: 140,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(1,1)
                                          ),
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(-1,-1)
                                          )
                                        ]
                                    ),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child:Image.asset('lib/students/iconacceuil/result (1).png'),
                                        ),
                                        SizedBox(height:10,),
                                        Text('Résultats',style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>Annonce(img: image, token:token, type: "student", nom: nom, prenom: prenom,)));
                                  }
                                  , child: Container(
                                  height: 140,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow:[
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset:Offset(1,1)
                                        ),
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset:Offset(-1,-1)
                                        )
                                      ]
                                  ),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 25,
                                        child:Image.asset('lib/students/iconacceuil/images (10).png'),
                                      ),
                                      SizedBox(height:10,),
                                      Text('Annonces',textAlign: TextAlign.center,style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                    ],
                                  ),
                                ),
                                ),

                                InkWell(
                                  onTap:(){
                                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>admietud(userId: 'f', name: 'f', token: token,)));
                                  },
                                  child: Container(
                                    height: 140,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(1,1)
                                          ),
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(-1,-1)
                                          )
                                        ]
                                    ),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child:Image.asset('lib/students/iconacceuil/blogger.png'),
                                        ),
                                        SizedBox(height:10,),
                                        Text('Boite de Reception',textAlign: TextAlign.center,style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                      ],
                                    ),
                                  ),
                                ),
                                /*                                GestureDetector(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>Screen()));
                                  }
                                 , child: Container(
                                    height: 140,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(1,1)
                                          ),
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(-1,-1)
                                          )
                                        ]
                                    ),
                                    child:Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child:Image.asset('lib/students/iconacceuil/info.png'),
                                        ),
                                        SizedBox(height:10,),
                                        Text('A propos',textAlign: TextAlign.center,style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                      ],
                                    ),
                                  ),
                                )*/
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>societtttttttttt(token:token,)));
                                  },
                                  child: Container(
                                    height: 140,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(1,1)
                                          ),
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(-1,-1)
                                          )
                                        ]
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child:Image.asset('lib/students/iconacceuil/buildings.png'),
                                        ),
                                        SizedBox(height:10,),
                                        Text('STAGE',textAlign: TextAlign.center,style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>rappfebook(token:token,)));
                                  },
                                  child: Container(
                                    height: 140,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(1,1)
                                          ),
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(-1,-1)
                                          )
                                        ]
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child:Image.asset('lib/students/iconacceuil/report.png'),
                                        ),
                                        SizedBox(height:10,),
                                        Text('Rapport PFE',textAlign: TextAlign.center,style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder:(context)=>pfebook(token:token,)));
                                  },
                                  child: Container(
                                    height: 140,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(1,1)
                                          ),
                                          BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              spreadRadius: 0,
                                              blurRadius: 5,
                                              offset:Offset(-1,-1)
                                          )
                                        ]
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 25,
                                          child:Image.asset('lib/students/iconacceuil/graduated.png'),
                                        ),
                                        SizedBox(height:10,),
                                        Text('PFE Book',textAlign: TextAlign.center,style:TextStyle(fontSize:17,fontWeight: FontWeight.bold,),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 80,),

                          ],
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFF012869),
        selectedItemColor: Colors.red,
        unselectedItemColor: Color(0xFF385b9f),
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),label: "Acceuil"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChatUiet(token:token, image: image,)));
          },icon:Icon(Icons.message)),label: "chat"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>ChatUiEnse(image: 'yt',)));
          },icon:Icon(Icons.info_outline)),label: "About"),
          BottomNavigationBarItem(icon:IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder:(context)=>EditProfile(img: 'f', nom: nom, token: token, prenom: prenom, email: email, date_de_naissance: date_de_naissance, telephone: telephone, image: image,)));
          },icon:Icon(Icons.settings)),label: "settings"),

        ],
      ),

    );
  }
}

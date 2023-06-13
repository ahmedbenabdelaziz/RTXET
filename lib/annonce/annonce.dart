import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:untitled62/annonce/ApiAnnonce.dart';
import 'package:untitled62/annonce/ApiAnnonceEtudiant.dart';
class Annonce extends StatefulWidget {
  final String token;
  final String type;
  final String img;
  final String nom;
  final String prenom;

  const Annonce({Key? key, required this.img, required this.token, required this.type, required this.nom, required this.prenom}) : super(key: key);

  @override
  State<Annonce> createState() => _AnnonceState();
}
class _AnnonceState extends State<Annonce> {
  late String image;
  late String nom;
  late String prenom;

  late String type;
  TextEditingController annonce = TextEditingController();
  TextEditingController textannonce = TextEditingController();

  StreamController<Map<String, dynamic>> _streamController =
  StreamController.broadcast();

  ApiAnnonce com = ApiAnnonce();

  String? im;
  String? a;

  Future<Map<String, dynamic>> getAnnonce() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',
    };

    HttpClient client = new HttpClient()
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/annonces'),
      headers: headers,
    );

    var data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      _streamController.add(data); // Mettre à jour le flux de données avec les modifications
      return data;
    } else {
      return data;
    }
  }


  void PickFile() async {
    final data = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg']);
    if (data != null) {
      setState(() {
        im = data.files.single.path!;
        a = (im != null ? im!.substring(im!.lastIndexOf("/") + 1) : null)!;
        print(a);
      });
    }
  }

   String? token;
  late String imagee;

  @override
  void initState() {
    getAnnonce();
    token = widget.token;
    type=widget.type;
    nom=widget.nom;
    prenom=widget.prenom;
    print(token);
    imagee = widget.img;
    super.initState();
    updateAnnoncesStream();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
  List<dynamic> annonces = [];
  void updateAnnoncesStream() async {
    Map<String, dynamic> annonceData = await getAnnonce();
    annonces = annonceData['annonces'];
    _streamController.add(annonceData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 32,color: Colors.white,),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xFF012869),
            ),
            child: Row(
              children: [
                IconButton(onPressed:(){
                  Navigator.pop(context);
                }, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                Text('Annonces',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 80,
            color: Colors.white,
            child:Row(
              children: [
                CircleAvatar(
                  radius: 25,
                 backgroundImage:NetworkImage("http://192.168.1.13/ISIMM_eCampus/storage/app/public/${imagee}"),
                ),
                SizedBox(width: 7,),
                Container(
                  height: 40,
                  width: 270,
                  decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                  ),
                  ),
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
                    child: GestureDetector(
                    onTap:(){
                      showDialog(context:context, builder:(context){
                        return AlertDialog(
                          content:SizedBox(
                            height: 350,
                            width: 400,
                            child: Column(
                              children: [
                                Text('Publier une Annonce',style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF012869),),),
                                SizedBox(height: 5,),
                               TextFormField(
                                  controller: textannonce,
                                  maxLines: 10,
                                  decoration:InputDecoration(
                                    hintText: "publier quellque chose ...",
                                    hintStyle:TextStyle(color: Color(0xFF012869),),
                                    border:OutlineInputBorder(
                                      borderSide: BorderSide(

                                      )
                                    )
                                  ),
                                ),
                                Container(
                                  child:Row(
                                    children: [
                                        TextButton(onPressed:(){
                                        PickFile();
                                        }, child:Text('Ajouter une image',style: TextStyle(color: Color(0xFF012869),),)),
                                      IconButton(onPressed:(){
                                        PickFile();
                                      }, icon:Icon(Icons.picture_as_pdf,color: Colors.green,size: 30,))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                width: 400
                                ,child: ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF012869),
                                    )
                                    ,onPressed: () {
                                  setState(() {
                                    if (im == null) {
                                      com.postAnnonce(textannonce.text, null, token);
                                    } else {
                                      com.postAnnonce(textannonce.text, im!, token);
                                    }

                                    // Pas besoin d'appeler getAnnonce() ici

                                    Navigator.pop(context, null);
                                  });

                                },

                                    child:Text('Publier')))
                              ],
                            ),
                          ),
                        );
                      });
                    }
                    ,
                        child: Text('Publier quelleque chose...'),
                    ),
                  ),
                ),
                SizedBox(width: 11,),
                Icon(Icons.picture_as_pdf,color: Colors.green,size: 22,)
              ],
            ),
          ),
          Divider(
            thickness: 5,
          ),
    Expanded(
    child: Container(
    color: Colors.white,
    child: StreamBuilder<Map<String, dynamic>>(
        stream:  _streamController.stream,
    builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {


          if (!snapshot.hasData) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      } else {
            var  data = snapshot.data!;
            List<dynamic> annonces = snapshot.data!['annonces'];
            List<dynamic> proprietaires = snapshot.data!['proprietaires'];
            List<dynamic> soutitre = snapshot.data!['soutitre'];
            print(soutitre);
        return ListView.builder(
            itemCount: proprietaires.length,
            itemBuilder: (context, id) {
            //  final formattedDate =  DateFormat('MMM dd, yyyy HH:mm').format(dateTime);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0,top:10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                          if (proprietaires[id]['image']!=null) CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:NetworkImage("http://192.168.1.13/ISIMM_eCampus/storage/app/public/${proprietaires[id]['image']}"),
                            ) ,
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(proprietaires[id]['nom']+' ${proprietaires[id]['prenom']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                SizedBox(height: 3,),
                                Text(soutitre[id]['nom'],style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.5)),),

                              ],
                            ),
                          ],
                        ),
                           nom+prenom== proprietaires[id]['nom']+proprietaires[id]['prenom']?PopupMenuButton(
                            child: Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) =>
                            [
                              PopupMenuItem(
                                  value: 'modifier', child: Text('Modifier')),
                              PopupMenuItem(
                                  value: 'supprimer', child: Text('Supprimer')),
                            ],
                            onSelected: (value) {
                              if (value == 'supprimer') {
                                setState(() {
                                  com.deleteAnnouncement(annonces[id]['id'],'${token}');
                                  getAnnonce();
                                });
                              } else if (value == 'modifier') {
                                final tita = TextEditingController(
                                    text: annonces[id]['description']);
                                showDialog(context:context, builder:(context){
                                  return AlertDialog(
                                    content:SizedBox(
                                      height: 350,
                                      width: 400,
                                      child: Column(
                                        children: [
                                          Text('Publier une Annonce',style:TextStyle(fontWeight: FontWeight.bold),),
                                          SizedBox(height: 5,),
                                          Divider(
                                            thickness: 2,
                                          ),
                                          TextFormField(
                                            controller: tita,
                                            maxLines: 10,
                                            decoration:InputDecoration(
                                            ),
                                          ),
                                          Container(
                                            child:Row(
                                              children: [
                                                TextButton(onPressed:(){
                                                  PickFile();
                                                }, child:Text("Modifier l'image")),
                                                IconButton(onPressed:(){}, icon:Icon(Icons.picture_as_pdf,color: Colors.green,size: 30,))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              width: 400
                                              ,child: ElevatedButton(onPressed:(){
                                            setState(() {
                                              com.UpdateAnnonce(tita.text,annonces[id]['id'],'${token}');
                                              getAnnonce();
                                              Navigator.pop(context,null);
                                            });
                                          }, child:Text('Modifier')))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              }
                            },
                          ):Text(''),
                        

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, left: 20, right:5, bottom: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ExpandableText(
                        annonces[id]['description'],
                        textAlign: TextAlign.left,
                        expandText: 'Read More',
                        maxLines: 4,
                        linkColor: Colors.blue,
                        style: TextStyle(fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.4),
                      ),
                    ),
                  ), 
                  annonces[id]['image']!=null?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.network("https://192.168.1.13/ISIMM_eCampus/storage/app/public/${annonces[id]['image']}"),
              ):Text(' '),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Divider(
              thickness: 2,
              ),
              ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('4 hours ,12 minutes ago',
                          style: TextStyle(color: Colors.grey),)
                        , Row(
                          children: [
                            Text(annonces[id]['likes_count'].toString(), style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),),
                            IconButton(onPressed: () {
                              print(annonces[id]['id']);
                              setState(() {
                                com.LikeAnnonce(annonces[id]['id'],token);
                                getAnnonce();
                              });
                            },
                                icon: Icon(Icons.thumb_up, color: Colors.blue,)),
                            Text(annonces[id]['deslikes_count'].toString(), style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),),
                            IconButton(onPressed: () {
                              print("dislike");
                              print(annonces[id]['id']);
                              print("dislike");
                              setState(() {
                                com.DisLikeAnnonce(annonces[id]['id'],token);
                                getAnnonce();
                              });
                            },
                                icon: Icon(
                                  Icons.thumb_down, color: Colors.blue,))

                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 7,
                    color: Colors.black.withOpacity(0.2),
                  )
                ],
              );
            });
      }
    }),
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

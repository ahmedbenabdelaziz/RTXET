import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'ApiCou/Api/ApiCours.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'Td.dart';
class cours extends StatefulWidget {
  final String type;
  final int ide;
  final int matiereid;
  final String token;
  const cours( {Key? key, required this.ide, required this.token, required this.type, required this.matiereid,}) : super(key: key);

  @override
  State<cours> createState() => _coursState();
}

class _coursState extends State<cours> {
  late int idee;
  String filecours=" ";
  String filecour=" ";
  PickCours()async{
    final fil =await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf','jpg','png']
    );
    if(fil!=null){
      setState(() {
        filecours=fil.files.single.path!;
        filecour = (filecours != null ? filecours.substring(filecours.lastIndexOf("/") + 1) : null)!;
        print(filecour);
        print('00');
      });
    }
  }
  TextEditingController descchapitre=TextEditingController();
  TextEditingController nomchap=TextEditingController();
  TextEditingController titre=TextEditingController();
  TextEditingController description=TextEditingController();
  TextEditingController cmntr=TextEditingController();
  Cours c = new Cours();
  late StreamController<List<dynamic>> _streamController ;
  late Stream<List<dynamic>> stream;
late String token;
late int matid;
late String type="enseignant";
@override
  void initState() {
    idee=widget.ide;
     type ="enseignant";
     matid=widget.matiereid;
    type =widget.type;
    token=widget.token;
    GetCours(token);
    super.initState();
  }
  Future<Map<String, dynamic>>  GetCours(token) async {
    http.Response response = await http.get(Uri.parse("http://192.168.1.13/ISIMM_eCampus/public/api/cours?matiere_id=${matid}&classe_id=1"),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }
    );
    var data = jsonDecode(response.body) as  Map<String, dynamic> ;
    if (response.statusCode == 200) {
      print(data);
      return data;
    } else {
      print(response.statusCode);
      print(data);
      return data;
      //  _streamController.add(data.reversed.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10,left:10,top: 60),
            height:300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF012869),Color(0xFF012869),
                    ]
                )
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed:(){
                                  Navigator.pop(context);
                                }, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                                Text('Espace Cours',style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(width: 150,),
                            Icon(Icons.notifications,color: Colors.white,)
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.08)
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search,color: Colors.white,)
                                ,
                                border: InputBorder.none
                                ,
                                hintText: "Search Cours ...",
                                hintStyle:TextStyle(
                                    color: Colors.white
                                )
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('lib/matiere/Cours/image/1362248.png',fit: BoxFit.contain,),
                            )),
                        SizedBox(height: 10,),
                        TextButton(
                            onPressed:(){
                              Navigator.push(context,MaterialPageRoute(builder:(context)=>TD(id: idee, token:token, matid: matid, type: type,)));
                            }
                            ,child: Text('TD',style:TextStyle(color:Color(0xFFc2daee),fontWeight: FontWeight.bold,fontSize: 20),))
                      ],
                    ),
                    SizedBox(width: 10,),
                    SizedBox(width: 10,),
                    Column(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('lib/matiere/Cours/image/760205.png',fit: BoxFit.contain,),
                            )),
                        SizedBox(height: 10,),
                        TextButton(
                            onPressed:(){}
                            ,child: Text('Examen',style:TextStyle(color:Color(0xFFc2daee),fontWeight: FontWeight.bold,fontSize: 20),))
                      ],
                    ),
                    SizedBox(width: 8,),
                    Column(
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('lib/matiere/Cours/image/1263925.png',fit: BoxFit.contain,),
                            )),
                        SizedBox(height: 10,),
                        TextButton(
                            onPressed:(){}
                            ,child: Text('Other Files',style:TextStyle(color:Color(0xFFc2daee),fontWeight: FontWeight.bold,fontSize: 20),))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(child:Container(
            padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:
            StreamBuilder<Map<String,dynamic>>(
              stream:Stream.fromFuture(GetCours(token)),
              builder:(context,AsyncSnapshot <Map<String,dynamic>> Snapshot) {
    if (!Snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    } else if (Snapshot.data!['message']=="Cours vide pour le moment") {
    return Center(child: Text("Cours vide pour le moment"));
    } else {
                List<dynamic> cours = Snapshot.data!['cours'];

                print(cours);
                return ListView.builder(
                scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: cours.length
            ,itemBuilder:(context,id){
            return Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [
            Colors.grey.withOpacity(0.07),
            Colors.grey.withOpacity(0.09),
            ]
            ),
            borderRadius: BorderRadius.circular(10)
            ),
            child: ListTile(
            leading:CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Image.asset('lib/matiere/Cours/image/format-de-fichier-pdf.png')),
            subtitle: Text(cours[id]['titre']),
            title:Text(cours[id]['description'],style:TextStyle(fontWeight: FontWeight.bold),),
            trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             type=="enseignant"? PopupMenuButton(itemBuilder: (BuildContext context)=>[
                PopupMenuItem(value: 'modifier', child: Text('Modifier')),
                PopupMenuItem(value: 'supprimer', child: Text('Supprimer')),
              ],
                onSelected:(value){
                  if(value=='supprimer'){
                    setState(() {
                      c.DeleteCours(cours[id]['id'],token,matid);
                      GetCours(token);
                    });
                  }else if (value=='modifier'){
                    print('modifier');
                 var titmod= TextEditingController(text:cours[id]['titre']);
               var descmod= TextEditingController(text:cours[id]['description']);
                    showDialog(context: context, builder:(context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        content: Container(
                          height: 350,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text('Commentaire',style:TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(height: 20,),
                              TextFormField(
                                controller:titmod,
                                decoration: InputDecoration(
                                  hintText: "Titre",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.deepPurple),
                                  ),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.deepPurple),

                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              TextFormField(
                                controller: descmod,
                                maxLines: 7,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.deepPurple),
                                  ),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.deepPurple),

                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              ElevatedButton(onPressed:(){
                                print(titmod.text);
                                print(descmod.text);
                                setState(() {
                                  c.UpdateCours(titmod.text, descmod.text ,cours[id]['id'],token,matid);
                                  GetCours(token);
                                });
                              //  titmod.text, descmod.text,cours[id]['id']
                                Navigator.of(context).pop(null);
                              }, child: Text('Modifier'),)
                            ],
                          ),
                        ),
                      );
                    } );

                  }
                },
              ):Text(''),
            SizedBox(width: 10,),
            CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.05),
            radius: 10,
            child: IconButton(icon:Icon(Icons.download),onPressed:(){
              c.downloadFile(cours[id]['file'].substring(0, cours[id]['file'].length - 4));
              print(cours[id]['file'].substring(0, cours[id]['file'].length - 4));
            },),
            )
            ],
            ),
            ),
            );
            });}
            }
            ),
          ))
        ],
      ),
      floatingActionButton: Visibility(
        visible: type=="enseignant",
        child: CircleAvatar(
          backgroundColor: Color(0xFF012869),
          child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        height: 400,
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Titre d'Cours"),
                            SizedBox(height: 5,),
                            TextFormField(
                              controller: description,
                              decoration: InputDecoration(
                                  hintText: ("nom d'Cours...")
                              ),
                            ),
                            SizedBox(height: 30,),
                            Text("Description d'Cours"),
                            SizedBox(height: 5,),
                            TextFormField(
                              controller: titre,
                              decoration: InputDecoration(
                                  hintText: ("Description d'Cours...")
                              ),
                            ),
                            SizedBox(height: 5,),
                            TextButton(
                                onPressed: () {
                                  PickCours();
                                },
                                child: Text('Téléverser Cours')
                            ),
                            SizedBox(height: 5,),
                            Text(filecour ?? ''),
                            SizedBox(height: 30,),
                            ElevatedButton(
                              onPressed: () {
                                c.PostCours( description.text,titre.text,
                                    File(filecours),matid, token,);
                                GetCours(token);
                                Navigator.of(context).pop(null);
                              },
                              child: Center(
                                  child: Text('Ajouter Examen')
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });}
           ,
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        ),
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

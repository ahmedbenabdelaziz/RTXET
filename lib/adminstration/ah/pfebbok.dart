import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:untitled62/adminstration/Api/ApiPfebbok.dart';
import 'package:untitled62/adminstration/Api/ApiRapport.dart';
class pfebook extends StatefulWidget {
  final String token;
  const pfebook({Key? key, required this.token}) : super(key: key);

  @override
  State<pfebook> createState() => _pfebookState();
}

class _pfebookState extends State<pfebook> {
  late var im;
  late String a;
  void pickFile() async {
    final data = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (data != null) {
      setState(() {
        im = File(data.files.single.path!);
        a = (im != null ? im.path.split('/').last : null)!;
        print(a);
      });
    }
  }
late String token;
  List<Color> list =[
    Color(0xFFe4fce6),
    Color(0xFFfff5ef),
    Color(0xFFe8ecf8),
    Color(0xFFefefef),

    Color(0xFFeeebff),
    Color(0xFFe4fce6),
    Color(0xFFfff5ef),
    Color(0xFFe8ecf8),
    Color(0xFFefefef),
    Color(0xFFeeebff),
    Color(0xFFe4fce6),
    Color(0xFFfff5ef),
    Color(0xFFe8ecf8),
    Color(0xFFefefef),
    Color(0xFFeeebff),
    Color(0xFFe4fce6),
    Color(0xFFfff5ef),
    Color(0xFFe8ecf8),
    Color(0xFFefefef),
  ];
  ApiPfeBook com = ApiPfeBook();
  late TextEditingController titre;
  late TextEditingController de;

  late TextEditingController desc;
  late TextEditingController desccrep;

  late TextEditingController id;
  late TextEditingController annee;
  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  Future<Map<String, dynamic>> getSoc() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',

    };

    HttpClient client = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    final response = await http.get(
      Uri.parse('https://192.168.1.13/ISIMM_eCampus/public/api/pfeBooks'),
      headers: headers,
    );
    var data = jsonDecode(response.body) as Map<String,dynamic>;
    if (response.statusCode == 200) {
      print('z');
      print(data);
      return data;
    } else {
      print(data);

      return data;
    }
  }

  @override
  void initState() {
    getSoc();
    token=widget.token;
    super.initState();
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
      body:Column(
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
                IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                Text('Espace PFE BOOK',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),
              ],
            ),
          ),
          Expanded(child:Container(
            color: Colors.grey.withOpacity(0.01),
            child: StreamBuilder<Map<String,dynamic>>(
                stream: Stream.fromFuture(getSoc()),
                builder: (context, snapshot) { if (!snapshot.hasData) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.data!['message']=="pas de PFE Book pour le moment") {
    return Center(child: Text("pas de PFE Book pour le moment"));
    } else {
                  List<dynamic> la = snapshot.data!['rapports'];
                  return ListView.builder(
                      itemCount: la.length
                      , itemBuilder:(context,id){
                    return Container(
                      padding: EdgeInsets.all(12),
                      height: 300,
                      margin: EdgeInsets.only(left: 20,bottom: 20,right: 20),
                      decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset:Offset(4,4)
                            ),
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset:Offset(-4,-4)
                            )
                          ]
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('lib/adminstration/imagePFEBOOK/téléchargement (7).png',height: 60,),
                              Expanded(child: Container()),
                              Container(
                                width: 60,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFe8f9f9),
                                ),
                                child:Center(
                                  child:Text('Done',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
                                ),
                              ),
                              PopupMenuButton(
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
                                      showDialog(context:context, builder:(context){
                                        return AlertDialog(
                                          content:Container(
                                            width: 380,
                                            height: 170,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Voulez-vous vraiment supprimer ce PFE BOOK ?",style:TextStyle(fontWeight: FontWeight.w600,color:Color(0xFF012869)),),
                                                SizedBox(height: 15,),
                                                Text("Attention ! Tout le contenu et les donneés du ce fichier seront définitivement perdus.",style:TextStyle(color: Colors.grey),),
                                                SizedBox(height: 15,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: 110,
                                                        height: 38
                                                        ,child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:Colors.red,
                                                            shape:RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10)
                                                            )
                                                        )
                                                        ,onPressed:(){
                                                      Navigator.pop(context,null);
                                                    }, child:Text('Cancel',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),
                                                    SizedBox(width: 10,),
                                                    SizedBox(
                                                        width: 110,
                                                        height: 38
                                                        ,child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:Color(0xFF012869),
                                                            shape:RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10)
                                                            )
                                                        )
                                                        ,onPressed:(){
                                                      setState(() {
                                                        com.deletepfebook(la[id]['id'],token);
                                                        getSoc();
                                                        Navigator.pop(context,null);
                                                      });
                                                    }, child:Text('Supprimer',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });

                                    });
                                  } else if (value == 'modifier') {
                                    setState(() {
                                      //     showModificationDialog = true;
                                    });
                                    final tita = TextEditingController(
                                        text: "f");
                                    showDialog(context:context,
                                      builder:(context){
                                        return AlertDialog(
                                          content:Container(
                                            height:400,
                                            width: 300,
                                            child:Column(
                                              children: [
                                                Text('Modifier PFE BOOK',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Color(0xFF012869),
                                                ),)
                                                ,SizedBox(height: 30,),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10),
                                                  child: TextFormField(
                                                    controller:titre=  TextEditingController(
                                                    text: la[id]['titre']),
                                                    decoration: InputDecoration(
                                                  labelText: 'Titre',
                                                  labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                  border: OutlineInputBorder(),
                                                  helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    width: 300,
                                                    padding: EdgeInsets.only(bottom: 10)
                                                    ,child:TextFormField(
                                                  maxLines: 8,
                                                  controller:  desc= TextEditingController(
                                                      text: la[id]['description']),
                                                  decoration: InputDecoration(
                                                    labelText: 'Description',
                                                    labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                    border: OutlineInputBorder(),
                                                    helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                  ),
                                                )
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10),
                                                  child: TextFormField(
                                                    controller:  TextEditingController(
                                                    text:la[id]['created_at'].substring(0,10)),
                                                    decoration: InputDecoration(
                                                  labelText: "annee",
                                                  labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                  border: OutlineInputBorder(),
                                                  helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        width: 110,
                                                        height: 38
                                                        ,child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor:Colors.red,
                                                            shape:RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(10)
                                                            )
                                                        )
                                                        ,onPressed:(){
                                                      Navigator.pop(context,null);
                                                    }, child:Text('Cancel',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),))),
                                                    SizedBox(width: 10,),
                                                    SizedBox(
                                                        width: 110,
                                                        height: 38
                                                        ,child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor:Color(0xFF012869),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          // print(rapport[id]['id']);
                                                          com.UpdatePfeBook(titre.text, desc.text, la[id]['id'],token);
                                                          Navigator.pop(context, null);
                                                          getSoc();
                                                        });
                                                      },
                                                      child: Text(
                                                        'Modifier',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                    ),

                                                  ],
                                                )

                                              ],
                                            ),
                                          ),
                                        );
                                      },

                                    );    }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 9,),
                          Text(la[id]['titre'],style:TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 2,),
                          SizedBox(
                            width: 25,
                            child: Divider(
                              thickness: 1,
                              color: Colors.green,
                            ),
                          ),
                          Expanded(child: Text(la[id]['description'],style:TextStyle(color: Colors.black.withOpacity(0.8)),)),
                          Divider(thickness: 5,color:list[id],),
                          SizedBox(height: 2,),
                          Row(
                            children: [
                              Image.asset('lib/adminstration/img/calendrier.png',height: 15,),
                              SizedBox(width: 5,),
                              Text(la[id]['created_at'].substring(0,10),style:TextStyle(fontSize: 12),),
                              Expanded(child: Container()),
                              TextButton(
                                onPressed: () {},
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      'Download',
                                      style: TextStyle(),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: 1,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  });}
                }
            ),
          ))


        ],
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor:Color(0xFF3b4790),
        child: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      height: 500,
                      width: 200,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          Center(child:Text('Ajouter Rapport PFE BOOK',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color(0xFF012869),),),),
                          SizedBox(height: 20,),
                          Text("Titre Sociéte :",style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF012869)),),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: titre =TextEditingController(),
                            decoration: InputDecoration(
                                hintText: ("nom du societe..."),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("Titre PFE BOOK :",style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF012869)),),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: desc =TextEditingController(),
                            decoration: InputDecoration(
                                hintText: ("Titre du PFE BOOK..."),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("A propos Du PFE BOOK :",style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF012869),),),
                          SizedBox(height: 5,),
                          TextFormField(
                            maxLines: 7,
                            controller: de =TextEditingController(),
                            decoration: InputDecoration(
                              hintText: ("A propos du PFE BOOK..."),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  )
                              ),
                            ),),
                          SizedBox(height: 5,),

                          TextButton(
                              onPressed: () {
                                pickFile();
                              },
                              child: Text('Téléverser PFE BOOK',style: TextStyle(color: Color(0xFF012869),),)
                          ),
                          SizedBox(height: 5,),

                          ElevatedButton(
                            style:ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF012869),
                            ),
                            onPressed: () {
                              // c.PostExamen(titre.text, description.text,File(filecours),);
                              //  GetExamen(idd);

                              setState(() {
                                // com.postRapport(titree.text, Societe, descrip, image)

                                com.postpfebook(titre.text, de.text, im,desc.text,token);
                                getSoc();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('PFE BOOK Ajouter avec suceés.'),
                                  ),
                                );
                              });
                              print("frr");
                              Navigator.of(context).pop(null);
                            },
                            child: Center(
                                child: Text('Ajouter PFE BOOK',style:TextStyle(color: Colors.white),)
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          },
          icon: Icon(Icons.add),
          color: Colors.white,
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

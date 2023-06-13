import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class societtttttttttt extends StatefulWidget {
  final String token;
  const societtttttttttt({Key? key, required this.token}) : super(key: key);

  @override
  State<societtttttttttt> createState() => _societttttttttttState();
}

class _societttttttttttState extends State<societtttttttttt> {

  Future<void> postSocie(String nom,email,telephone,a_propos,siteweb, image,adresse) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.13/ISIMM_eCampus/public/api/ajouter_societe'));
    request.fields['adresse'] = adresse;

    request.fields['nom'] = nom;
    request.fields['email'] = email;
    request.fields['telephone'] = telephone;
    request.fields['a_propos'] = a_propos;
    request.fields['site_web'] = siteweb;

    var headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json'

    };

    request.headers.addAll(headers);




    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseString);
    if (response.statusCode == 200) {
      print('Annonce postée avec succès');
    } else {
      print(jsonResponse);
    }
  }

  late TextEditingController titre;
  late TextEditingController adress;
  late TextEditingController phone;
  late TextEditingController site;
  late TextEditingController apropos;
  late TextEditingController img;
  late TextEditingController telephone;
  late TextEditingController email;
  late TextEditingController site2;

  late TextEditingController adress2;
  late TextEditingController telephone2;
  late TextEditingController email2;
  Future<void> deleteSociet(int annonceId) async {

    final response = await http.delete(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/supprimer_societe/${annonceId}'),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Announcement deleted successfully');
      print(data);
    } else {
      print('An error occurred while deleting the announcement');
      print(response.body);
    }

  }

  String? im;
  String? a;
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

List ime=[
  'lib/adminstration/ah/images (12).png',
  'lib/adminstration/ah/téléchargement (21).png',
  'lib/adminstration/ah/téléchargement (22).png',
];
  late TextEditingController de;

  late TextEditingController desc;
  late TextEditingController desccrep;

  UpdateSoc( int idannonce,email,telephone,adresse,siteweb) async {
    http.Response response = await http.patch(Uri.parse(
        "http://192.168.1.13/ISIMM_eCampus/public/api/update_societe/${idannonce}?email=${email}&telephone=${telephone}&adresse=${adresse}&site_web=${siteweb}"),

        headers: {
          'Authorization': 'Bearer ${token}',
          'Accept': 'application/json'
        }
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Update avec succes");

      print(data);
    } else {
      print(data);
    }
  }

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
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/societes'),
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
late String token;
  @override
  void initState() {
    token=widget.token;
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
                Text('Espace Sociéte',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20,letterSpacing: 1),),

              ],
            ),
          ),
          Expanded(
            child: Container(
              height:700 ,
              color: Colors.grey.withOpacity(0.01),
              child:Stack(
                children: [
                  Container(
                    height: 170,
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  Positioned(
                      top: 0,
                      child:Container(
                        height: 739,
                        width: 390,
                        child: StreamBuilder<Map<String,dynamic>>(
                            stream:Stream.fromFuture(getSoc()),
                            builder: (context,AsyncSnapshot<Map<String,dynamic>> snapshot) {
                              print('rrrrrrrrrr');


                              print("1");

                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              } else {                            var data = snapshot.data!;
                                List<dynamic> annonces = snapshot
                                    .data!['sociétés'];
                              return ListView.builder(
                                  itemCount: annonces.length,
                                  itemBuilder: (context, id) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          right: 10, bottom: 15, left: 20),
                                      padding: EdgeInsets.all(8),
                                      width: 50,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              7),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.1),
                                                spreadRadius: 0,
                                                blurRadius: 1,
                                                offset: Offset(4, 4)
                                            ),
                                            BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.1),
                                                spreadRadius: 0,
                                                blurRadius: 1,
                                                offset: Offset(-4, -4)
                                            )
                                          ]
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                              height: 50,
                                              color: Colors.red,
                                              width: 350,
                                              child: Image.network(
                                            "http://192.168.1.13/ISIMM_eCampus/storage/app/public/${annonces[id]['image']}",

                                                height: 70,
                                                fit: BoxFit.cover,)),
                                          SizedBox(height: 10,),
                                          Text(annonces[id]['nom'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),)
                                          , SizedBox(height: 5,),
                                          Text(annonces[id]['adresse'],
                                            style: TextStyle(
                                                color: Colors.black.withOpacity(
                                                    0.5)),)
                                          , SizedBox(height: 1,),
                                          Text(annonces[id]['site_web'],
                                            style: TextStyle(
                                                color: Colors.black.withOpacity(
                                                    0.5)),)
                                          , SizedBox(height: 5,),
                                          Text('Contact', style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),),
                                          Divider(thickness: 1,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.phone),
                                                  SizedBox(width: 4,),
                                                  Text(annonces[id]['telephone'],
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold),),
                                                ],
                                              ),
                                              Row(
                                                children: [
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
                                                                            deleteSociet(annonces[id]['id']);
                                                                            //com.deletepfebook(la[id]['id'],token);
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
                                                                height:350,
                                                                width: 300,
                                                                child:Column(
                                                                  children: [
                                                                    Text('Modifier PFE BOOK',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Color(0xFF012869),
                                                                    ),)
                                                                    ,SizedBox(height: 30,),
                                                                    Container(
                                                                      padding: EdgeInsets.only(bottom: 10),
                                                                      child: TextFormField(
                                                                        controller:email2=  TextEditingController(
                                                                         ),
                                                                        decoration: InputDecoration(
                                                                          labelText: 'Email',
                                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                                          border: OutlineInputBorder(),
                                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(bottom: 10),
                                                                      child: TextFormField(
                                                                        controller:telephone2=  TextEditingController(
                                                                        ),
                                                                        decoration: InputDecoration(
                                                                          labelText: 'telephone',
                                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                                          border: OutlineInputBorder(),
                                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(bottom: 10),
                                                                      child: TextFormField(
                                                                        controller:adress2=  TextEditingController(
                                                                        ),
                                                                        decoration: InputDecoration(
                                                                          labelText: 'Adresse',
                                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                                          border: OutlineInputBorder(),
                                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.only(bottom: 10),
                                                                      child: TextFormField(
                                                                        controller:site2=  TextEditingController(
                                                                        ),
                                                                        decoration: InputDecoration(
                                                                          labelText: 'Site Web',
                                                                          labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                                                          border: OutlineInputBorder(),
                                                                          helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                                                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                                                        ),
                                                                      ),
                                                                    ),
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
                                                                            shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                          ),
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              // print(rapport[id]['id']);
                                                                              UpdateSoc(annonces[id]['id'], email2.text, telephone2.text, adress2.text, site2.text);
                                                                            //  com.UpdatePfeBook(titre.text, desc.text, la[id]['id'],token);
                                                                              getSoc();
                                                                              Navigator.pop(context, null);

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
                                                  SizedBox(width: 3,),
                                                  GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                            context: (context),
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: Container(
                                                                  height: 350,
                                                                  width: 500,
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        annonces[id]['nom'],
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: 24,
                                                                        ),),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right: 50.0,
                                                                            left: 50),
                                                                        child: Image
                                                                            .asset(
                                                                            ime[1]),
                                                                      ),
                                                                      SizedBox(
                                                                        height: 8,),
                                                                      Row(
                                                                        children: [
                                                                          Icon(Icons
                                                                              .account_balance_outlined),
                                                                          SizedBox(
                                                                            width: 5,),
                                                                          Text(
                                                                            'A propos',
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight
                                                                                    .bold),),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 10,),
                                                                      Expanded(
                                                                          child: Text(
                                                                              annonces[id]['a_propos'])),
                                                                      SizedBox(height: 5,),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          SizedBox(
                                                                              width: 180,
                                                                              height: 38
                                                                              ,
                                                                              child: ElevatedButton(
                                                                                  style: ElevatedButton
                                                                                      .styleFrom(
                                                                                      backgroundColor: Colors
                                                                                          .red,
                                                                                      shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius
                                                                                              .circular(
                                                                                              10)
                                                                                      )
                                                                                  )
                                                                                  ,
                                                                                  onPressed: () {
                                                                                    Navigator
                                                                                        .pop(
                                                                                        context,
                                                                                        null);
                                                                                  },
                                                                                  child: Text(
                                                                                    'Cancel',
                                                                                    style: TextStyle(
                                                                                        fontWeight: FontWeight
                                                                                            .bold,
                                                                                        color: Colors
                                                                                            .white),))),
                                                                          SizedBox(
                                                                            width: 10,),

                                                                        ],
                                                                      ),

                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      }
                                                      ,
                                                      child: Text('More',
                                                        style: TextStyle(
                                                            color: Colors.blue),)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),

                                    );
                                  });}
                            }          ),
                      ))
                ],
              ),
            ),
          )

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
                      height: 630,
                      width: 200,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          Center(child:Text('Ajouter Sociéte',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),),
                          SizedBox(height: 15,),
                          Text("Titre Sociéte :",style:TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: titre =TextEditingController(text: "nom Sociéte"),
                            decoration: InputDecoration(
                                hintText: ("nom du societe...")
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("A propos Du Sociéte :",style:TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          TextFormField(
                            maxLines: 5,
                            controller: apropos =TextEditingController(text: "A propos Du Sociéte"),
                            decoration: InputDecoration(
                                hintText: ("A propos du societe...")
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("Adresse :",style:TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: adress = TextEditingController(text: "adresse Sociéte"),
                            decoration: InputDecoration(
                                hintText: ("Adresse Du Sociéte...")
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("Numéro Téléphone :",style:TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: telephone = TextEditingController(text: "Téléphone Sociéte"),
                            decoration: InputDecoration(
                                hintText: ("Téléphone Du Sociéte...")
                            ),
                          ),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: email = TextEditingController(text: "Email"),
                            decoration: InputDecoration(
                                hintText: ("Email...")
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("Site Sociéte :",style:TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          TextFormField(
                            controller: site = TextEditingController(text: "Site Sociéte"),
                            decoration: InputDecoration(
                                hintText: ("Site Du Sociéte...")
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                PickFile();
                              },
                              child: Text('Téléverser Image Sociéte')
                          ),
                          SizedBox(height: 5,),
                        //  Text(filecour ?? ''),
                          ElevatedButton(
                            onPressed: () {
                              postSocie(titre.text, email.text, telephone.text, apropos.text, site.text, im,adress.text);
                             // c.PostExamen(titre.text, description.text,File(filecours),);
                            //  GetExamen(idd);
                              Navigator.of(context).pop(null);
                            },
                            child: Center(
                                child: Text('Ajouter Sociéte')
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

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class EditProfile extends StatefulWidget {
   final String nom;
   final String token;
   final String prenom;
   final String email;
   final String date_de_naissance;
   final String telephone;
   final String image;
  final String img;
  const EditProfile({Key? key, required this.img, required this.nom, required this.token, required this.prenom, required this.email, required this.date_de_naissance, required this.telephone, required this.image}) : super(key: key);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final String nom;
  late final String token;
  late final String prenom;
  late final String email;
  late final String date_de_naissance;
  late final String telephone;
  late final String image;

  Future<Map<String, dynamic>> getUser() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',

    };

    HttpClient client = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/enseignants'),
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
 TextEditingController nomm =TextEditingController();
  late TextEditingController prenomm;
  late TextEditingController phone;
  late TextEditingController emaill;

  late TextEditingController datenaissance;
  late String img;
  @override
  void initState() {
    setState(() {
      img=widget.img;
      nom=widget.nom;
      prenom=widget.prenom;
      email=widget.email;
      date_de_naissance=widget.date_de_naissance;
      telephone=widget.telephone;
      image=widget.image;
      token=widget.token;
      print(telephone);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        children: [
          Container(height: 32,
          color: Colors.white,),
          Container(
            height: 260,
            decoration:BoxDecoration(
                color: Color(0xFF012869),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(100))
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed:(){}, icon:Icon(Icons.arrow_back,color: Colors.white,)),
                    Text('Profile',style:TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w500),),
                    IconButton(onPressed:(){
                      showDialog(context:context,
                        builder:(context){
                          return AlertDialog(
                            content:Container(
                              height:350,
                              width: 300,
                              child:Column(
                                children: [
                                  Text('Paramétres',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Color(0xFF012869),
                                  ),)
                                  ,SizedBox(height: 30,),
                                  TextFormField(
                                    controller: nomm= TextEditingController(
                                    text: nom),
                                    decoration: InputDecoration(
                                  labelText: 'Nom',
                                  labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(),
                                  helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  TextFormField(
                                    controller:  TextEditingController(
                                        text: nom),
                                    decoration: InputDecoration(
                                      labelText: 'prenom',
                                      labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(),
                                      helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  TextFormField(
                                    controller:  TextEditingController(
                                        text: email),
                                    decoration: InputDecoration(
                                      labelText: 'email',
                                      labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(),
                                      helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                    ),
                                  ),
                                  SizedBox(height: 12,),
                                  TextFormField(
                                    controller:  TextEditingController(
                                        text: date_de_naissance),
                                    decoration: InputDecoration(
                                      labelText: 'Date De naissance',
                                      labelStyle:TextStyle(color: Color(0xFFb1afb1),fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(),
                                      helperStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
                                            //com.UpdateRapport(titre.text, desc.text, la[id]['id']);
                                            Navigator.pop(context, null);
                                           // getSoc();
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

                      );
                    }, icon:Icon(Icons.edit,color: Colors.white,))
                  ],
                ),
                SizedBox(height: 70,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                     decoration:BoxDecoration(
                       color: Colors.white,
                       shape: BoxShape.circle
                     ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 3,
                            left: 3,
                            right:3,
                            bottom:3,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:NetworkImage('https://192.168.1.13/ISIMM_eCampus/storage/app/public/${image}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    StreamBuilder<Map<String,dynamic>>(
                      stream:Stream.fromFuture(getUser()),
                      builder: (context, AsyncSnapshot<Map<String,dynamic>> snapshot) {
                        if(!snapshot.hasData){
                          return CircularProgressIndicator();
                        }else{
                        List<dynamic> profile = snapshot.data!['enseignants'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(nom +" " +prenom,style:TextStyle(color: Colors.white,fontWeight:FontWeight.w500,fontSize: 20),),
                            SizedBox(height: 10,),
                          ],
                        );}
                      }
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 30,right: 30),
              color: Colors.white,
              width: double.infinity,
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Adresse Email :',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                , SizedBox(height: 10,)
                  ,Text(email,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:Color(0xFF8f9094)),)
                    , SizedBox(height: 10,),
                    Divider(color: Colors.grey,),
                    SizedBox(height:10),
                    Text('Password :',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                  , SizedBox(height: 10,),
                    Text('*************',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:Color(0xFF8f9094)),)
                    ,Divider(color: Colors.grey,),
                    SizedBox(height:10),
                    Text('Confirm Password :',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                    , SizedBox(height: 10,)
                    ,Text('*************',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:Color(0xFF8f9094)),)
                    ,Divider(color: Colors.grey,),
                    SizedBox(height:10),
                    Text('Phone Number:',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                    , SizedBox(height: 10,)
                    ,Text('+216 '+telephone,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:Color(0xFF8f9094)),)
                    ,Divider(color: Colors.grey,),
                    SizedBox(height:10),
                    Text('Date Of Birth:',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                    , SizedBox(height: 10,)
                    ,Text(date_de_naissance,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:Color(0xFF8f9094)),)
                  ],
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

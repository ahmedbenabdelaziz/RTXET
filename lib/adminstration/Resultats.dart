/*import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Api/ApiResult.dart';

class Resultats extends StatefulWidget {
  const Resultats({Key? key}) : super(key: key);

  @override
  State<Resultats> createState() => _Resultats();
}

class _Resultats extends State<Resultats> {
  late String _selectedOption;
  late String _selectedOptionn;
  late String _selectedOptionnn;
  late String _selectedOptionnnn;
  late String _selectedOptionnnnn;

  List<String> classe = [
    'Ingénierie',
    'Mastére',
    'L3',
    'L2',
    'L1',
  ];

  List<String> semestre = [
    'semestre 1',
    'semestre 2',

  ];
  List<String> typeclasse = [
    'Génie Logiciel',
    'Systéme Embarqué',
    'Maths',
    'Tic',
  ];

  List<String> TD = [
    'TD 1',
    'TD 2',
    'TD 3',
    'TD 4',
    'TD 5',
    'TD 6',
  ];

  List<String> Matieres = [
    'Physique',
    'Chimie',
    'Maths',
    'Algébre',
    'Analyse',
    'Java',
  'Multimédia'
  ];
  StreamController<Map<String, dynamic>> _streamController = StreamController.broadcast();
  List<Map<String, dynamic>> modifiedResultats = [];


  Future<Map<String, dynamic>> getResultats() async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${token}',
      'Accept': 'application/json',

    };


    final response = await http.get(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/list_resultats'),
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

  void ConfirmerResultats(
      int idEtudiant,
      double td,
      double tp,
      double ds,
      double examen,
      double moy,
      double cred,
      ) async {
    print("x");
    final response = await http.post(
      Uri.parse('http://192.168.1.13/ISIMM_eCampus/public/api/confirmer_resultat'),
      headers: {
        'Authorization': 'Bearer ${token}',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'matiere_id': 1,
        'resultats': [
          {
            'etudiant_id': idEtudiant,
            'note_TD': td,
            'note_TP': tp,
            'note_DS': ds,
            'note_Examen': examen,
            'moyenne': moy,
            'credit': cred,
          }
        ]
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print('Résultat envoyé avec succès');
      print(data);
    } else {
      print(response.statusCode);
      print('Erreur lors de l\'envoi du résultat');
      print(data);
    }
  }
  ApiResultat com = ApiResultat();

  @override
  void initState() {
    _selectedOption = classe[0];
    _selectedOptionn = typeclasse[0];
    _selectedOptionnn = TD[0];
    _selectedOptionnnn = Matieres[0];
    _selectedOptionnnnn = semestre[0];
    _streamController =  StreamController.broadcast();
    getResultats();
    super.initState();
  }
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFff7f7fa),
      body:Container(
        child:Column(children: [
          Container(
            height: 50,
            padding:EdgeInsets.only(right:30),
            width: double.infinity,
            color: Colors.white,
            child:Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child:Image.asset('lib/adminstration/img/téléchargement (2).png'),
                ),
                Row(
                  children: [
                    Text('ISIMM',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFF26519e)),),
                    Text('_eCAMPUS',style:TextStyle(fontSize: 20),),
                  ],
                ),
                SizedBox(width: 40,),
                Container(
                  width: 40,
                  height: 40,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue
                  ),
                  child:Center(
                    child:Icon(Icons.dashboard,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius:BorderRadius.circular(10)
                    )
                    ,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration:InputDecoration(
                        border: InputBorder.none,
                        hintText: "search..."
                    ),
                  ),
                )),
                Expanded(child:Container()),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.1),
                        ),

                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          right: 5,
                          bottom: 5
                          ,child:CircleAvatar(
                        backgroundImage:AssetImage('lib/adminstration/img/tunisie.png'),
                      ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                          child:CircleAvatar(
                            backgroundColor:Colors.black.withOpacity(0.05),
                            child: Icon(Icons.notifications_none,color: Colors.black,),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child:Stack(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration:BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.03),
                        ),
                      ),
                      Positioned(
                          child:CircleAvatar(
                            backgroundColor:Colors.black.withOpacity(0.03),

                            child:Icon(Icons.email_outlined,color: Colors.black,),
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                          radius:20,
                          child:Image.asset('lib/ISIM_LOGO_ar.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ISIMM',style:TextStyle(fontWeight: FontWeight.bold),),
                          Text('Adminstration',style:TextStyle(color: Colors.blue),)

                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                height: 530,
                width: 215,
                color:Colors.white,
                child:ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Text('Menu principal',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal:10,vertical:3),
                            decoration: BoxDecoration(
                                color: Color(0xFF3d5ee1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                children: [
                                  Icon(Icons.home,color: Colors.white,),
                                  SizedBox(width: 20,),
                                  Text('Acceuille',style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                                  Expanded(child: Container()),
                                  SizedBox(width:10,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/prof.png')),
                                SizedBox(width: 20,),
                                Text('enseignants',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/etudiant-diplome.png')),
                                SizedBox(width: 20,),
                                Text('Etudiants',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('Extra',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/discuter.png')),
                                SizedBox(width: 10,),
                                Text('Boite De Recéption',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/calendrier.png',color: Colors.black54,)),
                                SizedBox(width: 10,),
                                Text('Calendrier',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/presse-papiers.png')),
                                SizedBox(width: 10,),
                                Text('Résultats',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/emploi-du-temps.png')),
                                SizedBox(width: 10,),
                                Text('Emploi Du temps',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                    height: 25,
                                    width: 25
                                    ,child: Image.asset('lib/adminstration/img/discuter.png')),
                                SizedBox(width: 10,),
                                Text('Horaires Examens',style:TextStyle(color:Colors.black54,)),
                                Expanded(child: Container()),
                                Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    Text('Autre',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('Rapports PFE',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('PFE BOOK',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('Société',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Text('Gestion',style:TextStyle(color:Colors.black38,fontSize: 20
                    ),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('Rapports PFE',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('PFE BOOK',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: 25,
                              width: 25
                              ,child: Image.asset('lib/adminstration/img/files-and-folder.png')),
                          SizedBox(width: 10,),
                          Text('Société',style:TextStyle(color:Colors.black54,)),
                          Expanded(child: Container()),
                          Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 15,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

      Container(
        padding: EdgeInsets.only(top: 20, right: 30, left: 30),
        width: 1050,
        height: 530,
        color: Color(0xFff7f7fa),
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [

        Row(
        children: [
        Text('Résultats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        Expanded(child: Container()),
        Text('Home   /'),
        Text('  Résultats', style: TextStyle(color: Colors.black38)),
        ],
      ),
      SizedBox(height: 15),
      Row(
        children: [
          Container(
            height: 50,
            width: 260,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Rechercher par identifiant",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
          Container(
            height: 50,
            width: 260,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Rechercher par nom",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
          Container(
            height: 50,
            width: 260,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Rechercher par Adresse mail",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
          Container(
            height: 50,
            width: 100,
            color: Colors.purple,
            child: Center(
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 20),
      Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        height: 700,
        width: 500,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
        style:ElevatedButton.styleFrom(
        backgroundColor:Color(0xFF3d5ee1),
      ),
                onPressed: () {
                  print('modifiedResultats: $modifiedResultats'); // Check the value of modifiedResultats

                  for (var i = 0; i < modifiedResultats.length; i++) {
                    print(i);
                    ConfirmerResultats(
                      modifiedResultats[i]['student_id'],
                      modifiedResultats[i]['note_TD'],
                      modifiedResultats[i]['note_TP'],
                      modifiedResultats[i]['note_DS'],
                      modifiedResultats[i]['note_Examen'],
                      modifiedResultats[i]['moyenne'],
                      modifiedResultats[i]['credit'],
                    ); // Pass the modified result to the function
                    print('Résultat envoyé avec succès');
                  }

                  modifiedResultats.clear(); // Réinitialiser la liste des résultats modifiés
                  print('Résultats modifiés envoyés avec succès');
                },
                child: Text('Envoyer',style:TextStyle(fontWeight: FontWeight.bold),),
              ),

              Row(

        children: [
          Text(
            'classe',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF26519e),
              fontSize: 17,
            ),
          ),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: _selectedOption,
            items: classe.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOption = value!;
              });
            },
          ),
          SizedBox(width: 15),
          Text(
            'Section',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF26519e),
              fontSize: 17,
            ),
          ),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: _selectedOptionn,
            items: typeclasse.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOptionn = value!;
              });
            },
          ),
          SizedBox(width: 15),
          Text(
            'TD',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF26519e),
              fontSize: 17,
            ),
          ),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: _selectedOptionnn,
            items: TD.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOptionnn = value!;
              });
            },
          ),
          SizedBox(width: 15),
          Text(
            'Matiéres',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF26519e),
              fontSize: 17,
            ),
          ),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: _selectedOptionnnn,
            items: Matieres.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOptionnnn = value!;
              });
            },
          ),
          SizedBox(width: 15),
          Text(
            'Semestre',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF26519e),
              fontSize: 17,
            ),
          ),
          SizedBox(width: 10),
          DropdownButton<String>(
            value: _selectedOptionnnnn,
            items: semestre.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedOptionnnnn = value!;
              });
            },
          ),
        ],
      ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 155),
                    Text(
                      'ID',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 55),
                    Text(
                      'Examen',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 50),
                    Text(
                      'TP 1',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 45),
                    Text(
                      'Exercice 1',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 39),
                    Text(
                      'Moyenne',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 45),
                    Text(
                      'Crédit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),

              Expanded(
    child: Container(
    child: FutureBuilder<Map<String, dynamic>>(
    future: getResultats(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
    return Text('Erreur: ${snapshot.error}');
    }
    var data = snapshot.data!;
    List<dynamic> resultats = data['resultats'];

    return ListView.builder(
    itemCount: resultats.length,
    itemBuilder: (context, id) {
    var col;
    (id % 2 != 0) ? col = Color(0xFFfafafa) : col = Color(0xFFffffff);

    TextEditingController noteExamenController = TextEditingController(
    text: resultats[id]['note_Examen'].toString(),
    );

    TextEditingController noteTPController = TextEditingController(
    text: resultats[id]['note_TP'].toString(),
    );

    TextEditingController noteTDController = TextEditingController(
    text: resultats[id]['note_TD'].toString(),
    );

    TextEditingController moyenneController = TextEditingController(
    text: resultats[id]['moyenne'].toString(),
    );

    TextEditingController creditController = TextEditingController(
    text: resultats[id]['credit'].toString(),
    );

    return Container(
    color: col,
    child: Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
    children: [
    CircleAvatar(
    radius: 17,
    // backgroundImage: NetworkImage(
    //   "https://192.168.1.13/ISIMM_eCampus/storage/app/public/${resultats[id]['etudiant']['image']}",
    // ),
    ),
    SizedBox(width: 10),
    Container(
      width: 100,
      child: Text(
      resultats[id]['etudiant']['nom'] +
      " " +
      resultats[id]['etudiant']['prenom'],
      ),
    ),
    SizedBox(width: 57),
    Text(
    resultats[id]['id'].toString(),
    ),
    SizedBox(width: 60),
    Container(
    width: 100,
    child: TextFormField(
    controller: noteExamenController,
    decoration: InputDecoration(
    border: InputBorder.none,
    ),
    onChanged: (newValue) {
    // Mettre à jour la valeur de la note d'examen
    resultats[id]['note_Examen'] = double.tryParse(newValue) ?? 0.0;
    // Ajouter l'étudiant à la liste des résultats modifiés
    if (!modifiedResultats.contains(resultats[id])) {
    modifiedResultats.add(resultats[id]);
    }
    },
    ),
    ),
    Container(
    width: 90,
    child: TextFormField(
    controller: noteTPController,
    decoration: InputDecoration(
    border: InputBorder.none,
    ),
    onChanged: (newValue) {
    // Mettre à jour la valeur de
      resultats[id]['note_TP'] = double.tryParse(newValue) ?? 0.0;
// Ajouter l'étudiant à la liste des résultats modifiés
      if (!modifiedResultats.contains(resultats[id])) {
        modifiedResultats.add(resultats[id]);
      }
    },
    ),
    ),
      Container(
        width: 100,
        child: TextFormField(
          controller: noteTDController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: (newValue) {
// Mettre à jour la valeur de la note de TD
            resultats[id]['note_TD'] = double.tryParse(newValue) ?? 0.0;
// Ajouter l'étudiant à la liste des résultats modifiés
            if (!modifiedResultats.contains(resultats[id])) {
              modifiedResultats.add(resultats[id]);
            }
          },
        ),
      ),
      Container(
        width: 100,
        child: TextFormField(
          controller: moyenneController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: (newValue) {
// Mettre à jour la valeur de la moyenne
            resultats[id]['moyenne'] = double.tryParse(newValue) ?? 0.0;
// Ajouter l'étudiant à la liste des résultats modifiés
            if (!modifiedResultats.contains(resultats[id])) {
              modifiedResultats.add(resultats[id]);
            }
          },
        ),
      ),
      Container(
        width: 100,
        child: TextFormField(
          controller: creditController,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: (newValue) {
// Mettre à jour la valeur du crédit
            resultats[id]['credit'] = double.tryParse(newValue) ?? 0.0;
// Ajouter l'étudiant à la liste des résultats modifiés
            if (!modifiedResultats.contains(resultats[id])) {
              modifiedResultats.add(resultats[id]);
            }
          },
        ),
      ),

    ],
    ),
    ),
    );
    },
    );
    },
    ),
    ),
    ),

    ],
    ),
    ),
    ])),

            ],
          )
        ],),
      ),
    );

  }
}
*/
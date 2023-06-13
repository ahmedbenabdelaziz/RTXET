import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled62/adminstration/ah/soc.dart';
import 'package:untitled62/adminstration/chhhhhhhhhhhhhhhhhhh.dart';
import 'package:untitled62/adminstration/pfebook.dart';
import 'package:untitled62/matiere/Cours/ApiCou/Api/ApiCours.dart';
import 'package:untitled62/matiere/matiere.dart';
import 'package:untitled62/pfe/pfffff.dart';
import 'package:untitled62/pfe/rapport.dart';
import 'package:untitled62/pfe/societe.dart';
import 'package:untitled62/presence/pre.dart';
import 'package:untitled62/presence/presenece.dart';
import 'package:untitled62/students/AcceuiEtudian.dart';
import 'package:untitled62/students/EditProfile.dart';
import 'package:untitled62/students/FirstLogin.dart';
import 'package:untitled62/students/Registreensei.dart';

import 'BoiteReception/Etudient/BoiteReceptionEtudient.dart';
import 'BoiteReception/Etudient/admi.dart';
import 'BoiteReception/Etudient/test.dart';
import 'Emploi/Emploi.dart';
import 'Enseignant/EmploiEnseignant.dart';
import 'Login/LoginEtudient/LoginUser/BlocUser/Login/login_bloc.dart';
import 'Login/LoginEtudient/LoginUser/BlocUser/Registre/registre_bloc.dart';
import 'Login/LoginEtudient/LoginUser/LoginUser.dart';
import 'Login/LoginEtudient/LoginUser/Registre.dart';
import 'ResultatEtudiant/DateExamen.dart';
import 'ResultatEtudiant/resultatExam.dart';
import 'ResultatEtudiant/res.dart';
import 'Apropos.dart';
import 'adminstration/AccAdm.dart';
import 'adminstration/AcceuillAnnonc.dart';
import 'adminstration/AjouterEnseign.dart';
import 'adminstration/BoitereceptionEnseignant.dart';
import 'adminstration/Classe.dart';
import 'adminstration/DateExamen.dart';
import 'adminstration/Departement.dart';
import 'adminstration/ListEtudient.dart';
import 'adminstration/ListeEnseignant.dart';
import 'adminstration/LoginAdmin.dart';
import 'adminstration/Resultats.dart';
import 'adminstration/Soc.dart';
import 'adminstration/Subjects.dart';
import 'adminstration/ah/RapportPfe.dart';
import 'adminstration/ah/pfebbok.dart';
import 'adminstration/calendtest.dart';
import 'adminstration/chatadmistration.dart';
import 'adminstration/emploiDuTemps.dart';
import 'adminstration/rapportpfe.dart';
import 'adminstration/societe.dart';
import 'adminstration/test.dart';
import 'adminstration/wzb.dart';
import 'annonce/a.dart';
import 'annonce/annonce.dart';
import 'chat/GroupChat.dart';
import 'chat/chatEnseignant/Listchat.dart';
import 'chat/chathome.dart';
import 'chat/chatttttttttttttttttclasse.dart';
import 'chat/uichat.dart';
import 'Enseignant/enseignant.dart';
import 'matiere/Cours/AcceuilCours.dart';
import 'matiere/Cours/ApiCou/t.dart';
import 'matiere/Cours/Examen.dart';
import 'matiere/Cours/Td.dart';
import 'matiere/Cours/cours.dart';
import 'matiere/Cours/ApiCou/Api/ApiUser.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'matiere/Cours/looooooooooogin.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );

  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegistreBloc(ApiUser())),
        BlocProvider(create: (context) => LoginBloc(ApiUser())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider<RegistreBloc>(
          create: (context) => BlocProvider.of<RegistreBloc>(context),
          child:Signin(),
        ),
      ),
    );
  }
}

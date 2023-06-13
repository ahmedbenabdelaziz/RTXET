import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled62/Login/LoginEtudient/LoginUser/prof.dart';
import 'package:untitled62/students/Registreetud.dart';
import '../../../Enseignant/enseignant.dart';
import '../../../matiere/Cours/ApiCou/Api/ApiUser.dart';
import '../../../students/AcceuiEtudian.dart';
import '../../../students/Registreensei.dart';
import '../../Widgets/UserWidget/Text.dart';
import '../../Widgets/UserWidget/sizee.dart';
import 'BlocUser/Login/login_bloc.dart';
import 'Etudiant.dart';
import 'Registre.dart';
class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  GlobalKey<FormState> fo = GlobalKey<FormState>();


  TextEditingController emaill = TextEditingController();
  TextEditingController passwordd = TextEditingController();
  late LoginBloc loginBloc;
  ApiUser ahmed = ApiUser();
  void login() async {
    print("object");


      String ema = emaill.text;
      String pas = passwordd.text;
      print("object");

      loginBloc.add(Loginn(email: emaill.text, password: passwordd.text));

      loginBloc.stream.listen((state) {
        if (state is LoginStudentSuccessed) {
          var data = state.flag;
         if(data=="student"){
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>AcceilEtudiant(nom:state.nom, prenom: state.prenom, email: state.email, date_de_naissance:state.date_de_naissance, telephone: state.telephone, image: state.image,token: state.token, type: 'student',
           )));
         }else  if(data=="enseignant"){
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>AcceuilPof(token: state.token, nom:state.nom,prenom: state.prenom, email:state.email, date_de_naissance: state.date_de_naissance, telephone:state.telephone, image: state.image, type:'enseignant',
           )));
         }
          print(data);
        } else if (state is LoginError) {
          var error = state.emailError;
          print(error);
        }
      });
    }


  @override
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  String? mailerreur;
  String? passworderreur;

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(color: Color(0xFFa2abb9), letterSpacing: 1),
    );
  }

  Widget sizeheight(double size) {
    return SizedBox(
      height: size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF012869),
    body: Form(
    key: fo,
    child: ListView(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    children: [
    Container(
    height: 150,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: IconButton(
    onPressed: () {},
    icon: Icon(Icons.arrow_back, color: Colors.white),
    ),
    ),
    Padding(
    padding: const EdgeInsets.only(left: 20.0, bottom: 20),
    child: Text(
    'Se Connecter',
    style: TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    ),
    ),
    ),
    ],
    ),
    ),
    Container(
    width: double.infinity,
    height: 643,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(40),
    topLeft: Radius.circular(40),
    ),
    color: Colors.white,
    ),
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Center(
    child: Image.asset(
    'lib/Login/LoginEtudient/LoginUser/téléchargement (4).png',
    height: 70,
    ),
    ),
    sizeheight(10),
    Text(
    'Binvenue ...!',
    style: TextStyle(
    color: Color(0xFF032351),
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    ),
    ),
    sizeheight(10),
    Text(
    'Bonjour là-bas, à suivre...',
    style: TextStyle(color: Color(0xFFa2abb9), letterSpacing: 1),
    ),
    sizeheight(10),
    text('Email'),
    sizeheight(10),
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is EmailError) {
            mailerreur = state.emailError; // Modifier le nom de la propriété de l'erreur d'email
          } else if (state is PasswordError) {
            passworderreur = state.passwordError;
          } else if (state is LoginError) {
            mailerreur = state.emailError;
            passworderreur = state.passwordError;
          }

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFFf6f7f9),
            ),
            child: TextFormField(
              controller: emaill,
              onChanged: (text) {
                if (mailerreur != null) {
                  setState(() {
                    mailerreur = null;
                  });
                }
              },
              validator: (text) {
                if (text!.isEmpty) {
                  return "Email field must not be empty";
                } else if (!EmailValidator.validate(text)) {
                  return "Please enter a valid email address";
                } else if (mailerreur != null) {
                  return mailerreur;
                }
              },
              decoration: InputDecoration(
                isCollapsed: false,
                prefixIcon: Icon(Icons.mail),
                hintText: "Entrez votre adresse e-mail",
                border: InputBorder.none,
              ),
            ),
          );
        },
      ),

      sizeheight(15),
      text('Password'),
      sizeheight(15),
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is PasswordError) {
            passworderreur = state.passwordError;
          } else if (state is LoginError) {
            passworderreur = state.passwordError;
          }else if (state is EmailError) {
            passworderreur = state.emailError;
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFFf6f7f9),
            ),
            child: TextFormField(
              controller: passwordd,
              validator: (text) {
                if (text!.isEmpty) {
                  return "Password field must not be empty";
                }
                if (text.length < 6) {
                  return "Password must contain at least 6 characters";
                } else if (passworderreur != null) {
                  print("test");
                  return passworderreur;
                }
              },
              obscureText: true,
              decoration: InputDecoration(
                isCollapsed: false,
                prefixIcon: Icon(Icons.lock_outline),
                hintText: "Entrez votre mots de passe",
                border: InputBorder.none,
              ),
            ),
          );
        },
      ),
      sizeheight(15),
      Text(
        'Mot de passe oublié ?',
        style: TextStyle(color: Color(0xFF1651c8), letterSpacing: 1, fontWeight: FontWeight.bold),
      ),
      sizeheight(20),
      InkWell(
        onTap:(){
          login();
        },
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xFF0041c4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 5),
              Text(
                'Se Connecter',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Vous n'avez pas de compte ?",
            style: TextStyle(color: Color(0xFF1651c8)),
          ),
          SizedBox(width: 3),
          TextButton(
            onPressed:(){
             showDialog(context: context, builder:(context){
               return AlertDialog(
                 content: Container(
                   height: 100,
                   child:Column(
                     children: [
                       TextButton(onPressed:(){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Registreenseigan()));
                       }, child: Text('Enseignant')),
                       TextButton(onPressed:(){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Registreetudian()));
                       }, child: Text('Etudiant'))
                     ],
                   ),
                 ),
               );
             });
            },
            child:Text('Inscrivez-vous',style:TextStyle(color: Color(0xFF1651c8), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    );
  }
}

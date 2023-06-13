import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import '../Login/LoginEtudient/LoginUser/BlocUser/Login/login_bloc.dart';
import '../matiere/Cours/ApiCou/Api/ApiUser.dart';
import '../students/AcceuiEtudian.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginAdmin extends StatefulWidget {
  const LoginAdmin({Key? key}) : super(key: key);

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  GlobalKey<FormState> fo = GlobalKey<FormState>();



  TextEditingController emaill = TextEditingController();
  TextEditingController passwordd = TextEditingController();
  late LoginBloc loginBloc;
  ApiUser ahmed = ApiUser();



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
  void initState() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Row(
        children: [
          Container(
            height: 700,
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset(
                'lib/adminstration/imagePFEBOOK/349208252_270347508716303_7485101407230562141_n.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width*0.5,
            height: MediaQuery.of(context).size.height,
            color: Color(0xFF038bf9),
            child:Form(
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
                            'Sign In',
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
                            'Welcome Back',
                            style: TextStyle(
                              color: Color(0xFF032351),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          sizeheight(10),
                          Text(
                            'Hello there in to be continue',
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
                                    hintText: "Enter your email",
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
                                    hintText: "Enter your password",
                                    border: InputBorder.none,
                                  ),
                                ),
                              );
                            },
                          ),
                          sizeheight(15),
                          Text(
                            'Forget Password?',
                            style: TextStyle(color: Color(0xFF1651c8), letterSpacing: 1, fontWeight: FontWeight.bold),
                          ),
                          sizeheight(20),
                          Container(
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
                                /*                                GestureDetector(
                                  onTap: () async {
                                    loginBloc.add(Loginn(email: emaill.text, password: passwordd.text));
                                    await Future.delayed(Duration(milliseconds: 1380));
                                    if (fo.currentState!.validate()) {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AcceilEtudiant()));
                                    }else{
                                      print("oooo");
                                    }
                                  },

                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
*/
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(color: Color(0xFF1651c8)),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Sign UP',
                                  style: TextStyle(color: Color(0xFF1651c8), fontWeight: FontWeight.bold),
                                ),
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
          ),

        ],
      ),
    );
  }
}

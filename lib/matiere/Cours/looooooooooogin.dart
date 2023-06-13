import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../students/AcceuiEtudian.dart';
import 'package:http/http.dart' as http;
class si extends StatefulWidget {
  const si({Key? key}) : super(key: key);

  @override
  State<si> createState() => _siState();
}

class _siState extends State<si> {
  GlobalKey<FormState> fo = GlobalKey<FormState>();


  TextEditingController emaill = TextEditingController();
  TextEditingController passwordd = TextEditingController();
  Future<Map<String,dynamic>> LoginUser(String email,String password) async {
    http.Response response = await http.post(Uri.parse("https://192.168.1.13/ISIMM_eCampus/public/api/login"),
        body : jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {
          'content-type':'application/json',
          'accept':'application/json',
        }
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(data);
      return data;
    } else {
      print(data);
      return data;
    }
  }

  @override
  void initState() {
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
                Container(
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
                ),
                    sizeheight(15),
                    text('Password'),
                    sizeheight(15),
                Container(
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
                          GestureDetector(
                            onTap: () {
                              var a = LoginUser(emaill.text, passwordd.text).then((value) {
                                if (!fo.currentState!.validate()) {
                                  print("dssd");
                                }else{
                                  print('dsdsdsdsddddddddd');
                                }
                              });


                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
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
    );
  }
}

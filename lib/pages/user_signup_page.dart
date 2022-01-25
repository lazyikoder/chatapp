import 'package:chatapp/pages/chat_room_page.dart';
import 'package:chatapp/pages/user_login_page.dart';
import 'package:chatapp/userauthentication/user_auth.dart';
import 'package:chatapp/sizeConfig/size_config.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isloading = false;
  late Authentication _transaction;

  @override
  void initState() {
    super.initState();
    _transaction = Authentication();
  }

  onsignUp() {
    if (_formKey.currentState!.validate()) {
      _transaction.userSignUpWithEmailAndPassword({
        "name": _username.text,
        "email": _email.text,
        "password": _password.text,
      });
      setState(() {
        isloading = true;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatRoom(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isloading
            ? Center(
                // ignore: avoid_unnecessary_containers
                child: Container(
                child: const CircularProgressIndicator(),
              ))
            : Container(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          TextFormField(
                            validator: (value) {
                              return value!.isEmpty || value.length < 4
                                  ? "Username cannot be empty"
                                  : null;
                            },
                            controller: _username,
                            decoration: const InputDecoration(
                              label: Text("Full Name"),
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          TextFormField(
                            validator: (value) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value!)
                                  ? null
                                  : "Please Enter a valid email_ID";
                            },
                            controller: _email,
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: "Enter Email Address",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          TextFormField(
                            validator: (value) {
                              return value!.length <= 6
                                  ? null
                                  : "Password must be greater then 6";
                            },
                            obscureText: true,
                            controller: _password,
                            decoration: const InputDecoration(
                              label: Text("Password"),
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          TextButton(
                            child: const Text(
                              'SignUp',
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              primary: Colors.white,
                              shape: const BeveledRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: () {
                              onsignUp();
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 1,
                          ),
                          InkWell(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            ),
                            child: const Text(
                              "Already a User? Login",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}

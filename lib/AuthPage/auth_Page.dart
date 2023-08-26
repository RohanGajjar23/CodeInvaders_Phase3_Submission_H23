import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthcare/appRoutes.dart';
import 'package:firebase_database/firebase_database.dart';

class databaseClass {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  Future<void> addDataAfterLogin(User user) async {
    try {
      _database.child('users').child(user.uid).set({
        'username': user.displayName,
        'email': user.email,
        // Add more data fields as needed
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get CurrentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

class ErrorMessage extends StatelessWidget {
  final String message;

  ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.red,
          fontSize: 14,
        ),
      ),
    );
  }
}

class Auth_Page extends StatefulWidget {
  @override
  State<Auth_Page> createState() => _Auth_PageState();
}

class _Auth_PageState extends State<Auth_Page> {
  bool changedButton = false;
  String? errorMessage = "";
  bool isLoggedin = false;
  String? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Future<void> signInEmailPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget customerrorMessage() {
    return Material(
      child: Container(
        height: 50,
        width: 200,
        color: const Color.fromARGB(255, 235, 65, 65),
      ),
    );
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate() && user!.isNotEmpty) {
      setState(() {
        changedButton = true;
      });
      Auth().createWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, appRoutes.homeRoute);
      setState(() {
        changedButton = false;
      });
    }
  }

  Widget RegisterPage(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Material(
        child: SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            Image.asset("assets/images/RegisterPageBG.jpg"),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "New User",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 60),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controllerEmail,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Cannot be Empty";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Email-Id",
                        ),
                      ),
                      TextFormField(
                        controller: _controllerPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter your Password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )),
            Container(
              // height: size.height / 20,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                  child: Column(
                    children: [
                      RadioListTile(
                          title: Text("Recipient"),
                          value: "Recipient",
                          groupValue: user,
                          onChanged: (value) {
                            setState(() {
                              user = value.toString();
                            });
                          }),
                      RadioListTile(
                          title: Text("Doctor"),
                          value: "Doctor",
                          groupValue: user,
                          onChanged: (value) {
                            setState(() {
                              user = value.toString();
                            });
                          }),
                      RadioListTile(
                          title: Text("Pharmaceutical"),
                          value: "Pharmaceutical",
                          groupValue: user,
                          onChanged: (value) {
                            setState(() {
                              user = value.toString();
                            });
                          }),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              splashColor: Colors.redAccent,
              onTap: () => moveToHome(context),
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                width: changedButton ? 50 : 150,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(
                        Radius.circular(changedButton ? 50 : 8))),
                child: changedButton
                    ? Icon(Icons.done)
                    : Center(
                        child: Text(
                          "Register!",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedin
        ? Material(
            child: Column(
              children: [
                Image.asset("assets/images/loginPageBG.jpg"),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 60),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controllerEmail,
                          decoration: InputDecoration(
                            hintText: "Enter your Email-Id",
                          ),
                        ),
                        TextFormField(
                          controller: _controllerPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter your Password",
                          ),
                        )
                      ],
                    )),
                InkWell(
                  onTap: () async {
                    setState(() {
                      changedButton = true;
                    });
                    await Future.delayed(Duration(seconds: 1));
                    Navigator.pushNamed(context, appRoutes.homeRoute);
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: changedButton ? 50 : 150,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(
                            Radius.circular(changedButton ? 50 : 8))),
                    child: changedButton
                        ? Icon(Icons.done)
                        : Center(
                            child: Text(
                              "Login!",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                  ),
                )
              ],
            ),
          )
        : RegisterPage(context);
  }
}

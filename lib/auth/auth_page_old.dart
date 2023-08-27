// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:healthcare/appRoutes.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:page_transition/page_transition.dart';

// class DatabaseClass {
//   DatabaseReference databaseReference = FirebaseDatabase.instance.ref("Doctor");
//   Future<void> addDataAfterLogin(String typeofUser, String username) async {
//     try {
//       await databaseReference.set({
//         'Name': username,
//       });
//     } catch (e) {
//       print("Error adding data to the database: ${e.toString()}");
//     }
//   }

//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// }

// class Auth {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   User? get CurrentUser => _firebaseAuth.currentUser;
//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

//   Future<void> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//   }

//   Future<void> createWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     _firebaseAuth.createUserWithEmailAndPassword(
//         email: email, password: password);
//   }

//   Future<void> signOut(BuildContext context) async {
//     await _firebaseAuth.signOut().then(
//           (value) => Navigator.of(context).pushAndRemoveUntil(
//               PageTransition(
//                 child: const AuthPage(),
//                 type: PageTransitionType.leftToRightWithFade,
//               ),
//               (route) => false),
//         );
//     // _AuthPageState()._controllerPassword.text = "";
//     // _AuthPageState()._controllerEmail.text = "";
//     // _AuthPageState()._controllerName.text = "";
//   }
// }

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   bool changedButton = false;
//   String? errorMessage = "";
//   bool isLoggedin = false;
//   bool onLoginPage = false;
//   String enteredName = '';
//   String enteredEamil = '';
//   String enteredPassword = '';
//   String enteredConfirmPassword = '';

//   String? user;
//   final _formKey = GlobalKey<FormState>();
//   Future<void> signInEmailPassword() async {
//     try {
//       await Auth().signInWithEmailAndPassword(
//           email: _controllerEmail.text, password: _controllerPassword.text);
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   Widget customerrorMessage() {
//     return Material(
//       child: Container(
//         height: 50,
//         width: 200,
//         color: const Color.fromARGB(255, 235, 65, 65),
//       ),
//     );
//   }

//   moveToHome(BuildContext context) async {
//     if (_formKey.currentState!.validate() && user!.isNotEmpty) {
//       setState(() {
//         changedButton = true;
//       });
//       print(user);
//       Auth().createWithEmailAndPassword(
//           email: _controllerEmail.text, password: _controllerPassword.text);
//       await Future.delayed(const Duration(seconds: 1));
//       if (onLoginPage) {
//         await Navigator.pushNamed(context, appRoutes.homeRoute);
//       } else {
//         isLoggedin = true;
//         onLoginPage = true;
//       }
//       _controllerPassword.text = "";
//       setState(() {
//         changedButton = false;
//       });
//     }
//   }

//   Widget RegisterPage(BuildContext context) {
//     onLoginPage = false;
//     // final size = MediaQuery.of(context).size;
//     return Material(
//         child: SingleChildScrollView(
//       child: Form(
//         child: Column(
//           children: [
//             Image.asset("assets/images/RegisterPageBG.jpg"),
//             const SizedBox(
//               height: 20,
//             ),
//             const Center(
//               child: Text(
//                 "New User",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 25, horizontal: 60),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "UserName Cannot be Empty";
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           hintText: "Enter your UserName",
//                         ),
//                       ),
//                       TextFormField(
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Email Cannot be Empty";
//                           }
//                           return null;
//                         },
//                         decoration: const InputDecoration(
//                           hintText: "Enter your Email-Id",
//                         ),
//                       ),
//                       TextFormField(
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           hintText: "Enter your Password",
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Password cannot be empty';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           hintText: "Confirm Password",
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Password cannot be empty';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 )),
//             Container(
//               // height: size.height / 20,
//               child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
//                   child: Column(
//                     children: [
//                       RadioListTile(
//                           title: const Text("Recipient"),
//                           value: "Recipient",
//                           groupValue: user,
//                           onChanged: (value) {
//                             setState(() {
//                               user = value.toString();
//                             });
//                           }),
//                       RadioListTile(
//                           title: const Text("Doctor"),
//                           value: "Doctor",
//                           groupValue: user,
//                           onChanged: (value) {
//                             setState(() {
//                               user = value.toString();
//                             });
//                           }),
//                       RadioListTile(
//                           title: const Text("Pharmaceutical"),
//                           value: "Pharmaceutical",
//                           groupValue: user,
//                           onChanged: (value) {
//                             setState(() {
//                               user = value.toString();
//                             });
//                           }),
//                     ],
//                   )),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               splashColor: Colors.redAccent,
//               onTap: () => moveToHome(context),
//               child: AnimatedContainer(
//                 duration: const Duration(seconds: 1),
//                 width: changedButton ? 50 : 150,
//                 height: 50,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     color: Colors.deepPurple,
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(changedButton ? 50 : 8))),
//                 child: changedButton
//                     ? const Icon(Icons.done)
//                     : const Center(
//                         child: Text(
//                           "Register!",
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ),
//               ),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             Container(
//               child: const Text(
//                   textAlign: TextAlign.center,
//                   "OR",
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepPurple)),
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             Container(
//               width: 75,
//               height: 35,
//               decoration: const BoxDecoration(
//                 color: Colors.deepPurple,
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//               child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     _controllerPassword.text = "";
//                     _controllerEmail.text = "";
//                     _controllerName.text = "";
//                     isLoggedin = !isLoggedin;
//                   });
//                 },
//                 child: const Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         textAlign: TextAlign.center,
//                         "Login",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             )
//           ],
//         ),
//       ),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoggedin
//         ? Material(
//             child: Column(
//               children: [
//                 Image.asset("assets/images/loginPageBG.jpg"),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Center(
//                   child: Text(
//                     "Welcome Back",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 50, horizontal: 60),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           TextFormField(
//                               controller: _controllerEmail,
//                               decoration: const InputDecoration(
//                                 hintText: "Enter your Email-Id",
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Email cannot be empty';
//                                 }
//                                 return null;
//                               }),
//                           TextFormField(
//                               controller: _controllerPassword,
//                               obscureText: true,
//                               decoration: const InputDecoration(
//                                 hintText: "Enter your Password",
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Password cannot be empty';
//                                 }
//                                 return null;
//                               })
//                         ],
//                       ),
//                     )),
//                 Material(
//                   color: Colors.deepPurple,
//                   borderRadius:
//                       BorderRadius.all(Radius.circular(changedButton ? 50 : 8)),
//                   child: InkWell(
//                     onTap: () async {
//                       setState(() async {
//                         if (_formKey.currentState!.validate()) {
//                           Auth().signInWithEmailAndPassword(
//                               email: _controllerEmail.text,
//                               password: _controllerPassword.text);
//                           changedButton = true;
//                           await Future.delayed(
//                               const Duration(milliseconds: 300));
//                           await Navigator.pushNamed(
//                               context, appRoutes.homeRoute);
//                         }
//                       });

//                       setState(() {
//                         changedButton = false;
//                       });
//                     },
//                     child: AnimatedContainer(
//                       duration: const Duration(seconds: 1),
//                       width: changedButton ? 50 : 150,
//                       height: 50,
//                       alignment: Alignment.center,
//                       child: changedButton
//                           ? const Icon(Icons.done)
//                           : const Center(
//                               child: Text(
//                                 "Login!",
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   child: const Text(
//                     textAlign: TextAlign.center,
//                     "OR",
//                     style: TextStyle(
//                         color: Colors.deepPurple,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 17),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   width: 75,
//                   height: 35,
//                   decoration: const BoxDecoration(
//                     color: Colors.deepPurple,
//                     borderRadius: BorderRadius.all(Radius.circular(8)),
//                   ),
//                   child: InkWell(
//                     onTap: () async {
//                       setState(() {
//                         isLoggedin = !isLoggedin;
//                         _controllerPassword.text = "";
//                         _controllerEmail.text = "";
//                         _controllerName.text = "";
//                       });
//                     },
//                     child: const Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             textAlign: TextAlign.center,
//                             "Register",
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         : RegisterPage(context);
//   }
// }

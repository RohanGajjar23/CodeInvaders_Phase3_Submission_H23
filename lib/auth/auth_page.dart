// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/Api/apis.dart';
import 'package:healthcare/doctors/doctor.dart';
import 'package:healthcare/models/userModel.dart';
import 'package:healthcare/recipientPage/recipient.dart';
import 'package:healthcare/widget/consts.dart';
import 'package:healthcare/widget/customButton.dart';
import 'package:page_transition/page_transition.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

enum Profession { doctor, pharmaceuticals, recipient }

class _AuthPageState extends State<AuthPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  bool onRegisteredPage = true;
  String userName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool _isAuthenticating = false;
  bool showPassword1 = false;
  bool showPassword2 = false;
  Profession? _profession;

  @override
  Widget build(BuildContext context) {
    //Submitting the data
    void submit() async {
      final isValid = _formkey.currentState!.validate();
      if (!isValid) {
        return;
      }
      FocusScope.of(context).unfocus();
      _formkey.currentState!.save();

      if (!onRegisteredPage) {
        setState(() {
          _isAuthenticating = true;
        });
        try {
          UserCredential userCredential = await Api.auth
              .signInWithEmailAndPassword(email: email, password: password);
          print("ID : " + userCredential.user!.uid);
          final data = await Api.firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();
          if (data.exists) {
            print(data.data()!.toString());
            UserModel myModel = UserModel.fromMap(data.data()!);
            print(myModel.profession);
            if (myModel.profession == Profession.recipient.toString()) {
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                      child: HomeScreen(),
                      type: PageTransitionType.leftToRightWithFade),
                  (route) => false);
            } else if (myModel.profession == Profession.doctor.toString()) {
              Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                      child: DoctorHomeScreen(),
                      type: PageTransitionType.leftToRightWithFade),
                  (route) => false);
            }
          }
        } catch (e) {
          print(e.toString());
          setState(() {
            _isAuthenticating = false;
          });
          print('data doesn\'t exist');
          return;
        }
        setState(() {
          _isAuthenticating = false;
        });
      } else {
        setState(() {
          _isAuthenticating = false;
        });
        try {
          await Api.auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) async {
            //filling the details in the model
            final UserModel user = UserModel(
                uid: value.user!.uid,
                name: userName,
                email: email,
                profession: _profession.toString());

            //converting model to a hashmap and storing in database
            await Api.firestore
                .collection('users')
                .doc(value.user!.uid)
                .set(user.toMap())
                .then((value) {
              setState(() {
                _isAuthenticating = false;
              });
              if (user.profession == Profession.recipient.toString()) {
                Navigator.of(context).pushAndRemoveUntil(
                    PageTransition(
                        child: HomeScreen(),
                        type: PageTransitionType.leftToRightWithFade),
                    (route) => false);
              }
            });
          });
        } catch (e) {
          //if something happen while creating account of use delete it firebase and signout
          await Api.firestore
              .collection('users')
              .doc(Api.auth.currentUser!.uid)
              .delete()
              .then((value) {
            setState(() {
              _isAuthenticating = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                    child: const AuthPage(),
                    type: PageTransitionType.leftToRightWithFade),
                (route) => false);
            Api.auth.signOut();
          });
        }
      }
    }

    //for responsiveness
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 166),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                onRegisteredPage
                    ? buildsticker(
                        image: image1,
                        size1: size.height / 20,
                        size2: size.height / 4)
                    : buildsticker(
                        image: image2,
                        size1: size.height / 20,
                        size2: size.height / 4),
                SizedBox(
                  height: size.height / 30,
                ),
                Text(
                  'Welcome to CureHub',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                ),
                SizedBox(
                  height: size.height / 80,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 50),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        onRegisteredPage
                            ? TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.name,
                                onSaved: (value) {
                                  userName = value!;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is needed';
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter the Username",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        TextFormField(
                          // keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            email = value!;
                          },
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Enter Valid Email';
                            }
                            if (!value.contains('@')) {
                              return 'Enter valid Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter the Email ID",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _textEditingController,
                          onSaved: (value) {
                            password = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password is needed';
                            }
                            if (value.trim().length < 6) {
                              return 'password must be 6 character long';
                            }
                            return null;
                          },
                          obscureText: !showPassword1,
                          decoration: InputDecoration(
                            hintText: "Enter the Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword1 = !showPassword1;
                                });
                              },
                              child: Icon(showPassword1
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye_rounded),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        onRegisteredPage
                            ? TextFormField(
                                onSaved: (value) {
                                  setState(() {
                                    confirmPassword = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'password is needed';
                                  }
                                  if (value.trim().length < 6 ||
                                      value.trim() !=
                                          _textEditingController.text) {
                                    return 'Password is wrong. Check Again!';
                                  }

                                  return null;
                                },
                                obscureText: !showPassword2,
                                decoration: InputDecoration(
                                  hintText: "Enter the Confirm Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showPassword2 = !showPassword2;
                                      });
                                    },
                                    child: Icon(showPassword2
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye_rounded),
                                  ),
                                ),
                              )
                            : const SizedBox(
                                height: 0,
                              ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        if (onRegisteredPage)
                          Text(
                            "Select Profession",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Colors.black,
                                    fontSize: size.height / 40),
                          ),
                        if (onRegisteredPage)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text("Doctor"),
                                  leading: Radio<Profession>(
                                      value: Profession.doctor,
                                      groupValue: _profession,
                                      onChanged: _isAuthenticating
                                          ? (value) {}
                                          : (Profession? value) {
                                              setState(() {
                                                _profession = value!;
                                              });
                                            }),
                                ),
                                ListTile(
                                  title: const Text("Pharmaceuticals"),
                                  leading: Radio<Profession>(
                                      value: Profession.pharmaceuticals,
                                      groupValue: _profession,
                                      onChanged: _isAuthenticating
                                          ? (value) {}
                                          : (Profession? value) {
                                              setState(() {
                                                _profession = value!;
                                              });
                                            }),
                                ),
                                ListTile(
                                  title: const Text("Recipient"),
                                  leading: Radio<Profession>(
                                      value: Profession.recipient,
                                      groupValue: _profession,
                                      onChanged: _isAuthenticating
                                          ? (value) {}
                                          : (Profession? value) {
                                              setState(() {
                                                _profession = value!;
                                              });
                                            }),
                                ),
                              ],
                            ),
                          ),
                        if (_isAuthenticating)
                          const CircularProgressIndicator(),
                        if (!_isAuthenticating)
                          CustomButton(
                            submit: submit,
                            label: onRegisteredPage ? "Register" : "Login",
                            isOred: false,
                          ),
                        if (!_isAuthenticating)
                          SizedBox(
                            height: size.height / 40,
                          ),
                        if (!_isAuthenticating)
                          const Text(
                              textAlign: TextAlign.center,
                              "OR",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple)),
                        if (!_isAuthenticating)
                          const SizedBox(
                            height: 25,
                          ),
                        if (!_isAuthenticating)
                          CustomButton(
                            submit: () {
                              setState(() {
                                onRegisteredPage = !onRegisteredPage;
                              });
                            },
                            label: onRegisteredPage ? "Login" : "Register",
                            isOred: true,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

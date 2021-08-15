import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitterclone/pages/parrent.dart';
import 'package:twitterclone/services/firebaseservice.dart';
import 'package:twitterclone/widgets/mywidgets.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(160, 60),
        child: MyAppBar(),
      ),
      body: SignupPageBody(),
    );
  }
}

TextEditingController textControllerEmail = TextEditingController();
TextEditingController textControllerPassword = TextEditingController();
TextEditingController textControllerConfirmPassword = TextEditingController();
String password, email, confirmpassword;

class SignupPageBody extends StatelessWidget {
  const SignupPageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      height: Get.context.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/logoblue.png',
              height: Get.context.height * 0.14,
              width: Get.context.width * 0.3,
            ),
            const Text(
              "Create your account",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
            SizedBox(
              height: Get.context.height * 0.06,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (input) =>
                  input.isValidEmail() ? null : "Enter valid email",
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              maxLines: 1,
              style: const TextStyle(fontSize: 16),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 4, bottom: 4),
                hintText: 'Enter Your Email I\'d',
                labelText: 'Enter Your Email I\'d',
              ),
              controller: textControllerEmail,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value.length < 6) {
                  return 'Must be more than 6 charater';
                } else {
                  return null;
                }
              },
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              maxLines: 1,
              style: const TextStyle(fontSize: 16),
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 4, bottom: 4),
                hintText: 'Enter Your Password',
                labelText: 'Enter Your Password',
              ),
              controller: textControllerPassword,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                if (value != textControllerPassword.text) {
                  return 'password mismatch';
                } else {
                  return null;
                }
              },
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.left,
              maxLines: 1,
              style: const TextStyle(fontSize: 16),
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 4, bottom: 4),
                hintText: 'Confirm Your Password',
                labelText: 'Confirm Your Password',
              ),
              controller: textControllerConfirmPassword,
            ),
            SizedBox(
              height: Get.context.height * 0.1,
            ),
            Container(
              padding: const EdgeInsets.all(1),
              width: Get.context.width * 0.46,
              height: Get.context.height * 0.06,
              child: ElevatedButton(
                onPressed: () async {
                  email = textControllerEmail.text;
                  password = textControllerPassword.text;
                  confirmpassword = textControllerConfirmPassword.text;
                  if (email.trim().isEmpty || password.isEmpty) {
                    MyWidgets().dialogmsg("Error : Empty Fields");
                  } else {
                    if (password == confirmpassword) {
                      MyWidgets().dialog();
                      bool issignup = await signUp(email, password);
                      if (issignup) {
                        Get.back();
                        Get.offAll(const Home());
                        textControllerEmail.clear();
                        textControllerPassword.clear();
                        textControllerConfirmPassword.clear();
                      } else {
                        Get.back();
                        MyWidgets().dialogmsg("Error in Signup");
                      }
                    } else {
                      MyWidgets().dialogmsg("Password mismatch");
                    }
                  }
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_outlined,
          size: 30,
          color: Colors.blue,
        ),
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

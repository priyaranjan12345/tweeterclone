import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitterclone/pages/login.dart';
import 'package:twitterclone/pages/signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBody(),
    );
  }
}

class AuthBody extends StatelessWidget {
  const AuthBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
              Image.asset(
                'assets/images/logoblue.png',
                height: Get.context.height * 0.2,
                width: Get.context.width * 0.3,
              ),
              const Text(
                'See what’s happening in the world right now',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                width: Get.context.width * 0.6,
                height: Get.context.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const SignupPage());
                  },
                  child: const Text(
                    "Create account",
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
              const SizedBox(
                height: 26,
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const LoginPage());
                      },
                      child: const Text(
                        ' Log in',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

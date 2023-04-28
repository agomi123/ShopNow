import 'package:e_commerce/auth/singin_page.dart';
import 'package:e_commerce/auth/singup_page.dart';
import 'package:e_commerce/models/signup_body_model.dart';
import 'package:e_commerce/widgets/Big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Auther extends StatefulWidget {
  const Auther({super.key});

  @override
  State<Auther> createState() => _AutherState();
}

class _AutherState extends State<Auther> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigText(text: 'WelCome to EcoShop!!'),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text('Sign Up'),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                  child: Text('Sign In'),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

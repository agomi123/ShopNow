import 'package:e_commerce/widgets/custom_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController tc = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: tc,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(width: 5, color: Colors.tealAccent))),
            ),
            ElevatedButton(
              onPressed: () {
              
              },
              child: Text('Pay Now'),
            )
          ],
        ),
      ),
    );
  }
}

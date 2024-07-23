import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  String? phonenumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically sign in the user after verification is done.
          await _auth.signInWithCredential(credential);
          // Navigate to home screen or next page
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failed
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(verificationId: verificationId),
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle code retrieval timeout
        },
      );
    } catch (e) {
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar:
       PreferredSize(
          preferredSize: Size.fromHeight(50.0), // set the preferred height
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 31, 221, 37),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50), // set the border radius
              ),
            ),
            toolbarHeight: 50.0, // set the toolbar height
            title: Center(child: Text('ApniBook')),
          ),
        ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 170,
            width: 170,
            child: Image.network(
                "https://arkesel.com/wp-content/uploads/2023/12/otp-illustrations.png"),
          ),
          SizedBox(
            height: 50,
          ),
          IntlPhoneField(
            initialCountryCode: 'IN',
            showCountryFlag: true,
            showDropdownIcon: true,
            onChanged: (value) {
              if (value.number.length == 10) {
                phonenumber = value.completeNumber;
                verifyPhoneNumber(context, phonenumber!);
              }
            },
            decoration: InputDecoration(
              hintText: "Phone Number",
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              fillColor: Colors.white,
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => verifyPhoneNumber(
                  context, phonenumber!), // Replace with desired phone number
              child: Text('Send OTP'),
            ),
          ),
        ],
      ),
    );
  }
}

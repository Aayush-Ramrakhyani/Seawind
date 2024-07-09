import 'package:firebase_project/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;

  OTPScreen({required this.verificationId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  Future<void> signInWithOTP(String smsCode) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 31, 221, 37),
        content: Text("Wrong OTP"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 31, 221, 37),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          toolbarHeight: 50.0,
          title: Center(child: Text('OTP Verifiy')),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 170,
              width: 170,
              child: Image.network(
                  "https://arkesel.com/wp-content/uploads/2023/12/otp-illustrations.png"),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Pinput(
            controller: _otpController,
            keyboardType: TextInputType.number,
            length: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            onCompleted: (value) {
              signInWithOTP(value);
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => signInWithOTP(_otpController.text),
            child: Text('Verify OTP'),
          ),
        ],
      ),
    );
  }
}

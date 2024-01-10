import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPCheckPage extends StatelessWidget {
  final String verificationId;

  const OTPCheckPage({Key? key, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('OTP Verification Result'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can navigate to another page or perform any action here
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPForm extends StatefulWidget {
  final String verificationId;

  const OTPForm({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  TextEditingController _otpController = TextEditingController();

  Future<void> _verifyOTP() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text,
      );

      await _auth.signInWithCredential(credential);

      // Navigate to the OTPCheckPage on successful verification
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPCheckPage(verificationId: widget.verificationId),
        ),
      );

    } catch (e) {
      // Handle sign-in error
      print('Sign In Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enter the OTP received on your phone'),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _verifyOTP,
            child: Text('Verify OTP'),
          ),
        ],
      ),
    );
  }
}

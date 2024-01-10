import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Changeemailpassword extends StatefulWidget {
  const Changeemailpassword({Key? key}) : super(key: key);

  @override
  State<Changeemailpassword> createState() => _ChangeemailpasswordState();
}

class _ChangeemailpasswordState extends State<Changeemailpassword> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  String? useremail;
  Future<void> fetchemail() async{
    final user=_auth.currentUser;
    if(user!=null){
      setState(() {
        useremail=user.email;
      });
    }
  }
  Future<void> changePassword() async {
    final user = _auth.currentUser;

    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(email: useremail!, password: _password.text);

      try {
        await user.reauthenticateWithCredential(credential);

        if (!user.emailVerified) {
          // If the user's email is not verified, send a verification email
          await user.sendEmailVerification();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification email sent. Please verify your email before changing.'),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }

        // Use the updated email here
        await _auth.sendPasswordResetEmail(email: useremail.toString());

        print('Email address changed successfully.');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passsword Reset Link Sent Succesfully'),
            backgroundColor: Colors.green,
          ),
        );
        final docsnap=await _firestore.collection('Password Change Details').doc(user.uid).set(
            {
              'Password Changed':'Yes',
              'Time Of Getting Reset Link':FieldValue.serverTimestamp()
            });
        _email.clear();
        _password.clear();
      } catch (e) {
        print('Error: $e');
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchemail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Email',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Align children at the start
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Email Address',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white)
              ),
              child: TextField(
                readOnly: true,

                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: '    $useremail',
                  hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // SizedBox(
            //   height: 40,
            // ),
            // Text(
            //   'New Email Address',
            //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(50),
            //       border: Border.all(color: Colors.white)
            //   ),
            //   child: TextField(
            //     controller: _email,
            //     style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            //     decoration: InputDecoration(
            //       alignLabelWithHint: true,
            //       hintText: '    Enter New Email Address',
            //       hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Current Password',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.white)
              ),
              child: TextField(
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: '    Verify Password',
                  hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            // Center(
            //   child: ElevatedButton(
            //     onPressed:()async{
            //       changeEmail();
            //     },
            //     style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all(Colors.green),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30),
            //         ),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //       child: Text(
            //         '        Change Email        ',
            //         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Center(
              child: ElevatedButton(
                onPressed: changePassword,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    '        Change Password        ',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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

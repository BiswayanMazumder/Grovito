import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:whatscall/Homepage.dart';
import 'package:whatscall/navbar.dart';
import 'package:whatscall/profile.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool pwvisible=false;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  String androidId = 'Fetching...';
  String ipAddress = "Fetching...";
  String currentandroidid='Fetching';
  String currentipAddress='Fetching';
  Future<void> getcurrentDeviceInfo() async {
    try {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

      setState(() {
        currentandroidid = androidInfo.androidId ?? 'Not available';
      });

      print('Current Android id: $currentandroidid');
    } catch (e) {
      print('Error getting device information: $e');
    }
  }
  Future<void> fetchcurrentIpAddress() async {
    try {
      var response = await http.get(Uri.parse('https://api64.ipify.org'));
      if (response.statusCode == 200) {
        // Parse the JSON response and update the state with the IP address.
        setState(() {
          currentipAddress = response.body;
        });
        print('Current ip address: $currentipAddress');
      } else {
        throw Exception('Failed to load IP address');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  Future<void> fetchIpAddress() async {
    try {
      var response = await http.get(Uri.parse('https://api64.ipify.org'));
      if (response.statusCode == 200) {
        // Parse the JSON response and update the state with the IP address.
        setState(() {
          ipAddress = response.body;
        });
        print('ip address: $ipAddress');
      } else {
        throw Exception('Failed to load IP address');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  Future<void> getDeviceInfo() async {
    try {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

      setState(() {
        androidId = androidInfo.androidId ?? 'Not available';
      });

      print('Android id: $androidId');
    } catch (e) {
      print('Error getting device information: $e');
    }
  }
  Future<void> loginuser() async{
    try{
      await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      try{
        final user=_auth.currentUser;
        final docsnap=await _firestore.collection('User Device Info').doc(user!.uid).set(
            {
              'USER EMAIL':user.email,
              'USER VERIFIED':user.emailVerified,
              'MAC ADDRESS':androidId,
              'IP ADDRESS':ipAddress,
            });
        print(isprem);
      }catch(e){
        print('Error is: $e');
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavBar()),
      );
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter correct credentials',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
  Future<void> signInWithEmailLink() async {
    try {
      await _auth.sendSignInLinkToEmail(
        email: _emailController.text,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://quantumharmony.page.link/passwordlesslogin',
          androidPackageName: 'com.example.whatscall',
          handleCodeInApp: true,
        ),
      );

      // Show a message to the user that an email has been sent.

      // Check if the current link is a sign-in link
      final bool isSignInLink =
      await _auth.isSignInWithEmailLink('https://quantumharmony.page.link/passwordlesslogin');

      if (isSignInLink) {
        // Navigate to the next screen if the link is verified
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBar()),
        );
      } else {
        // Handle the case where the link is not verified
        print('Invalid sign-in link');
      }
    } catch (e) {
      print('Error sending sign-in link: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter email',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
  bool isprem=false;
  Future<void> PremSubs() async{
    final user=_auth.currentUser;
    if(user!=null){
      final docsnap=await _firestore.collection('Payments for Premium').doc(user.uid).get();
      if(docsnap.exists){
        setState(() {
          isprem=true;
        });
        print('premium:$isprem');
      }
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceInfo();
    fetchIpAddress();
    fetchcurrentIpAddress();
    getcurrentDeviceInfo();
    PremSubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text('Email Address',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text('Enter Password',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 35),),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: pwvisible?false:true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      pwvisible=!pwvisible;
                    });
                  }, icon: Icon(pwvisible?Icons.lock_open_rounded:Icons.lock_rounded,color: Colors.black,)),
                  hintText: 'Enter your password',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: ()async{
                  try{
                    final user=_auth.currentUser;
                    await _auth.sendPasswordResetEmail(email: _emailController.text);
                    MotionToast.success(
                        title:  Text("Password Reset Link Sent",style: TextStyle(fontWeight: FontWeight.bold),),
                        description:  Text("Successfully sent password reset link")
                    ).show(context);
                  }catch(e){
                    MotionToast.warning(
                        title:  Text("Error Sending Reset Link",style: TextStyle(fontWeight: FontWeight.bold),),
                        description:  Text("OOPS! We encountered a problem sending password reset link.")
                    ).show(context);
                  }
                },
                    child: Text('Reset Password',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ElevatedButton(
                onPressed: ()async{
                  loginuser();
                },
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
                    '        Login        ',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: ElevatedButton(
                onPressed: signInWithEmailLink,
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
                    '        Login Password Less        ',
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

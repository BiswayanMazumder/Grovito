import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatscall/Homepage.dart';
import 'package:whatscall/loginpage.dart';
import 'package:whatscall/navbar.dart';
import 'package:whatscall/phonelogin.dart';
import 'package:whatscall/signup.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grovito',
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.network('https://firebasestorage.googleapis.com/v0/b/hangouts-b50'
              'ce.appspot.com/o/QuantumHarmony%2F172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.pn'
              'g?alt=media&token=e485aaf3-030e-43f0-afe1-b5ca39c7e861'),
          nextScreen: user!=null? NavBar():LoginPage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.green));
  }
}


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showpw=false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  signInwithGoogle()async{
    GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;
    AuthCredential credential=GoogleAuthProvider.credential(
        accessToken:googleAuth?.accessToken,
        idToken:googleAuth?.idToken
    );
    UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);

  }
  bool _isLoggingIn = false;
  String errorMessage='';
  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoggingIn = true;
      errorMessage = ''; // Clear any existing error message
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      // Navigate to the home screen or another screen upon successful login
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (e) {
      setState(() {
        if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
          errorMessage = 'Please Enter Correct Credentials';
        }
        else if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
          errorMessage = 'Please Enter Every Fields';
        }
        _emailController.clear();
        _passwordController.clear();
      });
      print("Error: $e");
    } finally {
      if (errorMessage.isNotEmpty) {
        // Schedule the removal of the error message after 5 seconds
        Timer(Duration(seconds: 5), () {
          setState(() {
            errorMessage = '';
          });
        });
      }
      setState(() {
        _isLoggingIn = false;
      });
    }
  }
  Future<void> sendPasswordResetEmail() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password reset email sent successfully to ${_emailController.text}',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );
    } catch(e){
      print('Error email is ${e}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email not registered',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/hangouts-b50'
                  'ce.appspot.com/o/QuantumHarmony%2F172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.pn'
                  'g?alt=media&token=e485aaf3-030e-43f0-afe1-b5ca39c7e861')),
              SizedBox(
                height: 50,
              ),
              Text('Millions of songs.\nFree on Grovito',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,
              color: Colors.white),),
              SizedBox(
                height: 80,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
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
                      '        Sign Up for Free        ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Phone()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      '📱 Continue With Phone Number',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => loginpage()));
              }, 
                  child:Text('Log in',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Error signing in: $error');
    }
  }
}


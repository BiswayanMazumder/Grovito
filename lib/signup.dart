import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatscall/Homepage.dart';
import 'package:whatscall/main.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  bool showpw=false;
  bool registered=false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Future<void> registerdetails() async{
    final user=_auth.currentUser;
    await _firestore.collection('Users').doc(user?.uid).set({
      'name':_nameController.text,
      'email':_emailController.text,
      'time of joining':FieldValue.serverTimestamp(),
      'registered':'true'
    });
  }
  Future<void> signupuser() async{
    try {
      if(_nameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
        final user=_auth.currentUser;
        await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
        await user?.sendEmailVerification();
        registerdetails();
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                'Sign Up Successful.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ),
        );
        print('Updated details');
      }
      else if(_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please enter every fields',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Email already registered',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      print('Error Updating details ${e}');
    }
  }
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Create account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text("What's your email address\nand password?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
              fontSize: 30
              ),),
              SizedBox(
                height: 70,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
              ),
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
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: showpw?false:true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        showpw=!showpw;
                      });
                    }, icon: Icon(showpw?Icons.lock:Icons.lock_open,color: Colors.black,))
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
          Row(
            children: [
              Theme(
                data: ThemeData.light().copyWith(
                  unselectedWidgetColor: Colors.white,
                ),
                child: Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                      print(isChecked);
                    });
                  },
                ),
              ),
              SizedBox(width: 10,),
              Text('By checking you are accepting our\nterms and conditions',style: TextStyle(color: Colors.white),)
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
                  onPressed: () {
                    if(isChecked){
                      signupuser();
                    }
                    else if(isChecked==false){
                      SnackBar(
                        content: Center(
                          child: Text(
                            'Please accept T&C',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(isChecked?Colors.green:Colors.grey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      '        Signup        ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

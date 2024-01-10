import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class Emailaddresspage extends StatefulWidget {
  const Emailaddresspage({Key? key}) : super(key: key);

  @override
  State<Emailaddresspage> createState() => _EmailaddresspageState();
}

class _EmailaddresspageState extends State<Emailaddresspage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String email="loading";
  
  Future<void> fetchemailandverified()async{
    final user=_auth.currentUser;
    if(user!=null){
      setState(() {
        email=user.email!;
      });
    }
  }
  Future<void> fetchverified()async{
    final user=_auth.currentUser;
    if(user!=null){
      if(user.emailVerified){
        CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.check,color: Colors.black,));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchemailandverified();
    fetchverified();
  }
  @override
  Widget build(BuildContext context) {
    final user=_auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Address'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/651bfb2d40b8880da24a/files/65852372870de0582c03/view?project=64e0600003aac5802fbc&mode=admin')),
            SizedBox(
              height: 30,
            ),
            Text('  Email Address help you access your account,It is not visible to others',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,
            fontSize: 12),),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('   Email',style: TextStyle(color: Colors.grey),)),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('   ${email}',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 20,
                  ),
                  if(user!.emailVerified)
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.check,color: Colors.black,),
                        ),
                      ],
                    ),
                  if(user!.emailVerified==false)
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close,color: Colors.black,),
                        ),
                      ],
                    )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if(user!.emailVerified==false)
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text('Not Verified',style: TextStyle(color: Colors.red),),
                ],
              ),
            if(user!.emailVerified)
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text('Verified',style: TextStyle(color: Colors.green),),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

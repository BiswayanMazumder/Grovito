import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatscall/account.dart';
import 'dart:io';

import 'package:whatscall/myprofile.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _imageUrl;
  bool _uploading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<void> _loadProfilePicture() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final docSnapshot = await _firestore.collection('profile_pictures').doc(user.uid).get();
        if (docSnapshot.exists) {
          setState(() {
            _imageUrl = docSnapshot.data()?['url_user1'];
          });
        }
      } catch (e) {
        print('Error loading profile picture: $e');
      }
    }
  }
  Future<void> _uploadImage() async {
    try {
      final user = _auth.currentUser;
      if (user != null && _image != null) {
        setState(() {
          _uploading = true;
        });
        final ref = _storage.ref().child('profile_pictures/${user.uid}');
        await ref.putFile(_image!);
        final imageUrl = await ref.getDownloadURL();

        await user.updateProfile(photoURL: imageUrl);

        // Store the URL in Firestore
        await _firestore.collection('profile_pictures').doc(user.uid).set({
          'url_user1': imageUrl,
          'time stamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          _uploading = false;
          _imageUrl = imageUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile picture uploaded successfully!'),
        ));
      }
    } catch (e) {
      setState(() {
        _uploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error uploading profile picture: $e'),
      ));
    }
  }
  String?username;
  Future<void> fetchusername() async{
    final user=_auth.currentUser;
    final docsnap=await _firestore.collection('Users').doc(user?.uid).get();
    if(docsnap.exists){
      setState(() {
        username=docsnap.data()?['name'];
      });
    }
  }
  String? useremail;
  Future<void> fetchemail() async{
    final user=_auth.currentUser;
    setState(() {
      useremail=user?.email;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProfilePicture();
    fetchusername();
    fetchemail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfile(),));
              print('hi');
            },
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),elevation: MaterialStatePropertyAll(0)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Stack(
                      children: [
                        _uploading
                            ? CircularProgressIndicator(
                          color: Colors.red,
                        ) // Show the progress indicator while uploading
                            : _imageUrl == null
                            ? CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 40,
                          child: Image(
                            image: NetworkImage(
                                'https://cloud.appwrite.io/v1/storage/buckets/651bfb2d40b8880da24a/files'
                                    '/65840a71eda6a7f26471/view?project=64e0600003aac5802fbc&mode=admin'),
                          ),
                        )
                            : CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 40,
                          backgroundImage: NetworkImage(_imageUrl!),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Center(child: Text('${username}\n${useremail}',style: TextStyle(fontWeight: FontWeight.w500,fontSize:13,color: Colors.black),))
                  ],
                ),),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.black,
              indent: 50,
              endIndent: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.key,color: Colors.black,),
                  SizedBox(width: 20,),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Account(),));
                  },
                      child: Text('Account',style: TextStyle(color: Colors.black),)),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                  ),
                  Text('Security Notifications and change email',style: TextStyle(fontWeight: FontWeight.w300,color: Colors.grey),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

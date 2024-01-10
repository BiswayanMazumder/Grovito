import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:whatscall/Homepage.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
  String username='Grovito User';
  TextEditingController _newusername=TextEditingController();
  Future<void> updateusername() async{
    final user=_auth.currentUser;
    if(user!=null){
      final docsnap=await _firestore.collection('Users').doc(user.uid).set(
          {
            'name':_newusername.text,
            'Date And Time Of Name Change':FieldValue.serverTimestamp()
          });
      setState(() {
        username=_newusername.text;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    }
  }
  Future<void> fetchusername() async{
    final user=_auth.currentUser;
    final docsnap=await _firestore.collection('Users').doc(user?.uid).get();
    if(docsnap.exists){
      setState(() {
        username=docsnap.data()?['name'];
      });
    }
  }
  Future<void> _pickImage() async {
    final user = _auth.currentUser;
    if (user!.emailVerified) {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _uploadImage();
      }
    } else {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _uploadImage();
      }
    }
  }
  String? useremail;
  Future<void> fetchemail() async{
    final user=_auth.currentUser;
    setState(() {
      useremail=user?.email;
    });
  }
  String status='None';
  Future<void> fetchstatus() async {
    final user = _auth.currentUser;
    final docSnap = await _firestore.collection('Users').doc(user?.uid).get();

    if (docSnap.exists) {
      setState(() {
        final fullStatus = docSnap.data()?['status'];

        // Adjust the word limit as per your requirement
        final wordLimit = 3;

        // Split the text into words
        final words = fullStatus.split(' ');

        // Take the first 'wordLimit' words and join them back
        // Add ellipsis (...) if there are more words
        status = words.take(wordLimit).join(' ') +
            (words.length > wordLimit ? '...' : '');
      });
    }
  }

  TextEditingController _newstatus=TextEditingController();
  Future<void> updatestatus() async{
    final user=_auth.currentUser;
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Your Status',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
          elevation: 10,
          shadowColor: Colors.green,
          actions: [
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _newstatus,
                  maxLength: 138,
                  decoration: InputDecoration(
                      labelText: 'Enter Status',
                      hintText: 'Status',

                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      _newstatus.clear();
                      Navigator.pop(context);
                    }, child: Text('Cancel')),
                    TextButton(onPressed: ()async{
                      await _firestore.collection('Users').doc(user?.uid).update({
                        'status':_newstatus.text,
                        'Time Of Update Of Status':FieldValue.serverTimestamp(),
                      });
                      setState(() {
                        status=_newstatus.text;
                      });
                      _newusername.clear();
                      Navigator.pop(context);
                    }, child: Text('OK')),
                  ],
                ),
              ],
            )
          ],
        );
      },);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProfilePicture();
    fetchusername();
    fetchemail();
    fetchstatus();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
          _newusername.clear();
        },
            icon: Icon(Icons.close,color: Colors.white,)),
        title: Text('Edit Profile'),
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        actions: [
          TextButton(onPressed: (){
            updateusername();

          },
              child: Text('Save',style: TextStyle(color: Colors.white),))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
           children: [
             SizedBox(
               height: 30,
             ),
             Center(
               child: Stack(
                 children: [
                   _uploading
                       ? CircularProgressIndicator(
                     color: Colors.red,
                   ) // Show the progress indicator while uploading
                       : _imageUrl == null
                       ? CircleAvatar(
                     backgroundColor: Colors.black,
                     radius: 100,
                     child: Image(
                       image: NetworkImage(
                           'https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c-d53a-433d-8619-7e851aeee650'),
                     ),
                   )
                       : CircleAvatar(
                     backgroundColor: Colors.black,
                     radius: 100,
                     backgroundImage: NetworkImage(_imageUrl!),
                   ),
                   Positioned(
                     right:5,
                     bottom: -5, // Adjust the bottom value to position the icon
                     child: IconButton(
                       onPressed: _pickImage,
                       icon: Icon(Icons.camera_alt_rounded,color: Colors.white,),
                     ),
                   ),
                   SizedBox(
                     height: 30,
                   ),
                 ],
               ),
             ),
             SizedBox(
               height: 30,
             ),
             TextField(
               controller: _newusername,
               style: TextStyle(color: Colors.white), // Set text color to white
               decoration: InputDecoration(
                 hintText: username,
                 border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                 hintStyle: TextStyle(
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                 ),
                 alignLabelWithHint: true, // Center the hint text
               ),
             )
           ],
        ),
      ),
    );
  }
}

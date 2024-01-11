import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? user1 = 'User 1';
  String? _imageUrl;
  bool _uploading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _loadProfilePicture() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final docSnapshot =
        await _firestore.collection('profile_pictures').doc(user.uid).get();
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProfilePicture();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search',style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30),),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Stack(
                  children: [
                    _uploading
                        ? CircularProgressIndicator(
                      color: Colors.red,
                    )
                        : _imageUrl == null
                        ? CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: Image(
                        image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com'
                                '/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c'
                                '-d53a-433d-8619-7e851aeee650'),
                      ),
                    )
                        : CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 20,
                      backgroundImage: NetworkImage(_imageUrl!),
                    ),
                  ]
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: (){},
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'What do you want to listen to?',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.search,color: Colors.black,)
                    ),
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text('Explore your genres',style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                      'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Grovito/genres/',
                      width: 100, // Adjust the width as needed
                      height: 400, // Adjust the height as needed to make it long
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

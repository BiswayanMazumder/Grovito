import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatscall/359.dart';
import 'package:whatscall/Been%20a%20while.dart';
import 'package:whatscall/Hola%20Amigo.dart';
import 'package:whatscall/WohRaat.dart';
import 'package:whatscall/bazigaar.dart';
import 'package:whatscall/chorni.dart';
import 'package:whatscall/iguessKRSNA.dart';
import 'package:whatscall/kaam25.dart';
import 'package:whatscall/khattaflow.dart';
import 'package:whatscall/machayenge%204.dart';
import 'package:whatscall/mirchi.dart';
import 'package:whatscall/nocap.dart';
import 'package:whatscall/nocompetition.dart';
import 'package:whatscall/satya.dart';
import 'package:whatscall/ykwim.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: divinePlaylist(),
    );
  }
}

class divinePlaylist extends StatefulWidget {
  @override
  _divinePlaylistState createState() => _divinePlaylistState();
}

class _divinePlaylistState extends State<divinePlaylist> {
  final String clientId = 'ca8cc93a9b584f03b31cee0df3ad3d72';
  final String clientSecret = '4130261ae29645468e8e94fc9b1ac269';
  final String playlistId = '37i9dQZF1DZ06evO2GAl7Q';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLikedplaylist = false;
  bool isykwimhidden=false;
  bool iskhattahidden=false;
  bool ykwimHidden = false;
  bool khattaHidden=false;
  bool nocapHidden=false;
  bool wohraathidden=false;
  bool ykwimLiked = false; // Initialize with the default value
  bool khattaflowlikedd=false;
  bool wohraatlike=false;
  bool machanyenge4liked=false;
  bool holaamigoliked=false;
  bool nocapliked=false;
  bool iguessliked=false;
  bool beenawhileliked=false;
  Future<void> beenawhileLiked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Satya Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.beenawhileliked = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.beenawhileliked = true; // Update the state variable
        });
      }
    }
  }
  Future<void> fetchbeenawhilelikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Satya Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'isLiked' variable
        setState(() {
          beenawhileliked = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }
    }
  }
  Future<void> iguessLiked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Mirchi Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.iguessliked = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.iguessliked = true; // Update the state variable
        });
      }
    }
  }
  Future<void> fetchiguesslikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Mirchi Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'isLiked' variable
        setState(() {
          iguessliked = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }
    }
  }
  Future<void> nocapLiked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('No Cap Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.nocapliked = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.nocapliked = true; // Update the state variable
        });
      }
    }
  }
  Future<void> fetchnocaplikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('No Cap Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'isLiked' variable
        setState(() {
          nocapliked = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }
    }
  }
  Future<void> bazigaarliked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Bazigaar Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.holaamigoliked = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.holaamigoliked = true; // Update the state variable
        });
      }
    }
  }
  Future<void> fetchbazigaarlikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Bazigaar Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'isLiked' variable
        setState(() {
          holaamigoliked = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }
    }
  }
  Future<void> Kaam25liked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Kaam 25 Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.machanyenge4liked = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.machanyenge4liked = true; // Update the state variable
        });
      }
    }
  }
  Future<void> fetchkaam25likeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Kaam 25 Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'isLiked' variable
        setState(() {
          machanyenge4liked = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }
    }
  }
  Future<void> nocompetitionliked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('No Competition Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.wohraatlike = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.wohraatlike = true; // Update the state variable
        });
      }
    }
  }
  Future<void> fetchnocompetitionLikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('No Competition Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'ykwimLiked' variable
        setState(() {
          wohraatlike = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }
    }
  }
  Future<void> Chorniliked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Chorni Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.khattaflowlikedd = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.khattaflowlikedd = true; // Update the state variable
        });
      }
    }
  }
  Future<void> fetchchorniLikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Chorni Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'ykwimLiked' variable
        setState(() {
          khattaflowlikedd = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }
    }
  }
  Future<void> am359likes() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('3:59 AM Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.ykwimLiked = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.ykwimLiked = true; // Update the state variable
        });
      }
    }
  }

  Future<void> fetcham359LikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('3:59 AM Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'ykwimLiked' variable
        setState(() {
          ykwimLiked = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }
    }
  }

  Future<void> fetchworaathidden() async {
    final user = _auth.currentUser;
    final docsnap =
    await _firestore.collection('Wo Raat hidden').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        nocapHidden = docsnap.data()?['Wo Raat Hidden'] ?? false;
      });
    }
  }
  Future<void> fetchnocaphidden() async {
    final user = _auth.currentUser;
    final docsnap =
    await _firestore.collection('No Cap hidden').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        nocapHidden = docsnap.data()?['NOCapHidden'] ?? false;
      });
    }
  }
  Future<void> fetchykwimhidden() async {
    final user = _auth.currentUser;
    final docsnap =
    await _firestore.collection('YKWIM hidden').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        isykwimhidden = docsnap.data()?['YKWIMHidden'] ?? false;
      });
    }
  }
  Future<void> fetchkhattahidden() async {
    final user = _auth.currentUser;
    final docsnap =
    await _firestore.collection('Khatta Flow hidden').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        iskhattahidden = docsnap.data()?['KhattaHidden'] ?? false;
      });
    }
  }

  Future<String> _getAccessToken() async {
    final String tokenEndpoint = 'https://accounts.spotify.com/api/token';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';

    try {
      final response = await http.post(
        Uri.parse(tokenEndpoint),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String accessToken = data['access_token'];
        print('Access Token: $accessToken');
        return accessToken;
      } else {
        print('Failed to get access token');
        return '';
      }
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  Future<Map<String, dynamic>> _getPlaylistDetails(String accessToken) async {
    final String playlistEndpoint =
        'https://api.spotify.com/v1/playlists/$playlistId';

    try {
      final response = await http.get(
        Uri.parse(playlistEndpoint),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        return playlistData;
      } else {
        print('Failed to get playlist details');
        print('isykwimhidden:${isykwimhidden}');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  void khattaflowLiked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef =
      _firestore.collection('DIVINE Playlist Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, toggle the 'IsLiked' field
        final isLiked = docSnapshot.data()?['IsLiked'] ?? false;
        await docRef.update({'IsLiked': !isLiked});
        setState(() {
          this.isLikedplaylist = !isLiked; // Update the state variable
        });
      } else {
        // If the document doesn't exist, create it with 'IsLiked' set to true
        await docRef.set({
          'IsLiked': true,
          'Time Of Liking': FieldValue.serverTimestamp(),
        });
        setState(() {
          this.isLikedplaylist = true; // Update the state variable
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Initial fetch of like status
    fetchLikeStatus();
    fetchykwimhidden();
    fetchkhattahidden();
    fetchnocaphidden();
    fetchworaathidden();
    fetcham359LikeStatus();
    fetchchorniLikeStatus();
    fetchnocompetitionLikeStatus();
    fetchkaam25likeStatus();
    fetchbazigaarlikeStatus();
    fetchnocaplikeStatus();
    fetchiguesslikeStatus();
    fetchbeenawhilelikeStatus();
  }

  Future<void> fetchLikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef =
      _firestore.collection('DIVINE Playlist Liked').doc(user.uid);

      // Get the current document snapshot
      final docSnapshot = await docRef.get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // If the document exists, update the 'isLiked' variable
        setState(() {
          isLikedplaylist = docSnapshot.data()?['IsLiked'] ?? false;
        });
      }

      // Listen for changes in the like status
      docRef.snapshots().listen((event) {
        if (event.exists) {
          // Update the 'isLiked' variable when the document changes
          setState(() {
            isLikedplaylist = event.data()?['IsLiked'] ?? false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200]!,
      body: FutureBuilder(
        future: _getAccessToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final accessToken = snapshot.data as String;
            return FutureBuilder(
              future: _getPlaylistDetails(accessToken),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final playlistData = snapshot.data as Map<String, dynamic>;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.brown[900]!, // Dark blue
                          Colors.brown[300]!, // Light blue
                        ],
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Image.network(
                              playlistData['images'][0]['url'],
                              height: 300, // Adjust the height as needed
                              width: 300, // Adjust the width as needed
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${playlistData['description']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blueGrey[900]!,
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com'
                                        '/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c'
                                        '-d53a-433d-8619-7e851aeee650'),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${playlistData['owner']['display_name']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                ' ${playlistData['followers']['total']} saves . 2h 45min',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: IconButton(
                                  icon: Icon(
                                    isLikedplaylist
                                        ? Icons.check
                                        : Icons.add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    khattaflowLiked();
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('${isLikedplaylist?'Added to Playlist':'Add To Playlist'}',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),)
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          if(ykwimLiked || khattaflowlikedd || wohraatlike ||machanyenge4liked || holaamigoliked || nocapliked || iguessliked || beenawhileliked)
                            Center(
                                child: Text('Liked Songs',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                                )
                            ),
                          if(ykwimLiked)
                            Column(
                              children: [

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b27383c726c3768d0981c76acd38',
                                    ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('3:59 AM\nDIVINE',style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        ykwimLiked ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        am359likes();
                                        fetcham359LikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if(khattaflowlikedd)
                            Column(
                              children: [

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(image: NetworkImage("https://i.scdn.co/image/ab67616d0000b27392c32f95f518a1153a339117",
                                    ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Chorni\nSiddhu Moosewala, DIVINE',style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        khattaflowlikedd ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Chorniliked();
                                        fetchchorniLikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if(wohraatlike)
                            Column(
                              children: [

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b2732f8aea22b8e62bd6084e7094',
                                    ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('No Competition\nDIVINE, Jaas Manak',style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        wohraatlike ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        nocompetitionliked();
                                        fetchnocompetitionLikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if(machanyenge4liked)
                            Column(
                              children: [

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b2733179c08eecad4cf6f5c68e58',
                                    ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Kaam 25 - Sacred Games\nDIVINE',style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        machanyenge4liked ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Kaam25liked();
                                        fetchkaam25likeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if(holaamigoliked)
                            Column(
                              children: [

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b2733f1acedcbf16cc9b155e5700',
                                    ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Bazigaar\nDIVINE , Armani White',style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        holaamigoliked ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        bazigaarliked();
                                        fetchbazigaarlikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if(nocapliked)
                            Column(
                              children: [

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b2734c6edea22082734e5683c7b9',
                                    ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('No Cap\nKRSNA',style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        nocapliked ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        nocapLiked();
                                        fetchnocaplikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if(iguessliked)
                            Column(
                              children: [

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(image: NetworkImage("https://i.scdn.co/image/ab67616d0000b2735ac573b4ef43591be197a78b",
                                    ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Mirchi\nDIVINE',style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        iguessliked ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        iguessLiked();
                                        fetchiguesslikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if(beenawhileliked)
                            Column(
                              children: [

                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(image: NetworkImage("https://i.scdn.co/image/ab67616d0000b27383c726c3768d0981c76acd38",
                                    ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Satya\nDIVINE',style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.w500),),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        beenawhileliked ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        beenawhileLiked();
                                        fetchbeenawhilelikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text('Songs',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b27383c726c3768d0981c76acd38',
                              ),
                                height: 100,
                                width: 100,
                              ),

                              TextButton(onPressed: ()async{
                                Navigator.push(context, MaterialPageRoute(builder: (context) => am359(),));
                              },
                                  child:Text('3:59 AM\nDIVINE',style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  ykwimLiked ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  am359likes();
                                  fetcham359LikeStatus();
                                },
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(image: NetworkImage("https://i.scdn.co/image/ab67616d0000b27392c32f95f518a1153a339117",
                              ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => chorni(),));
                              },
                                  child:Text('Chorni\nSiddhu Moosewala, DIVINE',style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  khattaflowlikedd ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Chorniliked();
                                  fetchchorniLikeStatus();
                                },
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b2732f8aea22b8e62bd6084e7094',
                              ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),

                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => nocompetition()));
                              },
                                  child:Text('No Competition\nDIVINE, Jaas Manak',style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  wohraatlike ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  nocompetitionliked();
                                  fetchnocompetitionLikeStatus();
                                },
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b2733179c08eecad4cf6f5c68e58',
                              ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => kaam25()));
                              },
                                  child:Text('Kaam 25 - Sacred Games\nDIVINE',style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  machanyenge4liked? Icons.favorite : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Kaam25liked();
                                  fetchkaam25likeStatus();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b2733f1acedcbf16cc9b155e5700',
                              ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => bazigaar()));
                              },
                                  child:Text('Bazigaar\nDIVINE , Armani White',style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  holaamigoliked ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  bazigaarliked();
                                  fetchbazigaarlikeStatus();
                                },
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(image: NetworkImage("https://i.scdn.co/image/ab67616d0000b27383c726c3768d0981c76acd38",
                              ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => satya()));
                              },
                                  child:Text('Satya\nDIVINE',style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  beenawhileliked ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  beenawhileLiked();
                                  fetchbeenawhilelikeStatus();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(image: NetworkImage("https://i.scdn.co/image/ab67616d0000b2735ac573b4ef43591be197a78b",
                              ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => mirchi_dart()));
                              },
                                  child:Text('Mirchi\nDIVINE',style: TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  iguessliked ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  iguessLiked();
                                  fetchiguesslikeStatus();
                                },
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 50,
                          // ),
                          // Row(
                          //   children: [
                          //     SizedBox(
                          //       width: 5,
                          //     ),
                          //     Image(image: NetworkImage('https://i.scdn.co/image/ab67616d0000b2734c6edea22082734e5683c7b9',
                          //     ),
                          //       height: 100,
                          //       width: 100,
                          //     ),
                          //
                          //     TextButton(onPressed: ()async{
                          //       Navigator.push(context, MaterialPageRoute(builder: (context) => NoCap()));
                          //     },
                          //         child:Text('No Cap\nKRSNA',style: TextStyle(color: Colors.black,
                          //             fontWeight: FontWeight.bold),)),
                          //     Spacer(),
                          //     IconButton(
                          //       icon: Icon(
                          //         nocapliked ? Icons.favorite : Icons.favorite_border,
                          //         color: Colors.green,
                          //         size: 30,
                          //       ),
                          //       onPressed: () {
                          //         nocapLiked();
                          //         fetchnocaplikeStatus();
                          //       },
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 50,
                          // ),
                          //To be added more for KR$NA  Playlist
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatscall/Been%20a%20while.dart';
import 'package:whatscall/Hola%20Amigo.dart';
import 'package:whatscall/WohRaat.dart';
import 'package:whatscall/iguessKRSNA.dart';
import 'package:whatscall/khattaflow.dart';
import 'package:whatscall/machayenge%204.dart';
import 'package:whatscall/nocap.dart';
import 'package:whatscall/ykwim.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KR$NAPlaylist(),
    );
  }
}

class KR$NAPlaylist extends StatefulWidget {
  @override
  _KR$NAPlaylistState createState() => _KR$NAPlaylistState();
}

class _KR$NAPlaylistState extends State<KR$NAPlaylist> {
  final String clientId = 'ca8cc93a9b584f03b31cee0df3ad3d72';
  final String clientSecret = '4130261ae29645468e8e94fc9b1ac269';
  final String playlistId = '37i9dQZF1DZ06evO3iW9AR';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLikedplaylist = false;
  bool isykwimhidden = false;
  bool iskhattahidden = false;
  bool ykwimHidden = false;
  bool khattaHidden = false;
  bool nocapHidden = false;
  bool wohraathidden = false;
  bool ykwimLiked = false; // Initialize with the default value
  bool khattaflowlikedd = false;
  bool wohraatlike = false;
  bool machanyenge4liked = false;
  bool holaamigoliked = false;
  bool nocapliked = false;
  bool iguessliked = false;
  bool beenawhileliked = false;
  Future<void> beenawhileLiked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Been a While Liked').doc(user.uid);

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
      final docRef = _firestore.collection('Been a While Liked').doc(user.uid);

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
      final docRef = _firestore.collection('I Guess Liked').doc(user.uid);

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
      final docRef = _firestore.collection('I Guess Liked').doc(user.uid);

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

  Future<void> holaamigoLiked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Hola Amigo Liked').doc(user.uid);

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

  Future<void> fetchholaamigolikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Hola Amigo Liked').doc(user.uid);

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

  Future<void> machayengeLiked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Machayenge 4 Liked').doc(user.uid);

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

  Future<void> fetchmachayenge4likeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Machayenge 4 Liked').doc(user.uid);

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

  Future<void> wohraatLiked() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Woh Raat Liked').doc(user.uid);

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

  Future<void> fetchwohratLikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Woh Raat Liked').doc(user.uid);

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

  Future<void> khattaLike() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Khatta Flow Liked').doc(user.uid);

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

  Future<void> fetchkhattaLikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Khatta Flow Liked').doc(user.uid);

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

  Future<void> ykwimLike() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Ykwim Liked').doc(user.uid);

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

  Future<void> fetchYkwimLikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef = _firestore.collection('Ykwim Liked').doc(user.uid);

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
          _firestore.collection('KRSNA Playlist Liked').doc(user.uid);

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
    fetchYkwimLikeStatus();
    fetchkhattaLikeStatus();
    fetchwohratLikeStatus();
    fetchmachayenge4likeStatus();
    fetchholaamigolikeStatus();
    fetchnocaplikeStatus();
    fetchiguesslikeStatus();
    fetchbeenawhilelikeStatus();
  }

  Future<void> fetchLikeStatus() async {
    final user = _auth.currentUser;

    if (user != null) {
      final docRef =
          _firestore.collection('KRSNA Playlist Liked').doc(user.uid);

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
                          Colors.blueGrey[900]!, // Dark blue
                          Colors.blueGrey[200]!, // Light blue
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
                                ' ${playlistData['followers']['total']} saves . 2h 55min',
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
                                    isLikedplaylist ? Icons.check : Icons.add,
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
                              Text(
                                '${isLikedplaylist ? 'Added to Playlist' : 'Add To Playlist'}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          if (ykwimLiked ||
                              khattaflowlikedd ||
                              wohraatlike ||
                              machanyenge4liked ||
                              holaamigoliked ||
                              nocapliked ||
                              iguessliked ||
                              beenawhileliked)
                            Center(
                                child: Text(
                              'Liked Songs',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                          if (ykwimLiked)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        'https://i.scdn.co/image/ab67616d0000b2737162dc7fbd69d82805a2aab1',
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Ykwim\nKaran Aujla, KRSNA,Mehar Vaani',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        ykwimLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        ykwimLike();
                                        fetchYkwimLikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if (khattaflowlikedd)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        'https://i.scdn.co/image/ab67616d0000b273b7b544e5241b69574edc814e',
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Khatta Flow\nSeedhe Maut, KRSNA',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        khattaflowlikedd
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        khattaLike();
                                        fetchkhattaLikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if (wohraatlike)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        'https://i.scdn.co/image/ab67616d0000b2738eeefdbfd14ad10510ba6c86',
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Woh Raat\nRaftaar, KRSNA',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        wohraatlike
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        wohraatLiked();
                                        fetchwohratLikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if (machanyenge4liked)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        'https://i.scdn.co/image/ab67616d0000b2734e7bd9650368c95ed545b1d3',
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Machayenge 4\nKRSNA',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        machanyenge4liked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        machayengeLiked();
                                        fetchmachayenge4likeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if (holaamigoliked)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        'https://i.scdn.co/image/ab67616d0000b273843596e5677ecc71fee1c340',
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Hola Amigo\nSeedhe Maut, KRSNA, Umair',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        holaamigoliked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        holaamigoLiked();
                                        fetchholaamigolikeStatus();
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          if (nocapliked)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        'https://i.scdn.co/image/ab67616d0000b2734c6edea22082734e5683c7b9',
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'No Cap\nKRSNA',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        nocapliked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
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
                          if (iguessliked)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        'https://i.scdn.co/image/ab67616d0000b273a29f8977d3f13760d01332e0',
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'I Guess\nKRSNA',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        iguessliked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
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
                          if (beenawhileliked)
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        'https://i.scdn.co/image/ab67616d0000b2732d1d2bad9d7c2e4e79579648',
                                      ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Been a While\nKRSNA, Talha Anjum, Umair',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        beenawhileliked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
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
                            child: Text(
                              'Songs',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b2737162dc7fbd69d82805a2aab1',
                                ),
                                height: 100,
                                width: 100,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Ykwim(),
                                        ));
                                  },
                                  child: Text(
                                    'Ykwim\nKaran Aujla, KRSNA',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  ykwimLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  ykwimLike();
                                  fetchYkwimLikeStatus();
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
                              Image(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b273b7b544e5241b69574edc814e',
                                ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Khattaflow(),
                                        ));
                                  },
                                  child: Text(
                                    'Khatta Flow\nSeedhe Maut, KRSNA',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  khattaflowlikedd
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  khattaLike();
                                  fetchkhattaLikeStatus();
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
                              Image(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b2738eeefdbfd14ad10510ba6c86',
                                ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WohRaat()));
                                  },
                                  child: Text(
                                    'Woh Raat\nRaftaar, KRSNA',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  wohraatlike
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  wohraatLiked();
                                  fetchwohratLikeStatus();
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
                              Image(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b2734e7bd9650368c95ed545b1d3',
                                ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Machayenge4()));
                                  },
                                  child: Text(
                                    'Machayenge 4\nKRSNA',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  machanyenge4liked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  machayengeLiked();
                                  fetchmachayenge4likeStatus();
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
                              Image(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b273843596e5677ecc71fee1c340',
                                ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HolaAmigo()));
                                  },
                                  child: Text(
                                    'Hola Amigo\nKRSNA, Seedhe Maut, Umair',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  holaamigoliked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.green,
                                  size: 30,
                                ),
                                onPressed: () {
                                  holaamigoLiked();
                                  fetchholaamigolikeStatus();
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
                              Image(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b2732d1d2bad9d7c2e4e79579648',
                                ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Beenawhile()));
                                  },
                                  child: Text(
                                    'Been a While\nKRSNA, Talha Anjum, Umair',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  beenawhileliked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
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
                              Image(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b273a29f8977d3f13760d01332e0',
                                ),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => IGuess()));
                                  },
                                  child: Text(
                                    'I Guess\nKRSNA',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  iguessliked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
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
                            height: 50,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Image(
                                image: NetworkImage(
                                  'https://i.scdn.co/image/ab67616d0000b2734c6edea22082734e5683c7b9',
                                ),
                                height: 100,
                                width: 100,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NoCap()));
                                  },
                                  child: Text(
                                    'No Cap\nKRSNA',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Spacer(),
                              IconButton(
                                icon: Icon(
                                  nocapliked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
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
                            height: 50,
                          ),
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

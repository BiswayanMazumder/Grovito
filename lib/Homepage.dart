import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatscall/Kalaastar.dart';
import 'package:whatscall/Maharani%20Arpit%20Bala.dart';
import 'package:whatscall/checkitout.dart';
import 'package:whatscall/divine.dart';
import 'package:whatscall/iguesskrsna.dart';
import 'package:whatscall/khattaflow.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:whatscall/krsnaplaylist.dart';
import 'dart:convert';
import 'package:whatscall/main.dart';
import 'package:whatscall/myprofile.dart';
import 'package:whatscall/Jamal Kuttu.dart';
import 'package:whatscall/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:whatscall/settings.dart';
import 'package:whatscall/support_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? user1 = 'User 1';
  String? _imageUrl;
  bool _uploading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

  String username = 'Grovito User';

  Future<void> fetchusername() async {
    final user = _auth.currentUser;
    final docsnap = await _firestore.collection('Users').doc(user?.uid).get();
    if (docsnap.exists) {
      setState(() {
        username = docsnap.data()?['name'];
      });
    }
  }

  Future<void> _pickImage() async {
    final user = _auth.currentUser;
    if (user!.emailVerified) {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _uploadImage();
      }
    } else {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _uploadImage();
      }
    }
  }

  String trackId1 = '2qb5ASYergjk2qNLvYEQJD';
  String trackId2 = '4VosVUajzm6nzGlSb6nP3L';
  String trackId3 = '35FFqjqaPv1Fr9B1GtJdZO';
  String trackId4 = '0OxG3hlJNNzXcSrNVXEu8f';
  String trackId5 = '1sZFDDmmBVkcHOpV6AB0Nx';
  String trackId6 = '7unLxuzKpxbjASww1qi4br';
  String playlist1 = '37i9dQZF1DZ06evO3ckHLO';
  String playlist2 = '37i9dQZF1DZ06evO3ckHLO';
  String playlist3 = '37i9dQZF1DZ06evO3iW9AR';
  String albumCoverUrl1 = '';
  String trackName1 = '';
  String artistName1 = '';
  String albumCoverUrl2 = '';
  String trackName2 = '';
  String artistName2 = '';
  String albumCoverUrl3 = '';
  String trackName3 = '';
  String artistName3 = '';
  String albumCoverUrl4 = '';
  String trackName4 = '';
  String artistName4 = '';
  String albumCoverUrl5 = '';
  String trackName5 = '';
  String artistName5 = '';
  String albumCoverUrl6 = '';
  String trackName6 = '';
  String artistName6 = '';
  String playlistName1 = '';
  String playlistOwnerName1 = '';
  String playlistImageURL1 = '';
  String playlistName2 = '';
  String playlistOwnerName2 = '';
  String playlistImageURL2 = '';
  String playlistName3 = '';
  String playlistOwnerName3 = '';
  String playlistImageURL3 = '';
  String playlistName4 = '';
  String playlistOwnerName4 = '';
  String playlistImageURL4 = '';
  bool isLoading = true;
  Future<void> getPlaylistInfo4() async {
    try {
      final String playlistId = '37i9dQZF1DZ06evO1aUtIB';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/playlists/$playlistId'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          playlistName4 = playlistData['name'];
          playlistOwnerName4 = playlistData['owner']['display_name'];
          playlistImageURL4 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load playlist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getPlaylistInfo3() async {
    try {
      final String playlistId = '37i9dQZF1DZ06evO3iW9AR';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/playlists/$playlistId'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          playlistName3 = playlistData['name'];
          playlistOwnerName3 = playlistData['owner']['display_name'];
          playlistImageURL3 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load playlist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getPlaylistInfo2() async {
    try {
      final String playlistId = '37i9dQZF1DZ06evO4r9h36';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/playlists/$playlistId'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          playlistName2 = playlistData['name'];
          playlistOwnerName2 = playlistData['owner']['display_name'];
          playlistImageURL2 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load playlist information ${response.statusCode}');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  String trendingartistName1 = '';
  String artistImageURL1 = '';
  String trendingartistName2 = '';
  String artistImageURL2 = '';
  String trendingartistName3 = '';
  String artistImageURL3 = '';
  String trendingartistName4 = '';
  String artistImageURL4 = '';
  String trendingartistName5 = '';
  String artistImageURL5 = '';
  String trendingartistName6 = '';
  String artistImageURL6 = '';
  String trendingartistName7 = '';
  String artistImageURL7 = '';
  String trendingartistName8 = '';
  String artistImageURL8 = '';
  Future<void> getArtistInfo8() async {
    try {
      final String artistid = '1Xyo4u8uXC1ZmMpatF05PJ';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/artists/$artistid'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          trendingartistName8 = playlistData['name'];
          artistImageURL8 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load artist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getArtistInfo7() async {
    try {
      final String artistid = '5NHm4TU5Twz7owibYxJfFU';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/artists/$artistid'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          trendingartistName7 = playlistData['name'];
          artistImageURL7 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load artist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getArtistInfo6() async {
    try {
      final String artistid = '2GoeZ0qOTt6kjsWW4eA6LS';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/artists/$artistid'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          trendingartistName6 = playlistData['name'];
          artistImageURL6 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load artist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getArtistInfo5() async {
    try {
      final String artistid = '7dGJo4pcD2V6oG8kP0tJRR';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/artists/$artistid'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          trendingartistName5 = playlistData['name'];
          artistImageURL5 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load artist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getArtistInfo4() async {
    try {
      final String artistid = '4PULA4EFzYTrxYvOVlwpiQ';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/artists/$artistid'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          trendingartistName4 = playlistData['name'];
          artistImageURL4 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load artist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getArtistInfo3() async {
    try {
      final String artistid = '4YRxDV8wJFPHPTeXepOstw';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/artists/$artistid'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          trendingartistName3 = playlistData['name'];
          artistImageURL3 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load artist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getArtistInfo2() async {
    try {
      final String artistid = '3OQRPFFS3OsltFjFAXu1kE';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/artists/$artistid'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          trendingartistName2 = playlistData['name'];
          artistImageURL2 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load artist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getArtistInfo1() async {
    try {
      final String artistid = '5C1S9XwxMuuCciutwMhp5t';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/artists/$artistid'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          trendingartistName1 = playlistData['name'];
          artistImageURL1 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load artist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<void> getPlaylistInfo1() async {
    try {
      final String playlistId = '37i9dQZF1DZ06evO2GAl7Q';
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/playlists/$playlistId'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> playlistData = json.decode(response.body);
        setState(() {
          playlistName1 = playlistData['name'];
          playlistOwnerName1 = playlistData['owner']['display_name'];
          playlistImageURL1 = playlistData['images'][0]['url'];
          isLoading = false; // Set loading to false when image is loaded
        });
      } else {
        print('Failed to load playlist information');
        setState(() {
          isLoading = true; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = true; // Set loading to false on error
      });
    }
  }

  Future<String> getAccessToken() async {
    final String clientId = '896f2be0dd254e2985df6df3448b3f3f';
    final String clientSecret = 'e4ccf91ca8b1435ba7d1866d5d7c9a5c';
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'));

    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
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
      print(data['access_token']);
      return data['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<void> getTrackInfo6() async {
    try {
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/tracks/$trackId6'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> trackData = json.decode(response.body);
        final List<dynamic> images = trackData['album']['images'];
        if (images.isNotEmpty) {
          final List<dynamic> artists = trackData['artists'];
          final String artistName =
              artists.isNotEmpty ? artists[0]['name'] : '';
          setState(() {
            albumCoverUrl6 = images[0]['url'];
            trackName6 = trackData['name'];
            artistName6 = artistName;
          });
        }
      } else {
        print('Failed to load track information');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getTrackInfo5() async {
    try {
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/tracks/$trackId5'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> trackData = json.decode(response.body);
        final List<dynamic> images = trackData['album']['images'];
        if (images.isNotEmpty) {
          final List<dynamic> artists = trackData['artists'];
          final String artistName =
              artists.isNotEmpty ? artists[0]['name'] : '';
          setState(() {
            albumCoverUrl5 = images[0]['url'];
            trackName5 = trackData['name'];
            artistName5 = artistName;
          });
        }
      } else {
        print('Failed to load track information');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getTrackInfo4() async {
    try {
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/tracks/$trackId4'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> trackData = json.decode(response.body);
        final List<dynamic> images = trackData['album']['images'];

        if (images.isNotEmpty) {
          final List<dynamic> artists = trackData['artists'];
          final String artistName =
              artists.isNotEmpty ? artists[0]['name'] : '';

          setState(() {
            albumCoverUrl4 = images[0]['url'];
            trackName4 = trackData['name'];
            artistName4 = artistName;
          });
        }
      } else {
        print('Failed to load track information');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getTrackInfo3() async {
    try {
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/tracks/$trackId3'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> trackData = json.decode(response.body);
        final List<dynamic> images = trackData['album']['images'];
        if (images.isNotEmpty) {
          final List<dynamic> artists = trackData['artists'];
          final String artistName =
              artists.isNotEmpty ? artists[0]['name'] : '';
          setState(() {
            albumCoverUrl3 = images[0]['url'];
            trackName3 = trackData['name'];
            artistName3 = artistName;
          });
        }
      } else {
        print('Failed to load track information');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getTrackInfo2() async {
    try {
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/tracks/$trackId2'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> trackData = json.decode(response.body);
        final List<dynamic> images = trackData['album']['images'];
        if (images.isNotEmpty) {
          final List<dynamic> artists = trackData['artists'];
          final String artistName =
              artists.isNotEmpty ? artists[0]['name'] : '';
          setState(() {
            albumCoverUrl2 = images[0]['url'];
            trackName2 = trackData['name'];
            artistName2 = artistName;
          });
        }
      } else {
        print('Failed to load track information');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getTrackInfo1() async {
    try {
      final String accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/tracks/$trackId1'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> trackData = json.decode(response.body);
        final List<dynamic> images = trackData['album']['images'];
        if (images.isNotEmpty) {
          final List<dynamic> artists = trackData['artists'];
          final String artistName =
              artists.isNotEmpty ? artists[0]['name'] : '';
          setState(() {
            albumCoverUrl1 = images[0]['url'];
            trackName1 = trackData['name'];
            artistName1 = artistName;
          });
        }
      } else {
        print('Failed to load track information');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  bool isprem = false;
  Future<void> PremSubs() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docsnap = await _firestore
          .collection('Payments for Premium')
          .doc(user.uid)
          .get();
      if (docsnap.exists) {
        setState(() {
          isprem = true;
        });
        print(isprem);
      }
    }
  }

  bool khattaflowlistened = false;
  Future<void> khattaflowrecentlylistended() async {
    final user = _auth.currentUser;
    final docsnap = await _firestore
        .collection('Recently Listened Khatta Flow')
        .doc(user!.uid)
        .get();
    if (docsnap.exists) {
      setState(() {
        khattaflowlistened = true;
      });
    }
  }

  bool checkitoutlistened = false;
  Future<void> checkitoutrecentlylistended() async {
    final user = _auth.currentUser;
    final docsnap = await _firestore
        .collection('Recently Listened Check It Out')
        .doc(user!.uid)
        .get();
    if (docsnap.exists) {
      setState(() {
        checkitoutlistened = true;
      });
      print('check it out $checkitoutlistened');
    }
  }

  bool jamalkuttulistened = false;
  Future<void> jamalkutturecentlylistended() async {
    final user = _auth.currentUser;
    final docsnap = await _firestore
        .collection('Recently Listened Jamal Kuttu')
        .doc(user!.uid)
        .get();
    if (docsnap.exists) {
      setState(() {
        jamalkuttulistened = true;
      });
      print('jamalkuttu $jamalkuttulistened');
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the fetchusername method when the page loads
    fetchusername();
    _loadProfilePicture();
    getTrackInfo1();
    getTrackInfo2();
    getTrackInfo3();
    getTrackInfo4();
    getTrackInfo5();
    PremSubs();
    getTrackInfo6();
    getPlaylistInfo1();
    getPlaylistInfo2();
    getPlaylistInfo3();
    getPlaylistInfo4();
    getArtistInfo1();
    getArtistInfo2();
    getArtistInfo3();
    getArtistInfo4();
    getArtistInfo5();
    getArtistInfo6();
    getArtistInfo7();
    getArtistInfo8();
    khattaflowrecentlylistended();
    checkitoutrecentlylistended();
    jamalkutturecentlylistended();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    void _toggleDrawer() {
      _scaffoldKey.currentState?.openDrawer();
    }

    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => support_sections()));
          },
          highlightElevation: 50,
          backgroundColor: Colors.green,
          child: Icon(Icons.help),
        ),
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(100, 70),
          child: AppBar(
            centerTitle: true,
            title: Text(
              isprem ? 'Premium' : '',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            elevation: 10,
            leading: Builder(
                builder: (context) => IconButton(
                    onPressed: _toggleDrawer,
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ))),
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            actions: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.black,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  // Your existing header content
                  child: Column(
                    children: [
                      // Existing stack for image/avatar
                      Stack(children: [
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
                                    radius: 30,
                                    backgroundImage: NetworkImage(_imageUrl!),
                                  ),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyProfile()),
                              );
                            },
                            child: Text(
                              '${username}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Row(children: [
                          Icon(
                            Icons.flash_on,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Whats New',
                            style: TextStyle(
                              color: Colors.white, // Set text color to white
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Implement action for Whats New
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Settingsandprivacy(),
                              ));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Settings And Privacy',
                              style: TextStyle(
                                color: Colors.white, // Set text color to white
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Implement action for Change Profile Picture
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          _auth.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.white, // Set text color to white
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Implement action for Sign Out
                  },
                ),
                // Add more ListTile widgets for additional options
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome ${username}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Trending Songs",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final user = _auth.currentUser;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Khattaflow(),
                            ));
                        await _firestore
                            .collection('Recently Listened Khatta Flow')
                            .doc(user!.uid)
                            .set({
                          'Listened': true,
                          'TIme Of Listening': FieldValue.serverTimestamp(),
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          elevation: MaterialStatePropertyAll(0)),
                      child: albumCoverUrl1.isNotEmpty
                          ? Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: albumCoverUrl1,
                                  width: 150, // Adjust the width as needed
                                  height: 150,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '$trackName1',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '$artistName1',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ],
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Checkitout()));
                        final user = _auth.currentUser;
                        await _firestore
                            .collection('Recently Listened Check It Out')
                            .doc(user!.uid)
                            .set({
                          'Listened': true,
                          'TIme Of Listening': FieldValue.serverTimestamp(),
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          elevation: MaterialStatePropertyAll(0)),
                      child: albumCoverUrl2.isNotEmpty
                          ? Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: albumCoverUrl2,
                                  width: 150, // Adjust the width as needed
                                  height: 150,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '$trackName2',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '$artistName2',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ],
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => OneLove()));
                        final user = _auth.currentUser;
                        await _firestore
                            .collection('Recently Listened Jamal Kuttu')
                            .doc(user!.uid)
                            .set({
                          'Listened': true,
                          'TIme Of Listening': FieldValue.serverTimestamp(),
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          elevation: MaterialStatePropertyAll(0)),
                      child: albumCoverUrl3.isNotEmpty
                          ? Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: albumCoverUrl3,
                                  width: 150, // Adjust the width as needed
                                  height: 150,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '$trackName3',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '$artistName3',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ],
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IGuess(),
                            ));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          elevation: MaterialStatePropertyAll(0)),
                      child: albumCoverUrl4.isNotEmpty
                          ? Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: albumCoverUrl4,
                                  width: 150, // Adjust the width as needed
                                  height: 150,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '$trackName4',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '$artistName4',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ],
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Kalaastar()));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          elevation: MaterialStatePropertyAll(0)),
                      child: albumCoverUrl5.isNotEmpty
                          ? Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: albumCoverUrl5,
                                  width: 150, // Adjust the width as needed
                                  height: 150,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '$trackName5',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '$artistName5',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ],
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Maharani_Arpit(),
                            ));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          elevation: MaterialStatePropertyAll(0)),
                      child: albumCoverUrl6.isNotEmpty
                          ? Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: albumCoverUrl6,
                                  width: 150, // Adjust the width as needed
                                  height: 150,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '$trackName6',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '$artistName6',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                              ],
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Trending Playlist",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => divinePlaylist(),
                                    ));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: playlistImageURL1,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$playlistName1',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '$playlistOwnerName1',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: playlistImageURL2,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$playlistName2',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '$playlistOwnerName2',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => KR$NAPlaylist(),
                                    ));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: playlistImageURL3,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$playlistName3',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '$playlistOwnerName3',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: playlistImageURL4,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$playlistName4',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '$playlistOwnerName4',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Trending Artists",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: artistImageURL1,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$trendingartistName1',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: artistImageURL2,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$trendingartistName2',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: artistImageURL3,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$trendingartistName3',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: artistImageURL4,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$trendingartistName4',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: artistImageURL5,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$trendingartistName5',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: artistImageURL6,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$trendingartistName6',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: artistImageURL7,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$trendingartistName7',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  elevation: MaterialStatePropertyAll(0)),
                              child: Column(
                                children: [
                                  isLoading
                                      ? CircularProgressIndicator()
                                      : CachedNetworkImage(
                                          imageUrl: artistImageURL8,
                                          width:
                                              150, // Adjust the width as needed
                                          height: 150,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                  SizedBox(height: 20),
                                  Text(
                                    '$trendingartistName8',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              if (khattaflowlistened ||
                  checkitoutlistened ||
                  jamalkuttulistened)
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Recently Listened',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (khattaflowlistened)
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Khattaflow(),
                              ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            elevation: MaterialStatePropertyAll(0)),
                        child: albumCoverUrl1.isNotEmpty
                            ? Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: albumCoverUrl1,
                                    width: 150, // Adjust the width as needed
                                    height: 150,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '$trackName1',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '$artistName1',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              )
                            : CircularProgressIndicator(),
                      ),
                    SizedBox(
                      width: 30,
                    ),
                    if (checkitoutlistened)
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Checkitout()));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            elevation: MaterialStatePropertyAll(0)),
                        child: albumCoverUrl2.isNotEmpty
                            ? Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: albumCoverUrl2,
                                    width: 150, // Adjust the width as needed
                                    height: 150,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '$trackName2',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '$artistName2',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              )
                            : CircularProgressIndicator(),
                      ),
                    SizedBox(
                      width: 30,
                    ),
                    if (jamalkuttulistened)
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OneLove()));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            elevation: MaterialStatePropertyAll(0)),
                        child: albumCoverUrl3.isNotEmpty
                            ? Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: albumCoverUrl3,
                                    width: 150, // Adjust the width as needed
                                    height: 150,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    '$trackName3',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '$artistName3',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ],
                              )
                            : CircularProgressIndicator(),
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

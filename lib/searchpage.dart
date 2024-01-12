import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:whatscall/359.dart';
import 'package:whatscall/Been%20a%20while.dart';
import 'package:whatscall/Hola%20Amigo.dart';
import 'package:whatscall/WohRaat.dart';
import 'package:whatscall/bazigaar.dart';
import 'package:whatscall/chorni.dart';
import 'package:whatscall/iguessKRSNA.dart';
import 'package:whatscall/kaam25.dart';
import 'package:whatscall/khattaflow.dart';
import 'package:whatscall/krsnaplaylist.dart';
import 'package:whatscall/machayenge%204.dart';
import 'package:whatscall/mirchi.dart';
import 'package:whatscall/nocompetition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchScreen(),
    );
  }
}

class SearchResult {
  final String text;
  final String imageUrl;

  SearchResult(this.text, this.imageUrl);
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  stt.SpeechToText? _speech;
  bool _isListening = false;
  CollectionReference? _searchHistoryCollection;

  List<SearchResult> searchResultsList = [
    SearchResult("KRSNA", "https://i.scdn.co/image/ab6761610000f178debeea13700496b7d2b345d9"),
    SearchResult("Khatta Flow", "https://i.scdn.co/image/ab67616d00004851b7b544e5241b69574edc814e"),
    SearchResult("Woh Raat", "https://i.scdn.co/image/ab67616d0000b2738eeefdbfd14ad10510ba6c86"),
    SearchResult("Machayenge 4", "https://i.scdn.co/image/ab67616d0000b2734e7bd9650368c95ed545b1d3"),
    SearchResult("Hola Amigo", "https://i.scdn.co/image/ab67616d0000b273843596e5677ecc71fee1c340"),
    SearchResult("Been a While", "https://i.scdn.co/image/ab67616d0000b2732d1d2bad9d7c2e4e79579648"),
    SearchResult("I Guess", "https://i.scdn.co/image/ab67616d0000b273a29f8977d3f13760d01332e0"),
    SearchResult("No Cap", "https://i.scdn.co/image/ab67616d0000b2734c6edea22082734e5683c7b9"),
    SearchResult("Mirchi", "https://i.scdn.co/image/ab67616d0000b2735ac573b4ef43591be197a78b"),
    SearchResult("Satya", "https://i.scdn.co/image/ab67616d0000b27383c726c3768d0981c76acd38"),
    SearchResult("Bazigaar", "https://i.scdn.co/image/ab67616d0000b2733f1acedcbf16cc9b155e5700"),
    SearchResult("Kaam 25 - Sacred Games", "https://i.scdn.co/image/ab67616d0000b2733179c08eecad4cf6f5c68e58"),
    SearchResult("No Competition", "https://i.scdn.co/image/ab67616d0000b2732f8aea22b8e62bd6084e7094"),
    SearchResult("Chorni", "https://i.scdn.co/image/ab67616d0000b27392c32f95f518a1153a339117"),
    SearchResult("3:59 AM", "https://i.scdn.co/image/ab67616d0000b27383c726c3768d0981c76acd38"),
    // Add more search results with their respective image URLs
  ];

  _SearchScreenState() {
    _speech = stt.SpeechToText();
  }

  @override
  void initState() {
    super.initState();
    _searchHistoryCollection = _firestore.collection('users_search');
    _user = _auth.currentUser;
    if (_user != null) {
      _loadRecentSearches();
    }
  }

  void _listen() async {
    if (!_isListening) {
      if (await _speech!.initialize()) {
        _speech!.listen(
          onResult: (result) {
            setState(() {
              searchQuery = result.recognizedWords;
              _searchController.text = searchQuery;
            });
          },
        );
        setState(() {
          _isListening = true;
        });
      }
    } else {
      _speech!.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  Expanded buildSearchResults() {
    return Expanded(
      child: ListView.builder(
        itemCount: searchResultsList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final result = searchResultsList[index];
          if (result.text.toLowerCase().contains(searchQuery.toLowerCase())) {
            return ListTile(
              leading: CircleAvatar(
                radius:15,
                backgroundImage: NetworkImage(result.imageUrl),
              ),
              title: Text(result.text, style: TextStyle(color: Colors.white)),
              onTap: () {
                navigateToPage(context, result.text);
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  User? _user;
  List<String> _recentSearches = [];
  bool noResultsFound = false;


  void _loadRecentSearches() async {
    final userId = _user!.uid;
    final searchHistorySnapshot = await _firestore
        .collection('users_search')
        .doc(userId)
        .collection('searchHistory')
        .orderBy('timestamp', descending: true)
        .get();

    final searches = searchHistorySnapshot.docs.map((doc) {
      return doc.data()['query'].toString();
    }).toList();

    setState(() {
      _recentSearches = searches;
    });
  }

  void _saveSearchQuery(String query) async {
    final userId = _user!.uid;
    if (!_recentSearches.contains(query)) {
      _recentSearches.add(query);
      await _firestore.collection('users_search').doc(userId).collection(
          'searchHistory').add({
        'query': query,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> _clearMessages(BuildContext context) async {
    setState(() async {
      CollectionReference messagesCollection = FirebaseFirestore.instance
          .collection('users_search')
          .doc(_user!.uid)
          .collection('searchHistory');
      try {
        QuerySnapshot querySnapshot = await messagesCollection.get();

        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Center(
                child: Text('Recent Searches cleared successfully')),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Center(
                child: Text("Sorry Couldn't delete Recent Searches")),
          ),
        );
      }
    });
  }

  void navigateToPage(BuildContext context, String result) {
    if (!searchResultsList.any((element) => element.text == result)) {
      SearchResult newResult =
      SearchResult(result, "https://example.com/$result" + "_image.jpg");
      searchResultsList.add(newResult);
      _saveSearchQuery(result);
    }
    switch (result) {
      case "KRSNA":
      // Replace this with your actual navigation logic
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => KR$NAPlaylist()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Khatta Flow":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Khattaflow()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Woh Raat":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WohRaat()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Machayenge 4":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Machayenge4()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Hola Amigo":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HolaAmigo()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Been a While":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Beenawhile()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "I Guess":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => IGuess()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Mirchi":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => mirchi_dart()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Satya":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => mirchi_dart()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Bazigaar":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => bazigaar()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Mirchi":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => mirchi_dart()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Kaam 25 - Sacred Games":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => kaam25()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "No Competition":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => nocompetition()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Chorni":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => chorni()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "3:59 AM":
      // Replace this with your actual navigation logic
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => am359()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.grey.shade600,
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    noResultsFound = false;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _listen();
                    },
                    icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_off,
                        color: Colors.white),
                  ),
                  hintText: "Search for movies, shows, series....",
                  hintStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          if (_recentSearches.isEmpty)
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recent Searches:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "No Recent Searches Till Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 50,
                  indent: 50,
                  thickness: 0.4,
                ),
              ],
            ),

          if (_recentSearches.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "  Recent Searches:",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _clearMessages(context);
                      },
                      child: Text(
                        "Clear Searches",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10.0,
                  children: _recentSearches.map((search) {
                    return GestureDetector(
                      onTap: () {
                        navigateToPage(context, search);
                      },
                      child: Chip(
                        label: Text(search,
                            style: TextStyle(
                                color: Colors.grey, fontWeight: FontWeight.w400)),
                        backgroundColor: Colors.black,
                        autofocus: true,
                        surfaceTintColor: Colors.black,
                        side: BorderSide(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 50,
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 50,
                  indent: 50,
                  thickness: 0.4,
                ),
              ],
            ),

          buildSearchResults(),

          if (noResultsFound)
            Center(
              child: Text(
                "No Results Found",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
class BollywoodGenre extends StatefulWidget {
  @override
  _BollywoodGenreState createState() => _BollywoodGenreState();
}

class _BollywoodGenreState extends State<BollywoodGenre> {
  List<String> sampleVideoUrls = [
    'https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com/o/videos%20for%20genre%2Fbolly%2Flaat%20lag%20gayi%20-%20Made%20with%20Clipchamp.mp4?alt=media&token=90cf9cd1-4c45-4990-946f-3c11928bd81d',
    'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Grovito/genres/badshahgone-gir%20(1)%20(1).mp4?t=2024-01-12T10%3A20%3A23.594Z',
    'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Grovito/genres/jamalkudu_stznQJUl%20(1).mp4?t=2024-01-12T10%3A33%3A10.751Z',
    'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Grovito/genres/khariyat.mp4',
    'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Grovito/genres/phir%20bhi%20tumko%20chahunga.mp4?t=2024-01-11T19%3A37%3A21.514Z',
    'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Grovito/genres/chaleya.mp4?t=2024-01-11T19%3A40%3A11.135Z',
    'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Grovito/genres/baarishein.mp4',
    'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Grovito/Kala%20Chashma%20Baar%20Baar%20Dekho%20Sidharth%20M%20Katrina%20K%20Prem,%20Hardeep,%20Badshah,%20Kam,%20Neha,%20Indeep.mkv?t=2024-01-12T09%3A34%3A30.892Z'
  ];
  bool _isVisible = true;

  List<String> songNames = [
    'Laat Lag Gayi',
    'Badshah - Gone Girl',
    'Jamalkudu',
    'Khairiyat',
    'Phir Bhi Tumko Chaahunga',
    'Chaleya',
    'Baarishein',
    'Kala Chashma - Baar Baar Dekho'
  ];

  int _currentVideoIndex = 0;
  late VideoPlayerController _controller = VideoPlayerController.network('');
  bool _liked = false;
  bool _disliked = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initializeController(_currentVideoIndex);
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  void _initializeController(int videoIndex) {
    if (videoIndex < sampleVideoUrls.length) {
      String nextVideoUrl = sampleVideoUrls[videoIndex];

      _controller?.dispose();
      _controller = VideoPlayerController.network(nextVideoUrl)
        ..initialize().then((_) {
          setState(() {
            _currentVideoIndex = videoIndex;
          });

          // Fetch like status for the current video
          _checkUserReactions(_currentVideoIndex);

          _controller.play();
          _controller.setVolume(_isMuted ? 0.0 : 1.0); // Set initial volume
        });
    } else {
      // If the index is out of bounds, loop back to the first video
      _initializeController(0);
    }
  }

  void _checkUserReactions(int videoIndex) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Bollywood genre likes').doc(user.uid).get();

      if (snapshot.exists) {
        Map<String, dynamic>? userReactions = snapshot.data() as Map<String, dynamic>?;

        if (userReactions != null &&
            userReactions.containsKey(videoIndex.toString())) {
          setState(() {
            _liked = userReactions[videoIndex.toString()]['liked'] ?? false;
            _disliked = userReactions[videoIndex.toString()]['disliked'] ?? false;
          });
        } else {
          // Reset like and dislike status if not found for the current video
          setState(() {
            _liked = false;
            _disliked = false;
          });
        }
      }
    }
  }

  void _saveUserReaction(int videoIndex) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('Bollywood genre likes').doc(user.uid).set({
        videoIndex.toString(): {
          'liked': _liked,
          'disliked': _disliked,
        }
      }, SetOptions(merge: true));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          '#bollywood',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                // Swiped down
                _initializeController(_currentVideoIndex - 1);
              } else if (details.primaryVelocity! < 0) {
                // Swiped up
                _initializeController(_currentVideoIndex + 1);
              }
            },
            onTap: () {
              setState(() {
                _isMuted = !_isMuted;
                _controller.setVolume(_isMuted ? 0.0 : 1.0);
                _isVisible = true; // Show the icon when tapped
              });

              // Delay to hide the icon after 5 seconds
              Future.delayed(Duration(seconds: 5), () {
                setState(() {
                  Icon(CupertinoIcons.volume_mute);
                  _isVisible = false;
                });
              });

            },


            onDoubleTap: () {
              // Handle double-tap (like functionality)
              setState(() {
                _liked = !_liked;
                if (_disliked) _disliked = false; // Dislike is mutually exclusive
              });
              _saveUserReaction(_currentVideoIndex);
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: _controller?.value?.isInitialized ?? false
                        ? AspectRatio(
                      key: ValueKey<int>(_currentVideoIndex),
                      aspectRatio: _calculateAspectRatio(context),
                      child: VideoPlayer(_controller),
                    )
                        : CircularProgressIndicator(),
                  ),
                  SizedBox(height: 16),
                  // Align(
                  //   alignment: Alignment.bottomLeft,
                  //   child: Text(
                  //     songNames[_currentVideoIndex],
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.w300
                  //       ,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        _liked?CupertinoIcons.heart_fill:CupertinoIcons.heart,
                        color: _liked ? Colors.red : Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _liked = !_liked;
                          if (_disliked) _disliked = false; // Dislike is mutually exclusive
                        });
                        _saveUserReaction(_currentVideoIndex);
                      },
                    ),
                    Text('Like',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        _disliked?CupertinoIcons.heart_slash_fill:CupertinoIcons.heart_slash,
                        color: _disliked ? Colors.red : Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _disliked = !_disliked;
                          if (_liked) _liked = false; // Like is mutually exclusive
                        });
                        _saveUserReaction(_currentVideoIndex);
                      },
                    ),
                    Text('Dislike',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateAspectRatio(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return _controller.value.aspectRatio;
    } else {
      return 16 / 9; // Assuming a standard landscape aspect ratio
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}

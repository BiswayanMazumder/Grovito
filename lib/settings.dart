import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:whatscall/Homepage.dart';
import 'package:whatscall/changeemail.com.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:whatscall/grovitopremium.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Settingsandprivacy extends StatefulWidget {
  const Settingsandprivacy({Key? key}) : super(key: key);

  @override
  State<Settingsandprivacy> createState() => _SettingsandprivacyState();
}

class _SettingsandprivacyState extends State<Settingsandprivacy> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  User? _user;
  bool ispremiumind=false;
  bool showprem=false;
  String substype='Loading';
  String dateAfterOneMonth = 'Loading';
  TextEditingController _newemail=TextEditingController();
  Future<void> fetchpremiumstatus() async{
    final user=_auth.currentUser;
    if(user!=null){
      final docsnap= await _firestore.collection('Payments for Premium').doc(user.uid).get();
      if(docsnap.exists){
        setState(() {
          ispremiumind=true;
          substype=docsnap.data()?['Subscription Type'];
        });
        print(ispremiumind);
        print(substype);
      }
    }

  }
  Future<void> _fetchUserDetails() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      setState(() {
        _user = user;
      });
    }
  }
  bool isCheckedsavedata = false;
  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _fetchChecked();
    fetchpremiumstatus();
  }
  Future<void> _fetchChecked() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docSnap = await _firestore.collection('User Save Data').doc(user.uid).get();

      if (docSnap.exists) {
        final isCheckedFromFirestore = docSnap['Checked For Save Data'] ?? false;

        setState(() {
          isCheckedsavedata = isCheckedFromFirestore;
        });
      }
    }
  }
  Future<void> _updateFirestore() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('User Save Data').doc(user.uid).set(
        {
          'Checked For Save Data': isCheckedsavedata,
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              '  Account',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            if (_user != null && _user!.email != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  Email Address',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '  ${_user!.email}',
                    style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Changeemailpassword()));
                    },
                    child: Text(
                      'Update Password',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(onPressed: ()async{
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title:Text('Change Email ID'),
                        actions: [
                          Center(child: Text('Enter New Email',style: TextStyle(fontWeight: FontWeight.bold),)),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration:(
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black)
                            )
                            ),
                            child: TextField(
                              controller: _newemail,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              ElevatedButton(onPressed: ()async{
                                final user=_auth.currentUser;
                                if (user != null) {
                                  try {
                                    await user.updateEmail(_newemail.text);
                                    MotionToast.success(
                                        title:  Text("Email ID changed",style: TextStyle(fontWeight: FontWeight.bold),),
                                        description:  Text("Your email id has been changed to ${_newemail.text}")
                                    ).show(context);
                                  } catch (e) {
                                    MotionToast.warning(
                                        title:  Text("Error Updating Email",style: TextStyle(fontWeight: FontWeight.bold),),
                                        description:  Text("OOPS! We encountered a problem updating your email")
                                    ).show(context);
                                    print('Error updating email: $e');
                                    // Handle the error as needed

                                  }
                                } else {
                                  print('User is null. Unable to update email.');
                                }
                              },
                                  child: Text('Update Email',style: TextStyle(color: Colors.black),),
                              style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.green)),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              },
                                child: Text('Cancel',style: TextStyle(color: Colors.black),),
                                style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.red)),
                              ),
                            ],
                          )
                        ],
                      );
                    },);
                  },
                      child: Text(
                        'Change Email',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                      ),)
                  ],
              ),
            if (_user != null && _user!.phoneNumber != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '  Phone Number',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '  ${_user!.phoneNumber} ',
                    style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold, fontSize: 12),
                  ),

                ],
              ),
            SizedBox(
              height: 20,
            ),
            TextButton(onPressed: (){
              print('hi');
              Navigator.push(context, MaterialPageRoute(builder: (context) => Grovitopremium(),));
            },
                child:Text('Premium Plan',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
            Text('  View your plan details',style: TextStyle(color: Colors.blueGrey[200]!,fontWeight: FontWeight.bold,fontSize: 15),),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Save Data',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCheckedsavedata = !isCheckedsavedata;
                      _updateFirestore();
                    });
                    print(isCheckedsavedata);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),  // Adjust the padding as needed
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isCheckedsavedata ? Colors.green : Colors.transparent,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: isCheckedsavedata
                        ? Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.black87,
                        size: 20,
                      ),
                    )
                        : Container(),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            if(ispremiumind)
              TextButton(
                  onPressed: (){
                    final user=_auth.currentUser;
                    showDialog(context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Are you sure to delete your premium subscription',style: TextStyle(fontWeight:FontWeight.w400),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                },
                                  child: Text('Cancel',style: TextStyle(color: Colors.black),),
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red),
                                      elevation: MaterialStatePropertyAll(50)),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(onPressed: (){
                                  final user=_auth.currentUser;
                                  if(user!=null){
                                    try{
                                      final docsnap=_firestore.collection('Payments for Premium').doc(user.uid).delete();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Successfully unenrolled from premium subscription'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                                    }catch(e){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Oops! There's a problem"),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    }
                                  }
                                },
                                  child: Text('Go Ahead',style: TextStyle(color: Colors.black)),
                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green),
                                      elevation: MaterialStatePropertyAll(50)),
                                ),
                              ],
                            )
                          ],
                        );
                      },);
                  },
                  child: Text('Delete Premium Account',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),))


          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Settingsandprivacy(),
  ));
}

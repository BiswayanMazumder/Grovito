import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class PremiumInd extends StatefulWidget {
  const PremiumInd({Key? key}) : super(key: key);

  @override
  State<PremiumInd> createState() => _PremiumIndState();
}

class _PremiumIndState extends State<PremiumInd> {
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  String? useremail;
  bool ispremiumind=false;
  bool showprem=false;
  String substype='Loading';
  String dateAfterOneMonth = 'Loading';
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
  Future<void> fetchData() async {
    final user = _auth.currentUser;
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('Payments for Premium')
          .doc(user!.uid)
          .get();
      var timestamp = documentSnapshot.data()?['Date Of Purchase'];

      if (timestamp != null) {
        DateTime dateTime = (timestamp as Timestamp).toDate();

        // Add one month to the date
        DateTime dateAfterOneMonthDateTime = dateTime.add(Duration(days: 30));

        // Format the date using intl package
        String formattedDate = DateFormat('yyyy-MM-dd').format(dateAfterOneMonthDateTime);

        setState(() {
          dateAfterOneMonth = formattedDate;
        });

        print('Date after one month: $formattedDate');
      } else {
        print('Timestamp is null');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchpremiumstatus();
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Plan Preview',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueGrey[900]!,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800]!,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Row(
                      children: [
                        Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c-d53a-433d-8619-7e851aeee650'),
                          height: 100,
                          width: 100,
                        ),
                        Text('$substype',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Your plan will automatically renew on ${dateAfterOneMonth}.You will be charged ₹'
                        '119/month',style: TextStyle(color: Colors.grey,
                    fontWeight: FontWeight.bold,fontSize: 15),)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800]!,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Text('Plan Includes',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(Icons.check,color: Colors.green,),
                        Text(' Listen To Offline Music at high res',style: TextStyle(color: Colors.white,fontSize: 15),),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.check,color: Colors.green,),
                        Text(' Ad free music listening',style: TextStyle(color: Colors.white,fontSize: 15),),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.check,color: Colors.green,),
                        Text(' 2x higher music quality than free',style: TextStyle(color: Colors.white,fontSize: 15),),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.check,color: Colors.green,),
                        Text(' Group Listening With Other Premium Members',style: TextStyle(color: Colors.white,fontSize: 15),),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Text('Your plan will automatically renew on ${dateAfterOneMonth}.You will be charged ₹'
                    //     '119/month',style: TextStyle(color: Colors.grey,
                    //     fontWeight: FontWeight.bold,fontSize: 15),)
                  ],
                ),
              ),
            ),
          ],
        ),
      )

    );
  }
}

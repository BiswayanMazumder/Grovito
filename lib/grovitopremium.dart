import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatscall/Homepage.dart';
import 'package:whatscall/premium%20individual.dart';
class Grovitopremium extends StatefulWidget {
  const Grovitopremium({Key? key}) : super(key: key);

  @override
  State<Grovitopremium> createState() => _GrovitopremiumState();
}

class _GrovitopremiumState extends State<Grovitopremium> {
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  String? useremail;
  bool ispremiumind=false;
  bool showprem=false;
  String? substype;
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchpremiumstatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Avaliable Plans',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            if(ispremiumind)
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text('Subscribed Plan',style: TextStyle(color: Colors.blueGrey[200],fontSize: 20,fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c-d53a-433d-8619-7e851aeee650'),
                        height: 100,
                        width: 100,
                      ),
                      TextButton(onPressed: (){
                        print('hi');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PremiumInd(),));
                      },
                          child: Text('$substype',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),))
                    ],
                  ),
                  Divider(
                    color: Colors.yellow,
                    endIndent: 50,
                    indent: 50,
                  )
                ],
              ),
            if(ispremiumind==false)
              Column(
                children: [

                  Row(
                    children: [
                      Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c-d53a-433d-8619-7e851aeee650'),
                        height: 100,
                        width: 100,
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Razorpay _razorpay = Razorpay();

                              // Configure the Razorpay instance with your key
                              _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
                                print('Payment Successful: ${response.paymentId}');
                                final user = _auth.currentUser;
                                if (user != null) {
                                  final docsnap = _firestore.collection('Payments for Premium').doc(user.uid).set(
                                    {
                                      'payment': '₹119',
                                      'status': 'Successful',
                                      'Subscription Type': 'Premium Individual',
                                      'User Email': user.email,
                                      'Date Of Purchase': FieldValue.serverTimestamp(),
                                      'Payment ID': response.paymentId
                                    },
                                  );
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Welcome To Grovito Premium Family'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                              });

                              _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
                                print('Payment Error: ${response.message}');
                                // Implement any logic you want for a payment error
                              });

                              _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) {
                                print('External Wallet: ${response.walletName}');
                                // Implement any logic you want for external wallet payments
                              });

                              // Replace 'YOUR_KEY_ID' with your Razorpay Key ID
                              var options = {
                                'key': 'rzp_test_9nWSDmh9oFPqMq',
                                'amount': 11900, // Amount in paise (Example: 119.00 = 11900)
                                'name': 'Grovito Subscription',
                                'description': 'Premium Individual',
                                'payment_capture': 1, // Auto-capture enabled
                              };

                              try {
                                _razorpay.open(options);
                              } catch (e) {
                                print('Error opening Razorpay: $e');
                              }
                            },
                            child: Text(
                              'Premium Individual',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),

                          Text(
                            '₹119/month',
                            style: TextStyle(color: Colors.blueGrey[200]!, fontWeight: FontWeight.w400, fontSize: 15),
                          ), ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c-d53a-433d-8619-7e851aeee650'),
                        height: 100,
                        width: 100,
                      ),
                      Column(
                        children: [
                          TextButton(onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Not eligible! Only After verification done by Grovito team'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          },
                              child: Text('Student Individual',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                          Text('₹49/month',style: TextStyle(color: Colors.blueGrey[200]!, fontWeight: FontWeight.w400, fontSize: 15),)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(
              height: 20,
            ),
            Text(' See Avaliable Plans',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            SizedBox(
              height: 10,
            ),
          TextButton(onPressed: (){
            setState(() {
              showprem=true;
            });
          },
              child: Text(' Premium Individual, Student Individual',style: TextStyle(color: Colors.blueGrey[200]!,fontWeight: FontWeight.bold,fontSize: 15),),
          ),
            if(showprem)
              Column(
                children: [

                  Row(
                    children: [
                      Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c-d53a-433d-8619-7e851aeee650'),
                        height: 100,
                        width: 100,
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Sorry! You have already purchased this plan.',style: TextStyle(fontWeight: FontWeight.bold),),
                                  backgroundColor: Colors.orange,
                                ),
                              );
                            },
                            child: Text(
                              'Premium Individual',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Text(
                            '₹119/month',
                            style: TextStyle(color: Colors.blueGrey[200]!, fontWeight: FontWeight.w400, fontSize: 15),
                          ), ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/quantumharmony-85046.appspot.com/o/172876e3ef491d0bd9e9de1b0ded5233-removebg-preview.png?alt=media&token=4a1a5a3c-d53a-433d-8619-7e851aeee650'),
                        height: 100,
                        width: 100,
                      ),
                      Column(
                        children: [
                          TextButton(onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Not eligible! Only After verification done by Grovito team'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          },
                              child: Text('Student Individual',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                          Text('₹49/month',style: TextStyle(color: Colors.blueGrey[200]!, fontWeight: FontWeight.w400, fontSize: 15),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(onPressed: (){
                    setState(() {
                      showprem=false;
                    });
                  },
                      child:Text('Hide Details',style: TextStyle(color: Colors.blueGrey[200]!, fontWeight: FontWeight.w400, fontSize: 15),),)
                ],
              ),
          ],
        ),
      ),
    );
  }
}

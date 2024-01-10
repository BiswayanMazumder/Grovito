import 'package:flutter/material.dart';
import 'package:whatscall/email_address.dart';
class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Account'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                ElevatedButton(onPressed: (){},
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),
                    elevation: MaterialStatePropertyAll(0)),
                    child: Row(children: [
                      Icon(Icons.security,color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Security Notifications',style: TextStyle(color: Colors.black,fontSize: 15),)
                    ],)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                ElevatedButton(onPressed: (){},
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),
                        elevation: MaterialStatePropertyAll(0)),
                    child: Row(children: [
                      Icon(Icons.key_rounded,color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Passkeys',style: TextStyle(color: Colors.black,fontSize: 15),)
                    ],)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Emailaddresspage(),));
                },
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),
                        elevation: MaterialStatePropertyAll(0)),
                    child: Row(children: [
                      Icon(Icons.email_outlined,color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Email Address',style: TextStyle(color: Colors.black,fontSize: 15),)
                    ],)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                ElevatedButton(onPressed: (){},
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),
                        elevation: MaterialStatePropertyAll(0)),
                    child: Row(children: [
                      Icon(Icons.password,color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Two Step Verification',style: TextStyle(color: Colors.black,fontSize: 15),)
                    ],)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                ElevatedButton(onPressed: (){},
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),
                        elevation: MaterialStatePropertyAll(0)),
                    child: Row(children: [
                      Icon(Icons.attach_email_outlined,color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Change Email',style: TextStyle(color: Colors.black,fontSize: 15),)
                    ],)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                ElevatedButton(onPressed: (){},
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),
                        elevation: MaterialStatePropertyAll(0)),
                    child: Row(children: [
                      Icon(Icons.delete_outline,color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Delete Account',style: TextStyle(color: Colors.black,fontSize: 15),)
                    ],)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

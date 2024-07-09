import 'package:flutter/material.dart';
import 'package:seawind/Country.dart';

class PhoneNumberAuth extends StatefulWidget {
  const PhoneNumberAuth({super.key});

  @override
  State<PhoneNumberAuth> createState() => _PhoneNumberAuthState();
}

class _PhoneNumberAuthState extends State<PhoneNumberAuth> {

  
        


  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenheight,
        width:  screenwidth,
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white , Colors.purple.shade100 , Colors.white , Colors.pink.shade100 , Colors.white]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Container(
                
                height: screenheight * 0.1,
                width:  screenwidth * 0.4,
                child: Image.network(
                  fit: BoxFit.fill,
                  "https://static.vecteezy.com/system/resources/previews/033/255/652/original/blank-red-color-coupon-ticket-template-png.png")),
            ),
            Container(
              
              height: screenheight * 0.14,
              width: screenwidth * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                
                children: [
                  Text("BOOK MY" , style: TextStyle(fontSize: 36 ,height: 1 ,fontWeight: FontWeight.w700)),
                  Text("EVENT" , style: TextStyle(fontSize: 52 ,height: 1 ,fontWeight: FontWeight.w700))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top : 150 , left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Sign in" , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top : 8 , left: 20 ,right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Continue with mobile number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top : 50),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CountryScreen(),));
                },
                child: Container(
                  height: screenheight * 0.05,
                  width: screenwidth * 0.55,
                  decoration: BoxDecoration(
                    color: Color(0xFFD41F6A), // Pinkish color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(2, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Color.fromARGB(255, 130, 7, 58).withOpacity(0.9), // Slightly darker shade for the circle
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
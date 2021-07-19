import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sparks/homepage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: _isLoggedIn
              ? Container(
                  color: Colors.pink.shade500,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        "Logged In",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(height: 25),
                      CircleAvatar(
                        maxRadius: 75,
                        backgroundImage: NetworkImage(_userObj.photoUrl),
                      ),
                      SizedBox(height: 20),
                      Text(
                        _userObj.displayName,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _userObj.email,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () {
                            _googleSignIn.signOut().then((value) {
                              setState(() {
                                _isLoggedIn = false;
                              });
                            }).catchError((e) {});
                          },
                          child: Text("Logout")),
                      Spacer(),
                    ],
                  ))
              : Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 300),
                      Container(
                        alignment: Alignment.topLeft,
                        child:Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right:34),
                                child:Text("An App by ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              ),
                              Container(
                                padding: EdgeInsets.only(left:20),
                                child:Text("Kaviya S",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.pink),),
                              )
                            ]
                        ),
                      ),
                      SizedBox(height: 70),
                      Container(
                        padding: EdgeInsets.all(4),
                        child: OutlineButton.icon(
                            label: Text(
                              'Sign In With Google',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            shape: StadiumBorder(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 23, vertical: 8),
                            highlightedBorderColor: Colors.black,
                            borderSide: BorderSide(color: Colors.black),
                            textColor: Colors.black,
                            icon: FaIcon(FontAwesomeIcons.google,
                                color: Colors.black),
                            onPressed: () {
                              _googleSignIn.signIn().then((userData) {
                                setState(() {
                                  _isLoggedIn = true;
                                  _userObj = userData;
                                });
                              });
                            }),
                      ),
                      SizedBox(height: 8),
                      MovePage(),
                      Spacer(),
                    ],
                  ),
                )),
    );
  }
}


class MovePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: OutlineButton.icon(
        label: Text(
          'Sign In With Facebook',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        highlightedBorderColor: Colors.black,
        borderSide: BorderSide(color: Colors.black),
        textColor: Colors.black,
        icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.black),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FacebookSignUpButton()));
        },
      ),
    );
  }
}

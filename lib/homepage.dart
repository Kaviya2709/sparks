import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sparks/main.dart';

class FacebookSignUpButton extends StatefulWidget {
  @override
  _FacebookSignUpButtonState createState() => _FacebookSignUpButtonState();
}

class _FacebookSignUpButtonState extends State<FacebookSignUpButton> {
  bool _isLoggedIn = false;
  Map _userObj = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: _isLoggedIn ? Container(
            alignment: Alignment.center,
            color: Colors.pink.shade500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Logged In',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  maxRadius: 75,
                  backgroundImage: NetworkImage(_userObj ["picture"]["data"]["url"]),
                ),
                SizedBox(height: 8),
                Text(_userObj ["name"], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 8),
                Text(_userObj["email"], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                SizedBox(height: 16),
                ElevatedButton(
                    child: Text("Logout"),
                    onPressed: (){
                      FacebookAuth.instance.logOut().then((value){
                        setState((){
                          _isLoggedIn = false;
                          _userObj = {};
                        });
                      });
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                    }
                )
              ],
            ),
          ) : Container(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:Column(
                  children: [
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child:Container(
                        child: FaIcon(FontAwesomeIcons.facebook, color: Colors.blueAccent,size: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    Text(
                      'Are you sure about Facebook Login?',
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        child: Text('Yes\, I\'m Sure.'),
                        onPressed: () async{
                          FacebookAuth.instance.login(
                              permissions: ["public_profile","email"]
                          ).then((value){
                            FacebookAuth.instance.getUserData().then((userData){
                              setState((){
                                _isLoggedIn = true;
                                _userObj = userData;
                              });
                            });
                          });
                        }
                    ),
                    Spacer()
                  ],
                )
            ),
          ),
        )
    );
  }
}

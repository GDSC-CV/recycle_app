import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle_app/models/myuser.dart';
import 'package:recycle_app/screen/authenticate/sign_in.dart';
import 'package:recycle_app/service/database.dart';
import 'package:recycle_app/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recycle_app/screen/home_page/articles_links.dart';
import 'package:recycle_app/screen/home_page/friend_page.dart';
import 'package:recycle_app/screen/home_page/my_home_page.dart';
import 'package:recycle_app/screen/home_page/change_password.dart';
import 'package:recycle_app/screen/authenticate/forget_password.dart';
import 'package:recycle_app/service/auth.dart';
import 'package:recycle_app/screen/home_page/sdf.dart';




class Setting_page extends StatefulWidget {
  const Setting_page({super.key});

  @override
  State<Setting_page> createState() => _Setting_pageState();
}

class _Setting_pageState extends State<Setting_page> {

  final _formKey = GlobalKey<FormState>();
  String _currentName = "";
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
        appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: AppBar(
          backgroundColor:Color.fromRGBO(31, 64, 92, 1),
          automaticallyImplyLeading: false,
          title: Text(
            'Settings',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.white, 
                fontSize: 22,
              ),
            
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          child: Stack(
            children: [
              Image.asset(
                'Background.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(200, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Icon(
                                    Icons.person,
                                    color: Color.fromARGB(255, 111, 110, 110),
                                    size: 45,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => Provider(
                                              create: (context) => userData,
                                              builder: (context, child) => const ChangeName_page(),
                                            ),
                                          ),
                                          
                                        );
                                      },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(250, 40),
                                      backgroundColor: Color.fromARGB(255, 88, 56, 18),
                                    ),
                                    child: Text(
                                      'User Name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
	                                      fontFamily: 'Lato',
                                      ),

                                    ),
                                  )

                                ),
                              ],
                            ),
                          ),
                        ),
                       Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(200, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Icon(
                                    Icons.dialpad_outlined,
                                    color: Color.fromARGB(255, 111, 110, 110),
                                    size: 45,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => Provider(
                                              create: (context) => userData,
                                              builder: (context, child) => const ForgetPassword(),
                                            ),
                                          ),
                                        );
                                      },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(250, 40),
                                      backgroundColor: Color.fromARGB(255, 88, 56, 18),
                                    ),
                                    child: Text(
                                      'Reset Password',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
	                                      fontFamily: 'Lato',
                                      ),

                                    ),
                                  )

                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(200, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: Icon(
                                    Icons.logout,
                                    color: Color.fromARGB(255, 111, 110, 110),
                                    size: 45,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0),
                                  child: ElevatedButton(
                                      onPressed: () async {//SignIn
                                        await _auth.signOut();
                                        Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                        },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(250, 40),
                                      backgroundColor: Color.fromARGB(255, 88, 56, 18),
                                    ),
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
	                                      fontFamily: 'Lato',
                                      ),

                                    ),
                                  )

                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 250, 248, 248),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'Logo.png',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-0.6, -1),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                      ),
                      alignment: AlignmentDirectional(0, -1),
                      child: Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                          IconButton(
                            icon: const Icon(Icons.home),
                            tooltip: 'Home',
                            onPressed: () {
                              Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.article),
                            tooltip: 'Articles',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Provider(
                                    create: (context) => userData,
                                    builder: (context, child) => Articals_links(),
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.people),
                            tooltip: 'Friends',
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Provider(
                                    create: (context) => userData,
                                    builder: (context, child) => const FriendWidget(),
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings),
                            tooltip: 'Settings',
                            onPressed: () {
                              
                            },
                          ),
                        ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
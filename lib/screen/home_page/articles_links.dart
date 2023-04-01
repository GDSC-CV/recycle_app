import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycle_app/screen/home_page/my_home_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:recycle_app/tools/experience_system.dart';
import 'package:recycle_app/models/myuser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recycle_app/screen/home_page/friend_page.dart';
import 'package:recycle_app/screen/home_page/setting_page.dart';


class Articals_links extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context); // Accessing userData through Provider

    return Scaffold(
      backgroundColor: Colors.transparent,
        appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: AppBar(
          backgroundColor:Color.fromRGBO(31, 64, 92, 1),
          automaticallyImplyLeading: false,
          title: Text(
            'Articles',
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('links').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final docs = snapshot.data!.docs;

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final data = doc.data() as Map<String, dynamic>;
                          final title = data['title'] as String;
                          final content = data['content'] as String;
                          final url = data['url'] as String;

                          return ElevatedButton(
                            onPressed: () async {
                              await Experience.userGainExp(userData, 5);
                              //Experience.userGainExp(userData, 5);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WebView(
                                    initialUrl: url,
                                    javascriptMode: JavascriptMode.unrestricted,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.black),
                              ),
                              backgroundColor: Color.fromARGB(186, 250, 250, 250),
                              foregroundColor: Colors.black,
                              minimumSize: Size(200, 60),
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Provider(
                                    create: (context) => userData,
                                    builder: (context, child) => const Setting_page(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                        ),
                      ),
                    ),
                  ),
            ]

          
          )
        ]
       )
    );
  }        
}
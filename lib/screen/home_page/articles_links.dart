import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:recycle_app/tools/experience_system.dart';
import 'package:recycle_app/models/myuser.dart';

class Articals_links extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context); // Accessing userData through Provider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 64, 92, 1),
        title: Text('Articles Links'),
      ),
      body: Padding(
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
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.black),
                    ),
                    backgroundColor: Colors.grey[50],
                    foregroundColor: Colors.black,
                    minimumSize: Size(200, 60),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
      
    );
  }
}

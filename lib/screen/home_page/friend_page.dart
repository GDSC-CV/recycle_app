import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recycle_app/models/myuser.dart';
import 'package:recycle_app/service/database.dart';
import 'package:recycle_app/tools/constants.dart';
import 'package:recycle_app/tools/friend_system.dart';
import 'package:recycle_app/screen/home_page/userinfo_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  
  final _formKey = GlobalKey<FormState>();
  String _friendId = "";

  @override
  Widget build(BuildContext context) {

    UserData userData = Provider.of<UserData>(context);

    return Scaffold(
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
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const userInfo_widget(),
            const SizedBox(height: 30,),
            const Text(
              "Your ID",
              style: TextStyle(
                fontSize: 40
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: userData.uid));
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.black,
                  ),
                  label: Text(
                    userData.uid,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )
                )
              ],
            ),
            const SizedBox(height: 20,),
            const Text(
              "Enter Your Friend's ID!",
              style: TextStyle(
                fontSize: 20
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Your Friend\'s ID',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                    color: Color.fromRGBO(31, 64, 92, 1),
                    width: 4,
                    ),
                  borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (val) => val!.isEmpty ? 'Please enter a id' : null,
                onChanged: (val) => setState(() => _friendId = val),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(31, 64, 92, 1),
                foregroundColor: Colors.grey[50],
              ),
              child: const Text(
                'confirm'
              ),
              onPressed: () async {
                if(userData.friends.contains(_friendId)){
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        content: Text("ID Error or You already are friends!"),
                      );
                  });
                }else{
                  await FriendSystem.addFriend(userData, _friendId);
                }
              }
               
              
            ),
            
          ],
        )
      ),
    );
  }
}
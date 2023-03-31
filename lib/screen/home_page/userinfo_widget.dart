import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle_app/models/myuser.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:recycle_app/service/database.dart';
import 'package:recycle_app/tools/experience_system.dart';

class userInfo_widget extends StatefulWidget {
  const userInfo_widget({super.key});

  @override
  State<userInfo_widget> createState() => _userInfo_widgetState();
}

class _userInfo_widgetState extends State<userInfo_widget> {
  @override
  final _auth = FirebaseAuth.instance;
  String? userEmail;
  
  void getCurrentUserInfo() async {
    //user = await _auth.currentUser();
    userEmail = _auth.currentUser?.email; 
  }
  

  Widget build(BuildContext context) {

    final user = Provider.of<UserData>(context);
    
    final userRemainexp = Experience.calculate_LastExperience(user.experiences);
    final expPersent = userRemainexp/10;
    
    getCurrentUserInfo();
    
    
    return Column(
      
      children: [
        
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color:Color.fromRGBO(31, 64, 92, 1),
          ),
          currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage:AssetImage('Logo.png'),
          ),
          accountName: Text(user.name),
          accountEmail: Text(userEmail??" "),
          
        ),
        const Text("Current Level:"),
        
        const SizedBox(height: 10,),
        Text(
          user.level.toString(),
          style: const TextStyle(
            fontSize: 50,
          ),

        ),
        const SizedBox(height: 20,),
        LinearPercentIndicator(
          alignment: MainAxisAlignment.center,
          width: 250.0,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2000,
          percent: expPersent,
          center: Text((expPersent*100).toString()+"%"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Color.fromARGB(255, 246, 193, 47),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
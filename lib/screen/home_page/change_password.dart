import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle_app/models/myuser.dart';
import 'package:recycle_app/service/database.dart';
import 'package:recycle_app/tools/constants.dart';

class Change_password extends StatefulWidget {
  const Change_password({super.key});

  @override
  State<Change_password> createState() => _Change_passwordState();
}

class _Change_passwordState extends State<Change_password> {
  final _formKey = GlobalKey<FormState>();
  String _currentName = "";

  
  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 64, 92, 1),
        title: const Text('User name'),
        elevation: 0,
      ),
        body: Stack(
          children: [
            Image.asset(
              'Background.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              color: Colors.black54,
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Update your user name',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            fillColor: Colors.grey[100],
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          validator: (val) =>
                              val!.isEmpty ? 'Please enter a name' : null,
                          onChanged: (val) => setState(() => _name = val),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Confirm'),
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                            if(_currentName.isNotEmpty){
                            await DatabaseService(uid: userData.uid).updateUserDataInfo(
                           _currentName,
                            userData.level,
                            userData.experiences,
                    );
                  }
                  
                  Navigator.pop(context);
                }
                          },
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 171, 129, 4),
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _name;
}

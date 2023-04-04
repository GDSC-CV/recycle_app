import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycle_app/models/myuser.dart';
import 'package:recycle_app/service/database.dart';
import 'package:recycle_app/tools/constants.dart';

class ChangeName_page extends StatefulWidget {
  const ChangeName_page({super.key});

  @override
  State<ChangeName_page> createState() => _ChangeName_pageState();
}

class _ChangeName_pageState extends State<ChangeName_page> {

  final _formKey = GlobalKey<FormState>();
  String _currentName = "";

  @override
  Widget build(BuildContext context) {
    
    //User user = Provider.of<User>(context);
    UserData userData = Provider.of<UserData>(context);
    
    return Scaffold(

      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 64, 92, 1),
        title: const Text('Reset Password'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.asset(
            'Background.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.black54,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Update your user name',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                      child: TextFormField(
                        initialValue: userData.name,
                        decoration: inputTextDecoration,
                        validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text(
                            'confirm'
                        ),
                        onPressed: () async {
                          if(_formKey.currentState!.validate()){
                            if(_currentName.isNotEmpty){
                              await DatabaseService(uid: userData.uid).updateUserDataInfo(
                                _currentName,
                                userData.level,
                                userData.experiences,
                              );

                              Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            }

                          }
                        }
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(135, 255, 193, 7),
                        foregroundColor: Colors.black,
                      ),
                      onPressed: (){
                        Navigator.pop(context,"");
                      },
                      child: const Text(
                          'cancel'
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:multidelivery/shared/auth/auth_user.dart';
import 'package:multidelivery/shared/config.dart';

import '../../../../app_module.dart';

class Profile extends StatefulWidget {
  const Profile({ Key key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    AppModule.to<Config>().showLog('Profile Page iniciada');
  }
  @override
  void dispose() {
    super.dispose();
    AppModule.to<Config>().showLog('Profile Page destruida');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(child: Text(''),
        onPressed: (){
          AppModule.to<AuthUser>().signout();
        },
        ),
      ),
    );
  }
}
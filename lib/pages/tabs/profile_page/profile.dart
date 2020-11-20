import 'package:demo/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text('Perfil'),
        actions: [
          IconButton(icon: Icon(Icons.settings_power),
          onPressed: (){
            logout(context);
          },
          ),
        ],
      ),
      body: Center(
        child: Text('Page'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
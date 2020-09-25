import 'package:flutter/material.dart';

class PreorderPage extends StatefulWidget {
  PreorderPage({Key key}) : super(key: key);

  @override
  _PreorderPageState createState() => _PreorderPageState();
}

class _PreorderPageState extends State<PreorderPage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
         child: Text('Page'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
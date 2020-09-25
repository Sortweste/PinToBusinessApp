import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream example'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){ setState(() {
            
          }); }),
        ],
      ),
      body: SingleChildScrollView(
              child: Column(
          children: [
            CachedNetworkImage(
          imageUrl: "https://photographylife.com/wp-content/uploads/2017/01/What-is-landscape-photography.jpg",
          placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
          errorWidget: (context, url, error) => Icon(Icons.error),
     ),
          ],
        ),
      ),
    );
  }
}
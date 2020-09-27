import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class InternetWidget extends StatelessWidget {

   final Widget hasInternet;
   final Widget noInternet;
  
  InternetWidget({this.hasInternet, this.noInternet});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
           connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child){
            final bool connected = connectivity != ConnectivityResult.none;
            return Expanded(
                child: Column(
                  children: [
                    _internetLabel(context, connected),
                    if (connected) hasInternet else noInternet
                  ],
                ),
              )
              ;
          },
          child: Container(),
        );      
  }

  Widget _internetLabel(BuildContext context, bool i){
    return  AnimatedContainer(
                    height: (i) ? 0 : 32,
                    duration: Duration(seconds: 1),
                    curve: Curves.linear,
                    decoration: BoxDecoration(
                       color: i ? Theme.of(context).scaffoldBackgroundColor : Colors.red,
                    ),
                    child: Center(child: (!i) ? Text('No hay conexión a internet', style: TextStyle(color: Colors.white),) : Container()),
                  );
  }
}

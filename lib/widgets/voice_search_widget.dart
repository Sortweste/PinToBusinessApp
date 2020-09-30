import 'dart:async';

import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceSearch extends StatefulWidget {

  @override
  _VoiceSearchState createState() => _VoiceSearchState();
}

class _VoiceSearchState extends State<VoiceSearch> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "";
  final SpeechToText speech = SpeechToText();


  @override
  void initState() {
    super.initState();
     initSpeechState();
  }


  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
    if( _hasSpeech && !speech.isListening ){
      startListening();
    }
  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog (
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      
      title: Text('$lastWords', textAlign: TextAlign.center,),
      content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              AvatarGlow(
                animate: speech.isListening,
                glowColor: Colors.black,
                duration: Duration(milliseconds: 500),
                endRadius: 50,
                repeat: true, 
                child: FloatingActionButton(onPressed: () {
                    if(_hasSpeech && speech.isListening){
                      stopListening();
                    }else{
                      startListening();
                    }
                }, 
                backgroundColor: (speech.isListening) ? Colors.red : Colors.blue,
                child: Icon(Icons.mic),),
              ),
              SizedBox(height: 10,),
               Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              RaisedButton(color: Colors.greenAccent ,child: Text('Cancelar') ,onPressed: (){
                cancelListening();
              }),
            ],
          ),
            ],
          ),
        ),
    );
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 10),
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
    Future.delayed(Duration(milliseconds: 500), (){
         Navigator.pop(context, '');
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
      if(result.finalResult == true){
      Future.delayed(Duration(seconds: 1), (){
         Navigator.pop(context, lastWords);
      });
    }
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    // print(
    // "Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }



}
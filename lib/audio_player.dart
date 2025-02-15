import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_player/video_player.dart';




class AudioPlayerPage extends StatefulWidget{


  @override
  State<AudioPlayerPage> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayerPage> {

  //List<String> songSrc =["https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3","https://pixabay.com/music/modern-classical-relaxing-piano-music-259727/","https://pixabay.com/music/beautiful-plays-just-relax-11157/","https://pixabay.com/music/modern-classical-relaxing-piano-music-248868/"];

   AudioPlayer? audioPlayer;
  Duration bufferPosition=Duration.zero;
  Duration currentPosition=Duration.zero;
   Duration totalDuration = Duration.zero;
  @override
  void initState() {
    super.initState();
    setAudioPlayer();
  }
 void setAudioPlayer() async{
     String songSrc= "https://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Kangaroo_MusiQue_-_The_Neverwritten_Role_Playing_Game.mp3";
    audioPlayer = AudioPlayer();
 totalDuration =  (await audioPlayer!.setUrl(songSrc))!;
 //audioPlayer!.play();

 audioPlayer!.bufferedPositionStream.listen((event){
   bufferPosition=event;
   setState(() {

   });
 });
 audioPlayer!.positionStream.listen((event){
   currentPosition=event;
   setState(() {

   });
 });


  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       centerTitle: true,
      title: Text("Audio Player",style:TextStyle(fontSize:30,fontWeight:FontWeight.w300,color: Colors.blue))
   ),
   body: Container(
     child: Column(mainAxisAlignment: MainAxisAlignment.center,
       children: [
         ProgressBar(
           progress: currentPosition,
           total: totalDuration,
             buffered: bufferPosition,

           onSeek: (seekToValue){
           audioPlayer!.seek(seekToValue);
           },
         ),
         Row(mainAxisAlignment: MainAxisAlignment.center,
           children: [
             InkWell(
               onTap: (){

               },
               child: Container(
                 width: 50,height: 50,
                 decoration: BoxDecoration(
                     color: Colors.amber,
                     shape: BoxShape.circle
                 ),
                 child: Icon(Icons.skip_previous),
               ),
             ),
             SizedBox(width: 10,),
             InkWell(
               onTap: (){
                 if(audioPlayer!.playing){
                   audioPlayer!.pause();
                 } else{
                   audioPlayer!.play();
                 }
               },
               child: Container(
                 width: 50,height: 50,
                 decoration: BoxDecoration(
                   color: Colors.amber,
                   shape: BoxShape.circle
                 ),
                 child: Icon(audioPlayer!.playing ?Icons.pause: Icons.play_arrow),
               ),
             ),
             SizedBox(width: 10,),
             InkWell(
               onTap: (){
                 //play
               },
               child: Container(
                 width: 50,height: 50,
                 decoration: BoxDecoration(
                     color: Colors.amber,
                     shape: BoxShape.circle
                 ),
                 child: Icon(Icons.skip_next),
               ),
             ),
           ],
         )

       ],
     ),
   ),
     floatingActionButton: FloatingActionButton(onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (context){
         return VideoPlayerPage();
       }));
     },child: Icon(Icons.add,color: Colors.blue,),),
   );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget{



  @override
  State<VideoPlayerPage> createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {

  VideoPlayerController? mController;

  var videoSrc="http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  List<String> videoSongs=["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "  http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  " http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  " http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
  " http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
  " http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
  "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",

  ];
  @override
  void initState() {
    super.initState();
    mController=VideoPlayerController.networkUrl(Uri.parse(videoSrc));
    if(mController!=null) {
      mController!.initialize().then((value){
        setState(() {

        });
      });
    //  mController!.play();
    }
    mController!.addListener((){
      setState(() {

      });
    });

  }
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Video Player",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),),
      ),
      body: mController!=null? Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: mController!.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(mController!),
                    Center(
                      child: InkWell(
                        onTap:(){
                          if(mController!.value.isPlaying){
                            mController!.pause();
                            isVisible=false;
                          }else{
                            mController!.play();
                            isVisible=true;
                          }

                        },
                        child: AnimatedOpacity(
                          duration: Duration(seconds: 4),

                          opacity: isVisible ? 0:1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle
                            ),
                            child: Icon(mController!.value.isPlaying ?  Icons.play_arrow:Icons.pause),
                          ),
                        ),
                      ),
                    )

                  ],
                ),

              ),
              Slider(
                  value: mController!.value.position.inSeconds.toDouble(),
                  min: 0,
                  max: mController!.value.duration.inSeconds.toDouble(),
                  activeColor: Colors.grey,
                  inactiveColor: Colors.green.shade100,
                  thumbColor: Colors.grey.shade200,
                  onChanged: (value){
                    mController!.seekTo(Duration(seconds: value.toInt()));
                  })
            ],
          ),
        ),
      ): CircularProgressIndicator(),
    );
  }

}
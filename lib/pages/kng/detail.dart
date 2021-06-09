import 'package:flutter/material.dart';
import 'package:topteam/common/widgets.dart';
import 'package:topteam/services/main.dart';
import 'package:video_player/video_player.dart';

class KngDetail extends StatefulWidget {
  final id;
  final title;
  
  KngDetail(
    this.id,
    {
      Key key,
      this.title = '课程详情'
    }
  ) : super(key: key);

  @override
  _KngDetailState createState() => _KngDetailState();
}

class _KngDetailState extends State<KngDetail> {
  var loading = true;
  var detail = {};
  var error = false;
  var playing = false;
  VideoPlayerController _controller;
  @override
  void initState() {
    getDetail();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: loading || error ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            error ? Text('加载失败') : CircularProgressIndicator()
          ]
        ),
      ) : Column(
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(image: NetworkImage(detail['logoUrl']), fit: BoxFit.cover)
              ),
              child: playing ? Stack(
                alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ) : Offstage(
                offstage: playing,
                child: GestureDetector(
                  child: Container(
                    width: 120,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffffffff)),
                      color: Color.fromRGBO(0, 0, 0, .6),
                      borderRadius: BorderRadius.all(Radius.circular(16))
                    ),
                    child: AppText('开始学习', color: Colors.white,),
                  ),
                  onTap: play
                ),
              ),
            )
          )
        ]
      ),
    );
  }

  void getDetail() {
    getKngDetail(widget.id, query: { 'kngId': widget.id }).then((res) {
      setState(() {
        loading = false;
        detail = res.data;
      });
    }).catchError((err) {
      loading = false;
      error = true;
      setState(() {});
    });
  }

  void play() {
    // setState(() {
    //   playing = true;
    // });
    playing = true;
    getPlayInfo();
  }

  void getPlayInfo() {
    getKngPalyInfo({
      'fileId': detail['fileId'],
      'fileUrl': detail['fileUrl'],
      'sourceOrgId': detail['sourceOrgId'],
      'originType': '',
      'isH5': 1
    }).then((res) {
      // print(res.data['newPlayListItem']['videoItems'][0]['fileFullUrl']);
      _controller = VideoPlayerController.network(res.data['newPlayListItem']['videoItems'][0]['fileFullUrl']);
      // _controller = VideoPlayerController.network('https://www.runoob.com/try/demo_source/movie.mp4');
      _controller.addListener(() {
        setState(() {});
      });
      _controller.setLooping(true);
      _controller.initialize().then((_) => setState(() {})).catchError((err){
        print('eee');
        print(err);
      });
      _controller.play();
    });
  }
}
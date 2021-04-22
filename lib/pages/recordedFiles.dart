import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:emergency_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class RecordedFiles extends StatefulWidget {
  static String id = 'RecordedFiles';
  @override
  _RecordedFilesState createState() => _RecordedFilesState();
}

class _RecordedFilesState extends State<RecordedFiles> {
  List<FileSystemEntity> _files;
  List<FileSystemEntity> _audios = [];
  Directory extDir;
  bool audioAvailable = false;
  bool playing = false;
  IconData playBtn = Icons.play_arrow;
  AudioPlayer _player;
  AudioCache cache;
  Duration position = new Duration();
  Duration musicLength = new Duration();
  DateTime date;
  double sliderValue = 0;
  bool expanded = false;
  int _totalDuration;
  int _currentDuration;
  double _completedPercentage = 0.0;
  bool _isPlaying = false;
  bool _freshPlay = true;
  int _selectedIndex = -1;

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.red[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    asyncMethod();
    super.initState();
    _player = AudioPlayer();
    _player.onDurationChanged.listen((d) {
      setState(() {
        _totalDuration = d.inMicroseconds;
      });
    });
    _player.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
    //cache = AudioCache(fixedPlayer: _player);
  }

  Future<void> asyncMethod() async {
    _audios = [];
    if (Platform.isAndroid) extDir = await getExternalStorageDirectory();
    if (Platform.isIOS) extDir = await getApplicationDocumentsDirectory();
    _files = extDir.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity audios in _files) {
      String path = audios.path;
      if (path.endsWith('.m4a')) _audios.add(audios);
    }
    print(_audios);
    print(_audios.length);
    setState(() {
      audioAvailable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var baseColor = Theme.of(context).backgroundColor;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(currentDisplaySize.width * 0.0641),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: currentDisplaySize.height * 0.0355),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'Recorded Audios',
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: currentDisplaySize.width * 0.1153,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///Contacts List Container
              Expanded(
                flex: 14,
                child: ClayContainer(
                  emboss: true,
                  color: baseColor,
                  surfaceColor: baseColor,
                  depth: 20,
                  borderRadius: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        child: audioAvailable
                            ? ListView.builder(
                                itemCount: _audios.length,
                                itemBuilder: (context, index) {
                                  return RecorderTile(context, index);
                                },
                              )
                            : CircularProgressIndicator()),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              )
            ],
          ),
        ),
      ),
      /*body: SafeArea(
        child:Center(
          child: audioAvailable?ListView.builder(
            itemCount: _audios.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(_audios[index].path),
              );
            },
          ):CircularProgressIndicator()
        ),
      ),*/
    );
  }

  Padding RecorderTile(BuildContext context, int index) {
    date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(basenameWithoutExtension(_audios[index].path)));
    var dateString = DateFormat.yMd().add_jm().format(date);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        height: (_selectedIndex == index ? expanded : false)
            ? currentDisplaySize.height * 0.1347
            : currentDisplaySize.height * 0.0947,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              IconButton(
                  icon: Icon(
                    (_selectedIndex == index ? !expanded : !false)
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_up_rounded,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(()  {
                      _currentDuration = 0;
                      if (expanded) {
                        _player.stop();
                      }
                      expanded = !expanded;
                      _isPlaying = false;
                      _selectedIndex = index;
                      _freshPlay = true;
                    });
                  }),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(()  {
                          _currentDuration = 0;
                          if (expanded) {
                            _player.stop();
                          }
                          expanded = !expanded;
                          _isPlaying = false;
                          _selectedIndex = index;
                          _freshPlay = true;
                        });
                      },
                      child: Text(
                        dateString.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: currentDisplaySize.height * 0.0213,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context) =>
                    CupertinoAlertDialog(
                      title: Text("Are you sure you want to delete the audio file?"),
                      actions: [
                      CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("Yes"),
                        onPressed: (){
                        setState(() {
                          _audios[index].delete();
                          _audios.removeAt(index);
                        });
                        Navigator.pop(context);
                        },
                    ),
                    CupertinoDialogAction(
                    child: Text("No"),onPressed: (){
                     Navigator.pop(context);
                    },),
                      ],
                    ),
                    );
                    setState(() {
                     // _audios[index].delete();
                      //_audios.removeAt(index);
                    });
                  }),
            ]),
            if (_selectedIndex == index ? expanded : false)
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        (_selectedIndex == index ? _isPlaying : false)
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.red,
                      ),
                      onPressed: () async {

                          if (expanded && _freshPlay) {
                            await _onPlay(filePath: _audios[index].path,
                                index: index,
                                audioPlayer: _player);
                            setState(() {
                            _freshPlay = false;
                            _isPlaying = !_isPlaying;
    });
                          }
                          setState(() {
                          if (!_freshPlay) {
                            if (_isPlaying) _player.pause();
                            if (!_isPlaying) _player.resume();
                            _isPlaying = !_isPlaying;
                          }

                          /*if(_isPlaying) {
                            _player.pause();
                            _isPlaying = !_isPlaying;
                          }*/
                        });
                      }),
                  Expanded(
                    child: CupertinoSlider(
                        activeColor: Colors.red,
                        value:
                            _selectedIndex == index ? _completedPercentage : 0,
                        onChanged: (value) {
                          setState(() {
                            _player.seek(Duration(
                                microseconds:
                                    (_totalDuration * value).round()));
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(!(_freshPlay||_totalDuration==null)?
                      Duration(microseconds: (_totalDuration-_currentDuration)).toString().split('.')[0].substring(2, 7):"    ",
                      style: TextStyle(
                          fontSize: currentDisplaySize.height * 0.0189,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }

  Future<void> _onPlay(
      {@required String filePath,
      @required int index,
      @required AudioPlayer audioPlayer}) async {
    if (!_isPlaying) {
      //if(audioPlayer.state)
      await audioPlayer.play(filePath, isLocal: true);
      setState(() {
        _selectedIndex = index;
        _completedPercentage = 0.0;
        _isPlaying = true;
      });

      audioPlayer.onPlayerCompletion.listen((_) {
        setState(() {
          _isPlaying = false;
          _completedPercentage = 0.0;
        });
      });
      audioPlayer.onDurationChanged.listen((duration) {
        setState(() {
          _totalDuration = duration.inMicroseconds;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((duration) {
        setState(() {
          _currentDuration = duration.inMicroseconds;
          _completedPercentage =
              _currentDuration.toDouble() / _totalDuration.toDouble();
        });
      });
    }
  }

  stopPlayer({@required AudioPlayer audioPlayer}) {
    audioPlayer.stop();
  }
}

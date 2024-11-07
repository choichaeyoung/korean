import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:korean/components/body_builder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:korean/components/custom_image.dart';

import 'package:korean/widgets/indicators.dart';
//import 'package:korean/view_models/home_provider.dart';
import 'package:korean/utils/router.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:flutter_html/flutter_html.dart';

//import 'package:korean/models/group.dart';
import 'package:korean/models/test_progress.dart';
import 'package:korean/models/question.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:korean/components/loading_widget.dart';
import 'package:korean/pages/cate_main.dart';
import 'package:flutter/services.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:typed_data';

import 'package:korean/view_models/exam_provider.dart';

// import 'package:get/get.dart';

// This is a minimal example demonstrating a play/pause button and a seek bar.
// More advanced examples demonstrating other features can be found in the same
// directory as this example in the GitHub repository.

import 'package:audio_session/audio_session.dart';

import 'package:just_audio/just_audio.dart';
import 'package:korean/utils/audio.dart';
import 'package:rxdart/rxdart.dart';



class ExamPage extends StatefulWidget {

  final String? kind;
  final TestProgress? progress;
  final List<Question>? question;

  const ExamPage({Key? key, @required this.kind, this.progress, this.question}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}
class _CreatePostState extends State<ExamPage> with WidgetsBindingObserver {

  int _currentIndex = 0;
  bool _aCheck = false;
  final Map<int,dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final _player = AudioPlayer();

  List<Question>? questions;
  List<Question>? result = [];

  int _counter = 0;
  late Timer _timer;

  void _startTimer() {
    print('start timer');

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }


  //final PlayerController playerController = Get.put(PlayerController());

  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.black
  );
  final TextStyle _mini = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.black
  );

  void _play() {
    //player.play(url);
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();

    _counter = int.parse(widget.progress!.time_left!);

    if (Platform.isIOS) {
      //audioCache.fixedPlayer?.notificationService.startHeadlessService();
      //advancedPlayer.notificationService.startHeadlessService();
    }


    //group = widget.group![0];
    //questions = group!.question;
    //if(group!.audioUrl! !='') advancedPlayer.play(group!.audioUrl!);



    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));


    questions = widget.question;
    var exam = widget.question![_currentIndex];


    //var audioUrl=UrlSource(exam.audioUrl!);
    //player.play(audioUrl);
    if(exam.audioUrl! !='') {
      _init(exam.audioUrl!);
    }

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //print('size: ${MediaQuery.of(context).size}');

    for(var question in questions! ) {
      //_examIndex = question.no!;
      result!.add(question);

      //print(question);
    }

    if(widget.progress!.status! != '2') {
      Timer.run(() {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('필독사항'),
            content: const Text('TOPIC 실전 테스트 입니다. \nTest 응시 중간에 나오더라도 다시 이어서 응시가 가능합니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _startTimer();
                  Navigator.pop(context, 'OK');

                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }


  Future<void> _init(var audioUrl) async {


    // print(audioUrl);

    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          audioUrl)));
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    // advancedPlayer.stop();
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();

    _timer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context){
  //TIME:${(_counter/60).floor()}:'+'${_counter%60}'.padLeft(2, '0')
    //var exam = widget.question![_currentIndex];
    //audioUrl=UrlSource(exam.audioUrl!);
    //player.play(audioUrl);

    //print(exam.audioUrl!);

    //var ddd = exam.content.toString();

    //Widget html = Html(
     // data: '${exam.audioUrl!}',
    //);

    //Widget html1 = Html(
    //  data: ddd,
    //);

    Widget html = Html(
      data: """<div>
        <h1>Demo Page</h1>
        <p>This is a fantastic product that you should buy!</p>
        <h3>Features</h3>
        <ul>
          <li>It actually works</li>
          <li>It exists</li>
          <li>It doesn't cost much!</li>
        </ul>
        <!--You can pretty much put any html in here!-->
      </div>""",
    );

    //print('${exam.content!}');

    //print(exam.content);
    return WillPopScope(
      onWillPop:(widget.progress!.status! != '2')?_onWillPop:null,
      child: Scaffold(
        key: _key,
        appBar: AppBar(

          title:  Text('${widget.progress!.title}       ${(_counter/60).floor()}:'+'${_counter%60}'.padLeft(2, '0') ,style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 18.0,),),
          elevation: 0,

        ),
        body: ListView(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display play/pause button and volume/speed sliders.
                      ControlButtons(_player),
                      // Display seek bar. Using StreamBuilder, this widget rebuilds
                      // each time the position, buffered position or duration changes.
                      StreamBuilder<PositionData>(
                        stream: _positionDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;
                          return SeekBar(
                            duration: positionData?.duration ?? Duration.zero,
                            position: positionData?.position ?? Duration.zero,
                            bufferedPosition:
                            positionData?.bufferedPosition ?? Duration.zero,
                            onChangeEnd: _player.seek,
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      /*Expanded(
                        child: Text('Correct:',
                          softWrap: true,
                          style: _mini,),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text('Wrong:',
                          softWrap: true,
                          style: _mini,),
                      ),*/
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text("${questions![_currentIndex].num!} / ${widget.progress!.set_cnt!}",
                          softWrap: true,
                          style: _mini,),
                      ),
                    ],
                  ),
                  Divider(),




                  Row(
                    children: <Widget>[
                      // Icon(Icons.my_library_books_rounded),

                      SizedBox(width: 4.0),
                      Expanded(
                        child: Text(questions![_currentIndex].title!,
                          softWrap: true,
                          style: _questionStyle,),
                      ),
                    ],
                  ),
                  /*Text((exam.question! == '')?'':exam.question!,
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Aleo',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white
                    ),
                  ),*/
                  SizedBox(height: 6.0),


                  if (questions![_currentIndex].content != '')
                    html,

                  SizedBox(height:6,),
                  //for(var question in questions! )
                    Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(width: 20.0),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.black26,
                                child: Text("${questions![_currentIndex].num!}",
                                  style: TextStyle(

                                      fontSize: 16.0,
                                      color: Colors.white
                                  ),),
                              ),
                              SizedBox(width: 16.0),
                              if (questions![_currentIndex].question! !='')
                                Container(
                                  width:MediaQuery.of(context).size.width * 0.8,
                                  child:Text("${questions![_currentIndex].question!}",
                                    style: TextStyle(

                                      fontSize: 16.0,
                                      //color: Colors.red
                                    ),),)
                              /*Expanded(
                                child: Text(HtmlUnescape().convert(widget.group![_currentIndex].partName!),
                                  softWrap: true,

                                  style: _questionStyle,),
                              ),*/
                            ],
                          ),


                          //SizedBox(width: 16.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ...questions![_currentIndex].answers!.map((option)=>RadioListTile<String>(
                                title: (questions![_currentIndex].qtype =='0')?Text("$option"):Image(image: NetworkImage("$option",), fit: BoxFit.cover,),
                                groupValue: _answers[questions![_currentIndex].num!],
                                //dense: true,
                                value: option,
                                onChanged: (value){
                                  setState(() {
                                    _answers[questions![_currentIndex].num!] = value;
                                    _aCheck = true;
                                  });
                                },
                              )),


                            ],

                          ),
                        ]
                    ),


                  Container(
                    //alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 3, 199, 90),
                          surfaceTintColor: Color.fromARGB(255, 3, 199, 90),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      child: Text( _currentIndex == (widget.question!.length - 1) ? "Submit" : "Next"),
                      onPressed: _nextSubmit,
                      //  onTap: () { _study1(widget.set!, "4"); }
                    ),
                  ),


                ],


              ),
            ),
          ],
        ),
      ),
    );
  }


  void _nextSubmit() {

    if(widget.progress!.status != '2') {

      if (_aCheck == false) {
        //_key.currentState!.showSnackBar(const SnackBar(
        //  content: Text("You must select an answer to continue."),
        //));
        Fluttertoast.showToast(
            msg: "답을 선택하세요.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }
    }

    /*if(_answers[_examIndex] == null) {
      _key.currentState!.showSnackBar(SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    }*/



    if(_currentIndex < (widget.question!.length - 1)){
      setState(() {
        _currentIndex++;
       // group = widget.group![_currentIndex];
        //questions = group!.question;
       // if(group!.audioUrl! !='') advancedPlayer.play(group!.audioUrl!);
        //for(var question in questions! ) {
        //  _examIndex = question.num!;
        //  result!.add(question);

          //print(question);
       // }

        var exam = widget.question![_currentIndex];
        if(exam.audioUrl! !='') {
          _init(exam.audioUrl!);
        }

        _aCheck = false;

      });








    } else {
      //시험저장
      _save('3');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('시험완료'),
          content: const Text('시험을 완료하였습니다. 성적을 확인해 보세요.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                //Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );




      /*Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => ExamFinishedPage(set_id:widget.exam!.set_id, questions: result, answers: _answers)
      ));*/

    }
  }
  void _save(String mode) async{

    //시험이 끝났으면 저장하지 않는다.
    if(widget.progress!.status == '2') return ;


    //시험저장
    int correct = 0;
    String iCorrect = "0";
    int sel = 0;
    String str = "";
    _answers.forEach((index,value) async {
      var question = result![index - 1];
      var answer = 0;

      //선택한번호
      for (var i = 0; i < question.answers!.length; i++) {
        if (question.answers![i] == value.toString()) {
          //answer = i + 1;
          sel = i + 1;
        }
      }

      //정답
      if (question.answer == value.toString()) {
        correct++;
        iCorrect = "1";
      } else {
        iCorrect = "0";
      }

      str += question.num.toString() + ":" + sel.toString() + ":" + iCorrect + ",";
      /* var rtn = await exam.setExamSave(mode, widget.type!, widget.exam!.set_id!, question.iPart!, widget.member_seq!, question.content_id!,
          question.id!,question.iQNo!,answer.toString(), iCorrect, _counter.toString() );*/



    });

    print(str);

    //시험저장
    context.read<ExamProvider>().setExamSave(context, widget.progress!.seq, widget.progress!.kind, widget.progress!.set_seq, str, _counter);

    //print('dsfdsafdsafsdafds' + _answers.toString());



  }
  Future<bool> _onWillPop() async {
    return ( await showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text("시험을 종료하시겠습니까?.\n 현재까지 푼 문제는 저장되며 이어서 응시가 가능합니다."),
            title: Text("경고!"),
            actions: <Widget>[
              ElevatedButton(
                child: Text("예"),
                onPressed: () async {
                  _save('2');
                  _player.stop();


                  Navigator.pop(context,true);
                },
              ),
              ElevatedButton(
                child: Text("아니오"),
                onPressed: (){
                  Navigator.pop(context,false);
                },
              ),
            ],
          );
        }
    )) ?? false;
  }
}







/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:korean/components/body_builder.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:korean/components/custom_image.dart';

import 'package:korean/widgets/indicators.dart';
import 'package:korean/view_models/home_provider.dart';
import 'package:korean/utils/router.dart';
import 'package:korean/models/book.dart';
import 'package:korean/models/bookhis.dart';
import 'package:korean/models/question.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:korean/components/loading_widget.dart';
import 'package:korean/pages/exam_page.dart';
import 'package:korean/pages/exam_result.dart';

import 'package:flutter/services.dart';

class BookMain extends StatefulWidget {
  final Book book;
  final String kind;

  const BookMain(this.book, this.kind, {Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}
class _CreatePostState extends State<BookMain> {

  bool extended = false;
  late bool processing;


  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
          (_) => Provider.of<HomeProvider>(context, listen: false).getBookHis(widget.book.set_seq, widget.kind),
    );

  }
  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider data, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title:  Text(widget.book.title),
            //centerTitle: true,
            actions: [

            ],
          ),
          body: _buildBody(data),
          floatingActionButton: SizedBox(
            height: 50,
            width: 160,
            child: extendButton(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
      },
    );
  }
  FloatingActionButton extendButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        //setState(() {
         // extended = !extended;
        //});
        //MyRouter.pushPage(context, ExamPage(),);

        _start(widget.book, widget.kind);

      },
      label: const Text("Start Now"),
      //isExtended: extended,
      icon: const Icon(
        Icons.start,
        size: 30,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      /// 텍스트 컬러
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
    );
  }

  void _start(Book book, String kind) async {
    setState(() {
      processing=true;
    });
    try {
      await context.read<HomeProvider>().getExam(widget.book.set_seq, widget.kind);
      // print(question);

      //시험시작
      if(context.read<HomeProvider>().examList.length > 0) {
        Navigator.push(context, MaterialPageRoute(
            builder: (_) => ExamPage(kind:widget.kind, progress:context.read<HomeProvider>().testProgress, question: context.read<HomeProvider>().examList)
        )).then(onGoBack);
      }
    } catch(e){
      //print(e.message);
      //Navigator.pushReplacement(context, MaterialPageRoute(
      //    builder: (_) => ErrorPage(message: "Unexpected error trying to connect to the API",)
      //));
    }


    setState(() {
      processing=false;
    });
  }


  void _restart(String seq) async {
    setState(() {
      processing=true;
    });
    try {
      await context.read<HomeProvider>().getExamResume(seq);
      // print(question);

      //시험시작
      if(context.read<HomeProvider>().examList.length > 0) {
        Navigator.push(context, MaterialPageRoute(
            builder: (_) => ExamPage(kind:widget.kind, progress:context.read<HomeProvider>().testProgress, question: context.read<HomeProvider>().examList)
        )).then(onGoBack);
      }
    } catch(e){
      //print(e.message);
      //Navigator.pushReplacement(context, MaterialPageRoute(
      //    builder: (_) => ErrorPage(message: "Unexpected error trying to connect to the API",)
      //));
    }


    setState(() {
      processing=false;
    });
  }


  void _deleteHistory(String seq) async {
    setState(() {
      processing=true;
    });
    try {
      await context.read<HomeProvider>().setExamDelete(context, seq);
      // print(question);

    } catch(e){
      //print(e.message);
      //Navigator.pushReplacement(context, MaterialPageRoute(
      //    builder: (_) => ErrorPage(message: "Unexpected error trying to connect to the API",)
      //));
    }


    setState(() {
      processing=false;
    });
  }



  void onGoBack(dynamic value) {
    //_getUnit();
    //setState(() {});
  }

  Widget _buildBody(HomeProvider data) {
    return BodyBuilder(
      apiRequestStatus: data.apiRequestStatus,
      child: _buildBodyList(data),
      reload: () => data.getHome(),
    );
  }

  Widget _buildBodyList(HomeProvider data) {
    var title = "Listening";
    if(widget.kind=='L') title = 'Listening';
    if(widget.kind=='R') title = 'Reading';
    if(widget.kind=='G') title = 'Grammar';
    if(widget.kind=='W') title = 'Writing';
    if(widget.kind=='S') title = 'Speaking';

    return RefreshIndicator(
      onRefresh: () => data.getHome(),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          _buildTopTitle('${title}'),
          _buildTopTitle('총 : ${widget.book.set_cnt} 문항'),
          _buildTopTitle('제한시간 : ${widget.book.time_left}분'),
          SizedBox(height: 15.0),
          _buildSectionTitle('History'),
          _buildSectionTitleSmall('Tips : view detail of the test press on card body.'),

          _buildSection(data),

        ],
      ),
    );
  }
  _buildTopTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          //IconButton(
          //    onPressed: () async {
                //MyRouter.pushPage(context, Club(),);
         //     },
         //     icon: const Icon(CupertinoIcons.plus_circle_fill)
         // ),

        ],
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          //IconButton(
          //    onPressed: () async {
          //MyRouter.pushPage(context, Club(),);
          //     },
          //     icon: const Icon(CupertinoIcons.plus_circle_fill)
          // ),

        ],
      ),
    );
  }
  _buildSectionTitleSmall(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
  _buildSection(HomeProvider data) {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),

      itemCount: data.his.length ?? 0,
      itemBuilder: (BuildContext context, int index) {

        Bookhis history = data.his[index];

        return Card(
                elevation: 0,
                color:Colors.grey[300],
                shape: RoundedRectangleBorder(
                side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    onTap: () {
                      //MyRouter.pushPage(context, CateMain(cate),);
                     //_restart(history.seq);

                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => ExamResult(seq:history.seq),
                        ),
                      );




                    },
                    leading: Padding(
                      padding: EdgeInsets.all(6.0),
                      child:  IconButton(
                          onPressed: () {
                            _restart(history.seq);
                          },
                          icon: const Icon(Icons.play_circle, size:30)
                      ),
                    ),
                    title: Text('${history.regist_date}',
                        style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    subtitle: Text('Score : ${history.score} Time: ${history.time_left}',),
                  trailing: IconButton(
                      onPressed: () {

                        Timer.run(() {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('정말로 삭제하시겠습니까?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    _deleteHistory(history.seq);
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'NO');
                                  },
                                  child: const Text('NO'),
                                ),
                              ],
                            ),
                          );
                        });

                        //MyRouter.pushPage(
                        //  context,
                        //  Location(),
                        //);
                      },
                      icon: const Icon(Icons.delete, size:30)
                  ),
                ),
                  //Divider(),
            ]),
        );
      },
    );
  }

}

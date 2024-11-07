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
import 'package:korean/models/noti.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:korean/components/loading_widget.dart';
import 'package:korean/pages/notiview.dart';
import 'package:flutter/services.dart';
import 'package:korean/screens/comment.dart';
import 'package:ionicons/ionicons.dart';
class ExamResult extends StatefulWidget {
  final String? seq;

  const ExamResult({Key? key, @required this.seq}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}
class _CreatePostState extends State<ExamResult> {

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
          (_) => Provider.of<HomeProvider>(context, listen: false).getNoti(''),
    );

  }
  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider clubProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Ionicons.close_outline),
              onPressed: () {
                //viewModel.resetPost();
                Navigator.pop(context);
              },
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text('Overview',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 18.0,)),
            //centerTitle: true,
            actions: [

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: GestureDetector(
                    onTap: () async {
                      //context.read<HomeProvider>().setNotiReadAll(context);
                      //context.read<HomeProvider>().getNoti('');
                    },
                    child: IconButton(
                      icon: Icon(Ionicons.close_outline),
                      onPressed: () {
                        //viewModel.resetPost();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),

            ],
          ),
          body: _buildBody(clubProvider),
        );
      },
    );
  }
  Widget _buildBody(HomeProvider data) {
    return BodyBuilder(
      apiRequestStatus: data.apiRequestStatus,
      child: _buildBodyList(data),
      reload: () => data.getNoti(''),
    );
  }

  Widget _buildBodyList(HomeProvider data) {
    return RefreshIndicator(
      onRefresh: () => data.getNoti(''),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        children: <Widget>[
          //SizedBox(height: 15.0),
          //_buildSearch(),
          SizedBox(height: 15.0),
          //_buildSectionTitle('지금 인기있는책'),
          _buildSection(data),

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

      itemCount: data.notiList.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Noti noti = data.notiList[index];

        return  Column(
            children: [
              Container(
                color: (noti.status!='0')?Colors.grey[200]:Colors.white,
                child:
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  onTap: () {
                    if(noti.table=='posts') {
                      /*Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => Comments(post_seq: noti.msgseq),
                        ),
                      ).then((res) {
                        print(
                            '------------------------------------------------fdsafdsaf');
                        data.getNoti('');
                      });*/
                      context.read<HomeProvider>().setNotiRead(context, noti.seq);
                    } else {
                      MyRouter.pushPage(
                        context,
                        NotiView(post: noti),
                      ).then((res) {
                        print(
                            '------------------------------------------------fdsafdsaf');
                        data.getNoti('');
                      });
                    }
                  },
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                    CachedNetworkImageProvider(
                      '${noti.image}',
                    ),
                  ),

                  title: Text('${noti.msg}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  subtitle: Text('${noti.regist_date}',),
                  /*trailing: IconButton(
                        onPressed: () {
                          //MyRouter.pushPage(
                          //  context,
                          //  Location(),
                          //);
                        },
                        icon: const Icon(Icons.arrow_forward_ios)
                    ),*/
                ),
              ),Divider(),
            ]);
      },
    );
  }

}

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
import 'package:korean/models/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:korean/components/loading_widget.dart';
import 'package:korean/pages/cate_main.dart';
import 'package:flutter/services.dart';

class Study extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}
class _CreatePostState extends State<Study> {

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().init(context);
    SchedulerBinding.instance.addPostFrameCallback(
          (_) => Provider.of<HomeProvider>(context, listen: false).getHome(),
    );

  }
  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider data, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: Text('한글공부'),
            //centerTitle: true,
            actions: [

            ],
          ),
          body: _buildBody(data),
        );
      },
    );
  }
  Widget _buildBody(HomeProvider data) {
    return BodyBuilder(
      apiRequestStatus: data.apiRequestStatus,
      child: _buildBodyList(data),
      reload: () => data.getHome(),
    );
  }

  Widget _buildBodyList(HomeProvider data) {
    return RefreshIndicator(
      onRefresh: () => data.getHome(),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        children: <Widget>[
          //SizedBox(height: 15.0),
          //_buildSearch(),
          //SizedBox(height: 15.0),
          _buildSectionTitle('Study'),
          _buildSectionTitleSub('We study Hangul from the basics.'),
          _buildSection(data, '4'),

        ],
      ),
    );
  }
  _buildSectionTitle(String title) {
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

  _buildSectionTitleSub(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 14.0,
              //fontWeight: FontWeight.w500,
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

  _buildSection(HomeProvider data, String kind) {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),

      itemCount: data.category.length ?? 0,
      itemBuilder: (BuildContext context, int index) {

        Cate cate = data.category[index];

        return (data.category[index].parent_seq==kind)? Card(
                elevation: 0,
                color:Colors.grey[300],
                shape: RoundedRectangleBorder(
                side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child:Column(

                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    onTap: () {
                      MyRouter.pushPage(context, CateMain(cate),);
                    },

                    title: Text('${cate.title}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight:FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    subtitle: Text('${cate.sub_title}',),
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
                  //Divider(),
            ]),),
        ):SizedBox();
      },
    );
  }

}

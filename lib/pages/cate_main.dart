import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:korean/models/category.dart';
import 'package:korean/utils/constants.dart';
import 'package:korean/utils/router.dart';
import 'package:korean/view_models/home_provider.dart';
//import 'package:korean/views/genre/genre.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:korean/components/loading_widget.dart';
import 'package:korean/pages/cate1.dart';
//import 'package:korean/pages/cate2.dart';

class CateMain extends StatefulWidget {
  final Cate cate;

  const CateMain(this.cate, {Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CateMain>  with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    /*
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<HomeProvider>(context, listen: false).getCateMain(widget.cate.seq),
    );*/
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(widget.cate.title),
          //backgroundColor: Colors.blueGrey[900],
          bottom: const TabBar(
            tabs: [

              Tab(icon: Icon(Icons.headphones), text: "Listening",),
              Tab(icon: Icon(Icons.menu_book), text: "Reading",),

            ],
          ),
        ),
        body: TabBarView(
          children: [
            Cate1(widget.cate, 'L'),
            Cate1(widget.cate, 'R')
          ],
        ),
      ),
    );
  }
}
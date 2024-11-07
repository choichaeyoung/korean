import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:korean/components/body_builder.dart';
import 'package:korean/components/book_card.dart';
//import 'package:korean/components/book_list_item.dart';
//import 'package:flutter_ebook_app/models/category.dart';
import 'package:korean/models/book.dart';
import 'package:korean/utils/constants.dart';
import 'package:korean/utils/router.dart';
import 'package:korean/view_models/home_provider.dart';
//import 'package:social_media_app/views/genre/genre.dart';
import 'package:provider/provider.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:korean/components/loading_widget.dart';
import 'package:korean/pages/book_main.dart';
import 'package:korean/models/category.dart';

class Cate1 extends StatefulWidget {
  final Cate cate;
  final String kind;

  const Cate1(this.cate, this.kind, {Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Cate1>  with AutomaticKeepAliveClientMixin{
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<HomeProvider>(context, listen: false).getBooks(widget.cate!.seq, widget.cate.book_type),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider data,
          Widget? child) {
        return Scaffold(
            body: ListView(
                children: <Widget>[
                  _buildMainSection(data),
              ],
            ),
          );
        },
    );
  }

  _buildMainSection(HomeProvider data) {
    var cate = 'READING';
    if(widget.kind=='L') {
      cate = 'LISTENING';
    }
    if(widget.kind=='W') {
      cate = 'WRITING';
    }
    return ListView.builder(
      primary: false,
      //padding: EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.books.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Book book = data.books[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Card(
            elevation: 0,
            color:Colors.black12,
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
                      MyRouter.pushPage(context, BookMain(book, widget.kind),);
                    },
                    leading: Padding(
                      padding: EdgeInsets.all(6.0),
                        child:Text(
                          '${book.round}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),

                    title: Text('${cate}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight:FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    subtitle: Text('${book.title}',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        //MyRouter.pushPage(
                        //  context,
                        //  Location(),
                        //);
                      },
                      icon : getIconWidget(widget.kind),
                  ),
                  ),
                  //Divider(),
                ]),
          )
        );
      },
    );
  }
  Widget getIconWidget(id) {
    switch (id) {
      case 'R':
        return const Icon(Icons.menu_book);
      case 'L':
        return const Icon(Icons.headphones);

      default:
        return const Icon(Icons.menu_book);
    }
  }
  @override
  bool get wantKeepAlive => true;

}

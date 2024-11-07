import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:korean/posts/story/confrim_status.dart';
//import 'package:korean/view_models/status/status_view_model.dart';
import '../posts/create_post.dart';



class FabContainer extends StatelessWidget {
  final Widget? page;
  final IconData icon;
  final bool mini;

  FabContainer({this.page, required this.icon, this.mini = false});

  @override
  Widget build(BuildContext context) {

    //StatusViewModel viewModel = Provider.of<StatusViewModel>(context);
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return page!;
      },
      closedElevation: 4.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56 / 2),
        ),
      ),
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () {
            //chooseUpload(context, viewModel);
          },
          mini: mini,
        );
      },
    );
  }

  chooseUpload(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              /*
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Text(
                    '글쓰기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              Divider(),*/
              ListTile(
                leading: Icon(
                  CupertinoIcons.add_circled,
                  size: 25.0,
                ),
                title: Text('게시물작성'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => CreatePost(),
                    ),
                  );
                },
              ),

              ListTile(
                leading: Icon(
                  CupertinoIcons.book,
                  size: 25.0,
                ),
                title: Text('책 추가하기'),
                onTap: ()  {
                  // Navigator.pop(context);
                  //await viewModel.pickImage(context: context);
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (_) => CreatePost(),
                    ),
                  );

                },
              ),
            ],
          ),
        );
      },
    );
  }
}

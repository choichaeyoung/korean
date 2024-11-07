import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:ionicons/ionicons.dart';
import 'package:korean/auth/login/login.dart';
import 'package:korean/components/stream_grid_wrapper.dart';
import 'package:korean/models/post.dart';
import 'package:korean/models/user.dart';
import 'package:korean/screens/edit_profile.dart';
//import 'package:korean/screens/list_posts.dart';
import 'package:korean/screens/settings.dart';
//import 'package:korean/utils/firebase.dart';
import 'package:korean/widgets/post_tiles.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korean/components/loading_widget.dart';
import 'package:korean/utils/router.dart';
import 'package:korean/utils/constants.dart';
import 'package:korean/models/book.dart';
import 'package:korean/view_models/profile_provider.dart';
//import 'package:kg_charts/kg_charts.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:chips_choice/chips_choice.dart';
class Profile extends StatefulWidget {
  final String? memberSeq;

  Profile({this.memberSeq});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //User? user;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing = false;
  UserModel? users;
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  String? nickname ;
  String? photo ;

  List<String> tags = [];
  List<String> options = [
    '#책추천',
    '#자기계발',
    '#취미독서',
    '#같이읽어요.',
    '#직장인독서',
    '#필사',
    '#특정작가책읽기',
    '#독서습관만들기',
    '#함께생각해요',
  ];
  @override
  void initState() {
    super.initState();
    //checkIfFollowing();
    context.read<ProfileProvider>().init(context);
    SchedulerBinding.instance.addPostFrameCallback(
          (_) => Provider.of<ProfileProvider>(context, listen: false).getMember(widget.memberSeq),
    );
  }


  checkIfFollowing() async {
    /*DocumentSnapshot doc = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();*/

    setState(() {
      //isFollowing = doc.exists;
    });
  }

  @override
  Widget build(BuildContext context) {


    ProfileProvider data;
    return Consumer<ProfileProvider>(
        builder: (BuildContext context, ProfileProvider data, Widget? child) {
          return (data.member != null)? Scaffold(
            appBar: AppBar(
              //centerTitle: true,
              title: Text("내메뉴"),
              actions: [
                (data.memberSeq==data.member!.member_seq)
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: GestureDetector(
                            onTap: () async {
                              //await firebaseAuth.signOut();
                              await GetStorage().remove("member");

                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) => Login(),
                                ),
                              );
                            },
                            child: Text(
                              '로그아웃',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
            body: _buildBody(data),
          ):Padding(
            padding: EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                  alignment: FractionalOffset.center,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircularProgressIndicator()),
            ),);
        },
    );
  }

  Widget _buildBody(ProfileProvider data) {
    return ListView(
      children: <Widget>[
        //_buildSectionTitle('인기모임'),

        _buildTop(data),
        SizedBox(height: 20.0),
        _buildDivider(),
        (data.memberSeq==data.member!.member_seq)?_buildSectionShop(data):SizedBox(),
        SizedBox(height: 20.0),
        _buildSectionTitle('학습이력'),
        _buildDivider(),
        //_buildSection1(data),
        SizedBox(height: 20.0),
        _buildSectionTitle('학습이력'),
        _buildDivider(),
        //_buildSection4(data),

        //_buildSection4(data),
      ],
    );
  }
  _buildDivider() {
    return Divider(
      color: Theme.of(context).textTheme.bodySmall!.color,
    );
  }
  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              color: Constants.mainPrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),


        ],
      ),
    );
  }
  _buildSectionTitleIcon(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              color: Constants.mainPrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),
          IconButton(
            onPressed: () async {


            },
            icon: Icon(Feather.plus_circle),
          )
        ],
      ),
    );
  }
  _buildTop(ProfileProvider data) {
    //var username="홍길동";
    //String photoUrl = "http://book.whitesoft.net/data/user/user1.jpg";
    bool isMe = data.memberSeq == data.member!.member_seq;
print(data.memberSeq);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: data.member!.image!.isEmpty
              ? CircleAvatar(
            radius: 30.0,
            backgroundColor: Theme.of(context)
                .colorScheme
                .secondary,
            child: Center(
              child: Text(
                '${data.member!.nickname}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          )
              : CircleAvatar(
            radius: 30.0,
            backgroundImage:
            CachedNetworkImageProvider(
              '${data.member!.image}',
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: false,
                  child: SizedBox(width: 10.0),
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.0,
                      child: Text(
                        data.member!.nickname,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: null,
                      ),
                    ),
                    SizedBox(height: 4.0),

                    //SizedBox(width: 10.0),

                  ],
                ),
                (isMe)?ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => EditProfile(
                          member: data.member,
                        ),
                      ),
                    );
                  },
                  child: Text("프로필수정"),
                ):Text(''),
                SizedBox(width:2),
                (isMe)?ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => Setting(),
                      ),
                    );
                  },
                  child: Text("설정"),
                ):Text(''),
                /*InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => Setting(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(
                          Ionicons.settings_outline,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary,
                        ),
                        Text(
                          '설정',
                          style: TextStyle(
                            fontSize: 11.5,
                          ),
                        )
                      ],
                    ),
                  )*/


                // : buildLikeButton()
              ],
            ),
          ],
        ),
      ],
    );
  }

  _buildSectionShop(ProfileProvider homeProvider) {
    return Container(
      padding:EdgeInsets.all( 20.0),
      child: Card(
        elevation: 0,
        color:Colors.grey[300],
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width-50,
          //height: 100,

          padding:EdgeInsets.all( 20.0),
          child: Center(
            child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Feather.shopping_bag,
                    size:50,
                    color:Constants.mainPrimary,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '한국어',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 8.0),

                ]
            ),
          ),
        ),
      ),
    );
  }


  buildCount(String label, int count) {
    return Column(
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
        SizedBox(height: 3.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            fontFamily: 'Ubuntu-Regular',
          ),
        )
      ],
    );
  }
  /*
  buildProfileButton(data) {
    //if isMe then display "edit profile"
    //bool isMe = widget.profileId == firebaseAuth.currentUser!.uid;
    if (true) {
      return buildButton(
          text: "프로필수정",
          function: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => EditProfile(
                  member: data.member,
                ),
              ),
            );
          });
      //if you are already following the user then "unfollow"
    } else if (isFollowing) {
      return buildButton(
        text: "Unfollow",
        function: handleUnfollow,
      );
      //if you are not following the user then "follow"
    } else if (!isFollowing) {
      return buildButton(
        text: "Follow",
        function: handleFollow,
      );
    }
  }*/

  buildButton({String? text, Function()? function}) {
    return Center(
      child: GestureDetector(
        onTap: function!,
        child: Container(
          height: 40.0,
          width: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).colorScheme.secondary,
                Color(0xff597FDB),
              ],
            ),
          ),
          child: Center(
            child: Text(
              text!,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  handleUnfollow() async {

  }
  handleFollow() async {

  }
  List _elements = [
    {'name': 'John', 'group': 'Team A'},
    {'name': 'Will', 'group': 'Team B'},
    {'name': 'Beth', 'group': 'Team A'},
    {'name': 'Miranda', 'group': 'Team B'},
    {'name': 'Mike', 'group': 'Team C'},
    {'name': 'Danny', 'group': 'Team C'},
  ];


  _buildSection6(ProfileProvider data) {
    return Container(
      height: 110.0,
      child: Center(
        child: ListView.builder(
          primary: false,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: data.memberList.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            //Book entry = homeProvider.boosList[index];
            return GestureDetector(
                onTap: () => showProfile(context, profileId:  data.memberList[index].member_seq),
                child:Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                    child: Container(
                      width: 60.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 26.0,
                            backgroundImage: CachedNetworkImageProvider(
                              '${data.memberList[index].image}',
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data.memberList[index].nickname}',
                                style: TextStyle(
                                  //fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),

                            ],
                          ),
                        ],
                      ),
                    )
                ),
            );
          },
        ),
      ),
    );
  }

  _buildSection7(ProfileProvider data) {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.clubList.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        //Entry entry = homeProvider.recent.feed!.entry![index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: InkWell(
            onTap: () {

            },
            child: Container(
              height: 110.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    elevation: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: Hero(
                        tag: 'tag2',
                        child: CachedNetworkImage(
                          imageUrl: '${data.clubList[index].image}',
                          placeholder: (context, url) => Container(
                            height: 110.0,
                            width: 150.0,
                            child: LoadingWidget(
                              isImage: true,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/place.png',
                            fit: BoxFit.cover,
                            height: 110.0,
                            width: 70.0,
                          ),
                          fit: BoxFit.cover,
                          height: 110.0,
                          width: 150.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: 'tag3',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              '${data.clubList[index].title}',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.titleLarge!.color,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Hero(
                          tag: 'tag4',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              '${data.clubList[index].category}',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${'제한없음 · 100명 · 2주전'}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildSection4111111(ProfileProvider homeProvider) {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: homeProvider.clubList.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        //Entry entry = homeProvider.recent.feed!.entry![index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: InkWell(
            onTap: () {
              /*MyRouter.pushPage(
                context,
                ClubMain(homeProvider.clubList[index],),
              );*/
            },
            child: Container(
              height: 110.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    elevation: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      child: Hero(
                        tag: 'tag2',
                        child: CachedNetworkImage(
                          imageUrl: '${homeProvider.clubList[index].image}',
                          placeholder: (context, url) => Container(
                            height: 110.0,
                            width: 150.0,
                            child: LoadingWidget(
                              isImage: true,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/place.png',
                            fit: BoxFit.cover,
                            height: 110.0,
                            width: 70.0,
                          ),
                          fit: BoxFit.cover,
                          height: 110.0,
                          width: 150.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: 'tag3',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              '${homeProvider.clubList[index].title}',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.titleLarge!.color,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Hero(
                          tag: 'tag4',
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              '${homeProvider.clubList[index].category}',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${'은행나무 | 2015 | 최진영'}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          ),
                        ),


                      ],
                    ),
                  ),



                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildSection112(ProfileProvider homeProvider) {
    var userusername="홍길동";
    String userphotoUrl = "http://book.whitesoft.net/data/book/52.jpg";

    return ListView(
        children: <Widget>[
          ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          leading: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: userphotoUrl,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/place.png',
                  fit: BoxFit.cover,
                  height: 150.0,
                  width: 50.0,
                ),
                fit: BoxFit.cover,
                height: 150.0,
                width: 50.0,
              ),

            ],
          ),
          title: Text(
            '${userusername}',
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'type == MessageType.IMAGE ? "IMAGE" : ',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 10),
              Text(
                "2023.10.10",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
              SizedBox(height: 5),
              //buildCounter(context),
            ],
          ),
          /*onTap: () {
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                builder: (BuildContext context) {
                  return Conversation(
                    userId: userId!,
                    chatId: chatId!,
                  );
                },
              ),
            );
          },*/
        )
      ]
    );
  }
  buildPostView() {
    return buildGridPost();

  }
  showProfile(BuildContext context, {String? profileId}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => Profile(memberSeq: profileId),
      ),
    );
  }
  showBook(BuildContext context, {String? book_seq}) {

  }
  /*
  buildVerticalList(HomeProvider homeProvider) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: homeProvider.bookList.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          //Member mem = usersList[index];
          return VerticalPlaceItem(mem:homeProvider.bookList[index]);
        },
      ),
    );
  }*/

  buildGridPost() {

  }

  buildLikeButton() {

  }
}

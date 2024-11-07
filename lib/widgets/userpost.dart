import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:korean/components/custom_card.dart';
import 'package:korean/components/custom_image.dart';
import 'package:korean/models/feeds.dart';
import 'package:korean/models/user.dart';
import 'package:korean/pages/profile.dart';

import 'package:korean/screens/comment.dart';
import 'package:korean/screens/view_image.dart';
//import 'package:korean/services/post_service.dart';
//import 'package:social_media_app/utils/firebase.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:korean/components/main_text.dart';
//import 'package:share/share.dart';
import 'package:korean/utils/custom_alert.dart';


class UserPost extends StatelessWidget {
  final Feeds? post;
  final int? bookShow;

  UserPost({this.post, this.bookShow});

  final DateTime timestamp = DateTime.now();

  //currentUserId() {
  //  return 'firebaseAuth.currentUser!.uid';
  //}

  //final PostService services = PostService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            buildUser(context),
            (bookShow==1)? buildBook(context):Text(""),
            //buildUser(context),


            Padding(
              padding: EdgeInsets.all(8.0),
              child: MainTextWidget(text: '${post!.description}',),
            ),



            ClipRRect(
              /*borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),*/
              child: CustomImage(
                imageUrl: post?.image ?? '',
                height: MediaQuery.of(context).size.width/1.7,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Row(
                      children: [
                        buildLikeButton(),
                        SizedBox(width: 8.0),
                        InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (_) => Comments(post: post),
                              ),
                            );
                          },
                          child: Icon(
                            CupertinoIcons.chat_bubble,
                            size: 25.0,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () {
                            _share(post!.title);
                          },
                          child: Icon(
                            Feather.share,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /*Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            timeago.format(post!.timestamp!.toDate()),
                            style: TextStyle(fontSize: 10.0),
                          ),
                        ),*/
                  // SizedBox(height: 5.0),
                ],
              ),
            ),

          ],
        ),


      ],
    );
  }

  buildLikeButton() {
    return LikeButton(
      //onTap: onLikeButtonTapped,
      size: 25.0,
      circleColor:
      CircleColor(start: Color(0xffFFC0CB), end: Color(0xffff0000)),
      bubblesColor: BubblesColor(
          dotPrimaryColor: Color(0xffFFA500),
          dotSecondaryColor: Color(0xffd8392b),
          dotThirdColor: Color(0xffFF69B4),
          dotLastColor: Color(0xffff8c00)),
      likeBuilder: (bool isLiked) {
        return Icon(
          "".isEmpty ? Feather.heart : Feather.heart,
          color: "docs".isEmpty
              ? 'Theme.of(context).brightness' == Brightness.dark
              ? Colors.white
              : Colors.black
              : Colors.red,
          size: 25,
        );
      },
    );
  }

  addLikesToNotification() async {
    bool isNotMe = currentUserId() != post!.member_seq;


  }

  buildLikesCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Text(
        '$count likes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
        ),
      ),
    );
  }

  buildCommentsCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.5),
      child: Text(
        '-   $count comments',
        style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  buildUser(BuildContext context) {
    bool isMe = currentUserId() == post!.post_seq;

    //var username="홍길동";
    //String photoUrl = "http://book.whitesoft.net/data/user/user1.jpg";



    return Visibility(
      visible: !isMe,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: GestureDetector(
            onTap: () => showProfile(context, profileId:  post!.member_seq),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  post!.photo.isEmpty
                      ? CircleAvatar(
                    radius: 20.0,
                    backgroundColor:
                    Theme.of(context).colorScheme.secondary,
                    child: Center(
                      child: Text(
                        '${post!.nickname}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                      : CircleAvatar(
                    radius: 20.0,
                    backgroundImage: CachedNetworkImageProvider(
                      '${post!.photo}',
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${post?.nickname ?? ""}',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${post?.regist_date}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Color(0xff4D4D4D),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      minimumSize:Size(80, 24)
                    ),
                    onPressed: () async {
                      var ddd = await CustomAlert.customChooseDialog(context: context, title: '친구로 추가 하시겠습니까?', data:['예', '아니오']);
                      print('==>'+ddd.toString());

                    },
                    child: Text("친구맺기",style: TextStyle(
                      //fontWeight: FontWeight.w900,
                      //color: Colors.black,
                      fontSize:12
                    ),),
                  ),

                  SizedBox(width: 8.0),
                  InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () async {
                      var ddd = await CustomAlert.customChooseDialog(context: context, title: '신고 하시겠습니까?', data:['신고하기', '취소']);
                      print('==>'+ddd.toString());
                    },
                    child: Icon(
                      CupertinoIcons.app,
                      size: 25.0,
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildBook(BuildContext context) {
    bool isMe = currentUserId() == post!.post_seq;


    return Container(
        margin: EdgeInsets.only(top:10, bottom: 10),
        //padding: EdgeInsets.only(right:10),
        child: Container(
          height: 100.0,

          /*decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),*/
          child: GestureDetector(
            onTap: () => showBook(context, book_seq:  post!.book_seq),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: '${post?.book_image}',
                    fit: BoxFit.cover,
                    height: 100.0,
                    width: 70.0,
                  ),
                 SizedBox(width: 16.0),
                  Flexible(
                    child: Column(
                        //mainAxisSize: MainAxisSize.min,

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.0),
                          Material(
                            type: MaterialType.transparency,
                            child: Text(
                              '${post!.title}',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.titleLarge!.color,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          /*Text(
                            '${post?.title ?? ""}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize:13,
                              //color: Colors.white70,
                                //backgroundColor: Color.fromARGB(100, 22, 44, 33),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),*/
                          SizedBox(height: 6.0),
                          Text(
                            '${post?.author ?? ""} | ${post?.publisher ?? ""}',
                            style: TextStyle(
                              //fontWeight: FontWeight.w900,
                              fontSize:13,
                              //color: Colors.white70,
                              //backgroundColor: Color.fromARGB(100, 22, 44, 33),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
  _share(String title) {
    //Share.share(title);
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
}

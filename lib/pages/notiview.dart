import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:korean/components/stream_comments_wrapper.dart';
import 'package:korean/models/comments.dart';
import 'package:korean/models/noti.dart';
import 'package:korean/models/user.dart';
//import 'package:korean/services/post_service.dart';
//import 'package:korean/utils/firebase.dart';
import 'package:korean/widgets/cached_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:korean/components/custom_image.dart';
import 'package:korean/pages/profile.dart';

class NotiView extends StatefulWidget {
  final Noti? post;

  NotiView({this.post});

  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<NotiView> {
  UserModel? user;

  //PostService services = PostService();
  final DateTime timestamp = DateTime.now();
  TextEditingController commentsTEC = TextEditingController();

  currentUserId() {
    return 'firebaseAuth.currentUser!.uid';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        centerTitle: false,
        title: Text('남긴글'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: buildFullPost(),
                  ),
                  Divider(thickness: 1.5),
                  //Flexible(
                  //  child: buildComments(),
                  //)
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 190.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: commentsTEC,
                            style: TextStyle(
                              fontSize: 15.0,
                              color:
                              Theme.of(context).textTheme.titleLarge!.color,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color:
                                  Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color:
                                  Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color:
                                  Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                  Theme.of(context).colorScheme.secondary,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              hintText: "댓글을 입력 하세요.",
                              hintStyle: TextStyle(
                                fontSize: 15.0,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color,
                              ),
                            ),
                            maxLines: null,
                          ),
                          trailing: GestureDetector(
                            onTap: () async {
                              /*await services.uploadComment(
                                currentUserId(),
                                commentsTEC.text,
                                widget.post!.postId!,
                                widget.post!.ownerId!,
                                widget.post!.mediaUrl!,
                              );
                              commentsTEC.clear();*/
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.send,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildFullPost() {
    return Stack(
      children: [
        Column(
          children: [
            /*ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: CustomImage(
                imageUrl: widget.post?.image ?? '',
                height: MediaQuery.of(context).size.width/1.7,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),*/
            Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: StreamBuilder(
                            stream: likesRef
                                .where('postId', isEqualTo: post!.book_seq)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                QuerySnapshot snap = snapshot.data!;
                                List<DocumentSnapshot> docs = snap.docs;
                                return buildLikesCount(
                                    context, docs.length ?? 0);
                              } else {
                                return buildLikesCount(context, 0);
                              }
                            },
                          ),
                        ),
                      ),*/
                      SizedBox(width: 5.0),
                      /*StreamBuilder(
                        stream: commentRef
                            .doc(post!.book_seq)
                            .collection("comments")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            QuerySnapshot snap = snapshot.data!;
                            List<DocumentSnapshot> docs = snap.docs;
                            return buildCommentsCount(
                                context, docs.length ?? 0);
                          } else {
                            return buildCommentsCount(context, 0);
                          }
                        },
                      ),*/
                    ],
                  ),
                  Visibility(
                    visible: widget.post!.msg != null &&
                        widget.post!.msg.toString().isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 3.0),
                      child: Text(
                        '${widget.post?.msg ?? ""}',
                        style: TextStyle(
                          color:
                          Theme.of(context).textTheme.bodySmall!.color,
                          fontSize: 15.0,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.0),
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
        //buildUser(context),

      ],
    );
  }
  showProfile(BuildContext context, {String? profileId}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => Profile(memberSeq: profileId),
      ),
    );
  }
  buildUser(BuildContext context) {
    bool isMe = currentUserId() == widget.post!.seq;

    var username="홍길동";
    String photoUrl = "http://book.whitesoft.net/data/user/user1.jpg";



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
            onTap: () => showProfile(context, profileId:  widget.post!.seq),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  photoUrl!.isEmpty
                      ? CircleAvatar(
                    radius: 20.0,
                    backgroundColor:
                    Theme.of(context).colorScheme.secondary,
                    child: Center(
                      child: Text(
                        '${username}',
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
                      '${photoUrl}',
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.post?.msg ?? ""}',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      /*Text(
                        '${post?.location ?? 'Wooble'}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Color(0xff4D4D4D),
                        ),
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

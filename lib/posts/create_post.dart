//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:korean/components/custom_image.dart';
import 'package:korean/models/user.dart';
//import 'package:korean/utils/firebase.dart';
import 'package:korean/view_models/auth/posts_view_model.dart';
import 'package:korean/widgets/indicators.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import '../posts/pop_book.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}
class _CreatePostState extends State<CreatePost> {
  @override
  Widget build(BuildContext context) {
    currentUserId() {
      return 'firebaseAuth.currentUser!.uid';
    }

    PostsViewModel viewModel = Provider.of<PostsViewModel>(context);
    return WillPopScope(
      onWillPop: () async {
        await viewModel.resetPost();
        return true;
      },
      child: LoadingOverlay(
        progressIndicator: circularProgress(context),
        isLoading: viewModel.loading,
        child: Scaffold(
          key: viewModel.scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Ionicons.close_outline),
              onPressed: () {
                viewModel.resetPost();
                Navigator.pop(context);
              },
            ),
            title: Text('게시물작성'),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: () async {
                  await viewModel.uploadPosts(context);
                  Navigator.pop(context);
                  viewModel.resetPost();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '게시',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            children: [
              SizedBox(height: 15.0),
              _buildTop(viewModel),
              SizedBox(height: 10.0),
              CustomRadioButton(
                enableShape: true,
                elevation: 0,
                defaultSelected: "1",
                enableButtonWrap: true,
                // width: 120,
                autoWidth: true,
                unSelectedColor: Theme.of(context).canvasColor,
                buttonLables: [
                  '전체공개',
                  '친구공개',
                  '나만보기',
                ],
                buttonValues: [
                  "1",
                  "2",
                  "3",
                ],
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  selectedTextStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textStyle: Theme.of(context).textTheme.bodyLarge ??
                      TextStyle(),
                ),
                radioButtonValue: (value) {
                  print(value);
                },
                selectedColor: Theme.of(context).colorScheme.secondary,
              ),
              TextFormField(
                initialValue: viewModel.description,
                decoration: InputDecoration(
                  hintText: '생각을 나누면, 소통이 시작 됩니다.',
                  focusedBorder: UnderlineInputBorder(),
                ),
                maxLines: 10,
                onChanged: (val) => viewModel.setDescription(val),
              ),
              SizedBox(height: 20.0),

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width/2,

                child: viewModel.imgLink != null
                    ? CustomImage(
                  imageUrl: viewModel.imgLink,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width - 30,
                  fit: BoxFit.cover,
                )
                    : viewModel.mediaUrl == null
                    ? Center(
                  child: Text(
                    '',
                    style: TextStyle(
                      color:
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
                    : Image.file(
                  viewModel.mediaUrl!,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width - 30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.0),


            ],
          ),
        ),
      ),
    );
  }
  _buildTop(viewModel) {
    var username="홍길동";
    String photoUrl = "http://book.whitesoft.net/data/user/user1.jpg";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: photoUrl!.isEmpty
              ? CircleAvatar(
            radius: 24.0,
            backgroundColor: Theme.of(context)
                .colorScheme
                .secondary,
            child: Center(
              child: Text(
                '${username.toUpperCase()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          )
              : CircleAvatar(
            radius: 24.0,
            backgroundImage:
            CachedNetworkImageProvider(
              '${photoUrl!}',
            ),
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {

          },
          child: Row(
            children: [
              Icon(
                Ionicons.book_outline,
                color: Theme.of(context)
                    .colorScheme
                    .secondary,
              ),
              Text(
                ' 책',
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 20.0),

        InkWell(
          onTap: () {
            showImageChoices(context, viewModel);
          },
          child: Row(
            children: [
              Icon(
                Ionicons.image_outline,
                color: Theme.of(context)
                    .colorScheme
                    .secondary,
              ),
              Text(
                ' 사진',
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  showImageChoices(BuildContext context, PostsViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  '이미지선택',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Ionicons.camera_outline),
                title: Text('카메라'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(camera: true);
                },
              ),
              ListTile(
                leading: Icon(Ionicons.image),
                title: Text('갤러리'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

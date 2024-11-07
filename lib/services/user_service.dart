import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:korean/models/user.dart';
import 'package:korean/services/services.dart';


class UserService extends Service {
  //get the authenticated uis
  //String currentUid() {
    //return firebaseAuth.currentUser!.uid;
  //}

//tells when the user is online or not and updates the last seen for the messages
  setUserStatus(bool isOnline) {
    //var user = firebaseAuth.currentUser;

  }

//updates user profile in the Edit Profile Screen
  updateProfile(
      {File? image, String? username, String? bio, String? country}) async {
    //DocumentSnapshot doc = await usersRef.doc(currentUid()).get();
    //var users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    //users.username = username;
    //users.bio = bio;
    //users.country = country;
    //if (image != null) {
    //  users.photoUrl = await uploadImage(profilePic, image);
    //}
    //await usersRef.doc(currentUid()).update({
    //  'username': username,
    //  'bio': bio,
    //  'country': country,
    //  "photoUrl": users.photoUrl ?? '',
   // });

    return true;
  }
}

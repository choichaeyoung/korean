//import 'package:spon/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:textless/textless.dart';

class CustomAlert {
  /*
  static void customLoadingDialog(
      {bool dismissible = false, required BuildContext context}) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return WillPopScope(
          onWillPop: () async {
            return dismissible;
          },
          child: Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0,
                contentPadding: const EdgeInsets.only(
                    top: 8, bottom: 5, left: 10, right: 10),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    S.of(context).loading.text.bold.color(Colors.black),
                    const SizedBox(
                      height: 33,
                    ),
                    const CircularProgressIndicator.adaptive(),
                    const SizedBox(
                      height: 33,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
    );
  }*/

  static void showAlert({required BuildContext context, required String msg}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('확인'),
          content: Text(msg),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'))
          ],
        );
      },
    );
  }
  static void showError({required BuildContext context, required String err}) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('확인'),
          content: Text(err),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'))
          ],
        );
      },
    );
  }

  static void showSuccess(
      {required BuildContext context, required String err}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('fdsafdsa'),
          content: Text(err),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'))
          ],
        );
      },
    );
  }

  static Future<int?> customChooseDialog(
      {required BuildContext context,
        String? title,
        required List<String> data}) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title!,style: TextStyle( fontWeight: FontWeight.w700,fontSize: 16.0,),),Text(''),
                SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width:10),
                    ...data.map((e) => InkWell(
                      onTap: () {
                        Navigator.pop(context, data.indexOf(e));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e),
                      ),
                    )
                    ),
                    SizedBox(width:10),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  static Future<int?> customChooseDialog3(
      {required BuildContext context,
        String? title,
        required List<String> data}) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title!,style: TextStyle( fontWeight: FontWeight.w700,fontSize: 16.0,),),Text(''),
                SizedBox(height:10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    ...data.map((e) => InkWell(
                      onTap: () {
                        Navigator.pop(context, data.indexOf(e));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e),
                      ),
                    )
                    ),
                    //SizedBox(width:10),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }


}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practiceflutter/utility/CustomColor.dart';
import 'package:practiceflutter/utility/TopVariables.dart';
import 'package:practiceflutter/utility/dialog/progress_bar.dart';


class ErrorDialog extends StatefulWidget {
  final String description;

  const ErrorDialog({Key? key, required this.description}) : super(key: key);

  @override
  _ErrorDialog createState() => _ErrorDialog();
}

class _ErrorDialog extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0)),
            color: CustomColor.primary,
          ),
          child: const Text(
            'Error',
            textAlign: TextAlign.center,
            style: TextStyle(color: CustomColor.white),
          )),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(widget.description),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          alignment: Alignment.center,
          child: TextButton(
            child: const Text(
              'Okay',
              style: TextStyle(color: CustomColor.white),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(CustomColor.primary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                        borderRadius: BorderRadius.circular(10.0)))),
            onPressed: () async {
              isErrorDialogShowing = false;

              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}

bool isErrorDialogShowing = false;

showErrorDialog(String errorDetail) {
  CustomProgressDialog.hideProDialog();
  if (!isErrorDialogShowing) {
    isErrorDialogShowing = true;
    showDialog(
        barrierDismissible: false,
        context: TopVariables.appNavigationKey.currentContext!,
        builder: (BuildContext context) {
          return ErrorDialog(
            description: errorDetail,
          );
        });
  }
}

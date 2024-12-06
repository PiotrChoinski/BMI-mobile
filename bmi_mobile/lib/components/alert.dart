import 'package:flutter/cupertino.dart';

class Alert extends StatelessWidget {
  final String title;
  final String message;
  final String acceptButtonText;
  final String cancelButtonText;
  final void Function() acceptAction;
  final void Function()? cancelAction;

  const Alert({
    super.key,
    required this.title,
    required this.message,
    required this.acceptAction,
    this.acceptButtonText = 'OK',
    this.cancelButtonText = 'Cancel',
    this.cancelAction,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        if (cancelAction != null)
          CupertinoDialogAction(
            onPressed: cancelAction,
            child: Text(cancelButtonText),
          ),
        CupertinoDialogAction(
          isDestructiveAction: cancelAction != null,
          isDefaultAction: true,
          onPressed: () => acceptAction(),
          child: Text(acceptButtonText),
        ),
      ],
    );
  }
}

import 'package:bmi_mobile/database/database_helper.dart';
import 'package:bmi_mobile/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  const UserDetailsPage({super.key, required this.user});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  int _handleAge() {
    final DateTime birthday = DateTime.parse(widget.user.birthday.toString());
    final DateTime today = DateTime.now();
    int howOld = today.difference(birthday).inDays / 365 ~/ 1;
    if (today.month < birthday.month ||
        (today.month == birthday.month && today.day < birthday.day)) {
      howOld--;
    }
    return howOld;
  }

  void _deleteUser() async {
    await DatabaseHelper.instance.deleteUser(widget.user.id!);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("User Details"),
          trailing: GestureDetector(
              onTap: () => showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        title: const Text('Delete user'),
                        content: const Text(
                            'Are you sure you want to delete this user?'),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            child: const Text('Delete'),
                            onPressed: () => _deleteUser(),
                          ),
                        ],
                      )),
              child: const Icon(
                CupertinoIcons.delete,
                size: 25,
              )),
          backgroundColor: Colors.transparent,
        ),
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.user.name} ${widget.user.surname}",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.cake, size: 35),
                      const SizedBox(width: 10),
                      Text('${_handleAge()} y.o.')
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.height,
                        size: 35,
                      ),
                      const SizedBox(width: 10),
                      Text('${widget.user.weight} cm')
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.scale, size: 35),
                      const SizedBox(width: 10),
                      Text('${widget.user.weight} kg')
                    ],
                  )
                ],
              )
            ],
          ),
        )));
  }
}

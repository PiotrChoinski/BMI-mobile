import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("User Details"),
          trailing: GestureDetector(
              onTap: () => print('siema'),
              child: const Icon(
                CupertinoIcons.delete,
                size: 25,
              )),
          backgroundColor: Colors.transparent,
        ),
        child: SafeArea(child: Text('dupa')));
  }
}

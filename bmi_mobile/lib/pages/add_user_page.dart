import 'package:flutter/cupertino.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: Center(child: Text('Add User Page')));
  }
}

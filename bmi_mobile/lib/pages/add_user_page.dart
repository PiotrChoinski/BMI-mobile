import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Add User'),
          backgroundColor: Colors.transparent,
          previousPageTitle: 'Users List',
        ),
        child: SafeArea(
            child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: CupertinoFormSection.insetGrouped(
              header: const Text('Add new user'),
              children: [
                CupertinoTextFormFieldRow(
                  placeholder: 'Name',
                ),
                CupertinoTextFormFieldRow(
                  placeholder: 'Surname',
                ),
              ]),
        )));
  }
}

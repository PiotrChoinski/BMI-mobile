import 'package:bmi_mobile/components/date_picker.dart';
import 'package:bmi_mobile/components/picker.dart';
import 'package:bmi_mobile/database/database_helper.dart';
import 'package:bmi_mobile/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _newUser = {};

  final List heightList =
      List.generate(100, (index) => {'id': index, 'value': index + 135});
  final List weightList =
      List.generate(150, (index) => {'id': index, 'value': index});
  final List genderList = [
    {'id': 1, 'value': 'Man'},
    {'id': 2, 'value': 'Woman'}
  ];

  void _addUser() async {
    final newUserClass = User(
        name: _newUser['name'],
        surname: _newUser['surname'],
        birthday: _newUser['birthday'],
        height: _newUser['height'],
        weight: _newUser['weight'],
        gender: _newUser['gender']);

    await DatabaseHelper.instance.addUser(newUserClass);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('New user'),
          backgroundColor: Colors.transparent,
          previousPageTitle: 'Users List',
        ),
        child: SafeArea(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: CupertinoFormSection.insetGrouped(children: [
                    CupertinoTextFormFieldRow(
                        placeholder: 'Name',
                        onChanged: (value) => _newUser['name'] = value),
                    CupertinoTextFormFieldRow(
                      placeholder: 'Surname',
                      onChanged: (value) => _newUser['surname'] = value,
                    ),
                    DatePicker(
                        placeholder: 'Birthday',
                        selectOption: (value) => _newUser['birthday'] = value),
                    Picker(
                        placeholder: "Height",
                        data: heightList,
                        selectOption: (value) =>
                            _newUser['height'] = heightList[value]['value']),
                    Picker(
                        placeholder: "Weight",
                        data: weightList,
                        selectOption: (value) =>
                            _newUser['weight'] = weightList[value]['value']),
                    Picker(
                        placeholder: "Gender",
                        data: genderList,
                        selectOption: (value) =>
                            _newUser['gender'] = genderList[value]['value']),
                    CupertinoButton(
                        child: const Text('Add user'),
                        onPressed: () => _addUser())
                  ]),
                ))));
  }
}

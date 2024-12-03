import 'package:bmi_mobile/components/date_picker.dart';
import 'package:bmi_mobile/components/picker.dart';
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
      List.generate(100, (index) => {'id': index + 135, 'value': index + 135});
  final List weightList =
      List.generate(150, (index) => {'id': index, 'value': index});

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
                            _newUser['height'] = value + 135),
                    Picker(
                        placeholder: "Weight",
                        data: weightList,
                        selectOption: (value) => _newUser['weight'] = value),
                    Picker(
                        placeholder: "Gender",
                        data: const [
                          {'id': 1, 'value': 'Man'},
                          {'id': 1, 'value': 'Woman'}
                        ],
                        selectOption: (value) => _newUser['Gender'] = value),
                    CupertinoButton(
                        child: Text('Click'),
                        onPressed: () => print(_newUser.toString()))
                  ]),
                ))));
  }
}

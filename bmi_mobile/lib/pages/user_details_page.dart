import 'package:bmi_mobile/components/alert.dart';
import 'package:bmi_mobile/components/bmi_chart.dart';
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

  double _calculateBmi() {
    final heightInMeters = widget.user.height / 100;
    final double bmi = widget.user.weight / (heightInMeters * heightInMeters);
    return double.parse(bmi.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("User Details"),
          trailing: GestureDetector(
              onTap: () => showCupertinoDialog(
                  context: context,
                  builder: (context) => Alert(
                      title: 'Delete user',
                      message: 'Are you sure you want to delete this user?',
                      acceptAction: () => _deleteUser(),
                      cancelAction: () => Navigator.pop(context))),
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
              BmiChart(bmi: _calculateBmi()),
              Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
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
                              const SizedBox(width: 8),
                              Text('${_handleAge()} y.o.')
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.height,
                                size: 35,
                              ),
                              const SizedBox(width: 8),
                              Text('${widget.user.height} cm')
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.scale, size: 35),
                              const SizedBox(width: 8),
                              Text('${widget.user.weight} kg')
                            ],
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        )));
  }
}

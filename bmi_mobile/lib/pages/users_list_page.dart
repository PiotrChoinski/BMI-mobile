import 'package:bmi_mobile/pages/add_user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class Item {
  final String prefix;
  final String helper;
  const Item({required this.prefix, required this.helper});
}

List<Item> items = [
  const Item(prefix: "Italiano", helper: 'Italiano'),
  const Item(prefix: "English", helper: 'English'),
  const Item(prefix: "Español", helper: 'Español'),
  const Item(prefix: "Français", helper: 'Français'),
  const Item(prefix: "Polish", helper: 'Polish'),
];

class _UsersListPageState extends State<UsersListPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Users List'),
          backgroundColor: Colors.transparent,
          trailing: CupertinoButton(
              child: const Icon(CupertinoIcons.add),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddUserPage()))),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: CupertinoListSection.insetGrouped(
              children: [
                for (var item in items)
                  Dismissible(
                      key: Key(item.prefix),
                      onDismissed: (direction) => print(item.prefix),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: CupertinoColors.systemRed,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        child: const Icon(CupertinoIcons.delete,
                            color: Colors.white),
                      ),
                      child: CupertinoListTile(
                        title: Text(item.prefix),
                        leading: const Icon(CupertinoIcons.person),
                        trailing: const Icon(
                          CupertinoIcons.forward,
                          color: CupertinoColors.lightBackgroundGray,
                        ),
                        onTap: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                    title: const Text('Language'),
                                    content:
                                        Text('You selected ${item.prefix}'),
                                    actions: [
                                      CupertinoDialogAction(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context))
                                    ],
                                  ));
                        },
                      ))
              ],
            ),
          ),
        ));
  }
}

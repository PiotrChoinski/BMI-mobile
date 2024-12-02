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
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => Dismissible(
                key: Key(index.toString()),
                onDismissed: (direction) {
                  print('Dismissed');
                },
                background: Container(color: Colors.red),
                child: CupertinoListTile(
                  onTap: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                              title: Text(items[index].prefix),
                              content: Text(items[index].helper),
                              actions: [
                                CupertinoDialogAction(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ],
                            ));
                  },
                  leading: const Icon(CupertinoIcons.person),
                  title: Text(items[index].prefix),
                  trailing: const CupertinoListTileChevron(),
                ))));
  }
}

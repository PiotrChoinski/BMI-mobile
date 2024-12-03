import 'package:bmi_mobile/pages/add_user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class Item {
  final String name;
  final String surname;
  const Item({required this.name, required this.surname});
}

List<Item> items = [
  const Item(name: 'Tomasz', surname: 'Ogrodnik'),
  const Item(name: 'Adam', surname: 'Czyz'),
  const Item(name: 'Bartosz', surname: 'Prejs'),
  const Item(name: 'Witold', surname: 'Blady')
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
                      key: Key('${item.name}_${item.surname}'),
                      onDismissed: (direction) =>
                          print('${item.name} ${item.surname}'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: CupertinoColors.systemRed,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16.0),
                        child: const Icon(CupertinoIcons.delete,
                            color: Colors.white),
                      ),
                      child: CupertinoListTile(
                        title: Text('${item.name} ${item.surname}'),
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
                                    content: Text(
                                        'You selected ${item.name} ${item.surname}'),
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

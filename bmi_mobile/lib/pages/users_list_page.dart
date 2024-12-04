import 'package:bmi_mobile/database/database_helper.dart';
import 'package:bmi_mobile/model/User.dart';
import 'package:bmi_mobile/pages/add_user_page.dart';
import 'package:bmi_mobile/pages/user_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final userMaps = await DatabaseHelper.instance.getAllUsers();
    setState(() {
      _users = userMaps.map((userMap) => User.fromMap(userMap)).toList();
    });
  }

  Future<void> _deleteUser(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Users List'),
        backgroundColor: Colors.transparent,
        trailing: GestureDetector(
          child: const Icon(
            CupertinoIcons.add_circled,
            size: 25,
          ),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddUserPage()),
            );
            _fetchUsers();
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: _users.isEmpty
              ? const Center(child: Text('No users added yet'))
              : CupertinoListSection.insetGrouped(
                  children: [
                    for (var user in _users)
                      Dismissible(
                        key: Key('${user.id}'),
                        onDismissed: (direction) async {
                          await _deleteUser(user.id!);
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: CupertinoColors.systemRed,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16.0),
                          child: const Icon(
                            CupertinoIcons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: CupertinoListTile(
                          title: Text('${user.name} ${user.surname}'),
                          leading: const Icon(CupertinoIcons.person),
                          trailing: const Icon(
                            CupertinoIcons.forward,
                            color: CupertinoColors.lightBackgroundGray,
                          ),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserDetailsPage(),
                              ),
                            );
                            _fetchUsers();
                          },
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

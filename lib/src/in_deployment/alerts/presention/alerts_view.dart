import 'dart:convert';

import 'package:flutter/material.dart';

class AlertsView extends StatefulWidget {
  AlertsView({Key? key}) : super(key: key);

  @override
  State<AlertsView> createState() => _AlertsViewState();
}

class _AlertsViewState extends State<AlertsView> {
  final List<String> items = List.generate(14, (index) => 'item ${index + 1}');
  bool hasMore = false;
  final controller = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    /*
    final List newItems = jsonDecode('');
    setState(() {
      items.addAll(newItems.map<String>((item) {
        final number = item['id'];return 'Item $number';
      }).toList());
    });
     */
    const limit = 25;

    /// put in url address
    setState(() {
      items.addAll(['Item A', 'Item B', 'Item C']);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: controller,
        itemCount: items.length + 1,
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return index < items.length
              ? ListTile(
                  title: Text(items[index].toString()),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: hasMore
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : const Text('No more data to load'),
                  ),
                );
        },
      ),
    );
  }
}

class AlertsViewScrollable extends StatefulWidget {
  const AlertsViewScrollable({Key? key}) : super(key: key);

  @override
  State<AlertsViewScrollable> createState() => _AlertsViewScrollableState();
}

class _AlertsViewScrollableState extends State<AlertsViewScrollable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 150,
          color: Colors.red,
          child: Center(
            child: Text('Some things..'),
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 30,
            itemBuilder: (context, index) {},
          ),
        )
      ]),
    );
  }
}

class AlertsFromUrl extends StatefulWidget {
  const AlertsFromUrl({Key? key}) : super(key: key);

  @override
  State<AlertsFromUrl> createState() => _AlertsFromUrlState();
}

class U {
  const U({required this.id, required this.name, required this.city});
  final String name;
  final String id;
  final String city;
  static U fromJson(json) => U(
        name: json['name'],
        id: json['id'],
        city: json['city'],
      );
}

class _AlertsFromUrlState extends State<AlertsFromUrl> {
  late Future<List<U>> usersFuture;
  static Future<List<U>> getUsers(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('users.json');
    final body = jsonDecode(data);
    return body.map<U>(U.fromJson).toList();
  }

  @override
  void initState() {
    super.initState();
    usersFuture = getUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<U>>(
          future: usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return buildUsers(users);
            } else {
              return const Text('No user data.');
            }
          },
        ),
      ),
    );
  }
}

Widget buildUsers(List<U> users) => ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12,
        );
      },
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            title: Text(user.id),
          ),
        );
      },
    );

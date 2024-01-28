import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guardian_view/core/resources/media_res.dart';
import 'package:guardian_view/src/alerts/domain/entities/alert_entity.dart';
import 'package:guardian_view/src/video/presention/widgets/show_video.dart';
import 'package:video_player/video_player.dart';

/// checking functions
/*


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
 */
/// final product that shows list of alerts !!
class AlertListPage extends StatefulWidget {
  @override
  State<AlertListPage> createState() => _AlertListPageState();
}

class _AlertListPageState extends State<AlertListPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint('initilize');
  }

  @override
  void dispose() {
    debugPrint('disposed');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    debugPrint('disposed');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      debugPrint('found it !!!');
    }
    if (state == AppLifecycleState.hidden) {
      debugPrint('found it2222 !!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weapon Detection Alerts'),
      ),
      body: ListView.builder(
        itemCount: 10, // Number of alerts
        itemBuilder: (context, index) {
          return AlertCard(
            alert: Alert(
                id: '1',
                description: 'a knife is stabed !!!',
                isConfirmed: true,
                level: 'high',
                timestamp: DateTime.now(),
                videoUrl: 'assets/video.mp4'),
          );
        },
      ),
    );
  }
}

class AlertCard extends StatefulWidget {
  final Alert alert;

  const AlertCard({super.key, required this.alert});
  @override
  _AlertCardState createState() => _AlertCardState();
}

class _AlertCardState extends State<AlertCard> {
  VideoPlayerController? controller;
  bool isVisibly = false;
  bool isExpanded = false;
  /*
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/video.mp4")
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
      });
  }
   */

  void _initializeVideoPlayer() {
    controller =
        VideoPlayerController.asset(widget.alert.videoUrl) //"assets/video.mp4")
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize().then((_) => setState(() {}));
  }

  void _disposeVideoPlayer() {
    controller?.removeListener(() => setState(() {}));
    controller?.dispose();
    controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        leading: Icon(
          Level.emergency.iconData,
          color: Level.emergency.color,
        ), // Status Icon
        title: Text('Alert Title'), // Alert title
        subtitle: Text('Location: XYZ, Time: HH:MM'), // Location & Time

        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
            if (isExpanded) {
              _initializeVideoPlayer();
            } else {
              _disposeVideoPlayer();
            }
          });
        },
        children: <Widget>[
          Visibility(
            visible: isVisibly,
            child: ElevatedButton(
                onPressed:
                    () {}, // will need to update the data of the alert to send it to the user .. it will listen for it and wait.
                child: Container(
                  child: Text('send to the user'),
                )),
          ),
          Container(
            height: 100,
            width: 100,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(MediaRes.image1), // Thumbnail
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: VideoPlayerWidget(controller: controller),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text('Detailed information about the alert...',
                style: TextStyle(fontSize: 16)),
          ),
          // Add more widgets here for additional details
        ],
      ),
    );
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }
}

enum Level {
  /// use - Level.emergency.color
  emergency(Icons.circle, Colors.red),
  high(Icons.circle, Colors.redAccent),
  medium(Icons.circle, Colors.yellow),
  low(Icons.circle, Colors.green);

  final IconData iconData;
  final Color color;
  const Level(this.iconData, this.color);
}

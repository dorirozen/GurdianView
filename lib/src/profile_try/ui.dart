import 'package:flutter/material.dart';
import 'package:guardian_view/src/profile_try/entities.dart';
import 'package:guardian_view/src/profile_try/firebase_service.dart';

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data List'),
      ),
      body: SafeArea(
        child: ListView(
          /*
          Visibility(
          visible: context.userProvider.user!.isAdmin,
           */
          children: [
            CategoryExpansionTile(
              categoryTitle: 'Users',
              categoryItems: Firetry().getUsers(),
              onAddPressed: () => _showAddForm(context, 'Users'),
            ),
            CategoryExpansionTile(
              categoryTitle: 'Cameras',
              categoryItems: Firetry().getCameras(),
              onAddPressed: () => _showAddForm(context, 'Cameras'),
            ),
            CategoryExpansionTile(
              categoryTitle: 'Settings',
              categoryItems: Firetry().getSettings(),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddForm(BuildContext context, String categoryTitle) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add $categoryTitle'),
              SizedBox(height: 8.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Close the bottom sheet on cancel
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.isNotEmpty) {
                        _addItem(categoryTitle, _nameController.text);
                        Navigator.pop(context); // Close the bottom sheet on add
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _addItem(String categoryTitle, String itemName) {
    if (categoryTitle == 'Users') {
      Firetry().addUser(User(id: 'some_id', name: itemName));
    } else if (categoryTitle == 'Cameras') {
      Firetry().addCamera(Camera(id: 'some_id', name: itemName));
    }
  }
}

class CategoryExpansionTile extends StatelessWidget {
  final String categoryTitle;
  final Future<List<dynamic>> categoryItems;
  final void Function()? onAddPressed;

  CategoryExpansionTile({
    required this.categoryTitle,
    required this.categoryItems,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: categoryItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<dynamic> items = snapshot.data ?? [];
          return ExpansionTile(
            title: Text(categoryTitle),
            children: [
              for (var item in items)
                CategoryItemTile(
                  categoryItem: item,
                  categoryTitle: categoryTitle,
                ),
              if (categoryTitle == 'Users' || categoryTitle == 'Cameras') ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: onAddPressed,
                    child: Text('Add $categoryTitle'),
                  ),
                ),
              ],
            ],
          );
        }
      },
    );
  }
}

class CategoryItemTile extends StatelessWidget {
  final dynamic categoryItem;
  final String categoryTitle;

  CategoryItemTile({required this.categoryItem, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          categoryItem.name), // Assuming a 'name' property, adjust as needed
      subtitle: Text('Details: ${categoryItem.id}'), // Adjust details property
      onTap: () {
        // Implement logic to navigate to a detailed view or open an expansion
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Open a dialog or navigate to another screen to edit the item
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Firetry().deleteItem(categoryTitle, categoryItem.id);
            },
          ),
        ],
      ),
    );
  }
}

/*
class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data List'),
      ),
      body: ListView(
        children: [
          CategoryExpansionTile(
            categoryTitle: 'Users',
            categoryItems: Firetry().getUsers(),
          ),
          CategoryExpansionTile(
            categoryTitle: 'Cameras',
            categoryItems: Firetry().getCameras(),
          ),
          CategoryExpansionTile(
            categoryTitle: 'Settings',
            categoryItems: Firetry().getSettings(),
          ),
        ],
      ),
    );
  }
}

class CategoryExpansionTile extends StatelessWidget {
  final String categoryTitle;
  final Future<List<dynamic>> categoryItems;

  CategoryExpansionTile(
      {required this.categoryTitle, required this.categoryItems});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: categoryItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<dynamic> items = snapshot.data ?? [];
          return ExpansionTile(
            title: Text(categoryTitle),
            children: [
              for (var item in items)
                CategoryItemTile(
                  categoryItem: item,
                  categoryTitle: categoryTitle,
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Open a dialog or navigate to another screen to add a new item
                  },
                  child: Text('Add $categoryTitle'),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

class CategoryItemTile extends StatelessWidget {
  final dynamic categoryItem;
  final String categoryTitle;

  CategoryItemTile({required this.categoryItem, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          categoryItem.name), // Assuming a 'name' property, adjust as needed
      subtitle: Text('Details: ${categoryItem.id}'), // Adjust details property
      onTap: () {
        // Implement logic to navigate to a detailed view or open an expansion
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Open a dialog or navigate to another screen to edit the item
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
*/

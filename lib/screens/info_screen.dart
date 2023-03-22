import 'package:flutter/material.dart';
import 'package:hive_demo/screens/update_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_demo/screens/add_screen.dart';

import 'map_screen.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late final Box contactBox;

  // Delete info from people box
  _deleteInfo(int index) {
    contactBox.deleteAt(index);

    print('Item deleted from box at index: $index');
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    contactBox = Hive.box('peopleBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People Info'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddScreen(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactBox.listenable(),
        builder: (context, Box box, widget) {
          if (box.isEmpty) {
            return Center(
              child: Text('Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                var currentBox = box;
                var personData = currentBox.getAt(index)!;

                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdateScreen(
                        index: index,
                        person: personData,
                      ),
                    ),
                  ),
                  // _buildItem(
                  //           country: personData.country,
                  //           index: index,
                  //           name: personData.name),
                  //     );
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdateScreen(
                          index: index,
                          person: personData,
                        ),
                      ),
                    ),
                    // leading: Text('fares'),
                    title: Text(personData.name),
                    subtitle: Text(personData.country),
                    trailing: IconButton(
                      onPressed: () => _deleteInfo(index),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  
  Widget _buildItem(
      {required String name, required String country, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.purple[100],
        elevation: 10.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(country),
                ],
              ),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MapSample()),
                );
              },
              child: Text('GO Map'),
            ),
            IconButton(
              onPressed: () => _deleteInfo(index),
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/services/database.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;

final firestoreInstance = FirebaseFirestore.instance;

class ReadData extends StatefulWidget {
  @override
  _ReadDataState createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  void deleteItem(String key, bool value) {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else {
        // When stream exists, use Streambilder to wait for data
        return StreamBuilder<DocumentSnapshot>(
          stream: DatabaseService(uid: user.uid).getDailyEmissions(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              // resolve stream... Stream<DocumentSnapshot> -> DocumentSnapshot -> Map<String, bool>
              Map<String, dynamic> items = snapshot.data.data();

              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    String key = items.keys.elementAt(i);
                    return HomescreenElement(
                      key,
                      items[key],
                      () => deleteItem(
                          key, items[key]), //Item aus der Datenbank löschen
                    );
                  });
            }
          },
        );
      }
    });
  }
}

class HomescreenElement extends StatelessWidget {
  const HomescreenElement(this.name, this.emissions, this.remove);
  final String name;
  final int emissions;
  final Function remove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        title: Text(
          name,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {},
        ),
        onTap: () => Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>
                    HomescreenElement(name, emissions, remove))),
      ),
    );
  }
}

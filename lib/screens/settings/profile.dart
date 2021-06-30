import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/modules/firebaseUser.dart';
import 'package:forrest_flutter/services/auth.dart';
import 'package:forrest_flutter/shared/loading.dart';
import 'package:provider/provider.dart';
import 'configurations.dart';

final userRef = FirebaseFirestore.instance.collection('Nutzerdaten');

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String _currentName = '';
  String _currentEmail = '';
  String _currentPassword = '';
  String _currentHome = '';
  String error = '';

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Configuration()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    String userDocId = 'WmWa48zHonSViqL80KplnCTNiys2';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'forRest',
          style: TextStyle(
            fontFamily: 'GloriaHalleluja',
            fontSize: 24.0,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.green[900],
        actions: [
          PopupMenuButton<int>(
            padding: EdgeInsets.all(2),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                height: 40,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 16.0,
                ),
                value: 0,
                child: Container(
                    child: Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(
                      Icons.person,
                      size: 28,
                      color: Colors.green[900],
                    ),
                    SizedBox(width: 10),
                    Text('Profil'),
                  ],
                )),
              ),
              PopupMenuItem<int>(
                height: 40,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 16.0,
                ),
                value: 1,
                child: Container(
                    child: Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(
                      Icons.settings,
                      size: 28,
                      color: Colors.green[900],
                    ),
                    SizedBox(width: 10),
                    Text('Einstellungen'),
                  ],
                )),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                height: 30,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 16.0,
                ),
                value: 2,
                child: TextButton(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.green[900],
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CourierPrime',
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'dein Profil',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'GloriaHalleluja',
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/profilePicture.png'),
                    ),
                    Positioned(
                      right: -10,
                      bottom: 0,
                      child: SizedBox(
                        height: 55,
                        width: 55,
                        child: RawMaterialButton(
                            padding: EdgeInsets.zero,
                            shape: CircleBorder(),
                            onPressed: () {},
                            fillColor: Colors.brown[50],
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: Colors.green[900],
                              size: 30,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              GetUserName(user.uid),
              GetUserEmail(user.uid),
              GetUserHome(user.uid),
            ],
          ),
        ),
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return ProfileForm(
              category: 'Name:',
              userData: data['Name'],
              press: () {}); //Text("Full Name: ${data['Name']}");
        }
        return Loading();
      },
    );
  }
}

class GetUserEmail extends StatelessWidget {
  final String documentId;

  GetUserEmail(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return ProfileForm(
              category: 'Email:',
              userData: data['Email'],
              press: () {}); //Text("Full Name: ${data['Name']}");
        }
        return Loading();
      },
    );
  }
}

class GetUserHome extends StatelessWidget {
  final String documentId;

  GetUserHome(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return ProfileForm(
              category: 'Wohnort:',
              userData: data['Wohnort'],
              press: () {}); //Text("Full Name: ${data['Name']}");
        }
        return Loading();
      },
    );
  }
}

class GetUserCar extends StatelessWidget {
  final String documentId;

  GetUserCar(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return ProfileForm(
              category: 'Auto:',
              userData: data['Auto'],
              press: () {}); //Text("Full Name: ${data['Name']}");
        }
        return Loading();
      },
    );
  }
}

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    Key key,
    @required this.category,
    @required this.userData,
    @required this.press,
  }) : super(key: key);

  final String category, userData;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 30,
          width: 80,
          alignment: Alignment.centerLeft,
          child: Text(
            category,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'CourierPrime',
              fontSize: 16.0,
            ),
          ),
        ),
        Container(
          width: 200,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: Colors.green[900].withOpacity(0.2),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: Text(
              userData,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'CourierPrime',
                fontSize: 15.0,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Colors.green[900],
          ),
          onPressed: press,
        ),
      ],
    );
  }
}

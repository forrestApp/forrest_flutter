import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/modules/firebaseUser.dart';
import 'package:forrest_flutter/services/database.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:forrest_flutter/shared/loading.dart';
import 'package:provider/provider.dart';
import 'configurations.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Nutzerdaten');

String currentName;
String currentEmail;
String currentHome;
String currentProfilePicture = 'assets/images/profilePictures/manInFrame.png';

final _formKey = GlobalKey<FormState>();

final ScrollController controllerOne = ScrollController();

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

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
              ProfilePicture(),
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

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey,
                ),
              ),
              Positioned(
                top: 1,
                left: 1,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(currentProfilePicture),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: -12,
            bottom: -2,
            child: Stack(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey[100],
                  ),
                ),
                Positioned(
                  right: 4.5,
                  bottom: 4.5,
                  child: SizedBox(
                    height: 55,
                    width: 55,
                    child: RawMaterialButton(
                      padding: EdgeInsets.zero,
                      shape: CircleBorder(),
                      fillColor: Colors.green[900],
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                height: 360,
                                child: Column(children: [
                                  Text(
                                    'Hier kannst dein Profilbild ändern:',
                                    style: TextStyle(
                                      fontFamily: 'GloriaHalleluja',
                                      fontSize: 24.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    height: 200,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        ButtonBar(
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manInFrame.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/manInFrame.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanWithCellphone.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/womanWithCellphone.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manWithGlases.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/manWithGlases.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanWithPlant.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/womanWithPlant.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manWithCellphone.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/manWithCellphone.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanWithLaptop.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/womanWithLaptop.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manHappy.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/manHappy.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanWithCap.png';
                                                Navigator.pop(context);
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/womanWithCap.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manWithMelon.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/manWithMelon.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanBeach.png';
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/womanBeach.png'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20),
                                      ],
                                    ),
                                  )
                                ]),
                              );
                            });
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChooseProfilePicture extends StatelessWidget {
  const ChooseProfilePicture({
    Key key,
    @required this.profilePicture,
  }) : super(key: key);

  final String profilePicture;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: currentProfilePicture == profilePicture ? 165 : 110,
          width: currentProfilePicture == profilePicture ? 165 : 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey,
          ),
        ),
        Positioned(
          right: 2.1,
          top: 1.5,
          child: Container(
            height: currentProfilePicture == profilePicture ? 160 : 105,
            width: currentProfilePicture == profilePicture ? 160 : 105,
            child: CircleAvatar(
              backgroundImage: AssetImage(profilePicture),
            ),
          ),
        ),
      ],
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          currentName = data['Name'];
          return ProfileForm(
            category: 'Name:',
            userData: data['Name'],
            press: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                context: context,
                builder: (context) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    height: 250,
                    child: Column(children: [
                      Text(
                        'Hier kannst deinen Namen ändern:',
                        style: TextStyle(
                          fontFamily: 'GloriaHalleluja',
                          fontSize: 24.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 240,
                            child: TextFormField(
                              key: _formKey,
                              decoration: textInputDecoration.copyWith(
                                  hintText: currentName,
                                  fillColor: Colors.green[50],
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green[50])),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.green[900]))),
                              validator: (val) => val.isEmpty
                                  ? 'Du hast noch nichts eingegeben'
                                  : null,
                              onChanged: (val) {
                                currentName = val;
                              },
                            ),
                          ),
                          ElevatedButton(
                            child: Icon(Icons.check),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green[900],
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CourierPrime',
                                fontSize: 20.0,
                              ),
                            ),
                            onPressed: () async {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                currentName ?? data['Name'],
                                currentEmail ?? data['Email'],
                                currentHome ?? data['Home'],
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Profile()));
                            },
                          ),
                        ],
                      ),
                    ]),
                  );
                },
              );
            },
          );
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
    final user = Provider.of<FirebaseUser>(context);
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          currentEmail = data['Email'];
          return ProfileForm(
              category: 'Email:',
              userData: data['Email'],
              press: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                      height: 250,
                      child: Column(children: [
                        Text(
                          'Hier kannst deine Email ändern:',
                          style: TextStyle(
                            fontFamily: 'GloriaHalleluja',
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 240,
                              child: TextFormField(
                                key: _formKey,
                                decoration: textInputDecoration.copyWith(
                                    hintText: currentEmail,
                                    fillColor: Colors.green[50],
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green[50])),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green[900]))),
                                validator: (val) => val.isEmpty
                                    ? 'Du hast noch nichts eingegeben'
                                    : null,
                                onChanged: (val) {
                                  currentEmail = val;
                                },
                              ),
                            ),
                            ElevatedButton(
                              child: Icon(Icons.check),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[900],
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CourierPrime',
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () async {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                  currentName ?? data['Name'],
                                  currentEmail ?? data['Email'],
                                  currentHome ?? data['Home'],
                                );
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Profile()));
                              },
                            ),
                          ],
                        ),
                      ]),
                    );
                  },
                );
              });
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
    final user = Provider.of<FirebaseUser>(context);
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          currentHome = data['Wohnort'];
          return ProfileForm(
              category: 'Wohnort:',
              userData: data['Wohnort'],
              press: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (context) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                      height: 250,
                      child: Column(children: [
                        Text(
                          'Hier kannst deinen Wohnort ändern:',
                          style: TextStyle(
                            fontFamily: 'GloriaHalleluja',
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 240,
                              child: TextFormField(
                                key: _formKey,
                                decoration: textInputDecoration.copyWith(
                                    hintText: currentHome,
                                    fillColor: Colors.green[50],
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green[50])),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green[900]))),
                                validator: (val) => val.isEmpty
                                    ? 'Du hast noch nichts eingegeben'
                                    : null,
                                onChanged: (val) {
                                  currentHome = val;
                                },
                              ),
                            ),
                            ElevatedButton(
                              child: Icon(Icons.check),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[900],
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'CourierPrime',
                                  fontSize: 20.0,
                                ),
                              ),
                              onPressed: () async {
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                  currentName ?? data['Name'],
                                  currentEmail ?? data['Email'],
                                  currentHome ?? data['Home'],
                                );
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Profile()));
                              },
                            ),
                          ],
                        ),
                      ]),
                    );
                  },
                );
              });
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
    //final user = Provider.of<FirebaseUser>(context);
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          return ProfileForm(
              category: 'Auto:', userData: data['Auto'], press: () {});
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/modules/firebaseUser.dart';
import 'package:forrest_flutter/services/database.dart';
import 'package:forrest_flutter/services/energyDatabase.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:forrest_flutter/shared/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'configurations.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Nutzerdaten');

String currentProfilePicture = 'assets/images/profilePictures/manInFrame.png';
String currentName;
String currentEmail;
String currentHome;
String currentCar;
String currentBike;

List typesOfHeating = ['-', 'Fernwärme', 'Erdgas'];

String currentTypeOfHeating = '-';
int currentAmountOfHeating;
int emissionsOfHeating;

String currentEnergyInput;

String currentTypeOfPower;
int currentAmountOfPower;
int emissionsOfPower;
int emissionsOfPowerFactor;

String todaysDate = DateFormat.yMMMd().format(DateTime.now());

int currentYear = DateTime.now().year;
String powerYear = 'Strom $currentYear';
String heatingYear = 'Wärme $currentYear';

final _formKey = GlobalKey<FormState>();

final ScrollController controllerOne = ScrollController();

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String error = '';

  @override
  void initState() {
    //getTypesOfHeating();
    super.initState();
  }

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
            children: [
              Text('dein Profil', style: Theme.of(context).textTheme.headline1),
              SizedBox(height: 10),
              ProfilePicture(),
              SizedBox(height: 20),
              GetUserName(user.uid),
              GetUserEmail(user.uid),
              GetUserHome(user.uid),
              SizedBox(height: 40),
              Text('eigene Transportmittel:',
                  style: Theme.of(context).textTheme.headline2),
              GetUserCar(user.uid),
              GetUserBike(user.uid),
              SizedBox(height: 40),
              Text('Energie', style: Theme.of(context).textTheme.headline2),
              GetUserPower(user.uid),
              SizedBox(height: 20),
              GetUserHeating(user.uid),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

inputUserData(BuildContext context, FirebaseUser user, String nameOfCategory,
    String inputCategory, String inputCategoryDescribtion) async {
  String inputCategoryData;
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
                inputCategoryDescribtion,
                style: TextStyle(
                  fontFamily: 'GloriaHalleluja',
                  fontSize: 24.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  width: 240,
                  child: TextFormField(
                    key: _formKey,
                    decoration: textInputDecoration.copyWith(
                        hintText: inputCategory,
                        fillColor: Colors.green[50],
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[50])),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[900]))),
                    validator: (val) =>
                        val.isEmpty ? 'Du hast noch nichts eingegeben' : null,
                    onChanged: (val) {
                      inputCategoryData = val;
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
                      if (nameOfCategory == 'Name') {
                        await DatabaseService(uid: user.uid).updateUserData(
                            inputCategoryData,
                            currentEmail,
                            currentHome,
                            currentProfilePicture,
                            currentCar,
                            currentBike);
                      }
                      if (nameOfCategory == 'Email') {
                        await DatabaseService(uid: user.uid).updateUserData(
                            currentName,
                            inputCategoryData,
                            currentHome,
                            currentProfilePicture,
                            currentCar,
                            currentBike);
                      }
                      if (nameOfCategory == 'Home') {
                        await DatabaseService(uid: user.uid).updateUserData(
                            currentName,
                            currentEmail,
                            inputCategoryData,
                            currentProfilePicture,
                            currentCar,
                            currentBike);
                      }
                      if (nameOfCategory == 'Car') {
                        await DatabaseService(uid: user.uid).updateUserData(
                            currentName,
                            currentEmail,
                            currentHome,
                            currentProfilePicture,
                            inputCategoryData,
                            currentBike);
                      }
                      if (nameOfCategory == 'Bike') {
                        await DatabaseService(uid: user.uid).updateUserData(
                            currentName,
                            currentEmail,
                            currentHome,
                            currentProfilePicture,
                            currentCar,
                            inputCategoryData);
                      }

                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Profile()));
                    })
              ])
            ]));
      });
}

class ProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(currentProfilePicture);
    final user = Provider.of<FirebaseUser>(context);
    FirebaseFirestore.instance
        .collection('Nutzerdaten')
        .doc(user.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        currentProfilePicture = documentSnapshot['Profilbild'] ?? [];
        print(currentProfilePicture);
      } else {
        print('Document does not exist on the database');
      }
    });
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manInFrame.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanWithCellphone.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manWithGlases.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanWithPlant.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manWithCellphone.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanWithLaptop.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manHappy.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanWithCap.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));
                                              },
                                              child: ChooseProfilePicture(
                                                  profilePicture:
                                                      'assets/images/profilePictures/womanWithCap.png'),
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                primary: Colors.grey,
                                              ),
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/manWithMelon.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
                                              onPressed: () async {
                                                currentProfilePicture =
                                                    'assets/images/profilePictures/womanBeach.png';
                                                await DatabaseService(
                                                        uid: user.uid)
                                                    .updateUserData(
                                                        currentName,
                                                        currentEmail,
                                                        currentHome,
                                                        currentProfilePicture,
                                                        currentCar,
                                                        currentBike);
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
              inputUserData(context, user, 'Name', currentName,
                  'Hier kannst du deinen Namen ändern:');
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
                inputUserData(context, user, 'Email', currentEmail,
                    'Hier kannst du deine Email ändern:');
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
                inputUserData(context, user, 'Home', currentHome,
                    'Hier kannst du deinen Wohnort ändern:');
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
          currentCar = data['Auto'];
          return ProfileForm(
              category: 'Auto:',
              userData: data['Auto'] == null ? '-' : data['Auto'],
              press: () {
                inputUserData(context, user, 'Car', currentCar,
                    'Hier kannst du dein Automodell ändern:');
              });
        }
        return Loading();
      },
    );
  }
}

class GetUserBike extends StatelessWidget {
  final String documentId;

  GetUserBike(this.documentId);

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
          currentCar = data['Motorrad'];
          return ProfileForm(
              category: 'Motorrad:',
              userData: data['Motorrad'] == null ? '-' : data['Motorrad'],
              press: () {
                inputUserData(context, user, 'Bike', currentBike,
                    'Hier kannst du dein Motorradmodell ändern:');
              });
        }
        return Loading();
      },
    );
  }
}

class GetUserPower extends StatelessWidget {
  final String documentId;
  GetUserPower(this.documentId);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');

    return FutureBuilder<DocumentSnapshot>(
      future:
          users.doc(user.uid).collection('NutzerTracking').doc(powerYear).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          currentTypeOfPower = data['Stromart'];
          currentAmountOfPower = data['Menge'];
          return Column(children: [
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Stromart:', style: Theme.of(context).textTheme.bodyText1),
                SizedBox(width: 6),
                getSelectedPowerType(user, context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30,
                  width: 90,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Menge:',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'CourierPrime',
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    color: Colors.green[900].withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    child: Text(
                      currentAmountOfPower.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CourierPrime',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Text(
                  'kWh pro Jahr',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CourierPrime',
                    fontSize: 13.0,
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: Colors.green[900],
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
                                    horizontal: 25, vertical: 30),
                                height: 250,
                                child: Column(children: [
                                  Text(
                                    'Ändere hier deinen jährlichen Stromverbrauch:',
                                    style: TextStyle(
                                      fontFamily: 'GloriaHalleluja',
                                      fontSize: 24.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 80,
                                              child: TextFormField(
                                                key: _formKey,
                                                decoration: textInputDecoration.copyWith(
                                                    hintText:
                                                        currentAmountOfPower
                                                            .toString(),
                                                    fillColor: Colors.green[50],
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                        .green[
                                                                    50])),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                        .green[
                                                                    900]))),
                                                validator: (val) => val.isEmpty
                                                    ? 'Du hast noch nichts eingegeben'
                                                    : null,
                                                onChanged: (val) {
                                                  currentAmountOfPower =
                                                      int.parse(val);
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'kWh pro Jahr',
                                              style: TextStyle(
                                                fontFamily: 'CourierPrime',
                                                fontSize: 16.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
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
                                              calculatePowerEmissions(
                                                  user, context, true);
                                            })
                                      ])
                                ]));
                          });
                    })
              ],
            )
          ]);
        }
        return Loading();
      },
    );
  }
}

getSelectedPowerType(final user, context) {
  if (currentTypeOfPower == 'Oekostrom') {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.green[900], shadowColor: Colors.green[900]),
          child: Container(
            child: Text(
              'Ökostrom',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () {},
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Colors.green[900],
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.grey),
          ),
          onPressed: () async {
            currentTypeOfPower = 'Strommix';
            calculatePowerEmissions(user, context, false);
          },
          child: const Text('Strommix'),
        ),
      ],
    );
  } else if (currentTypeOfPower == 'Strommix') {
    return Row(
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Colors.green[900],
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.grey),
          ),
          onPressed: () async {
            currentTypeOfPower = 'Oekostrom';
            calculatePowerEmissions(user, context, false);
          },
          child: const Text('Ökostrom'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.green[900], shadowColor: Colors.green[900]),
          child: Container(
            child: Text(
              'Strommix',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

calculatePowerEmissions(final user, context, bool amountOfPowerChanged) async {
  await FirebaseFirestore.instance
      .collection('Energie')
      .doc(currentTypeOfPower)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      emissionsOfPowerFactor = documentSnapshot['Emissionen'] ?? [];
    } else {
      print('Document does not exist on the database');
    }
  });

  emissionsOfPower = emissionsOfPowerFactor * currentAmountOfPower;

  await AddEnergyDatabaseService(uid: user.uid, powerDate: powerYear)
      .addNewPower(currentTypeOfPower, currentAmountOfPower, emissionsOfPower);
  Navigator.pop(context);
  if (amountOfPowerChanged == true) {
    Navigator.pop(context);
  }
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => Profile()));
}

class GetUserHeating extends StatelessWidget {
  final String documentId;
  GetUserHeating(this.documentId);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    CollectionReference users =
        FirebaseFirestore.instance.collection('Nutzerdaten');
    return FutureBuilder<DocumentSnapshot>(
      future: users
          .doc(user.uid)
          .collection('NutzerTracking')
          .doc(heatingYear)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;
          //currentTypeOfHeating = data['Heizungsart'];
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 90,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Heizung:',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CourierPrime',
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.green[900].withOpacity(0.2),
                          width: 1.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.grey[100],
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      elevation: 8,
                      focusColor: Colors.green[900],
                      value: data['Heizungsart'],
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.green[900],
                        size: 25,
                      ),
                      onChanged: (value) async {
                        await getTypesOfHeating();
                        currentTypeOfHeating = value;
                        print(typesOfHeating);
                        print(currentTypeOfHeating);
                        await AddEnergyDatabaseService(
                                uid: user.uid, heatingDate: heatingYear)
                            .addNewHeating(currentTypeOfHeating,
                                currentAmountOfHeating, emissionsOfHeating);
                        Navigator.pop(context);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      items: typesOfHeating.map((itemsname) {
                            return DropdownMenuItem(
                              value: itemsname,
                              child: Container(
                                width: 140,
                                child: Text(
                                  itemsname,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CourierPrime',
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            );
                          }).toList() ??
                          [],
                    ),
                  ),
                ],
              ),
              ProfileForm(
                  category: 'Menge',
                  userData: data['Menge'] == null ? '-' : data['Menge'],
                  press: () async {}),
            ],
          );
        }
        return Loading();
      },
    );
  }
}

getTypesOfHeating() async {
  await FirebaseFirestore.instance
      .collection('Energie')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc['Name']);
      typesOfHeating = typesOfHeating + doc['Name'];
    });
  });
}

calculateEmissions() {}

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
          width: 90,
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
          width: 195,
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
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Colors.green[900],
            size: 25,
          ),
          onPressed: press,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:forrest_flutter/shared/constants.dart';

class ExpansionListFood extends StatefulWidget {
  @override
  _ExpansionListFoodState createState() => _ExpansionListFoodState();
}

class _ExpansionListFoodState extends State<ExpansionListFood> {
  String listedFood = 'Du hast einen Apfel gekauft';

  List<Item> _data = [
    Item(
      icon: Icons.lunch_dining_outlined,
      headerValue: 'Lebensmittel',
      expandedValue: 'Du hast einen Apfel gekauft',
    ),
  ];

  String newFood;

  void _showAddFood() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          height: 300,
          child: Column(children: [
            Text(
              'Füge hier ein neues Lebensmittel ein:',
              style: TextStyle(
                fontFamily: 'GloriaHalleluja',
                fontSize: 22.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'neues Lebensmittel',
                  fillColor: Colors.green[50],
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[50])),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[900]))),
              validator: (val) =>
                  val.isEmpty ? 'Du hast noch nichts eingegeben' : null,
              onChanged: (val) {
                setState(() => newFood = val);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Hinzufügen'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green[900],
                textStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'CourierPrime',
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {},
            ),
          ]),
        );
      },
    );
  }

  Widget _buildListPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      expandedHeaderPadding: EdgeInsets.symmetric(vertical: 5),
      dividerColor: Colors.lightGreen[50],
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Row(
                children: [
                  Icon(
                    item.icon,
                    size: 28,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 25),
                  Text(
                    item.headerValue,
                    style: TextStyle(
                      fontFamily: 'GloriaHalleluja',
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          },
          body: Container(
            color: Colors.lightGreen[50],
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    item.expandedValue,
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 15,
                    ),
                  ),
                  trailing: Icon(Icons.delete),
                  onTap: () {
                    setState(() {
                      _data.removeWhere((currentItem) => item == currentItem);
                    });
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    'Hinzufügen:',
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    _showAddFood();
                  },
                ),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildListPanel(),
    );
  }
}

class Item {
  String expandedValue, headerValue;
  IconData icon;
  bool isExpanded;

  Item(
      {this.expandedValue,
      this.headerValue,
      this.icon,
      this.isExpanded = false});
}

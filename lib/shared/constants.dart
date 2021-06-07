import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    hintStyle: TextStyle(
      fontFamily: 'CourierPrime',
      fontSize: 15,
    ),
    contentPadding: EdgeInsets.only(left: 14),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.5),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1),
    ));

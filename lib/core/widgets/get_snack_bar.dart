import 'package:flutter/material.dart';

SnackBar getSnackBar(String text ,bool isTrue) {
  return SnackBar(content: Text(text,style: TextStyle(color: Colors.white),), backgroundColor:isTrue? Colors.green: Colors.red);
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sanad_software_project/auuth/signup.dart';
import 'package:sanad_software_project/theme.dart';
import 'package:http/http.dart' as http;


class childDetailes extends StatefulWidget{
  final String id;
  final String name;

  const childDetailes({super.key, required this.id, required this.name});
  @override
  State<StatefulWidget> createState() {
    return childDetailesState();
  }

}

class childDetailesState extends State<childDetailes>{
  late String id;
  late String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id=widget.id;
    name=widget.name;
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child:Container(
          color: primaryLightColor,
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                      SizedBox(width: 15,),
                      Text(": الــطــفــل",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'myFont',fontSize: 18,color: Colors.black87),),
                    ],),
                  ),
                ),
            ],
          ),
        ) ,
      ),
    );

  }

}
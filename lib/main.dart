import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:wetherapp/Modelpage.dart';



void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
      },
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String citiy="surat";

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          title: Text(
            "$citiy",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                letterSpacing: .5),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.location_pin,
                size: 30,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: ApiCall("$citiy"),
          builder: (context,AsyncSnapshot snapshot){
            if (snapshot.hasError){
              print("${snapshot.error}");
              return Center(
                child:Text("${snapshot.error}"),
              );
            }
            else if (snapshot.hasData){
              Modal l1 = snapshot.data;
              return  Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: l1.main!.tempMax !> 300 ? Colors.yellow:Colors.blue,
                  ),
                  SingleChildScrollView(
                    child: Container(

                      child: Column(
                        children: [

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.wb_sunny_outlined,
                                    size: 65,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${l1.coord!.lat}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .5),
                                  ),
                                  Text(
                                    "Friday",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .5),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 130,
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "${l1.wind!.deg}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 90,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .5),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "    haze",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: .5),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 270,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 2.0, color: Colors.white),
                                bottom: BorderSide(width: 2.0, color: Colors.white),
                                right: BorderSide(width: 2.0, color: Colors.white),
                                left: BorderSide(width: 2.0, color: Colors.white),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.thermostat_outlined,
                                        size: 60,
                                      ),
                                      Text(
                                        "${l1.main!.temp}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5),
                                      ),
                                      Expanded(child: Container()),
                                      Icon(
                                        Icons.cloud_outlined,
                                        size: 60,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${l1.clouds!.all}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 30),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Temperature",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .5),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Clouds",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .5),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.air_outlined,
                                        size: 60,
                                      ),
                                      Text(
                                        "${l1.wind!.speed}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5),
                                      ),
                                      Expanded(child: Container()),
                                      Icon(
                                        Icons.arrow_circle_up,
                                        size: 60,
                                      ),
                                      Text(
                                        " ${l1.main!.tempMax}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, left: 20, right: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Wind Speed",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .5),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Wind Degree",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 30, right: 20),
                                  height: 2,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "More Getaile",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 20, right: 30),
                                  height: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 220,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 2.0, color: Colors.white),
                                bottom: BorderSide(width: 2.0, color: Colors.white),
                                right: BorderSide(width: 2.0, color: Colors.white),
                                left: BorderSide(width: 2.0, color: Colors.white),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Humibity",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: .5),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Visibility",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: .5),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "Sunrise",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: .5),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.thermostat_outlined,
                                        size: 50,
                                      ),
                                      Expanded(child: Container()),
                                      Icon(
                                        Icons.remove_red_eye,
                                        size: 50,
                                      ),
                                      Expanded(child: Container()),
                                      Icon(
                                        Icons.cloud_outlined,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${l1.main!.humidity}%",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .5),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "${l1.visibility}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .5),
                                      ),
                                      Expanded(child: Container()),
                                      Text(
                                        "${l1.sys!.sunrise}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: .5),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          },

        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              ListTile(
                title: const Text('SURAT'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    citiy="surat";
                  });

                },
              ),
              ListTile(
                title: const Text('AMDABAD'),
                onTap: () {

                  Navigator.pop(context);
                  setState(() {
                    citiy="london";
                  });
                },
              ),
              ListTile(
                title: const Text('VADODRA'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    citiy="vadodara";
                  });
                },
              ),
              ListTile(
                title: const Text('MUMBAI'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    citiy="mumbai";
                  });
                },
              ),
              ListTile(
                title: const Text('GANDHINAGAR'),
                onTap: () {
                  Navigator.pop(context);
                  citiy="gandhinagar";
                },
              ),
              ListTile(
                title: const Text('BIHAR'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    citiy="bihar";
                  });
                },
              ),
              ListTile(
                title: const Text('RAJASTAN'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    citiy="rajasthan";
                  });
                },
              ),
              ListTile(
                title: const Text('SAPUTARA'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    citiy="saputara";
                  });
                },
              ),
              ListTile(
                title: const Text('VESU'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    citiy="vesu";
                  });
                },
              ),
              ListTile(
                title: const Text('PUNE'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    citiy="pune";
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<dynamic> ApiCall(String city) async {
    Uri uri = Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$city&appid=f087892a8390ca647225a9370ac2e3bc",
    );
    var res = await http.get(uri);
    var Jsd = convert.jsonDecode(res.body);
    print(Jsd);
    return  Modal.fromJson(Jsd);
  }
}

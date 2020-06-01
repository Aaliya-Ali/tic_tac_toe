import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  var name1;
  var name2;
  HomeScreen({@required this.name1, @required this.name2});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cname1;
  var cname2;
  @override
  void initState() {
    getname1();

    super.initState();
    getname2();
  }

  void getname1() {
    Firestore.instance
        .collection('user 1')
        .document('FbrBJ9fjZuzNmgH5I4lb')
        .get()
        .then(
      (data) {
        var vname = data['name'].toString();
        var vucode = data['gameid'].toString();
        print(vname);
        print(vucode);

        setState(() {
          cname1 = vname;
        });
      },
    );
  }

  void getname2() {
    Firestore.instance
        .collection('user 2')
        .document('KwsMhcJ8kOmI74feXV5h')
        .get()
        .then(
      (data) {
        var xname = data['name'].toString();
        var xucode = data['gameid'].toString();
        print(xname);
        print(xucode);

        setState(() {
          cname2 = xname;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                      Text(widget.name1 != null
                          ? widget.name1 ?? "loading"
                          : cname1 ?? "loading"),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                      Text(widget.name2 != null
                          ? widget.name2 ?? "loading"
                          : cname2 ?? "loading"),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

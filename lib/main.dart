import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:splash_screen_view/SplashScreenView.dart';
import 'addedit.dart';

//import 'package:dio/dio.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/second': (context) => MyApp(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      home: MyHomePage(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "images/myprofile.png",
      text: "Splash Screen",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.green,
        Colors.yellow,
        Colors.brown,
        Colors.blue,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      title: 'Crud App\n BY Saad Shafiq \n FA17-BCS-129',
      home: example1,
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getData() async {
    var url = Uri.parse('http://192.168.43.51/crud_app/read.php');
    var response = await http.get(url);

    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crud App'),
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              icon: Icon(Icons.add_to_home_screen_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditPage(),
            ),
          );
          debugPrint('Clicked FloatingActionButton Button');
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 60.0),
              color: Colors.white,
              child: Center(
                child: ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 30.0, left: 30.0),
              color: Colors.white,
              child: ListTile(
                title: Text(
                  'Add edit form',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEditPage()),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 30.0, left: 30.0),
              color: Colors.white,
              child: ListTile(
                title: Text(
                  'Contact us',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Contactus()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    List list = snapshot.data;
                    return ListTile(
                      leading: GestureDetector(
                        child: Icon(Icons.edit),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditPage(
                                list: list,
                                index: index,
                              ),
                            ),
                          );
                          debugPrint('Edit Clicked');
                        },
                      ),
                      title: Text(list[index]['fname']),
                      subtitle: Text(list[index]['phone']),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: () {
                          setState(() {
                            var url = Uri.parse(
                                'http://192.168.43.51/crud_app/delete.php');
                            http.post(url, body: {
                              'id': list[index]['id'],
                            });
                          });
                          debugPrint('delete Clicked');
                        },
                      ),
                    );
                  })
              : CircularProgressIndicator();
        },
      ),
    );
  }
}

class Contactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100.0,
          title: Text(
            'Crud App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
            ),
          ),
          backgroundColor: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 60.0),
                color: Colors.white,
                child: Center(
                  child: ListTile(
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 30.0, left: 30.0),
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    'Add edit form',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddEditPage()),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 30.0, left: 30.0),
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    'Contact us',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Contactus()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Contact Us',
                style: TextStyle(
                  fontFamily: 'Quando',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  letterSpacing: 2.0,
                ),
              ),
              CircleAvatar(
                backgroundImage: AssetImage('images/myprofile.png'),
                backgroundColor: Colors.black,
                radius: 70.0,
              ),
              Text(
                'Saad Shafiq',
                style: TextStyle(
                  fontFamily: 'Satisfy',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 350.0,
                child: Divider(
                  color: Colors.white,
                  thickness: 4.0,
                ),
              ),
              Text(
                'BSCS Student/ Developer',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 5.0,
                ),
              ),
              SizedBox(
                height: 60.0,
                width: 350.0,
                child: Divider(
                  color: Colors.white,
                  thickness: 4.0,
                ),
              ),
              Card(
                color: Colors.yellow,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: Text(
                    '+923047966966',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                    color: Colors.yellow,
                  ),
                ),
              ),
              Card(
                color: Colors.yellow,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: Text(
                    'saadshafiq259@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                    color: Colors.yellow,
                  ),
                ),
              ),
              Card(
                color: Colors.yellow,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  title: Text(
                    'Burewala',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                  side: BorderSide(
                    color: Colors.yellow,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

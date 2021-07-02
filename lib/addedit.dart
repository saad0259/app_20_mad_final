import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:php_crud/main.dart';

class AddEditPage extends StatefulWidget {
  final List list;
  final int index;
  AddEditPage({this.list, this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController fname = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController address = TextEditingController();

  bool editMode = false;

  addUpdateData() {
    if (editMode) {
      var url = Uri.parse('http://192.168.43.51/crud_app/edit.php');
      http.post(url, body: {
        'id': widget.list[widget.index]['id'],
        'fname': fname.text,
        'phone': phone.text,
        'email': email.text,
        'address': address.text,
      });
    } else {
      var url = Uri.parse('http://192.168.43.51/crud_app/add.php');
      http.post(url, body: {
        'fname': fname.text,
        'phone': phone.text,
        'email': email.text,
        'address': address.text,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      fname.text = widget.list[widget.index]['fname'];

      phone.text = widget.list[widget.index]['phone'];

      email.text = widget.list[widget.index]['email'];

      address.text = widget.list[widget.index]['address'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(editMode ? 'Update' : 'Add Data'),
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: fname,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phone,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: address,
              decoration: InputDecoration(
                labelText: 'address',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  addUpdateData();
                  debugPrint('Adding running');
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
                debugPrint('Clicked RaisedButton Button');
              },
              color: Colors.yellow,
              child: Text(
                editMode ? 'Update' : 'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' show parse;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: UrlCheckScreen(),
//     );
//   }
// }

// class UrlCheckScreen extends StatefulWidget {
//   @override
//   _UrlCheckScreenState createState() => _UrlCheckScreenState();
// }

// class _UrlCheckScreenState extends State<UrlCheckScreen> {
//   String _statusMessage = 'Checking URL...';
//   List<Map<String, String>> _users = [];
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _idController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _checkUrl();
//   }

//   Future<void> _checkUrl() async {
//     final url = 'http://192.168.100.55/practice_api/config.php';

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         setState(() {
//           _statusMessage = 'URL is reachable. Status Code: ${response.statusCode}';
//           _parseHtml(response.body);
//         });
//       } else {
//         setState(() {
//           _statusMessage = 'Failed to reach URL. Status Code: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _statusMessage = 'Error occurred: $e';
//       });
//     }
//   }

//   void _parseHtml(String html) {
//     final document = parse(html);
//     final rawText = document.body?.text ?? '';

//     final userRegex = RegExp(r'id:\s*(\d+)\s*name:\s*([^\d]+?)\s*age:\s*(\d+)');
//     final matches = userRegex.allMatches(rawText);

//     List<Map<String, String>> users = [];

//     for (final match in matches) {
//       if (match.groupCount >= 3) {
//         final id = match.group(1)?.trim() ?? '';
//         final name = match.group(2)?.trim() ?? '';
//         final age = match.group(3)?.trim() ?? '';

//         users.add({
//           'id': id,
//           'name': name,
//           'age': age,
//         });
//       }
//     }

//     setState(() {
//       _users = users;
//     });
//   }

//   Future<void> _insertData(String name, String age) async {
//     final url = 'http://192.168.100.55/practice_api/add_user.php';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {
//           'name': name,
//           'age': age,
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           _statusMessage = 'Data inserted successfully.';
//           _checkUrl();
//         });
//       } else {
//         setState(() {
//           _statusMessage = 'Failed to insert data. Status Code: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _statusMessage = 'Error occurred: $e';
//       });
//     }
//   }

//   Future<void> _updateData(String id, String name, String age) async {
//     final url = 'http://192.168.100.55/practice_api/update_user.php';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {
//           'id': id,
//           'name': name,
//           'age': age,
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           _statusMessage = 'Data updated successfully.';
//           _checkUrl();
//         });
//       } else {
//         setState(() {
//           _statusMessage = 'Failed to update data. Status Code: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _statusMessage = 'Error occurred: $e';
//       });
//     }
//   }

//   Future<void> _deleteData(String id) async {
//     final url = 'http://192.168.100.55/practice_api/delete_data.php';

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {
//           'id': id,
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           _statusMessage = 'Data deleted successfully.';
//           _checkUrl();
//         });
//       } else {
//         setState(() {
//           _statusMessage = 'Failed to delete data. Status Code: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _statusMessage = 'Error occurred: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('CRUD Operations')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               _statusMessage,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: 'Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _ageController,
//               decoration: InputDecoration(
//                 labelText: 'Age',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 final name = _nameController.text;
//                 final age = _ageController.text;

//                 if (name.isNotEmpty && age.isNotEmpty) {
//                   _insertData(name, age);
//                 } else {
//                   setState(() {
//                     _statusMessage = 'Please enter both name and age.';
//                   });
//                 }
//               },
//               child: Text('Insert Data'),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _idController,
//               decoration: InputDecoration(
//                 labelText: 'ID (for update/delete)',
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 final id = _idController.text;
//                 final name = _nameController.text;
//                 final age = _ageController.text;

//                 if (id.isNotEmpty && name.isNotEmpty && age.isNotEmpty) {
//                   _updateData(id, name, age);
//                 } else {
//                   setState(() {
//                     _statusMessage = 'Please enter ID, name, and age.';
//                   });
//                 }
//               },
//               child: Text('Update Data'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 final id = _idController.text;

//                 if (id.isNotEmpty) {
//                   _deleteData(id);
//                 } else {
//                   setState(() {
//                     _statusMessage = 'Please enter an ID to delete.';
//                   });
//                 }
//               },
//               child: Text('Delete Data'),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _users.length,
//                 itemBuilder: (context, index) {
//                   final user = _users[index];
//                   return ListTile(
//                     title: Text('ID: ${user['id']}'),
//                     subtitle: Text('Name: ${user['name']}, Age: ${user['age']}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UrlCheckScreen(),
    );
  }
}

class UrlCheckScreen extends StatefulWidget {
  @override
  _UrlCheckScreenState createState() => _UrlCheckScreenState();
}

class _UrlCheckScreenState extends State<UrlCheckScreen> {
  String _statusMessage = 'Checking URL...';
  List<Map<String, String>> _users = [];
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _idController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkUrl();
  }

  Future<void> _checkUrl() async {
    final url = 'http://192.168.100.55/practice_api/config.php';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = 'URL is reachable. Status Code: ${response.statusCode}';
          _parseHtml(response.body);
        });
      } else {
        setState(() {
          _statusMessage = 'Failed to reach URL. Status Code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error occurred: $e';
      });
    }
  }

  void _parseHtml(String html) {
    final document = parse(html);
    final rawText = document.body?.text ?? '';

    final userRegex = RegExp(r'id:\s*(\d+)\s*name:\s*([^\d]+?)\s*age:\s*(\d+)');
    final matches = userRegex.allMatches(rawText);

    List<Map<String, String>> users = [];

    for (final match in matches) {
      if (match.groupCount >= 3) {
        final id = match.group(1)?.trim() ?? '';
        final name = match.group(2)?.trim() ?? '';
        final age = match.group(3)?.trim() ?? '';

        users.add({
          'id': id,
          'name': name,
          'age': age,
        });
      }
    }

    setState(() {
      _users = users;
    });
  }

  Future<void> _insertData(String name, String age) async {
    final url = 'http://192.168.100.55/practice_api/add_user.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': name,
          'age': age,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = 'Data inserted successfully.';
          _checkUrl();
        });
      } else {
        setState(() {
          _statusMessage = 'Failed to insert data. Status Code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error occurred: $e';
      });
    }
  }

  Future<void> _updateData(String id, String name, String age) async {
    final url = 'http://192.168.100.55/practice_api/update_user.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'id': id,
          'name': name,
          'age': age,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = 'Data updated successfully.';
          _checkUrl();
        });
      } else {
        setState(() {
          _statusMessage = 'Failed to update data. Status Code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error occurred: $e';
      });
    }
  }

  Future<void> _deleteData(String id) async {
    final url = 'http://192.168.100.55/practice_api/delete_data.php';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _statusMessage = 'Data deleted successfully.';
          _checkUrl();
        });
      } else {
        setState(() {
          _statusMessage = 'Failed to delete data. Status Code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = 'Error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CRUD Operations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _statusMessage,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final age = _ageController.text;

                if (name.isNotEmpty && age.isNotEmpty) {
                  _insertData(name, age);
                } else {
                  setState(() {
                    _statusMessage = 'Please enter both name and age.';
                  });
                }
              },
              child: Text('Add User'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID (for update/delete)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final id = _idController.text;
                      final name = _nameController.text;
                      final age = _ageController.text;

                      if (id.isNotEmpty && name.isNotEmpty && age.isNotEmpty) {
                        _updateData(id, name, age);
                      } else {
                        setState(() {
                          _statusMessage = 'Please enter ID, name, and age.';
                        });
                      }
                    },
                    child: Text('Update User'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final id = _idController.text;

                      if (id.isNotEmpty) {
                        _deleteData(id);
                      } else {
                        setState(() {
                          _statusMessage = 'Please enter an ID to delete.';
                        });
                      }
                    },
                    child: Text('Delete User'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(user['id'] ?? '0'),
                      ),
                      title: Text(user['name'] ?? 'No Name'),
                      subtitle: Text('Age: ${user['age'] ?? 'N/A'}'),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

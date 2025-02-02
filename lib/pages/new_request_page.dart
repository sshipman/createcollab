import 'package:flutter/material.dart';

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key});

  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _requestType;
  String? _expiresIn;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Request Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _requestType,
                    decoration: InputDecoration(labelText: 'Type of Request'),
                    items: ['Help', 'Conversation'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _requestType = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a request type';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 5,
                    maxLength: 350,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle image upload
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 50),
                            Text('Tap to Add An Image'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    value: _expiresIn,
                    decoration:
                        InputDecoration(labelText: 'Request Expires In'),
                    items: ['15 minutes', '30 minutes', '1 hour', '6 hours']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _expiresIn = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an expiration time';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                      }
                    },
                    child: Text('Post Help Request'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

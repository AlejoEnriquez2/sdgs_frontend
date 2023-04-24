import 'package:flutter/material.dart';

class FullScreenForm extends StatefulWidget {
  @override
  _FullScreenFormState createState() => _FullScreenFormState();
}

class _FullScreenFormState extends State<FullScreenForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  String _name = '';
  String _email = '';
  String _phoneNumber = '';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Screen Form'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _name = value!;
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _email = value!;
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _phoneNumber = value!;
                });
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _submitForm();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Submit the form data
    // For example, you can send the data to a server or save it to a local database
    print('Name: $_name');
    print('Email: $_email');
    print('Phone Number: $_phoneNumber');
  }
}

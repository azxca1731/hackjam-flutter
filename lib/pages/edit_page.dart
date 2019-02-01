import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphql/mutation.dart';

class EditPage extends StatefulWidget {
  final String apiKey;

  EditPage(this.apiKey);
  @override
  State<StatefulWidget> createState() {
    return _EditPageState();
  }
}

class _EditPageState extends State<EditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'content': null,
    'price': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title'),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildContentTextField() {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(labelText: 'content'),
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 10) {
          return 'content is required and should be 10+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['content'] = value;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Price'),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number.';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _buildSubmitButton() {
    return Mutation(createDraft, onCompleted: (Map<String, dynamic> result) {
      Navigator.pushReplacementNamed(context, '/main');
    }, builder: (
      RunMutation authenicate, {
      bool loading,
      var data,
      Exception error,
    }) {
      if (loading == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (error != null) {
        return Dialog(
          child: Text(error.toString()),
        );
      } else {
        return RaisedButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: () => _submitForm(authenicate));
      }
    });
  }

  Widget _buildPageContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            children: <Widget>[
              _buildTitleTextField(),
              _buildContentTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function createDraft) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print(widget.apiKey);
    createDraft({'title': _formData['title'], 'content': _formData['content']});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Page'),
      ),
      body: _buildPageContent(context),
    );
  }
}

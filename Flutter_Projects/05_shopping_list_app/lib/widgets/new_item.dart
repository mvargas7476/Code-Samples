import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // creates a reference so this package is now used by this name
import 'dart:convert'; // this is how we set the data into JSON end encoded

import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
// import 'package:shopping_list_app/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // This is here so that we can actually do validation in the form section below
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  void saveItem() async {
    if(_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();
      // Configuring the request to send to our DB in Firebase
      final url = Uri.https('flutter-meals-b056a-default-rtdb.firebaseio.com', 'shopping-list.json');
      // final response = await http.post(url, 
      final response = await http.post(url, 
        headers: {
          'Content-Type': 'application/json'
        }, 
        body: json.encode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'category': _selectedCategory.title
        })
      );

      final responseData = json.decode(response.body);
      
      if (!mounted) {
        return;
      }

      Navigator.of(context).pop( 
        GroceryItem(
          id: responseData['name'], 
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().length <= 1  || value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
                decoration: InputDecoration(
                  label: Text('Name'),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Quantity'),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)! <= 0) {
                          return 'Must be a valid positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8,),
                  // Dropdown for adding items
                  Expanded(
                    child: DropdownButtonFormField(
                      initialValue: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 8,),
                                Text(category.value.title)
                              ]
                            ),
                          )
                      ], 
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      }
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    // the null sets the button to be disabled
                    onPressed: _isSending ? null : () {
                      _formKey.currentState!.reset();
                    }, 
                    child: Text('Reset')
                  ),
                  ElevatedButton(
                    // the null sets the button to be disabled
                    onPressed: _isSending ? null : saveItem, 
                    child: _isSending ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator()) : const Text('Add item')
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
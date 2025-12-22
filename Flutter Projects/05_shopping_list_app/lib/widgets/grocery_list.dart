import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // creates a reference so this package is now used by this name
import 'dart:convert';

import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';
import 'package:shopping_list_app/data/categories.dart';

class GroceryList extends StatefulWidget{
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  // Setting up the initial behavior on app load
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  // Function to do the GET response from our database
  void _loadItems() async {
    final url = Uri.https('flutter-meals-b056a-default-rtdb.firebaseio.com', 'shopping-list.json');

    try {
      final response = await http.get(url);
      // This is in case there is an issue
      if(response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Try again later';
        });
      }

      // Here is what we will do if we get an error from the database connection
      if(response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Here  we start processing the response from the database by making it JSON then looping it throught the response
      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];
      for(final item in listData.entries) {
        // This is because we are saving only the vategory name in the DB but we need to find the category that matches that name
        final category = categories.entries.firstWhere((catItem) => catItem.value.title == item.value['category']).value;

        // Here we are adding ALL of the items in the response to update the UI
        loadedItems.add(
          GroceryItem(
            id: item.key, 
            name: item.value['name'], 
            quantity: item.value['quantity'], 
            category: category
          )
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch(error) {
      setState(() {
        _error = 'Something went really wrong. Please try again later';
      });
    }
  }

  // This is async so that we wait for the next screen to work
  void _addItem() async {
    // We have to set this up things so that we get data back from the other screen with the correct set up
    final newItem = await Navigator.push<GroceryItem>(context, 
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      )
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }


  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    // Updating the state first
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https('flutter-meals-b056a-default-rtdb.firebaseio.com', 'shopping-list/${item.id}.json');
    final response = await http.delete(url);

    if(response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });

      if(!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('There was an error deleting your item',),
        duration: Duration(seconds: 3)
      ));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet'));

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString())
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem, 
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: content
    );
  }
}
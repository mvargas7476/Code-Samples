import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

     // This clears the message after sending
    _messageController.clear();
    // This closes the keyboard
    FocusScope.of(context).unfocus();

    // Getting the currently logged in user's data for the message to save
    final user = FirebaseAuth.instance.currentUser!;
    // Getting the rest of the data for the current user
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    // This will create and automatically generacted name created by Firebase
    FirebaseFirestore.instance.collection('chat').add({
      'enteredMessage': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'], // This is how you retrieve it from a collection
      '': '',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            )
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: _submitMessage, 
            icon: const Icon(Icons.send)
          )
        ],
      ),
    );
    
  }
}
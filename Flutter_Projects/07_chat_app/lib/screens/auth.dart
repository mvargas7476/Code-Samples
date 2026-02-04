import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// This uses the SDK installed with all of the Firebase stuff
final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  // This keeps track of the form fields and their current values
  final _form = GlobalKey<FormState>();
  
  // The email and password are connected to the Form fields
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredUsername = '';
  var _enteredPassword = '';

  // We save the values, trigger validations, and make sure things are created correctly
  void _submit() async {
    final isValid = _form.currentState!.validate(); // This exclamation is because things ARE available when submit is pressed

    // There was an issue
    if (!isValid) {
      return;
    }
    
    // Saving the credentials in the form fields
    _form.currentState!.save();

    // We will try to create or login the user and get the credentials using firebase
    try {
      // If loging in, then we have retrieve users and check them against existing uses
      // Otherwise we create the username
      if (_isLogin) {
        // final userCredentials = await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
        await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);
        // await _firebase.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);

        // This is sending data to a Firestore NoSQL database
        // We know this is here since this was a part of the form
        await FirebaseFirestore.instance.collection('users').doc(userCredentials.user!.uid).set({
          'username': _enteredUsername,
          'email': _enteredEmail
        }); 
      }
    } on FirebaseAuthException catch(error) { // Hovering over the createUserWith... tells you the type of except and potential error.code responses
      // Here we just checked that the current widget is still mounted so that context works
      // We know this is the case, but we do this to keep consistency
      if(!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false, //Disables Autocorrect
                            textCapitalization: TextCapitalization.none, // Disables Capitalization
                            validator: (value) {
                              if(value == null || value.trim().isEmpty || !value.contains('@')) {
                                return 'Please enter a valid Email Address';
                              }
                              // Since the email is correct we return null
                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!; // We know the value will not be null thanks to the validator
                            },
                          ),
                          if(!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(labelText: 'Username'),
                              enableSuggestions: false, // Disables suggestions
                              autocorrect: false, //Disables Autocorrect
                              textCapitalization: TextCapitalization.none, // Disables Capitalization
                              validator: (value) {
                                if(value == null || value.trim().isEmpty || value.trim().length < 4) {
                                  return 'Please enter at least 4 characters';
                                }
                                // Since the email is correct we return null
                                return null;
                              },
                              onSaved: (value) {
                                _enteredUsername = value!; // We know the value will not be null thanks to the validator
                              },
                            ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if(value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              // Since the email is correct we return null
                              return null;
                            },
                            onSaved: (value) {
                              _enteredPassword = value!; // We know the value will not be null thanks to the validator
                            },
                          ),
                          const SizedBox(height: 12,),
                          ElevatedButton(
                            onPressed: _submit, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primaryContainer
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup')
                          ),
                          TextButton(
                            onPressed: () {
                              // We just set the button to the other so that we change the text to what we want
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            }, 
                            child: Text(_isLogin ? 'Create an account' : 'I already have an account')
                          )
                        ],
                      )
                    ),
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
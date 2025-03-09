import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tubebazaar/authentication/widgets/constant.dart';
import 'package:tubebazaar/authentication/widgets/custom%20btn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _registerFormLoading = false;
  String _registerEmail = '';
  String _registerPassword = '';
  String _earningAvailable = '';
  String _activeContracts = '';
  String _availableBalance = '';
  String _offers = '';
  String _archived = '';
  String _number = '';
  String _country = 'Select Country';
  String _firstName = '';
  String _lastName = '';

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  bool _isPasswordVisible = false;

  final List<String> _countries = [
    'Select Country', 'United States', 'Canada', 'United Kingdom', 'Australia', 'India', 'Germany', 'France', 'Brazil', 'Japan', 'China'
  ];

  @override
  void initState() {
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: [
            ElevatedButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<String?> _createAccount() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _registerEmail,
        password: _registerPassword,
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': _registerEmail,
        'earningAvailable': 0.00,
        'activeContracts': 0,
        'availableBalance': 0.00,
        'offers': 0,
        'archived': 0,
        'number': _number,
        'country': _country,
        'firstName': _firstName,
        'lastName': _lastName,
        'createdAt': Timestamp.now(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });

    String? _registerFeedback = await _createAccount();
    if (_registerFeedback != null) {
      _alertDialogBuilder(_registerFeedback);
    }

    setState(() {
      _registerFormLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text('Create an account', textAlign: TextAlign.center, style: Constants.boldHeading),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text('Lets go through a few Simple Steps', textAlign: TextAlign.center),
            ),
            SizedBox(height: 50),
            Column(
              children: [
                _buildTextField('First Name', Icons.person, (value) => _firstName = value),
                _buildTextField('Last Name', Icons.person, (value) => _lastName = value),
                _buildTextField('Email', Icons.email, (value) => _registerEmail = value),
                _buildPasswordField(),
                _buildTextField('Number', Icons.phone, (value) => _number = value),
                _buildCountryDropdown(),
                SizedBox(height: 24),
                GestureDetector(
                  onTap: _submitForm,
                  child: CustomBtn(text: 'Create New Account', outlineBtn: false, isLoading: _registerFormLoading),
                ),
              ],
            ),
            SizedBox(height: 56),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CustomBtn(text: 'Back To Login', outlineBtn: true, isLoading: false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onChanged: (value) => _registerPassword = value,
        obscureText: !_isPasswordVisible,
      ),
    );
  }

  Widget _buildCountryDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        value: _country,
        items: _countries.map((String country) {
          return DropdownMenuItem(value: country, child: Text(country));
        }).toList(),
        onChanged: (value) {
          setState(() {
            _country = value as String;
          });
        },
      ),
    );
  }
}

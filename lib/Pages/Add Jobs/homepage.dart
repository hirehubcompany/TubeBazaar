import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddJobs extends StatefulWidget {
  const AddJobs({super.key});

  @override
  State<AddJobs> createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _channelNameController = TextEditingController();
  final TextEditingController _channelURLController = TextEditingController();
  final TextEditingController _subscribersController = TextEditingController();
  final TextEditingController _totalViewsController = TextEditingController();
  final TextEditingController _totalVideosController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _category = 'Gaming';
  bool _isMonetized = false;
  bool _isNegotiable = false;
  String _reasonForSelling = 'No Time';

  final List<String> categories = ['Gaming', 'Tech', 'Education', 'Lifestyle', 'Entertainment', 'Other'];
  final List<String> sellingReasons = ['No Time', 'Financial Need', 'Switching Niche', 'Other'];

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String jobId = FirebaseFirestore.instance.collection('jobs').doc().id;

      await FirebaseFirestore.instance.collection('jobs').doc(jobId).set({
        'userId': userId,
        'jobId': jobId,
        'channelName': _channelNameController.text,
        'channelURL': _channelURLController.text,
        'category': _category,
        'subscribers': int.parse(_subscribersController.text),
        'totalViews': int.parse(_totalViewsController.text),
        'totalVideos': int.parse(_totalVideosController.text),
        'isMonetized': _isMonetized,
        'price': double.parse(_priceController.text),
        'isNegotiable': _isNegotiable,
        'reasonForSelling': _reasonForSelling,
        'description': _descriptionController.text,
        'timestamp': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Job Posted Successfully!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Job')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Channel Name', _channelNameController),
              _buildTextField('Channel URL', _channelURLController),
              _buildDropdown('Category', categories, _category, (value) => setState(() => _category = value!)),
              _buildTextField('Subscribers Count', _subscribersController, isNumber: true),
              _buildTextField('Total Views', _totalViewsController, isNumber: true),
              _buildTextField('Total Videos', _totalVideosController, isNumber: true),
              SwitchListTile(
                title: const Text('Monetized'),
                value: _isMonetized,
                onChanged: (value) => setState(() => _isMonetized = value),
              ),
              _buildTextField('Price (USD)', _priceController, isNumber: true),
              CheckboxListTile(
                title: const Text('Negotiable'),
                value: _isNegotiable,
                onChanged: (value) => setState(() => _isNegotiable = value!),
              ),
              _buildDropdown('Reason for Selling', sellingReasons, _reasonForSelling, (value) => setState(() => _reasonForSelling = value!)),
              _buildTextField('Description', _descriptionController, maxLines: 3),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Post Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        validator: (value) => value!.isEmpty ? 'This field is required' : null,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String selectedValue, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        value: selectedValue,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

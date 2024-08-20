import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormbpePage extends StatefulWidget {
  @override
  _FormbpePageState createState() => _FormbpePageState();
}

class _FormbpePageState extends State<FormbpePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  String _selectedProduct = 'Bawang Putih Ecer';
  String _selectedPrice = 'Rp 28.000';
  int _totalPrice = 0;

  final firebaseUrl =
      'https://panenbawang-c0c9b-default-rtdb.asia-southeast1.firebasedatabase.app/form.json';

  void _calculateTotal() {
    int price =
        int.tryParse(_selectedPrice.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    setState(() {
      _totalPrice = price * quantity;
    });
  }

  void _submitOrder() async {
    if (_formKey.currentState?.validate() ?? false) {
      final order = {
        'name': _nameController.text,
        'contact': _contactController.text,
        'address': _addressController.text,
        'product': _selectedProduct,
        'price': _selectedPrice,
        'quantity': _quantityController.text,
        'total': _totalPrice.toString(),
        'order_time': DateTime.now().toIso8601String(),
      };

      try {
        final response = await http.post(
          Uri.parse(firebaseUrl),
          body: json.encode(order),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Order submitted successfully!')),
          );
          _formKey.currentState?.reset();
          setState(() {
            _totalPrice = 0;
            _selectedProduct = '';
            _selectedPrice = '';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to submit order: ${response.reasonPhrase}')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit order: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Contact'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact information';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _selectedProduct,
                decoration: InputDecoration(labelText: 'Product'),
                enabled: false,
              ),
              TextFormField(
                initialValue: _selectedPrice,
                decoration: InputDecoration(labelText: 'Price'),
                enabled: false,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
                onChanged: (value) => _calculateTotal(),
              ),
              TextFormField(
                initialValue: _totalPrice.toString(),
                decoration: InputDecoration(labelText: 'Total'),
                enabled: false,
              ),
              TextFormField(
                initialValue: DateTime.now().toIso8601String(),
                decoration: InputDecoration(labelText: 'Order Time'),
                enabled: false,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitOrder,
                child: Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final String firebaseUrl =
      'https://panenbawang-c0c9b-default-rtdb.asia-southeast1.firebasedatabase.app/form.json';
  List<Map<String, dynamic>> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(firebaseUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> loadedOrders = [];
        data.forEach((key, value) {
          loadedOrders.add({
            'id': key,
            ...value,
          });
        });
        setState(() {
          _orders = loadedOrders;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch orders: $error')),
      );
    }
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        alignment: Alignment.center,
        height: 150.0,
        decoration: BoxDecoration(
          color: Color(0xFFF5DCD5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Name: ${order['name']}',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Text('Contact: ${order['contact']}'),
              Text('Product: ${order['product']}'),
              Text('Quantity: ${order['quantity']}'),
              Text('Total: ${order['total']}'),
              Text('Order Time: ${order['order_time']}'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  return _buildOrderItem(_orders[index]);
                },
              ),
            ),
    );
  }
}

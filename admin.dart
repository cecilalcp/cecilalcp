import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Order {
  String id;
  String productId;
  int quantity;
  String status;

  Order({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.status,
  });

  factory Order.fromFirebase(Map<String, dynamic> data, String id) {
    return Order(
      id: id,
      productId: data['productId'],
      quantity: data['quantity'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'productId': productId,
      'quantity': quantity,
      'status': status,
    };
  }
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final String firebaseUrl =
      'https://panenbawang-c0c9b-default-rtdb.asia-southeast1.firebasedatabase.app/form.json';
  List<Order> _orders = [];
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
        final List<Order> loadedOrders = data.entries
            .map((entry) => Order.fromFirebase(entry.value, entry.key))
            .toList();
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

  Widget _buildOrderItem(Order order) {
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
                'Order ID: ${order.id}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Product ID: ${order.productId}'),
              Text('Quantity: ${order.quantity}'),
              Text('Status: ${order.status}'),
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
        title: Text('Order History'),
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

class OrderProvider with ChangeNotifier {
  final String firebaseUrl =
      'https://panenbawang-c0c9b-default-rtdb.asia-southeast1.firebasedatabase.app/form.json';

  List<Order> _orders = [];

  List<Order> get orders => _orders;

  OrderProvider() {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final response = await http.get(Uri.parse(firebaseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      _orders = data.entries
          .map((entry) => Order.fromFirebase(entry.value, entry.key))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load orders from Firebase Realtime Database');
    }
  }

  Future<void> updateOrderStatusRealtime(
      String orderId, String newStatus) async {
    final order = _orders.firstWhere((order) => order.id == orderId);
    order.status = newStatus;

    final response = await http.patch(
      Uri.parse('$firebaseUrl/$orderId.json'),
      body: json.encode({'status': newStatus}),
    );

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception(
          'Failed to update order status in Firebase Realtime Database');
    }
  }
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, _) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFC23F4F),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Orders',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (context, index) {
                    final order = orderProvider.orders[index];
                    return ListTile(
                      title: Text('Order ID: ${order.id}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Product: ${order.productId} - Quantity: ${order.quantity}'),
                          Text('Status: ${order.status}'),
                          DropdownButton<String>(
                            value: order.status,
                            items: ['dikemas', 'dikirim', 'selesai']
                                .map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                            onChanged: (String? newStatus) {
                              if (newStatus != null) {
                                orderProvider.updateOrderStatusRealtime(
                                    order.id, newStatus);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle logout
                  },
                  child: Text('Logout', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC23F4F),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

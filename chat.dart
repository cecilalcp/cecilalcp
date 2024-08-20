import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  void _launchWhatsApp(BuildContext context) async {
    const phoneNumber = '6283879351722';
    final url = 'https://wa.me/$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal membuka WhatsApp'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _launchWhatsApp(context);
          },
          child: Text('Chat via WhatsApp'),
        ),
      ),
    );
  }
}

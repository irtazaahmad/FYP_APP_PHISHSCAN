import 'package:flutter/material.dart';
import 'main.dart';

class ManualEditorScreen extends StatefulWidget {
  @override
  _ManualEditorScreenState createState() => _ManualEditorScreenState();
}

class _ManualEditorScreenState extends State<ManualEditorScreen> {
  int _selectedIndex = 1;
  final TextEditingController _messageController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  void _checkForPhishing() {
    final message = _messageController.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Phishing Check'),
        content: Text('Message: $message\n\n(Detection logic pending...)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade300,
        title: Text(
          'SMS Phishing Detector',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter message here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue.shade300,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: _checkForPhishing,
              child: Text(
                'Check',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.lightBlue.shade300,
        child: Row(
          children: [
            _buildNavItem(
              icon: Icons.inbox,
              label: 'Inbox',
              index: 0,
            ),
            _buildNavItem(
              icon: Icons.edit,
              label: 'Manual Editor',
              index: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      {required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Container(
          color: isSelected
              ? Colors.lightBlue.shade100
              : Colors.lightBlue.shade300,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.black),
              Text(
                label,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

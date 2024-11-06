import 'package:flutter/material.dart';
import 'manual_editor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ManualEditorScreen()),
      );
    }
  }

  bool _isPhishingMessage(int index) {
    // Simple check: mark messages with even indices as phishing
    return index % 2 == 0;
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
      body: ListView.builder(
        itemCount: 20, // Increase the number of items to demonstrate scrolling
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.message, color: Colors.lightBlue),
              title: Text(
                'Sender ${index + 1}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('Sample message content for message ${index + 1}.'),
              trailing: _isPhishingMessage(index)
                  ? Icon(
                      Icons.error, // Warning icon for phishing messages
                      color: Colors.redAccent,
                      size: 24,
                    )
                  : SizedBox(width: 24), // Space to align with warning icons
            ),
          );
        },
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

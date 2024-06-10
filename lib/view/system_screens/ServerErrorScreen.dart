import 'package:flutter/material.dart';

class ServerErrorScreen extends StatelessWidget {
  const ServerErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Server error illustration (modern image from the internet)
            Image.network(
              'https://i.imgur.com/z2GmqvT.png',
              width: 300,
            ),
            SizedBox(height: 20),
            // Error message
            Text(
              '500 - Server Error',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Sorry, something went wrong on our server.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            // Retry button
            ElevatedButton.icon(
              onPressed: () {
                // Implement retry logic here
              },
              icon: Icon(Icons.refresh),
              label: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

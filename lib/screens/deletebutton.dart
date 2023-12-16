// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'deletebook.dart'; // Import the file where DeleteButton is defined

class YourPage extends StatelessWidget {
  const YourPage({super.key});
  @override
  Widget build(BuildContext context) {
    // Obtain the CookieRequest instance from the context
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Other widgets

            // Example of using DeleteButton in a button
            ElevatedButton(
              onPressed: () {
                // Assuming you have the bookId available
                int bookId = 123; // Replace with the actual book ID

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Confirm Deletion"),
                      content: Text("Are you sure you want to delete this book?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel"),
                        ),
                        // Use DeleteButton with the request obtained from the context
                        DeleteButton(bookId: bookId, request: request),
                      ],
                    );
                  },
                );
              },
              child: Text("Delete Book"),
            ),
          ],
        ),
      ),
    );
  }
}

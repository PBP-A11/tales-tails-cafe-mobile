// delete_button.dart
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class DeleteButton extends StatelessWidget {
  final int bookId;
  final CookieRequest request;

  const DeleteButton({super.key, required this.bookId, required this.request});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
      ),
      onPressed: () async {
        // Logic for deleting a book
        final response = await request.postJson(
          "https://talesandtailscafe-a11-tk.pbp.cs.ui.ac.id/catalog/delete-book-flutter/$bookId/",
          '{}', // An empty request body for delete requests
        );

        if (response['message'] == 'Data deleted successfully') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Buku berhasil dihapus!"),
          ));
          // Optionally, you can update the UI or navigate to a different screen
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Terdapat kesalahan, silakan coba lagi."),
          ));
        }
      },
      child: const Text(
        "Delete",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

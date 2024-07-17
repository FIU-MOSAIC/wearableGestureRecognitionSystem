import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/results model.dart';
import '../services/user provider.dart';
import 'result detail page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<ExerciseResult>>(
        future: userProvider.fetchAllResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final results = snapshot.data!;
            if (results.isEmpty) {
              return const Center(child: Text('No results available'));
            }
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return ListTile(
                  title: Text(result.exerciseName, style: GoogleFonts.lato(fontSize: 20)),
                  subtitle: Text('${DateFormat('MMM dd, yyyy - h:mm a').format(result.testDate)}', style: GoogleFonts.lato(fontSize: 16)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultDetailPage(result: result),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No results available'));
          }
        },
      ),
    );
  }
}

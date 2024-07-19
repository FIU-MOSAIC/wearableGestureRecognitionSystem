import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gesture_detection/services/user provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'result detail page.dart';
import '../services/results model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('History'),
      ),
      body: FutureBuilder<List<ExerciseResult>>(
        future: userProvider.fetchAllResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
            var results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var result = results[index];
                return ListTile(
                  title: Text(result.exerciseName, style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(DateFormat('MMM dd, yyyy - h:mm a').format(result.testDate)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResultDetailPage(result: result)));
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No results available', style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.bold)));
          }
        },
      ),
    );
  }
}

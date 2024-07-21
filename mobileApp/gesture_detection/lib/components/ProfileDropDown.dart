import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDropDown extends StatelessWidget {
  final Function(String?) onGenderChanged;
  final Function(String?) onFeetChanged;
  final Function(String?) onInchesChanged;
  final Function(String?) onImpairmentChanged;
  final String? genderHint;
  final String? feetHint;
  final String? inchesHint;
  final String? impairmentHint;

  const ProfileDropDown({
    super.key,
    required this.onGenderChanged,
    required this.onFeetChanged,
    required this.onInchesChanged,
    required this.onImpairmentChanged,
    this.genderHint,
    this.feetHint,
    this.inchesHint,
    this.impairmentHint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0),
                child: Text(
                  'Gender',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: genderHint ?? 'Select your gender',
                    hintStyle: GoogleFonts.lato(color: Colors.black),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  items: <String>['Male', 'Female', 'Non-binary', 'Prefer not to say'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(color: Colors.black),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    onGenderChanged(newValue);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0),
                child: Text(
                  'Height',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: feetHint ?? 'ft',
                    hintStyle: GoogleFonts.lato(color: Colors.black),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  items: <String>['0', '1', '2', '3', '4', '5', '6', '7', '8'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(color: Colors.black),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    onFeetChanged(newValue);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: inchesHint ?? 'in',
                    hintStyle: GoogleFonts.lato(color: Colors.black),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  items: <String>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    onInchesChanged(newValue);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0),
                child: Text(
                  'Impairment',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[600]),
                ),
              ),
            ),
            const SizedBox(width: 40),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: impairmentHint ?? 'Select your impairment',
                    hintStyle: GoogleFonts.lato(color: Colors.black),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  items: <String>['Stroke', 'Parkinson\'s Disease', 'Cerebral Palsy', 'Multiple Sclerosis', 'Arthritis', 'Other'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    onImpairmentChanged(newValue);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

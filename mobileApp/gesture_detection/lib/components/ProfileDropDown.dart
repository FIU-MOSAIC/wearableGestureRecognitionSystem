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
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0), // padding for the gender label
                child: Text(
                  'Gender',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40), // space between the label and the dropdown
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // padding for the gender dropdown
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: genderHint ?? 'Select your gender', // hint text for the gender dropdown
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
                    onGenderChanged(newValue); // handle gender change
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10), // space between rows
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0), // padding for the height label
                child: Text(
                  'Height',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40), // space between the label and the dropdowns
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0), // padding for the feet dropdown
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: feetHint ?? 'ft', // hint text for the feet dropdown
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
                    onFeetChanged(newValue); // handle feet change
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // padding for the inches dropdown
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: inchesHint ?? 'in', // hint text for the inches dropdown
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
                    onInchesChanged(newValue); // handle inches change
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10), // space between rows
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0), // padding for the impairment label
                child: Text(
                  'Impairment',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[600]),
                ),
              ),
            ),
            const SizedBox(width: 40), // space between the label and the dropdown
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0), // padding for the impairment dropdown
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: impairmentHint ?? 'Select your impairment', // hint text for the impairment dropdown
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
                    onImpairmentChanged(newValue); // handle impairment change
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

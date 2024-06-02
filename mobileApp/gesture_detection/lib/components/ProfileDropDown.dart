import 'package:flutter/material.dart';

class GenderPicker extends StatefulWidget {
  const GenderPicker({super.key});

  @override
  State<GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Text(
              'Gender',
              style: TextStyle(
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
              value: selectedGender,
              decoration: InputDecoration(
                hintText: 'Select your gender',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
              ),
              items: <String>['Male', 'Female', 'Non-binary', 'Prefer not to say'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
              isExpanded: true,
            ),
          ),
        ),
      ],
    );
  }
}

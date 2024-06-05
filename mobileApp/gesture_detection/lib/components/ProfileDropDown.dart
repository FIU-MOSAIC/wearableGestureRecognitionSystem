import 'package:flutter/material.dart';

class ProfileDropDown extends StatefulWidget {
  final Function(String?) onGenderChanged;
  final Function(String?) onFeetChanged;
  final Function(String?) onInchesChanged;
  final Function(String?) onImpairmentChanged;
  final String? initialGender;
  final String? initialFeet;
  final String? initialInches;
  final String? initialImpairment;

  const ProfileDropDown({
    super.key,
    required this.onGenderChanged,
    required this.onFeetChanged,
    required this.onInchesChanged,
    required this.onImpairmentChanged,
    this.initialGender,
    this.initialFeet,
    this.initialInches,
    this.initialImpairment,
  });

  @override
  State<ProfileDropDown> createState() => _ProfileDropDownState();
}

class _ProfileDropDownState extends State<ProfileDropDown> {
  String? selectedGender;
  String? selectedFeet;
  String? selectedInches;
  String? selectedImpairment;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialGender;
    selectedFeet = widget.initialFeet;
    selectedInches = widget.initialInches;
    selectedImpairment = widget.initialImpairment;
  }

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
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                  items: <String>['Male', 'Female', 'Non-binary', 'Prefer not to say'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.grey[600]),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                    widget.onGenderChanged(newValue);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0),
                child: Text(
                  'Height',
                  style: TextStyle(
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
                  value: selectedFeet,
                  decoration: InputDecoration(
                    hintText: 'ft',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                  items: <String>['0', '1', '2', '3', '4', '5', '6', '7', '8'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.grey[600]),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFeet = newValue;
                    });
                    widget.onFeetChanged(newValue);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: DropdownButtonFormField<String>(
                  value: selectedInches,
                  decoration: InputDecoration(
                    hintText: 'in',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                  items: <String>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.grey[600]),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedInches = newValue;
                    });
                    widget.onInchesChanged(newValue);
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0),
                child: Text(
                  'Impairment',
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
                  value: selectedImpairment,
                  decoration: InputDecoration(
                    hintText: 'Select your impairment',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                 items: <String>['Stroke', 'Parkinson\'s Disease', 'Cerebral Palsy', 'Multiple Sclerosis', 'Arthritis', 'Other'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.grey[600]),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedImpairment = newValue;
                    });
                    widget.onImpairmentChanged(newValue);
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

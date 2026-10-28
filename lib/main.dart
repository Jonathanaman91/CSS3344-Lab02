import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedHouse = 'Slytherin';

  final List<String> _houses = [
    'Gryffindor',
    'Slytherin',
    'Ravenclaw',
    'Hufflepuff'
  ];

  // 1. Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 2. Cupertino Date Picker (Modal Sheet)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() => _selectedDate = newDate);
                },
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  // 3. Cupertino Wheel Picker (Modal Sheet)
  void _showCupertinoHousePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            SizedBox(
              height: 190,
              child: CupertinoPicker(
                itemExtent: 32,
                scrollController: FixedExtentScrollController(
                  initialItem: _houses.indexOf(_selectedHouse),
                ),
                onSelectedItemChanged: (int index) {
                  setState(() => _selectedHouse = _houses[index]);
                },
                children: _houses.map((h) => Center(child: Text(h))).toList(),
              ),
            ),
            CupertinoButton(
              child: const Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  Widget _buildPickersSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Selected Date: ${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Selected House: $_selectedHouse',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // Material Date Picker Button
            ElevatedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Material Date Picker'),
            ),
            const SizedBox(height: 8),

            // Cupertino Date Picker Button
            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(CupertinoIcons.calendar),
              label: const Text('Cupertino Date Picker (Modal Sheet)'),
            ),
            const Divider(height: 24),

            // Material Dropdown
            Row(
              children: [
                const Text('Material Dropdown: '),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedHouse,
                  items: _houses.map((String house) {
                    return DropdownMenuItem<String>(
                      value: house,
                      child: Text(house),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedHouse = newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Cupertino House Wheel Picker Button
            OutlinedButton.icon(
              onPressed: () => _showCupertinoHousePicker(context),
              icon: const Icon(CupertinoIcons.list_bullet),
              label: const Text('Cupertino House Wheel Picker'),
            ),
          ],
        ),
      ),
    );
  }

  // Portrait Mode
  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Card(
          color: Colors.indigo[600],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpeg'),
                ),
                SizedBox(height: 20),
                Text(
                  'JONATHAN AMAN ANAK ADIN',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Student ID: BCS25020021',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                Divider(height: 32, thickness: 1, color: Colors.white24),
                Text(
                  'Personal Life Goal / Quote:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '"ABLE TO TRAVEL AROUND THE WORLD"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const TitleSection(
          name: 'Hogwarts School of Witchcraft and Wizardry',
          location: 'Hogsmeade, Scotland',
          starCount: 41,
        ),
        const SizedBox(height: 16),
        const ImageSection(imagePath: 'assets/background.jpg'),
        const SizedBox(height: 16),
        _buildPickersSection(),
      ],
    );
  }

  // Landscape Mode
  Widget _buildLandscapeView() {
    return Row(
      children: [
        const Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: ImageSection(imagePath: 'assets/background.jpg'),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                color: Colors.indigo[600],
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/profile.jpeg'),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'JONATHAN AMAN ANAK ADIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Student ID: BCS25020021',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      Divider(height: 24, thickness: 1, color: Colors.white24),
                      Text(
                        '"ABLE TO TRAVEL AROUND THE WORLD"',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const TitleSection(
                name: 'Hogwarts School of Witchcraft and Wizardry',
                location: 'Hogsmeade, Scotland',
                starCount: 41,
              ),
              const SizedBox(height: 16),
              _buildPickersSection(),
            ],
          ),
        ),
      ],
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: TextStyle(color: Colors.indigo[300]),
              ),
            ],
          ),
        ),
        Icon(Icons.star, color: Colors.indigo[400]),
        const SizedBox(width: 4),
        Text('$starCount'),
      ],
    );
  }
}
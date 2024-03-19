import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blood Pressure Classifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputScreen(),
      debugShowCheckedModeBanner: false, // Remove debug banner
    );
  }
}

class InputScreen extends StatelessWidget {
  final TextEditingController systolicController = TextEditingController();
  final TextEditingController diastolicController = TextEditingController();

  InputScreen({Key? key}) : super(key: key);

  void validateAndNavigate(BuildContext context) {
    int systolic = int.tryParse(systolicController.text) ?? 0;
    int diastolic = int.tryParse(diastolicController.text) ?? 0;

    if (systolic >= 75 &&
        systolic <= 147 &&
        diastolic >= 50 &&
        diastolic <= 91) {
      Get.to(InfoScreen(systolic: systolic, diastolic: diastolic));
    } else {
      Get.defaultDialog(
        title: "Invalid Data",
        content: const Text("Please enter valid blood pressure values."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blood Pressure Monitor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: systolicController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Input Your Systolic Blood Pressure '),
            ),
            TextField(
              controller: diastolicController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Input Your Diastolic Blood Pressure'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => validateAndNavigate(context),
              child: const Text('Show info'),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  final int systolic;
  final int diastolic;

  const InfoScreen({Key? key, required this.systolic, required this.diastolic}) : super(key: key);

  String getCategory() {
    if (systolic < 120 && diastolic < 80) {
      return 'Normal';
    } else if (systolic >= 120 && systolic < 130 && diastolic < 80) {
      return 'Elevated';
    } else if (systolic >= 130 && systolic < 140 || diastolic >= 80 && diastolic < 90) {
      return 'Hypertension Stage 1';
    } else if (systolic >= 140 || diastolic >= 90) {
      return 'Hypertension Stage 2';
    } else {
      return 'Hypertensive crisis';
    }
  }

  String getInformation(String category) {
    switch (category) {
      case 'Normal':
        return 'Blood pressure numbers of less than 120/80 mm Hg (millimeters of mercury) are considered within the normal range.';
      case 'Elevated':
        return 'Elevated blood pressure is when readings consistently range from 120-129 systolic and less than 80 mm Hg diastolic.';
      case 'Hypertension Stage 1':
        return 'Hypertension Stage 1 is when blood pressure consistently ranges from 130 to 139 systolic or 80 to 89 mm Hg diastolic.';
      case 'Hypertension Stage 2':
        return 'Hypertension Stage 2 is when blood pressure consistently is 140/90 mm Hg or higher.';
      case 'Hypertensive crisis':
        return 'This stage of high blood pressure requires medical attention.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    String category = getCategory();
    String information = getInformation(category);

    return Scaffold(
      appBar: AppBar(title: const Text('Category Information')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Category: $category',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              information,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

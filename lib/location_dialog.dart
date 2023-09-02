import 'package:flutter/material.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 300,
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 187, 187, 187),
                    width: 1,
                  ),
                ),
                child: Image.asset(
                  'assets/image/fakemap.png',
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            )),
            const SizedBox(height: 16),
            const Text(
              'Gunakan Lokasi Ini?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 81, 7),
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(
                      context, true); // true berarti "Gunakan Lokasi Ini"
                },
                child: const Text('Ya, Gunakan Lokasi ini'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

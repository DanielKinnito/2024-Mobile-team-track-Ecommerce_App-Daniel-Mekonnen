import 'package:flutter/material.dart';

class SizeWidget extends StatefulWidget {
  const SizeWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SizeWidgetState createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> {
  int _selectedSize = 37;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size:',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [38, 39, 40, 41, 42, 43, 44, 45].map((size) {
              print('Creating ChoiceChip for size $size');
              return ChoiceChip(
                backgroundColor: Colors.white,
                shadowColor: Colors.red,
                label: Text(
                  '$size',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedSize == size ? Colors.white : Colors.black,
                  ),
                ),
                selected: _selectedSize == size,
                showCheckmark: false,
                selectedColor: const Color.fromARGB(255, 54, 104, 255),
                onSelected: (selected) {
                  setState(() {
                    _selectedSize = size;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Colors.transparent),
                ),
                labelPadding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

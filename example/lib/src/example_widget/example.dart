import 'package:flutter/material.dart';

import 'widgets/curve_panel.dart';

class CurveExample extends StatefulWidget {
  const CurveExample({Key? key}) : super(key: key);

  @override
  State<CurveExample> createState() => _CurveExampleState();
}

class _CurveExampleState extends State<CurveExample> {
  late CurveType _selectedMenu = CurveType.spring;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          _buildCurveSelector(),
          CurvePanel(curveType: _selectedMenu, key: ValueKey(_selectedMenu))
        ],
      ),
    );
  }

  Widget _buildCurveSelector() {
    return DropdownButton<CurveType>(
      value: _selectedMenu,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      icon: const SizedBox.shrink(),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (curveMenu) {
        setState(() {
          _selectedMenu = curveMenu!;
        });
      },
      items:
          CurveType.values.map<DropdownMenuItem<CurveType>>((CurveType value) {
        return DropdownMenuItem<CurveType>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}

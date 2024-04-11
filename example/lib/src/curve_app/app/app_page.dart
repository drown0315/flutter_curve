import 'package:flutter/material.dart';

import '../widgets/curve_panel.dart';

class CurveExampleAppPage extends StatefulWidget {
  const CurveExampleAppPage({Key? key}) : super(key: key);

  @override
  State<CurveExampleAppPage> createState() => _CurveExampleAppPageState();
}

class _CurveExampleAppPageState extends State<CurveExampleAppPage> {
  late CurveType _selectedMenu = CurveType.spring;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Flutter curve'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  _buildCurveSelector(),
                  CurvePanel(
                      curveType: _selectedMenu, key: ValueKey(_selectedMenu)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurveSelector() {
    return DropdownButton<CurveType>(
      value: _selectedMenu,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      dropdownColor: Colors.white,
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

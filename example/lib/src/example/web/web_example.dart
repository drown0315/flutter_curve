import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import '../../style.dart';
import '../widgets/curve_panel.dart';

part 'ui/title_bar.dart';

part 'ui/title.dart';

class CurveWebExamplePage extends StatefulWidget {
  const CurveWebExamplePage({super.key});

  @override
  State<CurveWebExamplePage> createState() => _CurveWebExamplePageState();
}

class _CurveWebExamplePageState extends State<CurveWebExamplePage> {
  late CurveType _selectedMenu = CurveType.spring;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            const _TitleBar(),
            _buildDivider(),
            const SizedBox(height: SizeConstant.m),
            const _Title(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildCurveSelector(),
                CurvePanel(
                    curveType: _selectedMenu, key: ValueKey(_selectedMenu))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Builder(builder: (context) {
      return Container(
        width: MediaQuery.sizeOf(context).width,
        height: 0.3,
        color: Colors.grey,
      );
    });
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
      focusColor: Colors.transparent,
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

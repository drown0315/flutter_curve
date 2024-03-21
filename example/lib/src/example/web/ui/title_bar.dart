part of '../web_example.dart';

class _TitleBar extends StatelessWidget {
  const _TitleBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDocumentation(),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentation() {
    return Link(
      target: LinkTarget.blank,
      uri: Uri.tryParse('https://github.com/drown0315/flutter_curve'),
      builder: (BuildContext context, Future<void> Function()? followLink) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: followLink,
            child: const Text(
              'Documentation',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple),
            ),
          ),
        );
      },
    );
  }
}

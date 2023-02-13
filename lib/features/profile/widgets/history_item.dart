import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ozare/models/history.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.history,
  });

  final History history;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.245,
              child: AutoSizeText(
                history.team1,
                maxFontSize: 12,
                minFontSize: 8,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/images/logo1.png'),
            ),
            const SizedBox(width: 8),
            const Text(
              "VS",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/images/logo2.png'),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: size.width * 0.245,
              child: AutoSizeText(
                history.team2,
                maxFontSize: 12,
                minFontSize: 8,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              height: 32,
              width: 52,
              decoration: BoxDecoration(
                color: getColor(history.won).withOpacity(0.1),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Text(
                  getStatus(history.won),
                  style: TextStyle(
                    color: getColor(history.won),
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  Color getColor(int status) {
    switch (status) {
      case 0:
        return Colors.grey;
      case 1:
        return const Color(0xFF00BA88);
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatus(int status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Won';
      case 2:
        return 'Lost';
      default:
        return 'Pending';
    }
  }
}

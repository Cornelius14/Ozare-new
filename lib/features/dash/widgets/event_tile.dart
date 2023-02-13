import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ozare/consts.dart';

import 'package:ozare/models/models.dart';

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(
            'assets/images/bg.png',
          ),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.hardLight),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primary2Color.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  event.logo1,
                  height: size.height * 0.07,
                ),
                const SizedBox(height: 2),
                SizedBox(
                  height: size.height * 0.04,
                  child: AutoSizeText(
                    event.team1,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              if (event.score1 != '')
                Text(
                  "${event.score1} : ${event.score2}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              Text(
                event.score1 != ''
                    ? '${event.time}`'
                    : DateFormat.yMd().format(DateTime.parse(event.time)),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(
            width: size.width * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  event.logo2,
                  height: size.height * 0.07,
                ),
                const SizedBox(height: 2),
                SizedBox(
                  height: size.height * 0.04,
                  child: AutoSizeText(
                    event.team2,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

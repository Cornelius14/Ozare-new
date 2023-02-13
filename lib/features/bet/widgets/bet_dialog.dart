import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/consts.dart';
import 'package:ozare/features/bet/bloc/bet_bloc.dart';
import 'package:ozare/features/bet/models/bet.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/models/models.dart';
import 'package:uuid/uuid.dart';

/// Input Dialog to get the bet amount and the team
class BetDialog extends StatefulWidget {
  const BetDialog({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<BetDialog> createState() => _BetDialogState();
}

class _BetDialogState extends State<BetDialog> {
  final betController = TextEditingController();

  @override
  void dispose() {
    betController.dispose();
    super.dispose();
  }

  var selectedTeam = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = context.read<ProfileBloc>().state.user;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: size.height * 0.48,
        width: size.width * 0.8,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Place a Bet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Text(
              'Select the winning team you want to bet on!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTeam = 0;
                    });
                  },
                  child: TeamTile(
                    teamName: widget.event.team1,
                    isSelected: selectedTeam == 0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTeam = 1;
                    });
                  },
                  child: TeamTile(
                    teamName: widget.event.team2,
                    isSelected: selectedTeam == 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Enter the number of tokens you want to bet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  height: 50,
                  width: size.width * 0.5,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: TextField(
                      controller: betController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'enter number of tokens',
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('x'),
                ),
                Image.asset(
                  'assets/images/token.png',
                  height: 32,
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.read<BetBloc>().add(
                      BetCreated(
                        Bet(
                          id: const Uuid().v4(),
                          userId: user!.uid!,
                          userName: user.firstName,
                          status: 'Pending',
                          tokens: betController.text,
                          result: 'Pending',
                          createdAt: DateTime.now().toUtc(),
                          betTeamId: selectedTeam == 0
                              ? widget.event.id1
                              : widget.event.id2,
                          eventId: widget.event.id,
                        ),
                        widget.event,
                      ),
                    );
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: const BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Place a Bet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// team tile
class TeamTile extends StatelessWidget {
  const TeamTile({
    super.key,
    required this.teamName,
    required this.isSelected,
  });

  final String teamName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 120,
      decoration: BoxDecoration(
        color: isSelected ? primary1Color : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Center(
        child: AutoSizeText(
          teamName,
          textAlign: TextAlign.center,
          maxFontSize: 12,
          minFontSize: 8,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

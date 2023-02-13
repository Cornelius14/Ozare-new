import 'package:flutter/material.dart';

final List<Map<String, dynamic>> wallets = [
  {
    'name': "Wallet",
    'iconPath': "assets/images/wallet.png",
  },
  {
    'name': "TON Wallet",
    'iconPath': "assets/images/tonwallet.png",
  },
  {
    'name': "Tonkeeper",
    'iconPath': "assets/images/tonkeeper.png",
  },
  {
    'name': "Coin98",
    'iconPath': "assets/images/coin98.png",
  },
];

class AddWallet extends StatelessWidget {
  const AddWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Add New Wallet',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Which Wallet\nyou want to add?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: wallets
                  .map(
                    (wallet) => WalletSelector(
                      name: wallet['name'],
                      iconPath: wallet['iconPath'],
                    ),
                  )
                  .toList(),
            ),
          ),
        ]),
      ),
    );
  }
}

class WalletSelector extends StatelessWidget {
  const WalletSelector({
    super.key,
    required this.name,
    required this.iconPath,
  });

  final String name;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 0,
          child: Container(
            width: size.width * 0.4,
            height: size.width * 0.28,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          child: Image.asset(
            iconPath,
            height: size.width * 0.24,
          ),
        ),
      ],
    );
  }
}

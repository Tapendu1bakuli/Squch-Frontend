import 'package:flutter/cupertino.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({super.key});

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(
        child: Text("Wallet"),
      ),
    );
  }
}

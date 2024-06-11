import 'package:flutter/cupertino.dart';

class InboxTab extends StatefulWidget {
  const InboxTab({super.key});

  @override
  State<InboxTab> createState() => _InboxTabState();
}

class _InboxTabState extends State<InboxTab> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(
        child: Text("Inbox"),
      ),
    );
  }
}

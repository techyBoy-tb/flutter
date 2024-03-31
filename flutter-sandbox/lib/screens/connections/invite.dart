import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('INVITE'),
        OutlinedButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(
                text: 'This will be the code copeid!! \n NEW LINE?'));
          },
          child: Text('COPY'),
        ),
        OutlinedButton(
          onPressed: () async {
            Share.share(
              "Hey! Connect with me on MediaHookup!",
            );
            // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          },
          child: Text('SHARE'),
        ),
      ],
    );
  }
}

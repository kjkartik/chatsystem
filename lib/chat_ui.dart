// import 'package:flutter/material.dart';
//
// class Chatui extends StatefulWidget {
//   const Chatui({Key? key}) : super(key: key);
//
//   @override
//   _ChatuiState createState() => _ChatuiState();
// }
//
// class _ChatuiState extends State<Chatui> {
//   var chatController =TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat'),),
//       body: Container(child: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: TextFormField(controller:chatController ,),
//       ),),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future<void> main() async {
  const apiKey = "3u9cdranjdmg";
  const userToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicm9iZXJ0YnJ1bmhhZ2UifQ.5bYlaBFJ8w-_zSh3pgFPUVVlJNtiVKdz8F1clUhF8Dg";

  final client = StreamChatClient(
    apiKey,
    logLevel: Level.INFO,
  );

  await client.connectUser(
    User(
      id: 'ro',
      extraData: {
        'image': 'https://robertbrunhage.com/logo.png',
      },
    ),
    userToken,
  );
  final channel = client.channel(
    'messaging',
    id: 'co',
    extraData: {
      "name": " Kids",
      "image": "https://robertbrunhage.com/logo.png",
    },
  );

  /// `.watch()` is used to create and listen to the channel for updates. If the
  /// channel already exists, it will simply listen for new events.
  channel.watch();

  runApp(MyApp(client, channel));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;
  MyApp(this.client, this.channel);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.dark().copyWith(
      accentColor: Color(0xffc34c4c),
    );
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          child: widget,
          client: client,
          streamChatThemeData: StreamChatThemeData.fromTheme(theme),
        );
      },
      home: StreamChannel(
        channel: channel,
        child: ChannelPage(),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(
        showBackButton: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
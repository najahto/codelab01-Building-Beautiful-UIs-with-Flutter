import 'package:flutter/material.dart';
import 'package:flutterapp/chat_message.dart';

class ChatScreen extends StatefulWidget{
   @override
  State createState() => new ChatScreenState();

}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }
  Widget _textComposerWidget(){
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
      margin: const EdgeInsets.symmetric(horizontal:8.0 ) ,
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
            decoration: new InputDecoration.collapsed(hintText: "Send a message"),
            controller: _textController,
            onSubmitted: _handleSubmitted,
          )
          ),
          new Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: new Icon(Icons.send),
              onPressed: ()=> _handleSubmitted(_textController.text),
            ),
          )
        ],
      ),
    ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Flexible(
          child: ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_,int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(height: 1.0,),
        new Container(
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _textComposerWidget(),
        )
      ],
    );
  }
  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}
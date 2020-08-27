import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/contact/contact_bloc.dart';
import 'package:trashtagApp/src/bloc/home/home_bloc.dart';
import 'package:trashtagApp/src/models/user_message.dart';
import 'package:trashtagApp/src/stream_controllers/contact/contact_stream_controller.dart';
import 'package:trashtagApp/src/widgets/trashtag_button.dart';
import 'package:trashtagApp/src/widgets/trashtag_container.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _controller = ContactController();

  void _onSendButton(BuildContext context) {
    final UserMessage message = UserMessage(
      subject: _controller.subject,
      message: _controller.message,
    );
    BlocProvider.of<ContactBloc>(context).add(
      SendMessageButtonPressed(message: message),
    );
  }

  void _listener(BuildContext contex, ContactState state) {
    if (state is SendMessageSuccess) {
      final provider = BlocProvider.of<HomeBloc>(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return _successAlert(context, provider);
        },
      );
    }
  }

  void _goToHome(BuildContext context, HomeBloc provider) {
    Navigator.of(context).pop();
    provider.add(
      HomeButtonPressed(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) => _listener(context, state),
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              _background(context),
              _foreground(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _background(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).backgroundColor,
          height: 270.0,
        ),
      ],
    );
  }

  Widget _foreground(BuildContext context, ContactState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TrashTagContainer(
        child: Column(
          children: <Widget>[
            SizedBox(height: 80.0),
            _title(),
            SizedBox(height: 40.0),
            _form(state),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      children: <Widget>[
        Text(
          'Say hello!',
          style: TextStyle(fontSize: 40.0, color: Colors.white),
        ),
        Text(
          'Contact us by email or leave us your message',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25.0, color: Colors.white),
        ),
      ],
    );
  }

  Widget _form(ContactState state) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            _subject(),
            SizedBox(height: 25.0),
            _message(),
            SizedBox(height: 40.0),
            _sendButton(state),
            SizedBox(height: 20.0),
            _errorText(state),
            _progressIndicator(state),
          ],
        ),
      ),
    );
  }

  Widget _subject() {
    return StreamBuilder<String>(
      stream: _controller.subjectStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your subject',
            errorText: snapshot.error,
          ),
          maxLength: 50,
          onChanged: _controller.changeSubject,
        );
      },
    );
  }

  Widget _message() {
    return StreamBuilder<String>(
      stream: _controller.messageStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter your message',
            errorText: snapshot.error,
          ),
          maxLines: 4,
          maxLength: 200,
          onChanged: _controller.changeMessage,
        );
      },
    );
  }

  Widget _sendButton(ContactState state) {
    return TrashTagButton(
      stream: _controller.validFormStream,
      text: 'SEND MESSAGE',
      function: state is! SendingMessage ? () => _onSendButton(context) : null,
    );
  }

  Widget _errorText(ContactState state) {
    if (state is SendMessageFailed) {
      return Text(
        '${state.error}',
        style: TextStyle(color: Colors.red),
      );
    }
    return Container();
  }

  Widget _progressIndicator(ContactState state) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: (state is SendingMessage) ? CircularProgressIndicator() : null,
    );
  }

  Widget _successAlert(BuildContext context, HomeBloc provider) {
    return AlertDialog(
      title: Text('Thanks!'),
      content: Text('We will send you a message as soon as we can.'),
      actions: <Widget>[
        FlatButton(
          onPressed: () => _goToHome(context, provider),
          child: Text(
            'GO TO MY DASHBOARD',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}

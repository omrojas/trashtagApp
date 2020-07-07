import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trashtagApp/src/bloc/create_organization/create_organization_bloc.dart';
import 'package:trashtagApp/src/bloc/signup/organizer/organizer_signup_bloc.dart';
import 'package:trashtagApp/src/stream_controllers/organization/create_organization_controller.dart';

class CreateOrganizationForm extends StatefulWidget {
  CreateOrganizationForm({Key key}) : super(key: key);

  @override
  _CreateOrganizationFormState createState() => _CreateOrganizationFormState();
}

class _CreateOrganizationFormState extends State<CreateOrganizationForm> {
  final _streamController = CreateOrganizationController();

  void _onSubmitButtonPressed() {
    BlocProvider.of<CreateOrganizationBloc>(context).add(
      SubmitButtonPressed(
        name: _streamController.name,
        area: _streamController.area,
        phone1: _streamController.phone1,
        phone2: _streamController.phone2,
        addres: _streamController.address,
        managerName: _streamController.managerName,
        managerPhone: _streamController.managerPhone,
        managerEmail: _streamController.managerEmail,
      ),
    );
  }

  void _showMessage({
    @required final String message,
    @required Color backgroundColor,
  }) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void _blocListener(context, state) {
    if (state is SubmitFailure) {
      _showMessage(
        message: state.error,
        backgroundColor: Colors.red,
      );
    }
    if (state is SubmitSuccess) {
      _showMessage(
        message: state.message,
        backgroundColor: Theme.of(context).primaryColor,
      );
      _onSubmitSuccess();
    }
  }

  void _onSubmitSuccess() async {
    await Future.delayed(Duration(seconds: 2));
    BlocProvider.of<OrganizerSignUpBloc>(context).add(
      OrganizerSignUpStarted(),
    );
  }

  @override
  void dispose() {
    _streamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrganizationBloc, CreateOrganizationState>(
      listener: _blocListener,
      child: _blocBuilder(),
    );
  }

  Widget _blocBuilder() {
    return BlocBuilder<CreateOrganizationBloc, CreateOrganizationState>(
      builder: (context, state) {
        return _form(state);
      },
    );
  }

  Widget _form(CreateOrganizationState state) {
    return Form(
      child: Column(
        children: <Widget>[
          _organizationInformation(),
          SizedBox(height: 40),
          _managerAccountInformation(),
          SizedBox(height: 60),
          _createOrganizationButton(state),
          _progressIndicator(state),
        ],
      ),
    );
  }

  Widget _organizationInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Organization information',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25),
        _name(),
        SizedBox(height: 25),
        _area(),
        SizedBox(height: 25),
        _phones(),
        SizedBox(height: 25),
        _address(),
      ],
    );
  }

  Widget _phones() {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: (size.width / 2) * .8,
          child: _phone1(),
        ),
        Container(
          width: (size.width / 2) * .8,
          child: _phone2(),
        ),
      ],
    );
  }

  Widget _managerAccountInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Manager contact information',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25.0),
        _managerName(),
        SizedBox(height: 25.0),
        _managerPhone(),
        SizedBox(height: 25.0),
        _managerEmail(),
      ],
    );
  }

  Widget _name() {
    return StreamBuilder<String>(
      stream: _streamController.nameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a name',
            errorText: snapshot.error,
          ),
          onChanged: _streamController.changeName,
        );
      },
    );
  }

  Widget _area() {
    return StreamBuilder<String>(
      stream: _streamController.addressStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter an area',
            errorText: snapshot.error,
          ),
          onChanged: _streamController.changeArea,
        );
      },
    );
  }

  Widget _phone1() {
    return StreamBuilder<String>(
      stream: _streamController.phone1Stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a phone',
            errorText: snapshot.error,
          ),
          maxLength: 10,
          keyboardType: TextInputType.phone,
          onChanged: _streamController.changePhone1,
        );
      },
    );
  }

  Widget _phone2() {
    return StreamBuilder<String>(
      stream: _streamController.phone2Stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a phone',
            errorText: snapshot.error,
          ),
          maxLength: 10,
          keyboardType: TextInputType.phone,
          onChanged: _streamController.changePhone2,
        );
      },
    );
  }

  Widget _address() {
    return StreamBuilder<String>(
      stream: _streamController.addressStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter their address',
            errorText: snapshot.error,
          ),
          onChanged: _streamController.changeAddress,
        );
      },
    );
  }

  Widget _managerName() {
    return StreamBuilder<String>(
      stream: _streamController.managerNameStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a name',
            errorText: snapshot.error,
          ),
          onChanged: _streamController.changeManagerName,
        );
      },
    );
  }

  Widget _managerPhone() {
    return StreamBuilder<String>(
      stream: _streamController.managerPhoneStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter a phone',
            errorText: snapshot.error,
          ),
          maxLength: 10,
          keyboardType: TextInputType.phone,
          onChanged: _streamController.changeManagerPhone,
        );
      },
    );
  }

  Widget _managerEmail() {
    return StreamBuilder<String>(
      stream: _streamController.managerEmailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter an email',
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: _streamController.changeManagerEmail,
        );
      },
    );
  }

  Widget _createOrganizationButton(CreateOrganizationState state) {
    return StreamBuilder<bool>(
      stream: _streamController.validFormStream,
      builder: (context, snapshot) {
        return Container(
          width: double.infinity,
          child: RaisedButton(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'SUBMIT ORGANIZATION',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: (state is! SubmitInProgress && snapshot.hasData)
                ? _onSubmitButtonPressed
                : null,
          ),
        );
      },
    );
  }

  Widget _progressIndicator(CreateOrganizationState state) {
    final progressIndicator = Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: CircularProgressIndicator(),
    );

    return Container(
      child: state is SubmitInProgress ? progressIndicator : null,
    );
  }
}

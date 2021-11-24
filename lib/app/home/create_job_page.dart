import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker_flutter/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/app/models/job.dart';
import 'package:time_tracker_flutter/app/services/database_service.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/validators.dart';

import '../constants.dart';

//TODO:: convert to FORM and TEXTFIELDFORM !!

class CreateJobPage extends StatefulWidget with JobAndRateValidator {
  @override
  State<CreateJobPage> createState() => _CreateJobPageState();

  final DatabaseService databaseService;

  CreateJobPage({required this.databaseService});
}

class _CreateJobPageState extends State<CreateJobPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _rateFocusNode = FocusNode();

  String get _name => _nameController.text;
  double get _rate =>
      _rateController.text.isEmpty ? 0 : double.parse(_rateController.text);

  bool _isFormSubmitted = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Email SignIn'),
      ),
      body: SingleChildScrollView(child: _bodyContent(context)),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    _rateController.dispose();
    _rateFocusNode.dispose();
    super.dispose();
  }

  Widget _bodyContent(BuildContext context) {
    bool _isFormValid = widget.jobNameValidator.isNotEmptyValidation(_name) &&
        widget.jobRateValidator.isNotEmptyAndGraterThanZero(_rate);

    List<Widget> _buildChildren() {
      return [
        _nameTextField(),
        const SizedBox(
          height: 12.0,
        ),
        _rateTextField(),
        const SizedBox(
          height: 12.0,
        ),
        SignInButton(
          //TODO:: create a formSignIn Button extends CustomRaisedButton
          backgroundColor: Colors.indigoAccent,
          textColor: Colors.white,
          text: 'Create job',
          onPressed: _isFormValid && !_isLoading ? _submit : null,
          isEnable: !_isLoading || _isFormValid,
        )
      ];
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: _buildChildren(),
          ),
        ),
      ),
    );
  }

  TextField _rateTextField() {
    bool _showRate = _isFormSubmitted &&
        !widget.jobRateValidator.isNotEmptyAndGraterThanZero(_rate);

    return TextField(
      enabled: !_isLoading,
      decoration: InputDecoration(
        labelText: 'Rate per hour',
        errorText: _showRate ? widget.jobRateEmptyErrorValidator : null,
      ),
      onChanged: (value) => _updateState(),
      keyboardType: TextInputType.number,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      controller: _rateController,
      focusNode: _rateFocusNode,
      onEditingComplete: () => _onCompleteRateEditing(),
    );
  }

  TextField _nameTextField() {
    bool _showEmailError = _isFormSubmitted &&
        !widget.jobNameValidator.isNotEmptyValidation(_name);
    return TextField(
      enabled: !_isLoading,
      decoration: InputDecoration(
        hintText: 'My job 1',
        labelText: 'Job Name',
        errorText: _showEmailError ? widget.jobNameEmptyErrorValidator : null,
      ),
      onChanged: (value) => _updateState(),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      controller: _nameController,
      focusNode: _nameFocusNode,
      onEditingComplete: _onCompleteNameEditing,
    );
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
      _isFormSubmitted = true;
    });
    try {
      List<Job> _jobs = await widget.databaseService.streamJobs().first;
      List<String> _allNames = _jobs.map((Job job) => job.name).toList();
      if (_allNames.contains(_name)) {
        PlatformAlertDialog(
          title: 'Error',
          content: 'Name Already Exists',
          cancelTextButton: 'OK',
        ).show(context);
        return;
      }
      await widget.databaseService.createJob(
        Job(name: _name, ratePerHour: _rate),
      );

      Navigator.pop(context);
    } on PlatformException catch (error) {
      const String errorTitle = 'Failed to Save the job.';
      PlatformExceptionAlertDialog(
        title: errorTitle,
        exception: error,
      ).show(context);
    } catch (error) {
      print(error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onCompleteNameEditing() {
    var _newFocus = widget.jobNameValidator.isNotEmptyValidation(_name)
        ? _rateFocusNode
        : _nameFocusNode;
    FocusScope.of(context).requestFocus(_newFocus);
  }

  void _onCompleteRateEditing() {
    _submit();
  }

  void _updateState() {
    setState(() {});
  }
}

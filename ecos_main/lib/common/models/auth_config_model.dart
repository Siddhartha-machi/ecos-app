import 'package:ecos_main/common/models/form_models.dart';
import 'package:ecos_main/common/models/route_models.dart';
import 'package:flutter/material.dart';

class AuthConfigModel {
  late String headingText;
  late String captionText;
  late String buttonText;
  late String accountMessage;
  late String navigateButtonText;
  late String path;
  late String nextPath;
  late List<GenericFormField> formConfig;

  bool get isLogin => path == Routes.auth.login;
  bool get isRegister => path == Routes.auth.register;

  List<GenericFormField> get _pDconfig {
    return [
      GenericFormField(
        name: 'firstName',
        label: 'First Name',
        type: GenericFieldType.text,
        hintText: 'Mirana',
        isRequired: true,
      ),
      GenericFormField(
        name: 'lastName',
        label: 'Last Name',
        hintText: 'Blake',
        type: GenericFieldType.text,
        isRequired: true,
      ),
      GenericFormField(
        name: 'dob',
        label: 'Date of birth',
        type: GenericFieldType.date,
        suffixIcon: Icons.date_range_rounded.codePoint,
        isRequired: true,
      ),
      GenericFormField(
        name: 'bio',
        label: 'Bio',
        hintText: '( Optional )',
        type: GenericFieldType.text,
        minLength: 30,
        maxLength: 250,
        rows: 8,
      ),
      GenericFormField(
        name: 'gender',
        label: 'Gender',
        type: GenericFieldType.dropdown,
        isRequired: true,
        options: const [
          GenericFieldOption(value: 'male', optionLabel: 'Male'),
          GenericFieldOption(value: 'female', optionLabel: 'Female'),
          GenericFieldOption(
              value: 'rather-not-say', optionLabel: 'Rather not say'),
        ],
      ),
    ];
  }

  List<GenericFormField> get _loginConfig {
    return [
      GenericFormField(
        name: 'email',
        label: 'Email',
        type: GenericFieldType.email,
        hintText: 'Your email',
        prefixIcon: Icons.email_rounded.codePoint,
      ),
      GenericFormField(
        name: 'password',
        label: 'Password',
        hintText: 'Your password',
        type: GenericFieldType.password,
        prefixIcon: Icons.key_rounded.codePoint,
        isRequired: true,
      ),
      GenericFormField(
        name: 'aggrement',
        label: 'Terms and conditions',
        hintText: 'I\'ve read and agreed to user agreement and privacy policy.',
        type: GenericFieldType.checkbox,
        isRequired: true,
      ),
    ];
  }

  List<GenericFormField> get _registerConfig {
    return [
      GenericFormField(
        name: 'email',
        label: 'Email',
        type: GenericFieldType.email,
        hintText: 'Your email',
        prefixIcon: Icons.email_rounded.codePoint,
        isRequired: true,
      ),
      GenericFormField(
        name: 'password',
        label: 'Password',
        hintText: 'Your password',
        type: GenericFieldType.password,
        prefixIcon: Icons.key_rounded.codePoint,
        isRequired: true,
      ),
      GenericFormField(
        name: 'confirm-password',
        label: 'Confirm Password',
        hintText: 'Confirm password, same as your password.',
        type: GenericFieldType.password,
        prefixIcon: Icons.key_rounded.codePoint,
        isRequired: true,
      ),
      GenericFormField(
        name: 'aggrement',
        label: 'Terms and conditions',
        hintText: 'I\'ve read and agreed to user agreement and privacy policy.',
        type: GenericFieldType.checkbox,
        isRequired: true,
      ),
    ];
  }

  init(String sPath) {
    path = sPath;
    formConfig = [];
    if (path == Routes.auth.register) {
      // If the path is set to registration
      headingText = 'Get started now';
      captionText = 'Create an account or login to explore our app.';
      formConfig = _registerConfig;
      buttonText = 'Register';
      accountMessage = 'Already have an account with us?';
      navigateButtonText = 'Login';
      nextPath = Routes.auth.login;
    } else if (path == Routes.auth.login) {
      // If the path is set to login
      headingText = 'Login into your account';
      captionText = 'Fill in your account details to login.';
      formConfig = _loginConfig;
      buttonText = 'Login';
      accountMessage = 'Dont\'t have an account?';
      navigateButtonText = 'Register';
      nextPath = Routes.auth.register;
    } else {
      // If the path is set to personal details
      headingText = 'Almost there!';
      captionText = 'Tell us a little about yourself to get us aquainted.';
      formConfig = _pDconfig;
      buttonText = 'Save details';
      accountMessage = 'Login with a different account';
      navigateButtonText = 'Login';
      nextPath = Routes.auth.login;
    }
  }
}

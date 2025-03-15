import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:shared/models/route_models.dart';
import 'package:auth/data/models/auth_config_model.dart';
import 'package:shared/presentation/widgets/form/form_manager.dart';
import 'package:shared/presentation/widgets/atoms/contained_button.dart';
import 'package:shared/presentation/widgets/background/gradiant_background.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen(this.routerState, {super.key});

  final GoRouterState routerState;
  final AuthConfigModel _oAuthConfig = AuthConfigModel();
  final _formKey = GlobalKey<FormBuilderState>();

  Widget _authForm(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        children: [
          FormManager(
            fields: _oAuthConfig.formConfig,
            formKey: _formKey,
          ),
          ContainedButton(
            onPressed: () => _submitButtonHandler(context),
            label: _oAuthConfig.buttonText,
          ),
        ],
      ),
    );
  }

  Widget _signupToggle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _oAuthConfig.accountMessage,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        TextButton(
          onPressed: () => context.go(_oAuthConfig.nextPath),
          child: Text(
            _oAuthConfig.navigateButtonText,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }

  Widget _appIcon(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/logo.svg',
      height: 45,
      width: 45,
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onPrimary,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _authTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _oAuthConfig.headingText,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            _oAuthConfig.captionText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColorLight,
                ),
          ),
        ],
      ),
    );
  }

  Widget _termsAndPrivacyText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
          children: <TextSpan>[
            const TextSpan(text: 'By signing up you agree to our '),
            TextSpan(
              text: 'Terms of service',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchBottomSheet(context, 'Terms of service');
                },
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy policy',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchBottomSheet(context, 'Terms of service');
                },
            ),
          ],
        ),
      ),
    );
  }

  void _launchBottomSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      shape: Theme.of(context).buttonTheme.shape,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _submitButtonHandler(BuildContext context) {
    // TODO validate all the fields.
    final isValid = _formKey.currentState?.saveAndValidate();
    print(_formKey.currentState?.value);
    if (isValid == false) {
      return;
    }

    if (_oAuthConfig.isLogin) {
      // TODO login
    } else if (_oAuthConfig.isRegister) {
      // TODO save partial data
      // Navigate to personal details page
      return context.go(Paths.auth.personalDetails.absolutePath);
    } else {
      // TODO make API request to create user
    }
    context.go(Paths.main.root.absolutePath);
  }

  @override
  Widget build(BuildContext context) {
    _oAuthConfig.init(routerState.path ?? '');

    return GradientBackground(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _appIcon(context),
          const SizedBox(height: 12),
          _authTitle(context),
          const SizedBox(height: 24),
          _authForm(context),
          const SizedBox(height: 24),
          _signupToggle(context),
          const SizedBox(height: 6),
          _termsAndPrivacyText(context),
        ],
      ),
    );
  }
}

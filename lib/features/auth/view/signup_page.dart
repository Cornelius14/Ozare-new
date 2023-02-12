import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/common/utils/utils.dart';
import 'package:ozare/consts.dart';
import 'package:ozare/features/auth/bloc/auth_bloc.dart';
import 'package:ozare/features/auth/widgets/widgets.dart';
import 'package:ozare/models/ouser.dart';
import 'package:ozare/translations/locale_keys.g.dart';

import '../../../common/dialogs/dialogs.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LocaleKeys.create_account.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Form(
                key: formKey,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InputField(
                          controller: firstNameController,
                          hintText: LocaleKeys.enter_your_first_name.tr(),
                          labelText: LocaleKeys.first_name.tr(),
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          controller: lastNameController,
                          hintText: LocaleKeys.enter_your_last_name.tr(),
                          labelText: LocaleKeys.last_name.tr(),
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          controller: emailController,
                          hintText: LocaleKeys.enter_your_email_address.tr(),
                          labelText: LocaleKeys.email_address.tr(),
                          textInputType: TextInputType.emailAddress,
                          validator: (val) => Validators.emailValidator(val!),
                          inputFormators: [
                            InputFormators.spaceNotAllowed,
                          ],
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          controller: passwordController,
                          hintText: LocaleKeys.enter_your_password.tr(),
                          labelText: LocaleKeys.password.tr(),
                          isPassword: true,
                          maxLines: 1,
                          textInputType: TextInputType.visiblePassword,
                          validator: (val) =>
                              Validators.passwordValidator(val!),
                          inputFormators: [
                            InputFormators.spaceNotAllowed,
                          ],
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          controller: confirmPasswordController,
                          hintText: LocaleKeys.enter_your_password.tr(),
                          labelText: LocaleKeys.confirm_password.tr(),
                          isPassword: true,
                          maxLines: 1,
                          validator: (val) =>
                              Validators.confirmPasswordValidator(
                                  passwordController.text, val!),
                          textInputType: TextInputType.visiblePassword,
                          inputFormators: [
                            InputFormators.spaceNotAllowed,
                          ],
                        ),
                        SizedBox(height: size.height * 0.3),
                      ],
                    ),
                  ),
                ),
              ),

              ///
              const SizedBox(height: 24),
              OButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(AuthSignupRequested(
                          ouser: OUser(
                            uid: null,
                            email: emailController.text,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                          ),
                          password: passwordController.text,
                        ));
                  } else {
                    showSnackBar(context, "All fields are required");
                  }
                },
                label: LocaleKeys.register.tr(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.already_have_an_account.tr(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(const AuthLoginPageRequested());
                    },
                    child: Text(
                      LocaleKeys.login.tr(),
                      style: const TextStyle(
                        color: primary2Color,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

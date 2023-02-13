import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/common/dialogs/show_snackbar.dart';
import 'package:ozare/common/utils/utils.dart';
import 'package:ozare/consts.dart';
import 'package:ozare/features/auth/bloc/auth_bloc.dart';
import 'package:ozare/features/auth/widgets/widgets.dart';
import 'package:ozare/translations/locale_keys.g.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.lets_get_started.tr(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.06),

                // Email Field
                InputField(
                  controller: emailController,
                  hintText: LocaleKeys.enter_your_email_address.tr(),
                  labelText: LocaleKeys.email_address.tr(),
                  isPassword: false,
                  textInputType: TextInputType.emailAddress,
                  inputFormators: [
                    InputFormators.spaceNotAllowed,
                  ],
                  validator: (val) => Validators.emailValidator(val!),
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: passwordController,
                  hintText: LocaleKeys.enter_your_password.tr(),
                  labelText: LocaleKeys.password.tr(),
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword,
                  maxLines: 1,
                  inputFormators: [
                    InputFormators.spaceNotAllowed,
                  ],
                ),
                const SizedBox(height: 12),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    LocaleKeys.fogot_password.tr(),
                    style: const TextStyle(
                      color: primary2Color,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                ///
                SizedBox(height: size.height * 0.07),
                OButton(
                  onTap: () {
                    // check if user has entered valid data
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(AuthLoginRequested(
                            email: emailController.text,
                            password: passwordController.text,
                          ));
                    } else {
                      showSnackBar(context, "All fields are required");
                    }
                  },
                  label: LocaleKeys.login.tr(),
                ),
                const SizedBox(height: 16),

                /// Or Continue With
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      LocaleKeys.or_continue_with.tr(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// Social Buttons

                Row(
                  children: [
                    Expanded(
                        child: OButton.icon(
                            onTap: () {}, iconPath: 'assets/icons/google.svg')),
                    const SizedBox(width: 16),
                    Expanded(
                        child: OButton.icon(
                            onTap: () {}, iconPath: 'assets/icons/apple.svg')),
                  ],
                ),

                ///
                SizedBox(height: size.height * 0.08),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.dont_have_an_account.tr(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(const AuthSignupPageRequested());
                      },
                      child: Text(
                        LocaleKeys.register.tr(),
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
      ),
    );
  }
}

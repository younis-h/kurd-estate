
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/usecases/reset_password.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  final ResetPassword _resetPassword =
      GetIt.instance<ResetPassword>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      await _resetPassword(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password reset email has been sent.',
          ),
        ),
      );
    } on Exception catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _getErrorMessage(error),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getErrorMessage(Object error) {
    final message = error.toString();

    if (message.contains('User not found')) {
      return 'No account was found with this email.';
    }

    if (message.contains('network')) {
      return 'Network error. Please check your connection.';
    }

    return 'Unable to send reset email. Please try again.';
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 480,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    Icon(
                      Icons.lock_reset_outlined,
                      size: 72,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),

                    const SizedBox(
                      height: AppSpacing.lg,
                    ),

                    Text(
                      'Reset your password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    const SizedBox(
                      height: AppSpacing.sm,
                    ),

                    Text(
                      'Enter your email and we will send you '
                      'a password reset link.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    AppTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      keyboardType:
                          TextInputType.emailAddress,
                      textInputAction:
                          TextInputAction.done,
                      prefix: const Icon(
                        Icons.email_outlined,
                      ),
                      validator: _validateEmail,
                      onSubmitted: (_) => _reset(),
                    ),

                    const SizedBox(
                      height: AppSpacing.lg,
                    ),

                    AppButton(
                      text: 'Send Reset Link',
                      onPressed:
                          _isLoading ? null : _reset,
                      isLoading: _isLoading,
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              Navigator.of(context).pop();
                            },
                      child: const Text(
                        'Back to Sign In',
                      ),
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

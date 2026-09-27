import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../data/datasources/auth_remote_datasource.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final AuthRemoteDataSource _remote =
      GetIt.instance<AuthRemoteDataSource>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      await _remote.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _fullNameController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Account created successfully. Please check your email.',
          ),
        ),
      );

      context.pop();
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

    if (message.contains('User already registered')) {
      return 'This email is already registered.';
    }

    if (message.contains('Password should be')) {
      return 'Password does not meet the requirements.';
    }

    if (message.contains('network')) {
      return 'Network error. Please check your connection.';
    }

    return 'Account creation failed. Please try again.';
  }

  String? _validateFullName(String? value) {
    final fullName = value?.trim() ?? '';

    if (fullName.isEmpty) {
      return 'Please enter your full name';
    }

    if (fullName.length < 2) {
      return 'Please enter a valid name';
    }

    return null;
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

  String? _validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: AppSpacing.lg,
                    ),

                    Text(
                      'Create your Kurd Estate account',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    const SizedBox(
                      height: AppSpacing.sm,
                    ),

                    Text(
                      'Join Kurd Estate and start exploring properties.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    AppTextField(
                      controller: _fullNameController,
                      labelText: 'Full Name',
                      hintText: 'Enter your full name',
                      textInputAction: TextInputAction.next,
                      prefix: const Icon(
                        Icons.person_outline,
                      ),
                      validator: _validateFullName,
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    AppTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefix: const Icon(
                        Icons.email_outlined,
                      ),
                      validator: _validateEmail,
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    AppTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      prefix: const Icon(
                        Icons.lock_outline,
                      ),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword =
                                !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      validator: _validatePassword,
                    ),

                    const SizedBox(
                      height: AppSpacing.md,
                    ),

                    AppTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done,
                      prefix: const Icon(
                        Icons.lock_outline,
                      ),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword =
                                !_obscureConfirmPassword;
                          });
                        },
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      validator: _validateConfirmPassword,
                      onSubmitted: (_) => _signup(),
                    ),

                    const SizedBox(
                      height: AppSpacing.xl,
                    ),

                    AppButton(
                      text: 'Create Account',
                      onPressed:
                          _isLoading ? null : _signup,
                      isLoading: _isLoading,
                    ),

                    const SizedBox(
                      height: AppSpacing.lg,
                    ),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  context.pop();
                                },
                          child: const Text(
                            'Sign In',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: AppSpacing.lg,
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
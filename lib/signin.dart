import 'package:go_router/go_router.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/internationalization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'sign_in_model.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  static String routeName = 'SignIn';
  static String routePath = 'signIn';

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late SignInModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _model = SignInModel();
    _model.addListener(_onModelChanged);
    _model.initialize();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _onModelChanged() {
    safeSetState(() {});
  }

  @override
  void dispose() {
    _model.removeListener(_onModelChanged);
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _model.dispose();
    super.dispose();
  }

  void safeSetState(void Function() fn) {
    if (!mounted) return;
    setState(fn);
  }

  Future<void> _handleSignUp() async {
    FocusScope.of(context).unfocus();

    _model.updateEmail(_emailController.text.trim());
    _model.updatePassword(_passwordController.text);
    _model.updateConfirmPassword(_confirmController.text);

    final success = await _model.signUp();
    if (success && mounted) {
      context.go('/basehomepg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'Sign Up',
      color: FlutterFlowTheme.of(context).primary.withAlpha(0xFF),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).richBlackFOGRA39,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF21005D),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/53bb7ee361263b56c290ed2eaa1fe39b.jpg',
                ).image,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),

                      // Branding
                      Text(
                        'Beats',
                        style: GoogleFonts.interTight(
                          color: FlutterFlowTheme.of(context).error,
                          fontSize: 42,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Create your account',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(),
                              color: Colors.white60,
                            ),
                      ),

                      const SizedBox(height: 50),

                      // Sign up card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 32),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.15), width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context)
                                  .getText('l86s571b' /* SIGN UP */),
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w700),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 26,
                                  ),
                            ),

                            const SizedBox(height: 28),

                            // Email
                            _inputField(
                              controller: _emailController,
                              hint: 'Email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 16),

                            // Password
                            _inputField(
                              controller: _passwordController,
                              hint: 'Password',
                              icon: Icons.lock_outline,
                              obscure: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.white54,
                                  size: 20,
                                ),
                                onPressed: () => safeSetState(
                                    () => _obscurePassword = !_obscurePassword),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Confirm password
                            _inputField(
                              controller: _confirmController,
                              hint: 'Confirm Password',
                              icon: Icons.lock_outline,
                              obscure: _obscureConfirm,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirm
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.white54,
                                  size: 20,
                                ),
                                onPressed: () => safeSetState(
                                    () => _obscureConfirm = !_obscureConfirm),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Error message
                            if (_model.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  _model.errorMessage!,
                                  style: const TextStyle(
                                      color: Colors.redAccent, fontSize: 13),
                                ),
                              ),

                            const SizedBox(height: 8),

                            // Sign up button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed:
                                    _model.isLoading ? null : _handleSignUp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).error,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  elevation: 0,
                                ),
                                child: _model.isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2),
                                      )
                                    : Text(
                                        'Create Account',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Already have an account
                      GestureDetector(
                        onTap: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/login');
                          }
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(),
                                  color: Colors.white60,
                                ),
                            children: [
                              TextSpan(
                                text: 'Log in',
                                style: GoogleFonts.inter(
                                  color: FlutterFlowTheme.of(context).error,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.white38, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

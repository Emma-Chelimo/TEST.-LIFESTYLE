import 'package:flutter_test/flutter_test.dart';
import 'package:project_one/sign_in_model.dart';

void main() {
  group('SignInModel', () {
    late SignInModel model;

    setUp(() {
      model = SignInModel();
    });

    tearDown(() {
      model.dispose();
    });

    test('initial state', () {
      expect(model.email, '');
      expect(model.password, '');
      expect(model.confirmPassword, '');
      expect(model.isLoading, false);
      expect(model.errorMessage, null);
    });

    test('updateEmail', () {
      model.updateEmail('test@example.com');
      expect(model.email, 'test@example.com');
    });

    test('updatePassword', () {
      model.updatePassword('password123');
      expect(model.password, 'password123');
    });

    test('updateConfirmPassword', () {
      model.updateConfirmPassword('password123');
      expect(model.confirmPassword, 'password123');
    });

    test('validateInputs - valid inputs', () {
      model.updateEmail('test@example.com');
      model.updatePassword('password123');
      model.updateConfirmPassword('password123');

      expect(model.validateInputs(), true);
      expect(model.errorMessage, null);
    });

    test('validateInputs - invalid email', () {
      model.updateEmail('invalidemail');
      model.updatePassword('password123');
      model.updateConfirmPassword('password123');

      expect(model.validateInputs(), false);
      expect(model.errorMessage, 'Please enter a valid email');
    });

    test('validateInputs - short password', () {
      model.updateEmail('test@example.com');
      model.updatePassword('123');
      model.updateConfirmPassword('123');

      expect(model.validateInputs(), false);
      expect(model.errorMessage, 'Password must be at least 6 characters');
    });

    test('validateInputs - passwords do not match', () {
      model.updateEmail('test@example.com');
      model.updatePassword('password123');
      model.updateConfirmPassword('differentpassword');

      expect(model.validateInputs(), false);
      expect(model.errorMessage, 'Passwords do not match');
    });

    test('clearError', () {
      model.errorMessage = 'Some error';
      model.clearError();
      expect(model.errorMessage, null);
    });

    test('signUp - success', () async {
      model.updateEmail('test@example.com');
      model.updatePassword('password123');
      model.updateConfirmPassword('password123');

      final result = await model.signUp();
      expect(result, true);
      expect(model.isLoading, false);
      expect(model.errorMessage, null);
    });

    test('signUp - validation failure', () async {
      model.updateEmail('invalidemail');
      model.updatePassword('password123');
      model.updateConfirmPassword('password123');

      final result = await model.signUp();
      expect(result, false);
      expect(model.isLoading, false);
      expect(model.errorMessage, 'Please enter a valid email');
    });
  });
}

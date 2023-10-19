import 'package:zawya_islamic/application/features/login/feature.dart';
import 'package:zawya_islamic/application/features/navigation/feature.dart';

typedef VoidCallback = void Function();

Future<void> navigateToMainApp(VoidCallback? callback, AppBloc authBloc) async {
  if (callback == null) {
    final credentails = await loginFromCache();

    if (credentails != null) {
      final loginController = LoginController();

      loginController.setCredentials(
          credentails.identifier, credentails.password);
      loginController.login(authBloc, true);

      return;
    }

    NavigationService.pushNamedReplacement(Routes.loginRoute);
    return;
  }

  callback.call();
}

import 'dart:io';
import 'handle_route.dart';
import 'handle_middleware.dart';
import '../globals/context.dart';
import '../globals/typedefs.dart';

Future<void> resolveMethod(HttpRequest request, [String dynamicRoute]) async {
  final path = dynamicRoute ?? request.uri.path;
  final method = request.method;

  if (CONTEXT.routes[path].containsKey(method)) {
    HandleMiddleware handleGuard = CONTEXT.routes[path][method][GUARD];
    HandleReqRes handleResponse = CONTEXT.routes[path][method][REQUEST];
    if (await handleMiddleware(request, request.response))
      await handleRoute(handleGuard, handleResponse, request);
    else {
      request.response.statusCode = HttpStatus.unprocessableEntity;
      request.response.write(HTTP_UNPROCESSABLE_ENTITY);
    }
  } else {
    request.response.statusCode = HttpStatus.methodNotAllowed;
    request.response.write(HTTP_METHOD_NOT_ALLOWED);
  }
}

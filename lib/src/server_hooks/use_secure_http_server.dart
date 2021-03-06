import 'dart:io';
import '../helpers/set_gzip_auto_compress.dart';
import '../globals/context.dart';
import 'use_create_secure_http_server.dart';
import 'use_request_handler.dart';

/** 
 * + Creates a new HttpServer 
 * + Secure binds it to the given host:post 
 * + Handles incoming requests
 * + Uses Gzip by default
 * */
Future<HttpServer> useSecureHttpServer(
    String host, int port, SecurityContext sctx,
    {int backlog = 0,
    bool v60only = false,
    bool shared = false,
    bool autoClose = true}) async {
  HttpServer server = await useCreateSecureHttpServer(host, port, sctx,
      backlog: backlog, v60only: v60only, shared: shared);

  CONTEXT.server = server;
  CONTEXT.shouldAutoClose = autoClose;

  setGzipAutoCompress(server);
  useRequestHandler(server);

  return server;
}

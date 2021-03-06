import 'dart:io';
import '../globals/typedefs.dart';
import 'serve_files.dart';
import 'map_root_path_to_index_html.dart';

Future<dynamic> serveHtmlContent(HttpRequest req) async {
  return req.uri.path == ROOT_PATH
      ? await mapRootPathToIndexHTml(req)
      : await serveFiles(req);
}

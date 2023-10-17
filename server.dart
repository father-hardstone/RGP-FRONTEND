import 'dart:io';
import 'package:http_server/http_server.dart';

Future<void> main() async {
  final staticFiles = VirtualDirectory('./build/web')
    ..allowDirectoryListing = true;

  final server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    8082,
  );

  print('Serving at http://${server.address.host}:${server.port}');

  await for (HttpRequest request in server) {
    handleRequest(request, staticFiles);
  }
}

Future<void> handleRequest(HttpRequest request, VirtualDirectory staticFiles) async {
  final uri = request.uri.path == '/' ? '/index.html' : request.uri.path;
  final file = File('./build/web$uri');

  // Capture device details
  final ipAddress = request.connectionInfo?.remoteAddress ?? InternetAddress.anyIPv4;
  final userAgent = request.headers.value('user-agent');
  final requestMethod = request.method;

  print('IP Address: $ipAddress');
  print('User Agent: $userAgent');
  print('Request Method: $requestMethod');

  if (await file.exists()) {
    staticFiles.serveFile(file, request);
  } else {
    request.response.statusCode = HttpStatus.notFound;
    request.response.write('Not Found');
    await request.response.close();
  }
}
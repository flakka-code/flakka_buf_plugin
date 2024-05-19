import 'dart:async';
import 'dart:io';
import 'dart:typed_data' show BytesBuilder;

import 'package:flakka_buf_plugin/pb/google/protobuf/compiler/plugin.pb.dart';
import 'package:flakka_buf_plugin/src/code_generator/code_generator_request_handler.dart';
import 'package:protobuf/protobuf.dart';

/// {@template flakka_internal_code_gen_request_processor}
/// A processor for protobuf code generator requests
/// {@endtemplate}
class CodeGeneratorRequestProcessor {
  /// {@macro flakka_internal_code_gen_request_processor}
  const CodeGeneratorRequestProcessor(this._streamIn, this._streamOut);

  final Stream<List<int>> _streamIn;
  final StreamSink<List<int>> _streamOut;

  /// Applies the given handler to the input read from [_streamIn] and writes
  /// the handler response to [_streamOut].
  Future<void> handle(
    CodeGeneratorRequestHandler handler,
  ) async {
    final bytesBuilder = BytesBuilder();

    await for (final chunk in _streamIn) {
      bytesBuilder.add(chunk);
    }

    final bytes = bytesBuilder.toBytes();
    final reader = CodedBufferReader(bytes);
    final request = CodeGeneratorRequest()..mergeFromCodedBufferReader(reader);
    reader.checkLastTagWas(0);

    final response = handler(request);
    _streamOut.add(response.writeToBuffer());
    await _streamOut.close();
  }
}

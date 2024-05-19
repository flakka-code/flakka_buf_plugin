import 'package:flakka_buf_plugin/pb/google/protobuf/compiler/plugin.pb.dart';
import 'package:flakka_buf_plugin/src/request_processor/code_generator_request_processor.dart';

/// Returns a [CodeGeneratorResponse] given a [CodeGeneratorRequest]
///
/// Called by a [CodeGeneratorRequestProcessor]
typedef CodeGeneratorRequestHandler = CodeGeneratorResponse Function(
  CodeGeneratorRequest request,
);

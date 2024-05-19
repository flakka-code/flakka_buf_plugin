import 'package:flakka_buf_plugin/src/code_generator/code_generator_request_processor.dart';
import 'package:flakka_buf_plugin/src/pb/google/protobuf/compiler/plugin.pb.dart';

/// Returns a [CodeGeneratorResponse] given a [CodeGeneratorRequest]
///
/// Called by a [CodeGeneratorRequestProcessor]
typedef CodeGeneratorRequestHandler = CodeGeneratorResponse Function(
  CodeGeneratorRequest request,
);

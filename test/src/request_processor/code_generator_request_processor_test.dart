import 'dart:async';

import 'package:flakka_buf_plugin/pb/google/protobuf/compiler/plugin.pb.dart';
import 'package:flakka_buf_plugin/pb/google/protobuf/descriptor.pb.dart';
import 'package:flakka_buf_plugin/src/request_processor/code_generator_request_processor.dart';
import 'package:test/test.dart';

void main() {
  group('CodeGeneratorRequestProcessor', () {
    test('handles request and generates response', () async {
      // Create a request with some dummy data
      final request = CodeGeneratorRequest()
        ..protoFile.add(FileDescriptorProto()..name = 'test.proto')
        ..fileToGenerate.add('test.proto');

      // Create input stream
      final inputStream = Stream.fromIterable([request.writeToBuffer()]);

      // Create output stream
      final outputStreamController = StreamController<List<int>>();

      // Create the processor and handle the request
      final processorComplete =
          CodeGeneratorRequestProcessor(inputStream, outputStreamController)
              .handle((req) {
        // Verify the request
        expect(req.protoFile.length, 1);
        expect(req.protoFile.first.name, 'test.proto');
        expect(req.fileToGenerate.length, 1);
        expect(req.fileToGenerate.first, 'test.proto');

        // Create a response
        return CodeGeneratorResponse()
          ..file.add(CodeGeneratorResponse_File()..name = 'test.pb.dart');
      });

      // Capture the response
      final outputData = await outputStreamController.stream.toList();

      // await the pending response
      await processorComplete;

      final responseBytes = outputData.expand((list) => list).toList();
      final response = CodeGeneratorResponse.fromBuffer(responseBytes);

      expect(response.file.length, 1);
      expect(response.file.first.name, 'test.pb.dart');
    });
  });
}

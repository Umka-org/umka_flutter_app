import 'package:build_grpc_channel/build_grpc_channel.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:umka_proto/generated/umka.pbgrpc.dart';

const host = 'http://127.0.0.1';

int get port => kIsWeb ? 8888 : 5555;

class UmkaService {
  late final UmkaClient stub;

  UmkaService() {
    stub = UmkaClient(buildGrpcChannel(host: host, port: port, secure: false));
  }

  Future<Question> getRandomQuestion(Student student) async {
    final question = await stub.getQuestion(student);
    return question;
  }

  Future<Evaluation> sendAnswer(Answer answer) async {
    return await stub.sendAnswer(answer);
  }

  Stream<AnsweredQuestion> getTutorial(Student student) =>
      stub.getTutorial(student);

  Future<Exam?> getExam(Student student) async => await stub.getExam(student);

  Future<Evaluation?> takeExam(
      String studentName, Stream<Answer> answersStream) async {
    final evaluationFuture = stub.takeExam(answersStream,
        options: CallOptions(metadata: {'student_name': studentName}));
    return evaluationFuture;
  }
}

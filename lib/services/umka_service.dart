import 'package:grpc/grpc.dart';
import 'package:umka_proto/generated/umka.pbgrpc.dart';

ClientChannel _createChannel(String host) => ClientChannel(
      host,
      port: 5555,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

class UmkaService {
  late final UmkaClient stub;

  UmkaService() {
    stub = UmkaClient(_createChannel('127.0.0.1'));
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

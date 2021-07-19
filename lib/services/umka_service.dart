import 'package:grpc/grpc.dart';
import 'package:umka_proto/generated/umka.pbgrpc.dart';

class UmkaService {
  late final UmkaClient stub;

  UmkaService() {
    stub = UmkaClient(_createChannel('127.0.0.1'));
  }

  Future<Question?> getRandomQuestion(Student student) async {
    final question = await stub.getQuestion(student);
    return question;
  }
}

ClientChannel _createChannel(String host) => ClientChannel(
      host,
      port: 5555,
      options: ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

import 'package:grpc/grpc.dart';
import 'package:umka_proto/generated/umka.pbgrpc.dart';

class UmkaService {
  final String userName;
  final ClientChannel channel;
  late final UmkaClient stub;

  UmkaService(this.userName, this.channel) {
    stub = UmkaClient(channel);
  }
}

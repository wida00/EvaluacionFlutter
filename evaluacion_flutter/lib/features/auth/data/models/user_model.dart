import '../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    super.name,
    super.token,
  });

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id']?.toString() ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      name: map['name'],
      token: map['token'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      name: user.name,
      token: user.token,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'name': name,
      'token': token,
    };
  }

  @override
  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? name,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }
}

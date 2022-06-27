class MyData {
  String? previous;
  String? next;
  List<Results>? results;

  MyData.fromJson(Map<String, dynamic> json) {
    previous = json['previous'];
    next = json['next'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  Results.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
  }
}

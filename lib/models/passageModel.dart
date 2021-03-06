const passageData = {
  "id": 207,
  "estimated_departure": "06/12/21 08:00",
  "estimated_arrival": "06/12/21 14:30",
  "total_capacity": 22,
  "count_passages": 8,
  "finished": false,
  "rute": {
    "stops": [
      {
        "id": 13,
        "deleted": false,
        "created_at": "2021-10-27T11:22:28.240621+00:00",
        "updated_at": "2021-10-27T11:22:28.240640+00:00",
        "name": "Canelones",
        "location": "-34.52257537124503,-56.27070665359497"
      },
      {
        "id": 14,
        "deleted": false,
        "created_at": "2021-10-27T11:22:38.811717+00:00",
        "updated_at": "2021-11-29T22:16:12.150461+00:00",
        "name": "Florida",
        "location": "-34.10270799317486,-56.215667724609375"
      }
    ],
    "id": 6,
    "deleted": false,
    "created_at": "2021-10-27T11:36:04.081241+00:00",
    "updated_at": "2021-10-27T11:36:04.081260+00:00",
    "name": "Montevideo - Fray Bentos",
    "origin": {
      "id": 2,
      "deleted": false,
      "created_at": "2021-09-24T01:24:23.474695+00:00",
      "updated_at": "2021-10-27T11:22:10.611380+00:00",
      "name": "Montevideo",
      "location": "-34.89311206510446,-56.16511344909668"
    },
    "destination": {
      "id": 12,
      "deleted": false,
      "created_at": "2021-10-21T17:08:57.969596+00:00",
      "updated_at": "2021-10-21T17:08:57.969617+00:00",
      "name": "Fray Bentos",
      "location": "-33.12835119163156,-58.32641601562499"
    }
  },
  "program": {
    "vehicles": [2, 3, 8],
    "subscribed_passenger": [6, 3, 12, 7, 13, 14, 11, 1],
    "id": 3,
    "deleted": true,
    "created_at": "2021-10-27T11:36:50.062389+00:00",
    "updated_at": "2021-11-18T01:57:56.094112+00:00",
    "capacity_limit": 50,
    "arrival_time": "14:30:00",
    "departure_time": "08:00:00",
    "end_program": null,
    "days": ["Mon", "Tue", "Wed"],
    "rute": 6
  },
  "stop": {
    "id": 14,
    "deleted": false,
    "created_at": "2021-10-27T11:22:38.811717+00:00",
    "updated_at": "2021-11-29T22:16:12.150461+00:00",
    "name": "Florida",
    "location": "-34.10270799317486,-56.215667724609375"
  }
};

class PassageModel {
  PassageModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.resultsPassage,
  });
  late final int count;
  late final String next;
  late final String previous;
  late final List<ResultsPassage> resultsPassage;

  PassageModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'] ?? "";
    previous = json['previous'] ?? "";
    resultsPassage = List.from(json['results'])
        .map((e) => ResultsPassage.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['next'] = next;
    _data['previous'] = previous;
    _data['results'] = resultsPassage.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ResultsPassage {
  ResultsPassage({
    required this.stop,
    required this.id,
    required this.estimatedDeparture,
    required this.estimatedArrival,
    required this.totalCapacity,
    required this.countPassages,
    required this.rute,
    required this.finished,
    required this.program,
    required this.is_program,
  });
  late final Origin stop;
  late final int id;
  late final String estimatedDeparture;
  late final String estimatedArrival;
  late final int totalCapacity;
  late final int countPassages;
  late final Rute rute;
  late final bool finished;
  late final Program program;
  late final bool is_program;

  ResultsPassage.fromJson(Map<String, dynamic> json) {
    //if (json['stop'] != null) {
    stop = Origin.fromJson(json['stop']);
    //}
    id = json['id'];
    estimatedDeparture = json['estimated_departure'];
    estimatedArrival = json['estimated_arrival'];
    totalCapacity = json['total_capacity'];
    countPassages = json['count_passages'];
    rute = Rute.fromJson(json['rute']);
    finished = json['finished'];
    program = Program.fromJson(json['program']);
    is_program = json['is_program'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stop'] = stop.toJson();
    _data['estimated_departure'] = estimatedDeparture;
    _data['estimated_arrival'] = estimatedArrival;
    _data['total_capacity'] = totalCapacity;
    _data['count_passages'] = countPassages;
    _data['rute'] = rute.toJson();
    _data['finished'] = finished;
    _data['program'] = program.toJson();

    return _data;
  }
}

class Program {
  Program({
    required this.endProgram,
  });

  late final String endProgram;

  Program.fromJson(Map<String, dynamic> json) {
    //endProgram = json['end_program'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['end_program'] = endProgram;

    return _data;
  }
}

class Rute {
  Rute({
    required this.stops,
    required this.id,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.origin,
    required this.destination,
  });
  late final List<Stops> stops;
  late final int id;
  late final bool deleted;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final Origin origin;
  late final Destination destination;

  Rute.fromJson(Map<String, dynamic> json) {
    stops = List.from(json['stops']).map((e) => Stops.fromJson(e)).toList();
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    origin = Origin.fromJson(json['origin']);
    destination = Destination.fromJson(json['destination']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stops'] = stops.map((e) => e.toJson()).toList();
    _data['id'] = id;
    _data['deleted'] = deleted;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['origin'] = origin.toJson();
    _data['destination'] = destination.toJson();
    return _data;
  }
}

class Stops {
  Stops({
    required this.id,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.location,
  });
  late final int id;
  late final bool deleted;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final String location;

  Stops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['deleted'] = deleted;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['location'] = location;
    return _data;
  }
}

class Origin {
  Origin({
    required this.id,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.location,
  });
  late final int id;
  late final bool deleted;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final String location;

  Origin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['deleted'] = deleted;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['location'] = location;
    return _data;
  }
}

class Destination {
  Destination({
    required this.id,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.location,
  });
  late final int id;
  late final bool deleted;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final String location;

  Destination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['deleted'] = deleted;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['location'] = location;
    return _data;
  }
}

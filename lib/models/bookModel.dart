const bookData = {
  "count": 4,
  "next": null,
  "previous": null,
  "results": [
    {
      "id": 4,
      "estimated_departure": "02/11/21 08:30",
      "estimated_arrival": "02/11/21 08:30",
      "total_capacity": 11,
      "count_passages": 0,
      "rute": {
        "stops": [
          {
            "id": 8,
            "deleted": false,
            "created_at": "2021-10-16T18:25:30.216562+00:00",
            "updated_at": "2021-10-16T18:25:30.216582+00:00",
            "name": "Mercedes - Ansina y Varela",
            "location": "-33.253582332121454,-58.02489280700683"
          }
        ],
        "id": 3,
        "deleted": false,
        "created_at": "2021-10-16T18:32:48.497755+00:00",
        "updated_at": "2021-10-16T18:34:06.274361+00:00",
        "name": "Mercedes1",
        "origin": {
          "id": 7,
          "deleted": false,
          "created_at": "2021-10-16T18:23:15.395160+00:00",
          "updated_at": "2021-10-16T18:23:34.600164+00:00",
          "name": "Mercedes - Plaza Artigas",
          "location": "-33.25645332791316,-58.028218746185296"
        },
        "destination": {
          "id": 10,
          "deleted": false,
          "created_at": "2021-10-16T18:31:50.437823+00:00",
          "updated_at": "2021-10-16T18:31:50.437845+00:00",
          "name": "MdP - Vivero",
          "location": "-33.111673732982595,-58.18565368652343"
        }
      },
      "finished": false
    }
  ]
};

class BookModel {
  BookModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
  late final int count;
  late final String next;
  late final String previous;
  late final List<Results> results;

  BookModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'] ?? "";
    previous = json['previous'] ?? "";
    results =
        List.from(json['results']).map((e) => Results.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['next'] = next;
    _data['previous'] = previous;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Results {
  Results({
    required this.id,
    required this.estimatedDeparture,
    required this.estimatedArrival,
    required this.totalCapacity,
    required this.countPassages,
    required this.rute,
    required this.finished,
    //required this.program,
  });
  late final int id;
  late final String estimatedDeparture;
  late final String estimatedArrival;
  late final int totalCapacity;
  late final int countPassages;
  late final Rute rute;
  late final bool finished;
  //late final Program program;

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estimatedDeparture = json['estimated_departure'];
    estimatedArrival = json['estimated_arrival'];
    totalCapacity = json['total_capacity'];
    countPassages = json['count_passages'];
    rute = Rute.fromJson(json['rute']);
    finished = json['finished'];
    //program = Program.fromJson(json['program']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['estimated_departure'] = estimatedDeparture;
    _data['estimated_arrival'] = estimatedArrival;
    _data['total_capacity'] = totalCapacity;
    _data['count_passages'] = countPassages;
    _data['rute'] = rute.toJson();
    _data['finished'] = finished;
    //_data['program'] = program;

    return _data;
  }
}

/*class Program {
  Program({
    //required this.days,
    required this.endProgram,
  });
  //late final List<Days> days;
  late final String endProgram;

  /*Program.fromJson(Map<String, dynamic> json) {
    //days = List.from(json['days']).map((e) => Days.fromJson(e)).toList();
    endProgram = json['end_program'];
  }*/

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        endProgram: json["end_program"] == null ? null : json["end_program"],
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    //_data['days'] = days.map((e) => e.toJson()).toList();
    _data['end_program'] = endProgram;

    /*if (this.endProgram.isEmpty) {
      endProgram = '1900-01-01';
    }*/
    return _data;
  }
}*/

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

/*class Days {
  Days({
    required this.name,
  });
  late final List<Days> name;

  Days.fromJson(Map<String, dynamic> json) {
    days = List.from(json['days']).map((e) => Days.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['days'] = days.map((e) => e.toJson()).toList();
    return _data;
  }
}*/

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

import '../../domain/entities/pet.dart';

class WeightModel {
  final String? imperial;
  final String? metric;

  WeightModel({this.imperial, this.metric});

  factory WeightModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return WeightModel();
    }
    return WeightModel(
      imperial: json['imperial'] as String?,
      metric: json['metric'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'imperial': imperial, 'metric': metric};
  }

  Weight toEntity() {
    return Weight(imperial: imperial ?? '', metric: metric ?? '');
  }
}

class PetModel {
  final WeightModel? weight;
  final String? id;
  final String? name;
  final String? temperament;
  final String? origin;
  final String? countryCodes;
  final String? countryCode;
  final String? description;
  final String? lifeSpan;
  final int? indoor;
  final String? altNames;
  final int? adaptability;
  final int? affectionLevel;
  final int? childFriendly;
  final int? dogFriendly;
  final int? energyLevel;
  final int? grooming;
  final int? healthIssues;
  final int? intelligence;
  final int? sheddingLevel;
  final int? socialNeeds;
  final int? strangerFriendly;
  final int? vocalisation;
  final int? experimental;
  final int? hairless;
  final int? natural;
  final int? rare;
  final int? rex;
  final int? suppressedTail;
  final int? shortLegs;
  final String? wikipediaUrl;
  final int? hypoallergenic;
  final String? referenceImageId;

  PetModel({
    this.weight,
    this.id,
    this.name,
    this.temperament,
    this.origin,
    this.countryCodes,
    this.countryCode,
    this.description,
    this.lifeSpan,
    this.indoor,
    this.altNames,
    this.adaptability,
    this.affectionLevel,
    this.childFriendly,
    this.dogFriendly,
    this.energyLevel,
    this.grooming,
    this.healthIssues,
    this.intelligence,
    this.sheddingLevel,
    this.socialNeeds,
    this.strangerFriendly,
    this.vocalisation,
    this.experimental,
    this.hairless,
    this.natural,
    this.rare,
    this.rex,
    this.suppressedTail,
    this.shortLegs,
    this.wikipediaUrl,
    this.hypoallergenic,
    this.referenceImageId,
  });

  factory PetModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PetModel();
    }
    return PetModel(
      weight: WeightModel.fromJson(json['weight'] as Map<String, dynamic>?),
      id: json['id'] as String?,
      name: json['name'] as String?,
      temperament: json['temperament'] as String?,
      origin: json['origin'] as String?,
      countryCodes: json['country_codes'] as String?,
      countryCode: json['country_code'] as String?,
      description: json['description'] as String?,
      lifeSpan: json['life_span'] as String?,
      indoor: json['indoor'] as int?,
      altNames: json['alt_names'] as String?,
      adaptability: json['adaptability'] as int?,
      affectionLevel: json['affection_level'] as int?,
      childFriendly: json['child_friendly'] as int?,
      dogFriendly: json['dog_friendly'] as int?,
      energyLevel: json['energy_level'] as int?,
      grooming: json['grooming'] as int?,
      healthIssues: json['health_issues'] as int?,
      intelligence: json['intelligence'] as int?,
      sheddingLevel: json['shedding_level'] as int?,
      socialNeeds: json['social_needs'] as int?,
      strangerFriendly: json['stranger_friendly'] as int?,
      vocalisation: json['vocalisation'] as int?,
      experimental: json['experimental'] as int?,
      hairless: json['hairless'] as int?,
      natural: json['natural'] as int?,
      rare: json['rare'] as int?,
      rex: json['rex'] as int?,
      suppressedTail: json['suppressed_tail'] as int?,
      shortLegs: json['short_legs'] as int?,
      wikipediaUrl: json['wikipedia_url'] as String?,
      hypoallergenic: json['hypoallergenic'] as int?,
      referenceImageId: json['reference_image_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight?.toJson(),
      'id': id,
      'name': name,
      'temperament': temperament,
      'origin': origin,
      'country_codes': countryCodes,
      'country_code': countryCode,
      'description': description,
      'life_span': lifeSpan,
      'indoor': indoor,
      'alt_names': altNames,
      'adaptability': adaptability,
      'affection_level': affectionLevel,
      'child_friendly': childFriendly,
      'dog_friendly': dogFriendly,
      'energy_level': energyLevel,
      'grooming': grooming,
      'health_issues': healthIssues,
      'intelligence': intelligence,
      'shedding_level': sheddingLevel,
      'social_needs': socialNeeds,
      'stranger_friendly': strangerFriendly,
      'vocalisation': vocalisation,
      'experimental': experimental,
      'hairless': hairless,
      'natural': natural,
      'rare': rare,
      'rex': rex,
      'suppressed_tail': suppressedTail,
      'short_legs': shortLegs,
      'wikipedia_url': wikipediaUrl,
      'hypoallergenic': hypoallergenic,
      'reference_image_id': referenceImageId,
    };
  }

  Pet toEntity() {
    return Pet(
      weight: weight?.toEntity() ?? Weight(imperial: '', metric: ''),
      id: id ?? '',
      name: name ?? '',
      temperament: temperament ?? '',
      origin: origin ?? '',
      countryCodes: countryCodes ?? '',
      countryCode: countryCode ?? '',
      description: description ?? '',
      lifeSpan: lifeSpan ?? '',
      indoor: indoor ?? 0,
      altNames: altNames ?? '',
      adaptability: adaptability ?? 0,
      affectionLevel: affectionLevel ?? 0,
      childFriendly: childFriendly ?? 0,
      dogFriendly: dogFriendly ?? 0,
      energyLevel: energyLevel ?? 0,
      grooming: grooming ?? 0,
      healthIssues: healthIssues ?? 0,
      intelligence: intelligence ?? 0,
      sheddingLevel: sheddingLevel ?? 0,
      socialNeeds: socialNeeds ?? 0,
      strangerFriendly: strangerFriendly ?? 0,
      vocalisation: vocalisation ?? 0,
      experimental: experimental ?? 0,
      hairless: hairless ?? 0,
      natural: natural ?? 0,
      rare: rare ?? 0,
      rex: rex ?? 0,
      suppressedTail: suppressedTail ?? 0,
      shortLegs: shortLegs ?? 0,
      wikipediaUrl: wikipediaUrl ?? '',
      hypoallergenic: hypoallergenic ?? 0,
      referenceImageId: referenceImageId ?? '',
    );
  }
}

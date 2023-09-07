// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    String word;
    String? phonetic;
    List<Phonetic> phonetics;
    List<Meaning> meanings;
    License license;
    List<String> sourceUrls;

    Post({
        required this.word,
        required this.phonetic,
        required this.phonetics,
        required this.meanings,
        required this.license,
        required this.sourceUrls,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        word: json["word"],
        phonetic: json["phonetic"],
        phonetics: List<Phonetic>.from(json["phonetics"].map((x) => Phonetic.fromJson(x))),
        meanings: List<Meaning>.from(json["meanings"].map((x) => Meaning.fromJson(x))),
        license: License.fromJson(json["license"]),
        sourceUrls: List<String>.from(json["sourceUrls"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "word": word,
        "phonetic": phonetic,
        "phonetics": List<dynamic>.from(phonetics.map((x) => x.toJson())),
        "meanings": List<dynamic>.from(meanings.map((x) => x.toJson())),
        "license": license.toJson(),
        "sourceUrls": List<dynamic>.from(sourceUrls.map((x) => x)),
    };
}

class License {
    String name;
    String url;

    License({
        required this.name,
        required this.url,
    });

    factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };
}

class Meaning {
    String partOfSpeech;
    List<Definition> definitions;
    List<String> synonyms;
    List<dynamic> antonyms;

    Meaning({
        required this.partOfSpeech,
        required this.definitions,
        required this.synonyms,
        required this.antonyms,
    });

    factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: List<Definition>.from(json["definitions"].map((x) => Definition.fromJson(x))),
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "partOfSpeech": partOfSpeech,
        "definitions": List<dynamic>.from(definitions.map((x) => x.toJson())),
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms.map((x) => x)),
    };
}

class Definition {
    String definition;
    List<String> synonyms;
    List<dynamic> antonyms;
    String? example;

    Definition({
        required this.definition,
        required this.synonyms,
        required this.antonyms,
        this.example,
    });

    factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
        example: json["example"],
    );

    Map<String, dynamic> toJson() => {
        "definition": definition,
        "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
        "antonyms": List<dynamic>.from(antonyms.map((x) => x)),
        "example": example,
    };
}

class Phonetic {
    String? text;
    String? audio;
    String? sourceUrl;
    License? license;

    Phonetic({
        this.text,
        this.audio,
        this.sourceUrl,
        this.license,
    });

    factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
        text: json["text"],
        audio: json["audio"],
        sourceUrl: json["sourceUrl"],
        license: json["license"] == null ? null : License.fromJson(json["license"]),
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "audio": audio,
        "sourceUrl": sourceUrl,
        "license": license?.toJson(),
    };
}

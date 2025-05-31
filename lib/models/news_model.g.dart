// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsArticleAdapter extends TypeAdapter<NewsArticle> {
  @override
  final int typeId = 0;

  @override
  NewsArticle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsArticle(
      title: fields[0] as String,
      description: fields[1] as String,
      url: fields[2] as String,
      imageUrl: fields[3] as String,
      publishedAt: fields[4] as String,
      source: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewsArticle obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.publishedAt)
      ..writeByte(5)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

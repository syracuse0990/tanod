import 'dart:math';

import 'package:basic_utils/basic_utils.dart';
import 'package:english_words/english_words.dart' as english;
 import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

T anyOf<T>(Iterable<T> iterable) {
  final index = randomInt(iterable.length) % iterable.length;
  return iterable.elementAt(index);
}

bool chancedBool({int successChance = 80}) {
  return randomInt(100) <= successChance;
}

Future delay({int latencyMilliseconds = 1000}) {
  return Future.delayed(Duration(milliseconds: latencyMilliseconds));
}


bool randomBool() {
  return Random.secure().nextBool();
}

DateTime randomPastDateTime() {
  return DateTime.now().subtract(Duration(days: randomInt(100, minimum: 1)));
}

Duration randomDuration({int maximumSeconds = 100000}) {
  return Duration(seconds: randomInt(maximumSeconds, minimum: 45));
}

int randomInt(int maximum, {int minimum = 0}) {
  return max(minimum, Random.secure().nextInt(maximum));
}

String randomDate() {
  return [
    randomInt(31, minimum: 1),
    randomInt(12, minimum: 1),
    randomInt(2022, minimum: 1968),
  ].join("/");
}

Color randomColor() {

  return Color.fromARGB(
    255,
    randomInt(256),
    randomInt(256),
    randomInt(256),
  );
}

String randomPhoneNumber() {
  // 8000000000 <= phoneNumber < 9000000000
  return (8000000000 + randomInt(1000000000)).toString();
}

String randomPhotoUrl({int width = 200, int height = 200}) {
  return anyOf([
    "https://picsum.photos/$width/$height",
    "https://random.imagecdn.app/$width/$height",
    // // "https://via.placeholder.com/${width}x$height",
    "https://cataas.com/cat?filter=blur",
  ]);
}

String randomPersonPhotoUrl() {
  return "https://thispersondoesnotexist.com/image";
}

String randomMusicUrl() {
  return anyOf([
    // "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3",
    // "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3",
    // "https://archive.org/download/igm-v8_202101/IGM%20-%20Vol.%208/15%20Pokemon%20Red%20-%20Cerulean%20City%20%28Game%20Freak%29.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-15.mp3",
    // "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-16.mp3",

    "https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand3.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/CantinaBand60.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/Fanfare60.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/gettysburg10.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/gettysburg.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/ImperialMarch60.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/PinkPanther30.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/PinkPanther60.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/preamble10.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/preamble.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/StarWars3.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/StarWars60.wav",
    "https://www2.cs.uic.edu/~i101/SoundFiles/taunt.wav",
  ]);
}

String randomRadioUrl() {
  return anyOf([
    "https://stream.live.vc.bbcmedia.co.uk/bbc_radio_one",
    "https://streaming.radio.co/s97881c7e0/listen",
  ]);
}

String randomVideoUrl() {
  return anyOf([
    "https://storage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
    "https://storage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
  ]);
}

String randomLiveStreamUrl() {
  return anyOf([
    /// HLS Test Stream (Quality) LIVE
    "https://cph-msl.akamaized.net/hls/live/2000341/test/master.m3u8",
  ]);
}

String randomStreamUrl() {
  // mpd reference
  // https://reference.dashif.org/dash.js/latest/samples/dash-if-reference-player/index.html
  // "https://dash.akamaized.net/akamai/bbb_30fps/bbb_30fps.mpd",
  // "https://d24rwxnt7vw9qb.cloudfront.net/v1/dash/e6d234965645b411ad572802b6c9d5a10799c9c1/All_Reference_Streams/4577dca5f8a44756875ab5cc913cd1f1/index.mpd",

  return anyOf([
    // "https://dash.akamaized.net/dash264/TestCasesHD/2b/qualcomm/1/MultiResMPEG2.mpd",
    // "https://mtoczko.github.io/hls-test-streams/test-group/playlist.m3u8",
    // "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8",

    /// HLS: Qualities
    "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",

    /// HLS: Qualities & Captions
    "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8",

    /// DASH: Qualities & Captions
    "https://bitmovin-a.akamaihd.net/content/sintel/sintel.mpd",
  ]);
}

String randomText(int wordCount) {
  final pairs = english.generateWordPairs().take(wordCount);
  final words = List<String>.empty(growable: true);
  for (var pair in pairs) {
    words.add(pair.first);
    words.add(pair.second);
  }
  final text = words.take(wordCount).join(" ");
  return StringUtils.capitalize(text, allWords: true);
}

String randomUuid() {
  return _UuidHelper.create();
}

class _UuidHelper {
  static const Uuid uuid = Uuid();

  static String create() {
    return uuid.v4();
  }
}

import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reqhub/config/app_typography.dart';

const _fontAsset = 'assets/fonts/NotoSansSC-Variable.ttf';

Future<Uint8List> _renderWeight(FontWeight weight) async {
  final text = TextPainter(
    text: TextSpan(
      text: '设置 数据存储 外观 请求设置 中文',
      style: TextStyle(
        fontFamily: appFontFamily,
        fontSize: 18,
        fontWeight: weight,
        color: Colors.black,
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  final recorder = ui.PictureRecorder();
  text.paint(Canvas(recorder), Offset.zero);
  final picture = recorder.endRecording();
  final image = await picture.toImage(500, 48);
  final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  final result = Uint8List.fromList(
    data!.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
  );
  image.dispose();
  picture.dispose();
  text.dispose();
  return result;
}

int _inkCoverage(Uint8List image) {
  var coverage = 0;
  for (var i = 3; i < image.length; i += 4) {
    coverage += image[i];
  }
  return coverage;
}

void main() {
  testWidgets(
    'Bundled Chinese font has a native weight axis covering UI weights',
    (tester) async {
      final data = await rootBundle.load(_fontAsset);
      var foundWeightAxis = false;
      final tableCount = data.getUint16(4);
      for (var table = 0; table < tableCount; table++) {
        final record = 12 + table * 16;
        if (data.getUint32(record) != 0x66766172) continue; // fvar
        final fvar = data.getUint32(record + 8);
        final axes = fvar + data.getUint16(fvar + 4);
        final axisCount = data.getUint16(fvar + 8);
        final axisSize = data.getUint16(fvar + 10);
        for (var axis = 0; axis < axisCount; axis++) {
          final offset = axes + axis * axisSize;
          if (data.getUint32(offset) != 0x77676874) continue; // wght
          foundWeightAxis = true;
          expect(data.getInt32(offset + 4) / 65536, lessThanOrEqualTo(400));
          expect(data.getInt32(offset + 12) / 65536, greaterThanOrEqualTo(700));
        }
      }
      expect(
        foundWeightAxis,
        isTrue,
        reason: 'A static font would reintroduce missing semibold weights.',
      );
    },
  );

  testWidgets(
    'Chinese 400, 500, 600 and 700 paint distinct, progressively heavier strokes',
    (tester) async {
      await tester.runAsync(() async {
        final loader = FontLoader(appFontFamily)
          ..addFont(rootBundle.load(_fontAsset));
        await loader.load();
        Uint8List? previous;
        var previousCoverage = 0;
        for (final weight in [
          FontWeight.w400,
          FontWeight.w500,
          FontWeight.w600,
          FontWeight.w700,
        ]) {
          final pixels = await _renderWeight(weight);
          final coverage = _inkCoverage(pixels);
          expect(
            coverage,
            greaterThan(previousCoverage),
            reason:
                'Chinese $weight must have a real intermediate stroke weight.',
          );
          if (previous != null) {
            expect(
              listEquals(previous, pixels),
              isFalse,
              reason: '$weight must not collapse to the previous weight.',
            );
          }
          previous = pixels;
          previousCoverage = coverage;
        }
      });
    },
  );
}

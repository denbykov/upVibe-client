import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

ThemeData get themeData {
  const int primaryColor = 0xFFC0000A;
  const int secondaryColor = 0xFF775652;
  const int tertiaryColor = 0xFF705C2E;
  const int neutralColor = 0xFF998e8d;
  const int neutralVariantColor = 0xFFA08C89;

  List<int> colors = <int>[
    ...toTonalPalette(primaryColor).asList,
    ...toTonalPalette(secondaryColor).asList,
    ...toTonalPalette(tertiaryColor).asList,
    ...toTonalPalette(neutralColor).asList,
    ...toTonalPalette(neutralVariantColor).asList,
  ].toList();

  ColorScheme colorScheme =
      CorePaletteToColorScheme(CorePalette.fromList(colors))
          .toColorScheme(brightness: Brightness.dark);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}

TonalPalette toTonalPalette(int value) {
  final color = Hct.fromInt(value);
  return TonalPalette.of(color.hue, color.chroma);
}

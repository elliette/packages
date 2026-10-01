# API Changes

Material 3 Expressive introduces new emphasized type styles for all the existing main text styles (e.g. displayLarge and emphasizedDisplayLarge).

According to the M3E spec:

"the emphasized variant is intended to be used for bold, selection, and other areas of emphasis. Material components don’t use emphasized type styles by default. To use an emphasized type style, swap the baseline token for the emphasized token of the same style. Baseline and emphasized styles are meant to be used together."

## Proposed new TextTheme

```
class TextTheme with Diagnosticable {
  const TextTheme({
    this.displayLarge,
    this.displayMedium,
    this.displaySmall,
    this.headlineLarge,
    this.headlineMedium,
    this.headlineSmall,
    this.titleLarge,
    this.titleMedium,
    this.titleSmall,
    this.bodyLarge,
    this.bodyMedium,
    this.bodySmall,
    this.labelLarge,
    this.labelMedium,
    this.labelSmall,
    this.displayLargeEmphasized,
    this.displayMediumEmphasized,
    this.displaySmallEmphasized,
    this.headlineLargeEmphasized,
    etc.
  });
  ...
}
```

## Propose new usage:

`Theme.of(...).textTheme.titleMediumEmphasized`


# Potential Breaking Changes

## Replace tall/englishLike with alphabetic and dense with ideographic

In Material versions for Material 3, tall scripts had larger default font sizes and different line heights than English-like and dense scripts.

However, in Material 3 onwards, tall and englishLike scripts are identical, and the only difference between them and dense scripts is that the dense scripts use ideographic baselines instead of alphabetic baselines. Therefore, in Material 3 onwards, we have three separate TextThemes to represent a single text baseline difference.

### Proposal

Pre-M2 Deprecation:

- gen_defaults generates only alphabetic and ideographic TextThemes for M3E
- Use alphabetic TextTheme in all public APIs that expect englishLike or tall
- Use ideographic TextTheme in all public APIs that expect englishLike or tall

Post-M2 Deprecation:

- Replace dense, tall and englishLike APIs with alphabetic and ideographic

## Decouple text color and text geometry

Because the font colors are defined in the platform-specific TextThemes, there is currently no paradigmatic way to provide Material version-specific colors or font families. See section How is an app’s TextTheme is resolved?

However, because Material 3 ties font colors to the app’s color scheme, the Typography.material2021 factory constructor currently modifies the colors of the black and white TextThemes, making the black and white parameters poorly named. 

### Proposal

Pre-M2 Deprecation:

- Create a new factory constructor Typography._withM3Colors to be used by material2021 and material2026 factory constructors. _withM3Colors takes either geometry TextTheme or black/white TextTheme 
- Typography.material2021 continues to use black/white
- Typography.material2026 instead uses geometry

Post-M2 Deprecation:

- Remove all references to black and white TextThemes and replace with geometry


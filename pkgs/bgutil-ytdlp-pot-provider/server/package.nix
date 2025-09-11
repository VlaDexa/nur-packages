{
  buildNpmPackage,
  cairo,
  giflib,
  lib,
  libjpeg,
  librsvg,
  meta,
  nodejs,
  pango,
  pixman,
  pkg-config,
  src,
  typescript,
  version,
  ...
}:
buildNpmPackage (finalAttrs: {
  inherit
    nodejs
    src
    version
    meta
    ;

  pname = "bgutil-ytdlp-pot-provider";

  sourceRoot = "${finalAttrs.src.name}/server";

  nativeBuildInputs = [
    pkg-config
    typescript
  ];

  buildInputs = [
    cairo
    giflib
    libjpeg
    librsvg
    pango
    pixman
  ];

  makeCacheWritable = true;
  npmDepsHash = "sha256-lCK7ukI60Exe+PW0rATm3szzWDv8AaVJPS6Hl9Rfm18=";

  buildPhase = ''
    runHook preBuild

    tsc

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r build $out/build
    sed -i "1i\#!${lib.getExe finalAttrs.nodejs}" $out/build/main.js
    cp -r node_modules $out/node_modules
    ln -s $out/build/main.js $out/bin/bgutil-ytdlp-pot-provider
    chmod +x $out/bin/bgutil-ytdlp-pot-provider

    runHook postInstall
  '';
})

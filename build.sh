#!/usr/bin/env bash
set -euo pipefail

# === Paths ===
SRC="src/main/java/org/example"
WEBAPP="src/main/webapp"
RESOURCES="src/main/resources"
OUT="build"
LIB="lib"
WAR_NAME="VelonKan.war"

# Clean and create output directory
rm -rf "$OUT"
mkdir -p "$OUT"

# Collect Java sources
echo "Creating source list..."
find "$SRC" -name '*.java' > sources.txt

# Compile
echo "Compiling Java files..."
javac -encoding UTF-8 -source 17 -target 17 -cp "$LIB/*" -d "$OUT/WEB-INF/classes" @sources.txt

# Copy webapp
echo "Copying webapp files..."
cp -r "$WEBAPP/." "$OUT/"

# Copy resources
echo "Copying resources..."
if [[ -d "$RESOURCES" ]]; then
  cp -r "$RESOURCES/." "$OUT/WEB-INF/classes/"
else
  echo "Warning: resources directory '$RESOURCES' not found!"
fi

# Copy libraries
echo "Copying libraries..."
mkdir -p "$OUT/WEB-INF/lib"
cp "$LIB/"*.jar "$OUT/WEB-INF/lib/" || echo "No JARs found in $LIB"

# Build WAR
echo "Creating WAR: $WAR_NAME"
cd "$OUT"
jar -cvf "../$WAR_NAME" *
cd ..

echo "🎉 WAR generated successfully: $WAR_NAME"
echo "Please verify application.properties is present in WEB-INF/classes"

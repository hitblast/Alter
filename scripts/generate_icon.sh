#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./generate_icon.sh image.png"
  exit 1
fi

PNG_FILE="$1"

if [ ! -f "$PNG_FILE" ]; then
  echo "File not found: $PNG_FILE"
  exit 1
fi

ICON_NAME=$(basename "$PNG_FILE" .png)
PARENT_DIR=$(dirname "$PNG_FILE")
ICONSET_DIR="${PARENT_DIR}/${ICON_NAME}.iconset"

mkdir -p "$ICONSET_DIR"

/usr/bin/sips -z 16 16 "$PNG_FILE" --out "$ICONSET_DIR/icon_16x16.png"
/usr/bin/sips -z 32 32 "$PNG_FILE" --out "$ICONSET_DIR/icon_16x16@2x.png"
/usr/bin/sips -z 32 32 "$PNG_FILE" --out "$ICONSET_DIR/icon_32x32.png"
/usr/bin/sips -z 64 64 "$PNG_FILE" --out "$ICONSET_DIR/icon_32x32@2x.png"
/usr/bin/sips -z 64 64 "$PNG_FILE" --out "$ICONSET_DIR/icon_64x64.png"
/usr/bin/sips -z 128 128 "$PNG_FILE" --out "$ICONSET_DIR/icon_64x64@2x.png"
/usr/bin/sips -z 128 128 "$PNG_FILE" --out "$ICONSET_DIR/icon_128x128.png"
/usr/bin/sips -z 256 256 "$PNG_FILE" --out "$ICONSET_DIR/icon_128x128@2x.png"
/usr/bin/sips -z 256 256 "$PNG_FILE" --out "$ICONSET_DIR/icon_256x256.png"
/usr/bin/sips -z 512 512 "$PNG_FILE" --out "$ICONSET_DIR/icon_256x256@2x.png"
/usr/bin/sips -z 512 512 "$PNG_FILE" --out "$ICONSET_DIR/icon_512x512.png"
/usr/bin/sips -z 1024 1024 "$PNG_FILE" --out "$ICONSET_DIR/icon_512x512@2x.png"

echo "Iconset created at $ICONSET_DIR"

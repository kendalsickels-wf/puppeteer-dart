set -e

if [[ -z "$DART_SDK_VERSION" ]]; then
  DART_SDK_VERSION='2.7.0'
fi

case "$OSTYPE" in
  darwin*)  DART_ZIP_NAME="dartsdk-macos-x64-release.zip" ;;
  linux*)   DART_ZIP_NAME="dartsdk-linux-x64-release.zip" ;;
  *)        DART_ZIP_NAME="dartsdk-windows-x64-release.zip" ;;
esac

DART_CHANNEL="stable"
if [[ $DART_SDK_VERSION == *"-dev."* ]]; then
  DART_CHANNEL="dev"
fi

DART_SDK_URL="https://storage.googleapis.com/dart-archive/channels/$DART_CHANNEL/raw/$DART_SDK_VERSION/sdk/$DART_ZIP_NAME"

wget -qO- $DART_SDK_URL | tar -xvzf -

DART_SDK_BIN_PATH=$(pwd)/dart-sdk/bin
echo "::add-path::$DART_SDK_BIN_PATH"

(cd "$DART_SDK_BIN_PATH"; ls -l)
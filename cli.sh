#!/bin/bash -e
#
# Usage:
#   $ curl -fsSL https://raw.githubusercontent.com/pact-foundation/pact-ruby-standalone/master/install.sh | bash
# or
#   $ wget -q https://raw.githubusercontent.com/pact-foundation/pact-ruby-standalone/master/install.sh -O- | bash
#
detected_os=$(uname -sm)
echo detected_os = $detected_os
case ${detected_os} in
'Linux x86_64' | "Linux"*)
    echo 'using linux-x86_64'
    os='linux-x86_64'
    ;;
'Darwin x86' | 'Darwin x86_64' | 'Darwin arm64' | "Darwin"*)
    echo 'using osx'
    os='osx'
    ;;
"Windows"* | "MINGW64"*)
    echo 'using win32'
    os='win32'
    ;;
  *)
  echo "Sorry, you'll need to install the pact-ruby-standalone manually."
  echo "or add your os to the list"
  exit 1
    ;;
esac

tag=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/pact-foundation/pact-ruby-standalone/releases/latest))
case $os in
'linux-x86_64' | 'osx')
    filename="pact-${tag#v}-${os}.tar.gz"
    curl -LO https://github.com/pact-foundation/pact-ruby-standalone/releases/download/${tag}/${filename}
    tar xzf ${filename}
    ;;
'win32')
    filename="pact-${tag#v}-${os}.zip"
    curl -LO https://github.com/pact-foundation/pact-ruby-standalone/releases/download/${tag}/${filename}

    unzip ${filename}
    ext=.bat
    ;;
esac
rm ${filename}
pact/bin/pact-broker${ext} help
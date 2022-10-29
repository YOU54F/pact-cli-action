#!/bin/bash

case $(uname -sm) in
'Linux x86_64')
    os='linux-x86_64'
    ;;
'Darwin x86' | 'Darwin x86_64' | 'Darwin arm64')
    os='osx'
    ;;
'Windows')
    os='win32'
    ;;
esac

tag=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/pact-foundation/pact-ruby-standalone/releases/latest))
filename="pact-${tag#v}-${os}.tar.gz"
curl -LO https://github.com/pact-foundation/pact-ruby-standalone/releases/download/${tag}/${filename}
case $os in
'linux-x86_64' | 'osx')
    tar xzf ${filename}
    ;;
'win32')
    unzip ${filename}
    ext=.bat
    ;;
esac
rm ${filename}
./pact/bin/pact-broker${ext} help
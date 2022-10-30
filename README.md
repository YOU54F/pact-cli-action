# pact ruby cli action

Pact standalone CLI

```yml
on: 
  workflow_dispatch:
  push:
  
jobs:
  test_cli_action:
    strategy:
      matrix:
        os: [ubuntu-latest,windows-latest,macos-latest]
      fail-fast: false
    runs-on: ${{ matrix.os }}
    name: test pact cli action
    steps:
      - uses: actions/checkout@v3
      - id: pact-cli
        uses: you54f/paction@v1
      - run: pact-broker.bat
        if: runner.os == 'windows'
        shell: cmd
      - run: pact-broker
        if: runner.os != 'windows'
        shell: bash
```

other ways you can download

```yml
name: Build

on:
  push:
  workflow_dispatch:

jobs:
  ubuntu:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3
      - run: curl -fsSL https://raw.githubusercontent.com/pact-foundation/pact-ruby-standalone/master/install.sh | bash && pact/bin/pact help
      - run: wget -q https://raw.githubusercontent.com/pact-foundation/pact-ruby-standalone/master/install.sh -O- | bash
      - run: echo "PATH=${PATH}:${PWD}/pact/bin/" >> $GITHUB_ENV

```

```yml
  mac:
    runs-on: macos-latest

    steps:
      - uses: actions/checkout@v3
      - run: ./cli.sh
      - run: |
          brew tap pact-foundation/pact-ruby-standalone
          brew install pact-ruby-standalone
          pact help
        shell: bash
      - run: curl -fsSL https://raw.githubusercontent.com/pact-foundation/pact-ruby-standalone/master/install.sh | bash && pact/bin/pact help
      - run: echo "PATH=${PATH}:${PWD}/pact/bin/" >> $GITHUB_ENV

```
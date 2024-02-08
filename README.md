# Caracal

Note: This project is an in-house fork of [Caracal](https://github.com/urvin-compliance/caracal), which is licensed under the MIT software license. The original README can be viewed [here](README-upstream.md).

### Install Dependencies

To install gems, use the provided script

```bash
install-gems.sh
```

Note that by default the `install-gems` script assumes you are in a non-development (aka operational) environment. Consequently, it will _not_ install development dependencies.

If you need development dependencies, you will need to configure your environment before running the script:

```bash
POSTURE=development install-gems.sh
```

### Publishing

```bash
./publish.sh
```

Copyright (c) 2020-present WSGR

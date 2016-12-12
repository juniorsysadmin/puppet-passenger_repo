# passenger_repo

[![Build Status](https://secure.travis-ci.org/juniorsysadmin/puppet-passenger_repo.png)](http://travis-ci.org/juniorsysadmin/puppet-passenger_repo)

#### Table of Contents

1. [Overview](#overview)
1. [Usage](#usage)
1. [Limitations](#limitations)
1. [Development](#development)

## Overview

This module installs and enables the Phusion Passenger OSS or Enterprise APT
repository. When run on a non-Debian variant it exits with no action
performed.

## Usage

Install the Phusion Passenger OSS APT repository:

```puppet
include  '::passenger_repo'
```

Install the Phusion Passenger Enterprise APT repository:

```puppet
class {'::passenger_repo':
  enterprise_license_key => 'abc12345',
  enterprise_token       => 'DEF6789',
```

Use the Phusion OSS package and the `puppetlabs-apache` module:

```puppet
class {'::apache': }
class {'::passenger_repo': }->
class {'::apache::mod::passenger': }
```

Use the Phusion Enterprise package and the `puppetlabs-apache` module:

```puppet
class {'::apache': }
class {'::passenger_repo':
  enterprise_license_key => 'abc12345',
  enterprise_token       => 'DEF6789',
}->
class {'::apache::mod::passenger':
  mod_package => 'libapache2-mod-passenger-enterprise',
}
```

### Parameters

The following parameters are available in the passenger_repo module:

#### `ensure`

Whether to ensure the repository is present or absent. Defaults to present.

#### `enterprise_license_key`

The license key to use for installing the Phusion Enterprise APT repository.
If set, the Enterprise repository will be installed. Otherwise the OSS APT
repository is installed.

#### `enterprise_repo_name`

Used for the name of the Enterprise Phusion Passenger repository. Defaults to
'phusion_passenger_enterprise'.

#### `enterprise_token`

The download token used for downloading from the Phusion Enterprise APT
repository.

#### `key_id`

The key (fingerprint) id to fetch from the key server.

#### `key_server`

The key server used for APT key fetches. Defaults to keyserver.ubuntu.com.

#### `oss_repo_name`

Used for the name of the Phusion Passenger OSS repository. Defaults to
'phusion_passenger'.

#### `pin`

Whether to perform APT pinning to pin the repository with a specific
value. Defaults to `false`.

## Limitations

This module has received limited testing on:

* Debian 6
* Debian 7
* Ubuntu 10.04
* Ubuntu 12.04
* Ubuntu 14.04

## Development

Patches are welcome.

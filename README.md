# Menu-CLI
 [![Build Status](https://secure.travis-ci.org/kurtisnelson/menu-cli.png)](http://travis-ci.org/kurtisnelson/menu-cli)
[![Gem Version](https://badge.fury.io/rb/menu-cli.png)](http://badge.fury.io/rb/menu-cli)
[![Code Climate](https://codeclimate.com/github/kurtisnelson/menu-cli.png)](https://codeclimate.com/github/kurtisnelson/menu-cli)
[![Coverage Status](https://coveralls.io/repos/kurtisnelson/menu-cli/badge.svg)](https://coveralls.io/r/kurtisnelson/menu-cli)
[![Dependency Status](https://gemnasium.com/kurtisnelson/menu-cli.png)](https://gemnasium.com/kurtisnelson/menu-cli)
[Documentation](http://rubydoc.info/gems/menu-cli/)

## Installation

`gem install menu-cli`

Make sure you have the following in your environment:

```bash
AWS_ID="AWS ID per AWS-SDK docs"
AWS_SECRET="AWS Secret per AWS-SDK docs"
MENU_URL="Raw bucket URL, of the format http://bucket-name.regionstuff.s3.amazon.com"
MENU_SSL_URL="URL to be used to fetch assets, should be https://menu.yourdomain.com"
MENU_BUCKET="Name of bucket to store artifacts"
```

## Usage

`menu -c COMPONENT payload` to deploy
`menu -h` for help.

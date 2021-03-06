| Build | AppVeyor (Windows) | Travis CI (Linux / macOS) | Code Coverage |
|:-----:|:------------------:|:--------------------------:|:-------------:|
| Master | [![Build status](https://ci.appveyor.com/api/projects/status/8a4jsfv42tbmlym8/branch/master?svg=true)](https://ci.appveyor.com/project/nferrell/VaporShell/branch/master) |  [![Build Status](https://travis-ci.org/scrthq/VaporShell.svg?branch=master)](https://travis-ci.org/scrthq/VaporShell) | [![Coverage Status](https://coveralls.io/repos/github/scrthq/Vaporshell/badge.svg?branch=dev)](https://coveralls.io/github/scrthq/Vaporshell?branch=master) |
| Dev | [![Build status](https://ci.appveyor.com/api/projects/status/8a4jsfv42tbmlym8/branch/dev?svg=true)](https://ci.appveyor.com/project/nferrell/VaporShell/branch/dev) | [![Build Status](https://travis-ci.org/scrthq/VaporShell.svg?branch=dev)](https://travis-ci.org/scrthq/VaporShell) | [![Coverage Status](https://coveralls.io/repos/github/scrthq/Vaporshell/badge.svg?branch=dev)](https://coveralls.io/github/scrthq/Vaporshell?branch=dev) |


# *VaporShell* 

[VaporShell](http://VaporShell.io/) is a module for Powershell that allows easier and less error prone build outs of AWS CloudFormation JSON templates using familiar syntax and structure to define AWS resources, while simultaneously gaining the capabilities of Powershell and removing the need to work with JSON directly.

VaporShell allows you to either initialize a new template or import an existing template, add appropriate properties and export it out to JSON.

***

### Like what's happening and want to send over some coffee money for fuel? Invoke-Donation by clicking below!

[![Donate through Paypal](https://img.shields.io/badge/paypal-donate-brightgreen.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=GU6CJMFGVP6ZS) [![Donate through Gratipay](https://img.shields.io/gratipay/user/scrthq.svg)](https://gratipay.com/VaporShell)

***

## Getting Started (Documentation)

http://VaporShell.io/docs

***

## Module Digest (Deeper Dive)

http://VaporShell.io/docs/digest

***

## Tips & Tricks

http://VaporShell.io/docs/tips


***

## Examples

http://VaporShell.io/docs/examples


***

## Change Log

http://VaporShell.io/changelog

***

## Disclaimer

This module is only to be used to ease creation of CloudFormation templates. Any stack creations within AWS are the responsibility of the person/group deploying it, so please validate any template builds using `aws cloudformation validate-template`! ([Click here for documentation from AWS](http://docs.aws.amazon.com/cli/latest/reference/cloudformation/validate-template.html))

If you find any oddities with the template build, please open an issue here on GitHub and include your script with sensitive data redacted, what you were expecting it to add to the template and what actually was added.

Thanks!

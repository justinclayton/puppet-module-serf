[![Build Status](https://travis-ci.org/justinclayton/puppet-module-serf.svg?branch=master)](https://travis-ci.org/justinclayton/puppet-module-serf)

Description
-------
This module installs [Serf](http://serfdom.io), installs an init script appropriate for your distro,
and manages agent configuration via a JSON file. It is compliant with both puppet 2.7+ and 3+, and has been tested for quality using [puppet-lint](http://github.com/puppetlabs/puppet-lint), [rspec-puppet](http://github.com/rodjek/rspec-puppet), and [rspec-system](http://github.com/puppetlabs/rspec-system).

Installation
------
If you're using librarian-puppet, add a line to your `Puppetfile`:

```
mod 'justinclayton/serf', '1.x'
```

Usage
------
```
include serf
```

Support
-------

You are welcome to submit [pull requests](https://github.com/justinclayton/puppet-module-serf/pull_requests) and [post issues](https://github.com/justinclayton/puppet-module-serf/issues).

License
-------
MIT
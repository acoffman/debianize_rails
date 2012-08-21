debianize_rails
---

-----

Does the bare minimum to get a Rails application packaged up for debian.

Tries to figure out some sane defaults from the environment it was run in and sub those values into the debian/* files that it will create. Most values are overridable at the command line and the generated defaults will obviously differ from what is seen below.

        Usage (in rails app directory): debianize_rails [opts]

        This command will attempt to intuit sane defaults (overridable with options) to generate the intial 
        debian packaging files needed to make a .deb. It will then try to build the package.
        WARNING: This can blow away any existing debian directory you have, so be careful!

        Options:
            -c, --compat LEVEL               debian package compatability level (default: 7)
            -l, --license LICENSE            License to use in debian copyright file (default: GPLv2)
                                             valid values: mit, artistic, gpl2, gpl3
            -a, --author AUTHOR              author name to use in debian files (default: Adam Coffman)
            -e, --email EMAIL                email address to use in debian files (default: acoffman@genome.wustl.edu)
            -d, --depends PACKAGE1,PACKAGE2  List of debian package dependencies (app specific, not for rails in general)
            -n, --package-name NAME          Name of debian package to construct (default: dgi-db)
            -v, --package-version VERSION    Version to set the debian package to (default: 0.1)
            -t, --target-app PATH            Path to the app to be packaged (default: /gscuser/acoffman/testing/dgi-db)
            -s, --server-path PATH           Deploy location on your server (default: /var/www)
            -b, --bootstrap                  Bootstrap a new debian directory
            -p, --build-package              Build a .deb
            -h, --help                       Display this screen

# lxml scripts

This repo contains two scripts that build lxml from source code on a newly created Debian Linux bookworm GCP Compute VM. They must be run from the home directory. Also, they probably work in many similar environments, perhaps with minor modifications. They are based on the [lxml documentation](https://lxml.de/) for building the library, but written in the form of a single script.

## The scripts

The repo contains two scripts. The scripts are both designed to prepare a new VM to be used for remote development, debugging, and testing of lxml and its dependencies. Each script builds lxml, and then opens an interactive Python session where lxml can be imported. One script does a static build. This means that it downloads the two C libraries that are dependencies, and then installs them, all before building lxml. The script that builds non-statically builds the C dependencies from source, and then uses them to build lxml.

## Script best practices

The scripts follow various best practices. Firstly, they install a minimal number of dependencies from the Debian package manager `apt`, for resource-constrained environments. In addition, they run a minimal number of commands to build the C libraries. After running the non-static script, the C dependency code is built in such a way that it can can be edited and built again for testing lxml without having to rebuild lxml itself unless lxml code changes. This can be done by running `make` and `sudo make install`. Conversely, if lxml changes but its dependencies don't, then only the command that builds lxml must be run.

## How to run the scripts

The scripts are designed to be run on a newly created GCP Compute VM using a Debian bookworm image. It may be convenient to run `sudo apt install git` first so you can clone the scripts and run them, rather than copying and pasting from GitHub or some other way.
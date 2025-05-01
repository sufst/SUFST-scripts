# Scripts
Utility CI/CD scripts for [sufst/pcb](https://github.com/sufst/pcb/) repository

## List of scripts
### `docker`
This directory contains a docker script to build an image with the KiCad CLI and some other dependencies.

- `Dockerfile` - the Dockerfile that contains the dependencies
- `build.sh` - While inside the directory (i.e. after running `cd docker`), run this script with your username and the docker image name, e.g. `./build.sh username/packagename`.
 
This image is currently uploaded to Docker Hub as [`maartin0/kicadutils`](https://hub.docker.com/r/maartin0/kicadutils/) but can be moved/renamed as needed

---
### `gen`
Generation scripts for various KiCad related outputs.

#### `fab.sh`
Usage: `./gen/fab.sh <pcb> <release dir>`

Generates gerber files for every layer and zips them in a file called `Fabrication.zip`, placing it in `<release dir>`

#### `schem.sh`
Usage: `./gen/schem.sh <sch> <release dir>`

Generates a PDF schematic of the provided schematic, called `Schematic.pdf` in `<release dir>`. This can be multiple pages for a hierarchical schematic.

#### `ibom.sh`
Usage: `./gen/ibom.sh <pcb> <release dir>`

Generates an [Interactive HTML BOM](https://github.com/openscopeproject/InteractiveHtmlBom) for the provided PCB, placing it in `<release dir>`

#### `pr-message.sh`
Usage: `./gen/pr-message.sh <changes base ref>`

This script doesn't generate KiCad outputs as such; but discovers a project based on changes between the current and provided git branch, then writes a message to trigger later auto generation.

`<changes base ref>` will typically be `origin/main` as this is where a PR is typically merged into

---
### `test`
Testing scripts for specific scenarios

#### `drc.sh`
Usage: `./test/drc.sh <pcb>`

Runs the KiCad design rules checker on the provided PCB, exiting with a non-zero exit code on errors

#### `erc.sh`
Usage: `./test/erc.sh <schematic>`

Runs the KiCad electrical rules checker on the provided schematic, exiting with a non-zero exit code on errors

#### `relative.sh`
Usage: `./test/relative.sh <library table>`

Searches the provided file (ending in `-lib-table`) for non-relative paths

---
### `util`
Various utility scripts for setting up/searching in the current environment

#### `copy-lib-tables.sh`
Usage: `./util/copy-lib-tables.sh`

Initialises `~/.config/kicad/<version>` and copies the default lib tables from `/usr/share/kicad/template/` to that directory

#### `find-root-schem.sh`
Usage: `./util/find-root-schem.sh <schematic>`

Finds all root KiCad schematics associated with the provided schematic. 

This is important since if a child schematic has been modified without modifying the parent since you can only run KiCad's ERC on the root schematic, not the children which are automatically included in the check

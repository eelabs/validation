# go-lib-template

![Actions Status](https://github.com/eelabs/go-lib-template/workflows/build/badge.svg)

Template repository for AWS targeted Golang libraries. This template can be used for non-AWS libs too you just need to delete the AWS related files/build steps.

## ToDos

Using this repo as a template only gets you so far, you will need to do the following:

* Update `README.md`, by replacing references to `go-lib-template` with the new library name and deleting other text not relevant.

* Update `.github/workflows/gobuild.yml` by replacing `<ADD_GITHUB_ORGANISATION>` with the GitHub Organisation name

* Delete `LICENSE` if not applicable.

* Update the [localstack](https://github.com/localstack/localstack) `docker-compose.yml` with other mock/fake AWS services that are needed for your unit tests. Default config is setup to start `dynamodb` only.

* If required, add DynamoDB schema definitions, else delete `/schema` dir
    * `.github/workflows/gobuild.yml`

* Go to GitHub Settings / Branch protection rules / Click Add rule:
    * Name rule after the branch, e.g. `master`
    * Check `Require status checks to pass before merging` and all sub categories
    * Check `Include administrators`

* For referencing private repo then the `secret.MACHINE_ACCESS_TOKEN` is required
    * Go to GitHub Settings / Secrets / Click `Add new secret`
    * Add Name of `MACHINE_ACCESS_TOKEN`
    * Add Value of a personal access token.

* If private repository, for `go mod` to be able to reference other private repositories when run locally : `export GOPRIVATE="github.com/{GITHUB_ORGANISATION}"`

* Delete the `ToDos` text from the `README.md` as it is no longer needed.

Once you have completed the above you are all set to create the next best thing!

## Versioning / Release Strategy
This repository follows [Semver](https://www.semver.org) versioning strategy

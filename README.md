# wp-coding-standards

PHP tool binaries for BSU WordPress development. Installed via npm, ships the following tools in `vendor/bin/`:

| Binary | Version | Purpose |
|---|---|---|
| `phpcs` | 4.x | PHP CodeSniffer — enforces BSUPhpLint coding standards |
| `phpcbf` | 4.x | PHP Code Beautifier — auto-fixes PHPCS violations |
| `phpstan` | 1.x | PHPStan — static analysis for type safety and correctness |

## Consuming the Package

Published to GitHub Packages as `@bemidjistate/wp-coding-standards` and
consumed under the `@bsu/wp-coding-standards` alias, so script paths keep the
short name:

```json
"@bsu/wp-coding-standards": "npm:@bemidjistate/wp-coding-standards@3.4.4"
```

The consumer's `.npmrc` routes the scope to GitHub Packages
(`@bemidjistate:registry=https://npm.pkg.github.com`); installing requires a
GitHub personal access token (classic) with `read:packages` in `~/.npmrc`,
and CI uses its workflow `GITHUB_TOKEN` via the package's Actions access list.

Consumers reference the binaries directly by path in `package.json` scripts:

```bash
node_modules/@bsu/wp-coding-standards/vendor/bin/phpcs
node_modules/@bsu/wp-coding-standards/vendor/bin/phpcbf
node_modules/@bsu/wp-coding-standards/vendor/bin/phpstan
```

There is deliberately no `.npmignore`: the published tarball carries the
committed `vendor/` toolchain — the same content the git dependency
delivered.

## Updating

To update tool versions, modify `composer.json` and run `composer update`, then commit the updated `composer.lock` and `vendor/` in a PR to `release`.

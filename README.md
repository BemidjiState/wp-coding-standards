# @bsu/wp-coding-standards

PHP tool binaries for BSU WordPress development. Installed via npm, ships the following tools in `vendor/bin/`:

| Binary | Version | Purpose |
|---|---|---|
| `phpcs` | 4.x | PHP CodeSniffer — enforces BSUWordPressCS coding standards |
| `phpcbf` | 4.x | PHP Code Beautifier — auto-fixes PHPCS violations |
| `phpstan` | 1.x | PHPStan — static analysis for type safety and correctness |

## Usage in bsuwp

These binaries are referenced directly by path in `bsuwp/package.json` scripts:

```bash
npm run lint:php        # phpcs via this package
npm run fix:php         # phpcbf via this package
npm run analyse:php     # phpstan via this package
```

## Updating

To update tool versions, modify `composer.json` and run `composer update`, then commit the updated `composer.lock` and `vendor/` in a PR to `release`.

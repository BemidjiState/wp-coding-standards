/**
 * BSU WordPress Coding Standards.
 *
 * Commitlint Configuration.
 *
 * @see https://commitlint.js.org/#/reference-configuration
 */

'use strict';

module.exports = {
	/**
	 * Define extends.
	 *
	 * We extend the recommended conventional changelog config.
	 */
	extends: ['@commitlint/config-conventional'],

	/**
	 * Define rules.
	 *
	 * Add or override any rules from the conventional config.
	 *
	 * A rule is defined as: [Level, Applicability, Value]
	 * - Level: 0 (disable), 1 (warn), 2 (error)
	 * - Applicability: 'always' or 'never'
	 * - Value: The value for the rule
	 */
	rules: {
		/**
		 * Enforce that the scope (the part in parenthesis) is never empty.
		 */
		'scope-empty': [2, 'never'],

		/**
		 * Restrict commits to a defined set of allowed scopes.
		 */
		'scope-enum': [
			2,
			'always',
			[
				'ci',
				'config',
				'deps',
				'docs',
				'release',
				'tools',
			],
		],

		/**
		 * Set the max length for the header to 125 characters.
		 */
		'header-max-length': [2, 'always', 125],
	},
};

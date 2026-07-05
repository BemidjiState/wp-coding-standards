<?php
/**
 * Register the BSUWordPressCS standard with PHP_CodeSniffer.
 *
 * The dealerdirect composer installer regenerates CodeSniffer.conf on every
 * composer install/update and only registers composer-installed standards, so
 * the consumer-side BSUWordPressCS path is dropped each time. This composer
 * post-install/post-update hook re-appends it, so consuming repos can resolve
 * the BSUWordPressCS standard by name.
 *
 * The path is relative to the phpcs directory (vendor/squizlabs/php_codesniffer),
 * reaching @bsu/BSUWordPressCS installed as a sibling in the consumer's
 * node_modules/@bsu/.
 */

$phpcs    = __DIR__ . '/../vendor/bin/phpcs';
$bsu_path = '../../../../BSUWordPressCS';

if ( ! is_file( $phpcs ) ) {
	return;
}

/* Read the installed_paths phpcs currently knows about. */
$show = (string) shell_exec( escapeshellarg( PHP_BINARY ) . ' ' . escapeshellarg( $phpcs ) . ' --config-show 2>/dev/null' );
preg_match( '/installed_paths:\s*(.*)/', $show, $match );
$paths = array_values( array_filter( array_map( 'trim', explode( ',', $match[1] ?? '' ) ) ) );

/* Nothing to do if it is already registered. */
if ( in_array( $bsu_path, $paths, true ) ) {
	echo "BSUWordPressCS already registered in phpcs installed_paths.\n";
	return;
}

/* Append it and write the config back through phpcs itself. */
$paths[] = $bsu_path;
shell_exec( escapeshellarg( PHP_BINARY ) . ' ' . escapeshellarg( $phpcs ) . ' --config-set installed_paths ' . escapeshellarg( implode( ',', $paths ) ) . ' 2>/dev/null' );
echo "Registered BSUWordPressCS in phpcs installed_paths.\n";

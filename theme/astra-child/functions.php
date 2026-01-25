<?php
/**
 * Astra Child Theme Functions
 *
 * @package Astra Child - Zoomubik
 * @since 1.0.0
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly.
}

/**
 * Define Constants
 */
define( 'ASTRA_CHILD_THEME_VERSION', '1.0.0' );
define( 'ASTRA_CHILD_THEME_DIR', get_stylesheet_directory() );
define( 'ASTRA_CHILD_THEME_URI', get_stylesheet_directory_uri() );

/**
 * Enqueue styles
 */
function astra_child_enqueue_styles() {
	// Enqueue parent theme stylesheet
	wp_enqueue_style( 
		'astra-parent-style', 
		get_template_directory_uri() . '/style.css',
		array(),
		wp_get_theme()->parent()->get('Version')
	);
	
	// Enqueue child theme stylesheet
	wp_enqueue_style( 
		'astra-child-style',
		get_stylesheet_directory_uri() . '/style.css',
		array( 'astra-parent-style' ),
		ASTRA_CHILD_THEME_VERSION
	);
}
add_action( 'wp_enqueue_scripts', 'astra_child_enqueue_styles', 15 );

/**
 * Enqueue custom scripts for footer functionality
 */
function astra_child_enqueue_scripts() {
	// jQuery is already enqueued by WordPress
	// Add any additional custom scripts here if needed
}
add_action( 'wp_enqueue_scripts', 'astra_child_enqueue_scripts' );

/**
 * Add body class for logged-in/logged-out users
 */
function astra_child_body_classes( $classes ) {
	if ( is_user_logged_in() ) {
		$classes[] = 'user-logged-in';
	} else {
		$classes[] = 'user-logged-out';
	}
	
	return $classes;
}
add_filter( 'body_class', 'astra_child_body_classes' );

/**
 * Customize the sticky footer button text
 * Can be filtered by other plugins/themes
 */
function astra_child_get_publicar_button_text() {
	return apply_filters( 'astra_child_publicar_button_text', __( '📝 Publicar Anuncio', 'astra-child-zoomubik' ) );
}

/**
 * Get the target section ID for the publicar button
 * Can be filtered to change the target
 */
function astra_child_get_publicar_target_section() {
	return apply_filters( 'astra_child_publicar_target_section', 'publicar-section' );
}

/**
 * Get the form button class
 * Can be filtered to change the target button
 */
function astra_child_get_form_button_class() {
	return apply_filters( 'astra_child_form_button_class', 'mostrar-formulario-btn' );
}

/**
 * Check if sticky footer should be displayed on current page
 */
function astra_child_show_sticky_footer() {
	// By default, show on all pages except admin
	$show = ! is_admin();
	
	// Allow filtering to hide on specific pages
	return apply_filters( 'astra_child_show_sticky_footer', $show );
}

/**
 * Additional Ultimate Member integration
 */
if ( function_exists( 'um_get_core_page_id' ) ) {
	/**
	 * Redirect to specific page after login
	 */
	function astra_child_um_login_redirect( $url ) {
		// Check if there's a redirect parameter
		if ( isset( $_GET['redirect_to'] ) ) {
			// Validate redirect URL to prevent open redirect vulnerabilities
			return wp_validate_redirect( $_GET['redirect_to'], home_url() );
		}
		
		// Default redirect to home or specific page
		return home_url();
	}
	// Uncomment to enable custom login redirect
	// add_filter( 'um_login_redirect_url', 'astra_child_um_login_redirect', 10, 1 );
}

/**
 * Custom action hook after sticky footer button
 * Allows other plugins/themes to add content after the sticky button
 */
function astra_child_footer_sticky_button_after() {
	do_action( 'astra_footer_sticky_button_after' );
}

/**
 * Add support for additional features
 */
function astra_child_setup() {
	// Add support for custom logo
	add_theme_support( 'custom-logo', array(
		'height'      => 100,
		'width'       => 400,
		'flex-height' => true,
		'flex-width'  => true,
	) );
	
	// Add support for custom header
	add_theme_support( 'custom-header' );
	
	// Add support for custom background
	add_theme_support( 'custom-background' );
}
add_action( 'after_setup_theme', 'astra_child_setup' );

/**
 * Register custom navigation menus (optional)
 */
function astra_child_register_menus() {
	register_nav_menus( array(
		'footer-menu' => __( 'Footer Menu', 'astra-child-zoomubik' ),
	) );
}
// Uncomment to enable custom menus
// add_action( 'init', 'astra_child_register_menus' );

/**
 * Customize excerpt length
 */
function astra_child_excerpt_length( $length ) {
	return 30; // Number of words
}
// Uncomment to enable custom excerpt length
// add_filter( 'excerpt_length', 'astra_child_excerpt_length' );

/**
 * Add custom JavaScript variables for footer script
 */
function astra_child_footer_js_vars() {
	if ( ! astra_child_show_sticky_footer() ) {
		return;
	}
	
	$js_vars = array(
		'ajaxurl'          => admin_url( 'admin-ajax.php' ),
		'isUserLoggedIn'   => is_user_logged_in(),
		'loginUrl'         => function_exists('um_get_core_page_id') 
			? get_permalink( um_get_core_page_id('login') ) 
			: wp_login_url(),
		'targetSection'    => astra_child_get_publicar_target_section(),
		'formButtonClass'  => astra_child_get_form_button_class(),
	);
	
	echo '<script type="text/javascript">';
	echo 'var astraChildVars = ' . json_encode( $js_vars ) . ';';
	echo '</script>';
}
add_action( 'wp_head', 'astra_child_footer_js_vars' );

/**
 * AJAX handler for checking user status (example)
 */
function astra_child_check_user_status() {
	check_ajax_referer( 'astra-child-nonce', 'nonce' );
	
	$response = array(
		'logged_in' => is_user_logged_in(),
		'user_id'   => get_current_user_id(),
	);
	
	wp_send_json_success( $response );
}
// Uncomment to enable AJAX endpoint
// add_action( 'wp_ajax_check_user_status', 'astra_child_check_user_status' );
// add_action( 'wp_ajax_nopriv_check_user_status', 'astra_child_check_user_status' );

/**
 * Security: Remove WordPress version from head
 */
remove_action( 'wp_head', 'wp_generator' );

/**
 * Custom function to get login URL with proper fallback
 */
function astra_child_get_login_url() {
	if ( function_exists( 'um_get_core_page_id' ) ) {
		$login_page_id = um_get_core_page_id( 'login' );
		if ( $login_page_id ) {
			return get_permalink( $login_page_id );
		}
	}
	
	// Fallback to WordPress default login
	return wp_login_url( get_permalink() );
}

/**
 * Debug helper - only show for administrators with proper nonce
 */
function astra_child_debug_info() {
	if ( ! current_user_can( 'administrator' ) ) {
		return;
	}
	
	// Verify debug mode is enabled with proper key
	if ( ! isset( $_GET['astra_debug'] ) || $_GET['astra_debug'] !== wp_create_nonce( 'astra_debug_' . get_current_user_id() ) ) {
		return;
	}
	
	echo '<!-- Astra Child Theme Debug Info -->';
	echo '<!-- Version: ' . ASTRA_CHILD_THEME_VERSION . ' -->';
	echo '<!-- Parent Theme: ' . wp_get_theme()->parent()->get('Name') . ' ' . wp_get_theme()->parent()->get('Version') . ' -->';
	echo '<!-- User Logged In: ' . ( is_user_logged_in() ? 'Yes' : 'No' ) . ' -->';
}
add_action( 'wp_footer', 'astra_child_debug_info' );

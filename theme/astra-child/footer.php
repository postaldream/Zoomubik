<?php
/**
 * The template for displaying the footer.
 *
 * @package Astra
 * @since 1.0.0
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly.
}

?>

<?php astra_content_bottom(); ?>

	</div> <!-- ast-container -->

	</div><!-- #content -->

	<?php
		astra_content_after();

		astra_footer_before();

		astra_footer();

		astra_footer_after();
	?>

</div><!-- #page -->

<?php
	astra_body_bottom();
	wp_footer();
?>

<!-- Sticky Publicar Button -->
<style>
.sticky-publicar-wrapper {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;
	z-index: 999;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	padding: 15px 0;
	box-shadow: 0 -2px 10px rgba(0,0,0,0.1);
}

.sticky-publicar-btn {
	display: block;
	width: 90%;
	max-width: 400px;
	margin: 0 auto;
	padding: 15px 30px;
	background: #fff;
	color: #667eea;
	border: none;
	border-radius: 50px;
	font-size: 18px;
	font-weight: bold;
	cursor: pointer;
	transition: all 0.3s ease;
	text-align: center;
	box-shadow: 0 4px 15px rgba(0,0,0,0.2);
}

.sticky-publicar-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(0,0,0,0.3);
	background: #f0f0f0;
}

.sticky-publicar-btn:active {
	transform: translateY(0);
}

@media (max-width: 768px) {
	.sticky-publicar-btn {
		font-size: 16px;
		padding: 12px 25px;
	}
}
</style>

<div class="sticky-publicar-wrapper">
	<button class="sticky-publicar-btn" id="sticky-publicar-btn">
		📝 Publicar Anuncio
	</button>
</div>

<script>
(function($) {
	'use strict';

	/**
	 * Configuration
	 */
	const config = {
		stickyBtnId: 'sticky-publicar-btn',
		targetSectionId: 'publicar-section',
		formButtonClass: 'mostrar-formulario-btn',
		loginUrl: '<?php echo esc_js( function_exists('astra_child_get_login_url') ? astra_child_get_login_url() : wp_login_url() ); ?>',
		scrollOffset: 100, // Offset for sticky footer height
		scrollDuration: 800,
		retryDelay: 100,
		maxRetries: 20
	};

	/**
	 * Check if user is logged in
	 */
	function isUserLoggedIn() {
		return <?php echo is_user_logged_in() ? 'true' : 'false'; ?>;
	}

	/**
	 * Get the height of the sticky footer
	 */
	function getFooterHeight() {
		const footer = document.querySelector('.sticky-publicar-wrapper');
		return footer ? footer.offsetHeight : 0;
	}

	/**
	 * Wait for element to be available in DOM
	 */
	function waitForElement(selector, callback, retries = 0) {
		const element = document.querySelector(selector);
		
		if (element) {
			callback(element);
		} else if (retries < config.maxRetries) {
			setTimeout(() => {
				waitForElement(selector, callback, retries + 1);
			}, config.retryDelay);
		} else {
			console.warn(`Element ${selector} not found after ${config.maxRetries} retries`);
		}
	}

	/**
	 * Smooth scroll to element with offset adjustment
	 */
	function smoothScrollToElement(element) {
		if (!element) {
			console.warn('Element not found for scrolling');
			return;
		}

		const elementPosition = element.getBoundingClientRect().top + window.pageYOffset;
		const footerHeight = getFooterHeight();
		const offsetPosition = elementPosition - config.scrollOffset - footerHeight;

		window.scrollTo({
			top: Math.max(0, offsetPosition),
			behavior: 'smooth'
		});
	}

	/**
	 * Focus on input field within element
	 */
	function focusFirstInput(container) {
		if (!container) return;

		// Wait a bit for the scroll to complete
		setTimeout(() => {
			const firstInput = container.querySelector('input[type="text"], input[type="email"], textarea');
			if (firstInput) {
				firstInput.focus();
			}
		}, config.scrollDuration);
	}

	/**
	 * Show login modal
	 */
	function showLoginModal() {
		// Check if Ultimate Member modal exists
		if (typeof UM !== 'undefined' && UM.modal) {
			UM.modal.open({
				content: 'login',
				size: 'medium'
			});
		} else {
			// Fallback: redirect to login page
			window.location.href = config.loginUrl;
		}
	}

	/**
	 * Handle form button click
	 */
	function handleFormButtonClick(formButton) {
		// Click the button to show the form
		formButton.click();

		// Wait for form to appear and then scroll to it
		setTimeout(() => {
			const publicarSection = document.getElementById(config.targetSectionId);
			if (publicarSection) {
				smoothScrollToElement(publicarSection);
				focusFirstInput(publicarSection);
			}
		}, 200);
	}

	/**
	 * Handle publicar button click
	 */
	function handlePublicarClick(e) {
		e.preventDefault();
		e.stopPropagation();

		// Check if user is logged in
		if (!isUserLoggedIn()) {
			showLoginModal();
			return;
		}

		// Try to find the target section
		const publicarSection = document.getElementById(config.targetSectionId);
		
		if (publicarSection) {
			// Check if form is already visible
			const formVisible = publicarSection.style.display !== 'none' && 
			                   publicarSection.offsetHeight > 0;

			if (formVisible) {
				// Form is visible, just scroll to it
				smoothScrollToElement(publicarSection);
				focusFirstInput(publicarSection);
			} else {
				// Form is hidden, need to click the button to show it
				waitForElement(`.${config.formButtonClass}`, handleFormButtonClick);
			}
		} else {
			// Section doesn't exist, look for the form button
			waitForElement(`.${config.formButtonClass}`, handleFormButtonClick);
		}
	}

	/**
	 * Initialize sticky button
	 */
	function initStickyButton() {
		const stickyBtn = document.getElementById(config.stickyBtnId);
		
		if (stickyBtn) {
			// Remove any existing listeners
			stickyBtn.removeEventListener('click', handlePublicarClick);
			// Add new listener
			stickyBtn.addEventListener('click', handlePublicarClick);
			
			console.log('Sticky Publicar button initialized');
		} else {
			console.warn('Sticky Publicar button not found');
		}
	}

	/**
	 * Handle body click to detect dynamically added elements
	 */
	function handleBodyClick(e) {
		if (e.target && e.target.classList && e.target.classList.contains(config.formButtonClass)) {
			setTimeout(() => {
				const publicarSection = document.getElementById(config.targetSectionId);
				if (publicarSection) {
					smoothScrollToElement(publicarSection);
					focusFirstInput(publicarSection);
				}
			}, 200);
		}
	}

	/**
	 * Observe DOM changes for dynamically loaded content
	 */
	function observeDOMChanges() {
		const observer = new MutationObserver((mutations) => {
			mutations.forEach((mutation) => {
				mutation.addedNodes.forEach((node) => {
					if (node.nodeType === 1) { // Element node
						// Check if the added node or its children contain the target section
						if (node.id === config.targetSectionId || 
						    node.querySelector(`#${config.targetSectionId}`)) {
							console.log('Publicar section detected in DOM');
						}
						
						// Check for form button
						if (node.classList && node.classList.contains(config.formButtonClass) ||
						    node.querySelector(`.${config.formButtonClass}`)) {
							console.log('Form button detected in DOM');
						}
					}
				});
			});
		});

		observer.observe(document.body, {
			childList: true,
			subtree: true
		});
	}

	/**
	 * Initialize when DOM is ready
	 */
	function init() {
		// Initialize sticky button
		initStickyButton();

		// Add body click listener for dynamic elements
		document.body.addEventListener('click', handleBodyClick);

		// Observe DOM changes
		observeDOMChanges();

		// Add window resize listener to recalculate footer height
		window.addEventListener('resize', () => {
			// Recalculation happens automatically in getFooterHeight()
		});

		console.log('Footer script initialized');
	}

	// Initialize on DOM ready
	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', init);
	} else {
		init();
	}

	// Also initialize on jQuery ready for compatibility
	$(document).ready(function() {
		// Reinitialize in case of any conflicts
		setTimeout(initStickyButton, 500);
	});

})(jQuery);
</script>

<?php
/**
 * Additional Ultimate Member integration
 */
if ( function_exists('um_is_core_page') && um_is_core_page('login') ) : ?>
<script>
// Additional login page specific scripts can go here
</script>
<?php endif; ?>

<?php
/**
 * Additional hooks for extensibility
 */
do_action( 'astra_footer_sticky_button_after' );
?>

</body>
</html>

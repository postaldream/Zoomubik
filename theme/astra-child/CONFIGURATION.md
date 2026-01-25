# Configuration Guide

This guide explains all configurable options for the Astra Child Theme sticky "Publicar" button functionality.

## Table of Contents

1. [JavaScript Configuration](#javascript-configuration)
2. [PHP Configuration](#php-configuration)
3. [CSS Customization](#css-customization)
4. [WordPress Filters](#wordpress-filters)
5. [Advanced Configuration](#advanced-configuration)

---

## JavaScript Configuration

### Config Object

Located in `footer.php`, line ~140:

```javascript
const config = {
    stickyBtnId: 'sticky-publicar-btn',
    targetSectionId: 'publicar-section',
    formButtonClass: 'mostrar-formulario-btn',
    loginUrl: '<?php echo esc_js($um_login_url); ?>',
    scrollOffset: 100,
    scrollDuration: 800,
    retryDelay: 100,
    maxRetries: 20
};
```

### Configuration Options

#### `stickyBtnId` (string)
- **Default**: `'sticky-publicar-btn'`
- **Purpose**: ID of the sticky footer button
- **Usage**: Must match the button ID in the HTML
- **Example**:
  ```javascript
  stickyBtnId: 'my-custom-btn-id'
  ```

#### `targetSectionId` (string)
- **Default**: `'publicar-section'`
- **Purpose**: ID of the section to scroll to
- **Usage**: Must match your publication form section ID
- **Example**:
  ```javascript
  targetSectionId: 'create-post-section'
  ```

#### `formButtonClass` (string)
- **Default**: `'mostrar-formulario-btn'`
- **Purpose**: Class of button that shows the form
- **Usage**: Used when form is initially hidden
- **Example**:
  ```javascript
  formButtonClass: 'show-form-btn'
  ```

#### `loginUrl` (string)
- **Default**: Ultimate Member login URL or WordPress default
- **Purpose**: Where to redirect non-logged-in users
- **Usage**: Auto-configured via PHP, usually don't change
- **Example**:
  ```javascript
  loginUrl: '/mi-login-personalizado/'
  ```

#### `scrollOffset` (number)
- **Default**: `100`
- **Purpose**: Additional offset in pixels for scroll position
- **Usage**: Accounts for sticky headers or spacing
- **Range**: 0-500 (practical range)
- **Example**:
  ```javascript
  scrollOffset: 150  // More spacing at top
  ```

#### `scrollDuration` (number)
- **Default**: `800`
- **Purpose**: Duration of scroll animation in milliseconds
- **Usage**: Longer = slower, more visible scroll
- **Range**: 300-2000 (practical range)
- **Example**:
  ```javascript
  scrollDuration: 1000  // Slower, smoother
  ```

#### `retryDelay` (number)
- **Default**: `100`
- **Purpose**: Delay between retries when waiting for elements (ms)
- **Usage**: How often to check if element is loaded
- **Range**: 50-500 (practical range)
- **Example**:
  ```javascript
  retryDelay: 200  // Check every 200ms
  ```

#### `maxRetries` (number)
- **Default**: `20`
- **Purpose**: Maximum attempts to find dynamic elements
- **Usage**: Total wait time = retryDelay × maxRetries
- **Range**: 5-50 (practical range)
- **Example**:
  ```javascript
  maxRetries: 30  // Try 30 times (3 seconds with 100ms delay)
  ```

### Configuration Examples

#### Quick Scroll, No Waiting
```javascript
const config = {
    stickyBtnId: 'sticky-publicar-btn',
    targetSectionId: 'publicar-section',
    formButtonClass: 'mostrar-formulario-btn',
    scrollOffset: 50,
    scrollDuration: 400,      // Fast scroll
    retryDelay: 50,           // Quick checks
    maxRetries: 10            // Don't wait long
};
```

#### Slow, Patient Configuration
```javascript
const config = {
    stickyBtnId: 'sticky-publicar-btn',
    targetSectionId: 'publicar-section',
    formButtonClass: 'mostrar-formulario-btn',
    scrollOffset: 150,
    scrollDuration: 1200,     // Slow, smooth scroll
    retryDelay: 200,          // Longer between checks
    maxRetries: 50            // Very patient
};
```

---

## PHP Configuration

### Functions in `functions.php`

#### Theme Version
```php
define( 'ASTRA_CHILD_THEME_VERSION', '1.0.0' );
```
- Update this when you make changes
- Helps with cache busting

#### Button Text Function
```php
function astra_child_get_publicar_button_text() {
    return apply_filters( 
        'astra_child_publicar_button_text', 
        __( '📝 Publicar Anuncio', 'astra-child-zoomubik' ) 
    );
}
```

**Usage in footer.php:**
```php
<button class="sticky-publicar-btn">
    <?php echo astra_child_get_publicar_button_text(); ?>
</button>
```

#### Show/Hide Footer Function
```php
function astra_child_show_sticky_footer() {
    $show = ! is_admin();
    return apply_filters( 'astra_child_show_sticky_footer', $show );
}
```

**Usage in footer.php:**
```php
<?php if ( astra_child_show_sticky_footer() ) : ?>
    <div class="sticky-publicar-wrapper">
        <!-- Button HTML -->
    </div>
<?php endif; ?>
```

---

## CSS Customization

### Color Scheme

Located in `footer.php` `<style>` section:

#### Background Gradient
```css
.sticky-publicar-wrapper {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}
```

**Examples:**

Blue to Green:
```css
background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
```

Red to Orange:
```css
background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
```

Solid Color:
```css
background: #667eea;
```

#### Button Colors
```css
.sticky-publicar-btn {
    background: #fff;
    color: #667eea;
}
```

**Dark Mode Button:**
```css
.sticky-publicar-btn {
    background: #333;
    color: #fff;
}
```

### Sizing

#### Button Size
```css
.sticky-publicar-btn {
    padding: 15px 30px;    /* Vertical Horizontal */
    font-size: 18px;
}
```

**Larger Button:**
```css
.sticky-publicar-btn {
    padding: 20px 40px;
    font-size: 20px;
}
```

**Smaller Button:**
```css
.sticky-publicar-btn {
    padding: 10px 20px;
    font-size: 16px;
}
```

#### Footer Height
```css
.sticky-publicar-wrapper {
    padding: 15px 0;
}
```

Affects the `getFooterHeight()` calculation.

### Position

#### Z-Index
```css
.sticky-publicar-wrapper {
    z-index: 999;
}
```

Increase if footer is hidden behind other elements:
```css
z-index: 9999;
```

#### Alignment
```css
.sticky-publicar-btn {
    margin: 0 auto;  /* Center */
}
```

Left aligned:
```css
.sticky-publicar-btn {
    margin: 0 0 0 20px;
}
```

Right aligned:
```css
.sticky-publicar-btn {
    margin: 0 20px 0 auto;
}
```

### Animations

#### Hover Effect
```css
.sticky-publicar-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0,0,0,0.3);
}
```

**More Dramatic:**
```css
.sticky-publicar-btn:hover {
    transform: translateY(-5px) scale(1.05);
    box-shadow: 0 10px 30px rgba(0,0,0,0.4);
}
```

**Subtle:**
```css
.sticky-publicar-btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 3px 10px rgba(0,0,0,0.2);
}
```

### Responsive Breakpoints

```css
@media (max-width: 768px) {
    .sticky-publicar-btn {
        font-size: 16px;
        padding: 12px 25px;
    }
}
```

**Custom Breakpoints:**
```css
@media (max-width: 1200px) { /* Tablet */ }
@media (max-width: 768px) { /* Mobile */ }
@media (max-width: 480px) { /* Small Mobile */ }
```

---

## WordPress Filters

### Available Filters

#### 1. Button Text
```php
add_filter('astra_child_publicar_button_text', 'my_custom_button_text');
function my_custom_button_text($text) {
    return '🚗 Publicar Vehículo';
}
```

#### 2. Target Section
```php
add_filter('astra_child_publicar_target_section', 'my_custom_target');
function my_custom_target($section_id) {
    return 'my-custom-section-id';
}
```

#### 3. Form Button Class
```php
add_filter('astra_child_form_button_class', 'my_custom_button_class');
function my_custom_button_class($class) {
    return 'my-show-form-button';
}
```

#### 4. Show/Hide Footer
```php
add_filter('astra_child_show_sticky_footer', 'hide_on_specific_pages');
function hide_on_specific_pages($show) {
    if (is_page('about') || is_page('contact')) {
        return false;  // Hide on about and contact pages
    }
    return $show;
}
```

**Hide on all pages except home:**
```php
add_filter('astra_child_show_sticky_footer', function($show) {
    return is_front_page();
});
```

**Hide for non-logged-in users:**
```php
add_filter('astra_child_show_sticky_footer', function($show) {
    return is_user_logged_in();
});
```

### Custom Actions

#### After Footer Button
```php
add_action('astra_footer_sticky_button_after', 'add_custom_content');
function add_custom_content() {
    echo '<div class="custom-footer-note">';
    echo 'Powered by Zoomubik';
    echo '</div>';
}
```

---

## Advanced Configuration

### Multiple Target Sections

If you need to scroll to different sections based on conditions:

```php
add_filter('astra_child_publicar_target_section', 'dynamic_target_section');
function dynamic_target_section($section_id) {
    if (is_user_logged_in()) {
        return 'publicar-section';
    } else {
        return 'info-section';
    }
}
```

### Custom Login Handler

Replace default login logic:

```javascript
// In footer.php, modify showLoginModal function
function showLoginModal() {
    // Your custom login logic
    window.location.href = '/custom-login/?redirect=' + window.location.pathname;
}
```

### AJAX Form Submission

Add to `functions.php`:

```php
add_action('wp_ajax_submit_publicar_form', 'handle_publicar_submission');
add_action('wp_ajax_nopriv_submit_publicar_form', 'handle_publicar_submission');

function handle_publicar_submission() {
    check_ajax_referer('astra-child-nonce', 'nonce');
    
    $data = $_POST['form_data'];
    
    // Process form data
    // Save to database
    // Send notifications
    
    wp_send_json_success([
        'message' => 'Publicación creada con éxito'
    ]);
}
```

### Conditional Button Display

Based on user role:

```php
add_filter('astra_child_show_sticky_footer', 'show_for_subscribers_only');
function show_for_subscribers_only($show) {
    $user = wp_get_current_user();
    return in_array('subscriber', $user->roles) || in_array('administrator', $user->roles);
}
```

### Custom Scroll Behavior

Replace smooth scroll with instant:

```javascript
// In footer.php, modify smoothScrollToElement
function smoothScrollToElement(element) {
    element.scrollIntoView();  // Instant scroll, no animation
}
```

Or use custom easing:

```javascript
function smoothScrollToElement(element) {
    const start = window.pageYOffset;
    const end = element.getBoundingClientRect().top + window.pageYOffset - config.scrollOffset;
    const distance = end - start;
    const duration = config.scrollDuration;
    let startTime = null;

    function animation(currentTime) {
        if (startTime === null) startTime = currentTime;
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);
        
        // Easing function (easeInOutCubic)
        const easing = progress < 0.5
            ? 4 * progress * progress * progress
            : 1 - Math.pow(-2 * progress + 2, 3) / 2;
        
        window.scrollTo(0, start + distance * easing);
        
        if (progress < 1) {
            requestAnimationFrame(animation);
        }
    }
    
    requestAnimationFrame(animation);
}
```

---

## Configuration Best Practices

### 1. Use Child Theme Functions
Don't modify the theme files directly. Use filters in your own plugin or another child theme.

### 2. Test Changes
Always test on staging before deploying to production.

### 3. Document Customizations
Keep a list of your customizations for future reference.

### 4. Use Version Control
Track changes with git to easily rollback if needed.

### 5. Clear Caches
Always clear all caches after configuration changes.

---

## Configuration Checklist

Before going live:

- [ ] Set correct `targetSectionId`
- [ ] Verify `formButtonClass` matches your form
- [ ] Adjust `scrollOffset` for your header
- [ ] Test `scrollDuration` for desired speed
- [ ] Configure login URL (if not using UM)
- [ ] Customize button text
- [ ] Update colors to match brand
- [ ] Test on all breakpoints
- [ ] Verify accessibility
- [ ] Clear all caches
- [ ] Test with and without JavaScript
- [ ] Check browser compatibility

---

**Last Updated**: 2026-01-25  
**Version**: 1.0.0

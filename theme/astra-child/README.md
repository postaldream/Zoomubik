# Astra Child Theme - Custom Footer Template

This directory contains a custom footer template for the Astra WordPress theme with an improved "Publicar" (Publish) button functionality.

## Overview

The footer template (`footer.php`) includes a sticky "Publicar Anuncio" button that provides smooth scrolling and proper focus management for publishing new content on the Zoomubik website.

## Key Improvements

### 1. Fixed Button Behavior
- **Problem**: The original button used `<a href="#">` which caused the page to jump to the top
- **Solution**: Replaced `<a>` tag with `<button>` element and removed the problematic `href="#"`
- **Result**: Button no longer navigates, only triggers the intended functionality

### 2. Smooth Scroll with Footer Offset
- **Problem**: When scrolling to the target section, it was obscured by the sticky footer
- **Solution**: Added logic to calculate footer height and adjust scroll position accordingly
- **Result**: Target section is properly visible and not hidden behind the footer

### 3. Dynamic Element Validation
- **Problem**: The form button might not be loaded when the page initially renders
- **Solution**: Implemented a retry mechanism with `waitForElement()` function that polls for the element
- **Result**: Handles dynamically loaded content reliably

### 4. Login Modal Integration
- **Problem**: Non-logged-in users weren't properly redirected or shown a login interface
- **Solution**: Integrated with Ultimate Member plugin to show login modal, with fallback to login page
- **Result**: Smooth user experience for both logged-in and non-logged-in users

## Features

### Sticky Footer Button
- Fixed position at bottom of viewport
- Responsive design with mobile optimizations
- Eye-catching gradient background
- Smooth hover and click animations

### Smart Scrolling
- Calculates footer height dynamically
- Adds configurable offset for better visibility
- Smooth scroll animation
- Auto-focuses first input field after scroll

### Robust Element Detection
- Waits for dynamically loaded elements
- Configurable retry mechanism (max 20 attempts)
- MutationObserver for DOM changes
- Handles various loading scenarios

### User Authentication
- Checks WordPress user login status
- Integrates with Ultimate Member plugin
- Shows login modal for non-authenticated users
- Fallback to login page if modal unavailable

## Installation

### For WordPress with Astra Theme

1. **Create a Child Theme** (if you don't have one):
   ```
   wp-content/themes/astra-child/
   ```

2. **Copy the footer.php file**:
   ```
   cp theme/astra-child/footer.php wp-content/themes/astra-child/footer.php
   ```

3. **Ensure your child theme has a style.css** with proper headers:
   ```css
   /*
   Theme Name: Astra Child
   Template: astra
   */
   ```

4. **Activate the child theme** in WordPress admin

### Configuration

The script includes a configuration object that can be customized:

```javascript
const config = {
    stickyBtnId: 'sticky-publicar-btn',          // Button ID
    targetSectionId: 'publicar-section',         // Target section to scroll to
    formButtonClass: 'mostrar-formulario-btn',   // Form button class
    scrollOffset: 100,                           // Additional scroll offset
    scrollDuration: 800,                         // Scroll animation duration (ms)
    retryDelay: 100,                            // Delay between retries (ms)
    maxRetries: 20                              // Max attempts to find elements
};
```

## Requirements

- **WordPress**: 5.0 or higher
- **Astra Theme**: 3.0 or higher
- **jQuery**: Included with WordPress
- **Ultimate Member** (optional): For login modal functionality

## Browser Compatibility

- Chrome/Edge: ✓
- Firefox: ✓
- Safari: ✓
- Opera: ✓
- IE11: Partial (smooth scroll uses polyfill)

## Customization

### Changing Button Text
Edit line with button content:
```html
<button class="sticky-publicar-btn" id="sticky-publicar-btn">
    📝 Publicar Anuncio  <!-- Change this text -->
</button>
```

### Styling
Modify the `<style>` block to change:
- Colors and gradients
- Button size and shape
- Shadows and animations
- Responsive breakpoints

### Functionality
Adjust the `config` object in the JavaScript section to modify:
- Target elements
- Scroll behavior
- Timing and delays

## Troubleshooting

### Button doesn't scroll
- Check that `targetSectionId` matches your actual section ID
- Verify the section exists in the DOM
- Check browser console for error messages

### Login modal doesn't appear
- Ensure Ultimate Member plugin is installed and activated
- Check that `um_get_core_page_id` function is available
- Verify login page URL is correct

### Form doesn't open
- Confirm `formButtonClass` matches the actual button class
- Check if the button exists in the page
- Verify the button triggers the form visibility

## Code Structure

The footer.php file contains:
1. **PHP Header**: WordPress compatibility and hook integration
2. **HTML Structure**: Standard Astra footer markup
3. **CSS Styles**: Sticky button styling
4. **JavaScript Logic**: 
   - User authentication check
   - Element detection and validation
   - Smooth scrolling functionality
   - Login modal integration
   - DOM observation for dynamic content

## Version History

- **v1.0.0** (2026-01-25): Initial release with all improvements
  - Button element replacement
  - Smooth scroll with offset
  - Dynamic element validation
  - Login modal integration

## Support

For issues or questions:
- Check the browser console for error messages
- Verify WordPress and plugin versions
- Ensure child theme is properly activated
- Review configuration settings

## License

This code is provided as part of the Zoomubik project and follows the same license as the parent project (MIT License).

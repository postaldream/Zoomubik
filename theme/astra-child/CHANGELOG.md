# Changelog

All notable changes to the Astra Child Theme - Zoomubik will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-25

### Added

#### Core Functionality
- Initial release of Astra child theme with sticky "Publicar" button
- Smooth scroll functionality with footer offset adjustment
- Dynamic element detection with retry mechanism
- Ultimate Member login modal integration
- Fallback to WordPress default login for non-UM installations

#### JavaScript Features
- Configuration object for easy customization
- `waitForElement()` function with configurable retry attempts
- `smoothScrollToElement()` with automatic footer height calculation
- `focusFirstInput()` for improved UX after scroll
- `showLoginModal()` with UM and WordPress fallback
- MutationObserver for detecting dynamically loaded content
- Event delegation for handling dynamic form buttons

#### PHP Features
- Custom hooks for extensibility (`astra_footer_sticky_button_after`)
- Filter hooks for button text, target section, and form button class
- Body classes for logged-in/logged-out states
- Theme setup with custom logo, header, and background support
- Security enhancements (ABSPATH check, output escaping, version removal)
- Debug mode for administrators

#### Styling
- Gradient purple background for sticky footer
- Smooth hover and active state transitions
- Responsive design with mobile optimizations
- Accessibility-focused focus states
- Shadow effects for depth
- Animations for form visibility

#### Documentation
- Comprehensive README.md with feature overview
- Detailed INSTALLATION.md with multiple installation methods
- Complete TESTING.md with test scenarios and checklists
- Example HTML page showing proper structure
- Inline code documentation and comments

### Fixed

#### Button Behavior
- **Fixed**: Button no longer jumps to top of page when clicked
  - **Before**: Used `<a href="#">` which caused scroll to top
  - **After**: Changed to `<button>` element with proper event handling
  
- **Fixed**: Target section properly visible after scroll
  - **Before**: Sticky footer obscured the target section
  - **After**: Calculates footer height and adjusts scroll offset

- **Fixed**: Handles dynamically loaded form elements
  - **Before**: Failed if form wasn't immediately available
  - **After**: Retry mechanism waits for elements to load (up to 20 attempts)

- **Fixed**: Login requirement properly enforced
  - **Before**: Inconsistent login modal behavior
  - **After**: Shows UM modal or redirects to login page reliably

### Security

- Implemented ABSPATH check to prevent direct file access
- Added output escaping with `esc_js()` for JavaScript variables
- Removed WordPress version from header
- Added nonce verification framework for AJAX requests (commented, ready to use)
- Capability checks for debug mode (admin only)

### Performance

- Optimized JavaScript initialization (runs only once)
- Efficient event delegation for dynamic elements
- MutationObserver with targeted monitoring
- Minimal CSS with optimized selectors
- Leverages WordPress's built-in jQuery (no additional library)

### Accessibility

- Semantic HTML with proper `<button>` elements
- Focus management for keyboard navigation
- Screen reader compatible
- High contrast support
- Proper ARIA attributes (implicit through semantic HTML)

### Browser Compatibility

- Chrome/Edge: Full support
- Firefox: Full support
- Safari: Full support
- Opera: Full support
- IE11: Partial support (smooth scroll requires polyfill)

### Known Issues

- Smooth scroll may not work on very old browsers (IE11 and below)
- Ultimate Member modal styling depends on UM version
- Initial scroll offset may need adjustment for custom headers

### Migration Notes

For users upgrading from custom footer implementations:
1. Backup existing footer.php before replacing
2. Update any custom button IDs to match new configuration
3. Clear all caches after installation
4. Test on staging environment first

## [Unreleased]

### Planned Features

- [ ] AJAX form submission without page reload
- [ ] File upload support for vehicle images
- [ ] Form validation with visual feedback
- [ ] Success/error message display
- [ ] Save draft functionality
- [ ] Multi-step form option
- [ ] Google reCAPTCHA integration
- [ ] Social login integration
- [ ] User dashboard for managing posts
- [ ] Email notifications for new posts

### Planned Improvements

- [ ] Add loading spinner during scroll
- [ ] Implement form field auto-save
- [ ] Add analytics tracking for button clicks
- [ ] Create admin settings page for configuration
- [ ] Add localization support (translation-ready)
- [ ] Implement unit tests for JavaScript functions
- [ ] Add PHP unit tests for WordPress functions
- [ ] Create Gutenberg block for publication form
- [ ] Add shortcode support for embedding form

### Planned Fixes

- [ ] Improve scroll calculation for pages with sticky headers
- [ ] Better handling of conflicting JavaScript libraries
- [ ] Enhanced mobile touch event handling
- [ ] Optimize for very slow network connections

## Version History

### Version Numbering

- **Major version** (1.x.x): Significant changes, possible breaking changes
- **Minor version** (x.1.x): New features, backward compatible
- **Patch version** (x.x.1): Bug fixes, minor improvements

### Release Schedule

- **Patch releases**: As needed for critical bugs
- **Minor releases**: Monthly or as features complete
- **Major releases**: Annually or for significant rewrites

## Upgrade Guide

### From Custom Implementation to v1.0.0

1. **Backup everything**
   ```bash
   cp -r wp-content/themes/your-theme wp-content/themes/your-theme-backup
   ```

2. **Install new theme**
   - Follow INSTALLATION.md

3. **Migrate customizations**
   - Review your old footer.php
   - Use filter hooks instead of direct modifications
   - Update CSS in style.css

4. **Test thoroughly**
   - Check all pages
   - Test login flow
   - Verify mobile responsiveness

5. **Deploy**
   - Test on staging first
   - Deploy during low-traffic period
   - Monitor for issues

### Configuration Migration

If you had custom settings, use filters in your child theme or plugin:

```php
// Old way (direct modification)
// <button>Custom Text</button>

// New way (filter hook)
add_filter('astra_child_publicar_button_text', function() {
    return 'Custom Text';
});
```

## Support

- **Documentation**: See README.md and other docs
- **Issues**: Report on GitHub repository
- **Email**: Contact repository maintainer
- **Updates**: Watch repository for new releases

## Contributors

- Zoomubik Team - Initial development
- Community contributors - Bug reports and suggestions

## License

This project is licensed under the MIT License - see LICENSE file for details.

---

**Last Updated**: 2026-01-25  
**Maintained By**: Zoomubik Team  
**Repository**: https://github.com/postaldream/Zoomubik

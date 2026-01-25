# Testing Guide - Publicar Button Functionality

This document provides comprehensive testing procedures for the fixed "Publicar" button functionality in the Astra child theme.

## Prerequisites for Testing

- WordPress installation with Astra parent theme
- Astra Child theme installed and activated
- Web browser with Developer Tools (Chrome, Firefox, or Edge)
- (Optional) Ultimate Member plugin for login testing

## Test Environment Setup

### 1. Local WordPress Setup

Use one of these methods:

**Option A: Local by Flywheel**
```bash
# Download and install Local from localwp.com
# Create new site with WordPress
# Install Astra theme
# Install the child theme
```

**Option B: XAMPP/MAMP**
```bash
# Install XAMPP or MAMP
# Download WordPress
# Set up WordPress with Astra theme
# Install child theme
```

**Option C: Docker**
```bash
docker run -d -p 8080:80 \
  -e WORDPRESS_DB_HOST=db \
  -e WORDPRESS_DB_NAME=wordpress \
  wordpress:latest
```

### 2. Install Test Page

Create a test page in WordPress:

1. Go to **Pages > Add New**
2. Title: "Test Publicar"
3. Switch to HTML editor
4. Paste the content from `example-page.html` (body content only)
5. Publish the page

### 3. Verify Theme Installation

Check that all files are present:
```
wp-content/themes/astra-child/
├── footer.php         ✓
├── functions.php      ✓
├── style.css         ✓
├── README.md         ✓
├── INSTALLATION.md   ✓
└── example-page.html ✓
```

## Manual Testing Checklist

### Test 1: Button Visibility

**Steps:**
1. Navigate to any page on the site
2. Scroll down the page

**Expected Results:**
- [ ] Sticky button appears at bottom of viewport
- [ ] Button shows text "📝 Publicar Anuncio"
- [ ] Button has gradient purple background
- [ ] Button is centered horizontally
- [ ] Button is visible on all pages

**Screenshot Location:** Take screenshot showing sticky button

### Test 2: Button Click (Logged Out User)

**Steps:**
1. Log out of WordPress
2. Clear browser cache
3. Navigate to test page
4. Click the sticky "Publicar" button

**Expected Results:**
- [ ] Login modal appears (if Ultimate Member installed)
- [ ] OR redirect to login page (WordPress default)
- [ ] Page does NOT jump to top
- [ ] Button click is smooth without errors

**Browser Console:** Should show:
```
Sticky Publicar button initialized
Footer script initialized
```

### Test 3: Button Click (Logged In User - Form Hidden)

**Steps:**
1. Log in to WordPress
2. Navigate to test page
3. Ensure publication form is hidden
4. Click the sticky "Publicar" button

**Expected Results:**
- [ ] Page scrolls smoothly to publication section
- [ ] "Mostrar Formulario" button is clicked automatically
- [ ] Form becomes visible
- [ ] First input field receives focus
- [ ] Section is not obscured by footer
- [ ] No page jump to top

**Browser Console:** Should show:
```
Sticky Publicar button initialized
Footer script initialized
```

### Test 4: Button Click (Logged In User - Form Visible)

**Steps:**
1. Ensure user is logged in
2. Navigate to test page
3. Click "Mostrar Formulario" to make form visible
4. Scroll away from the form
5. Click the sticky "Publicar" button

**Expected Results:**
- [ ] Page scrolls smoothly to publication section
- [ ] Form remains visible (no toggle)
- [ ] First input field receives focus
- [ ] Section is properly positioned (not hidden by footer)
- [ ] Scroll animation is smooth

### Test 5: Responsive Design

**Steps:**
1. Open page in browser
2. Open Developer Tools (F12)
3. Toggle device toolbar (Ctrl+Shift+M or Cmd+Shift+M)
4. Test on different screen sizes

**Test Resolutions:**
- [ ] Desktop (1920x1080): Button centered, full width limited
- [ ] Tablet (768x1024): Button scales appropriately
- [ ] Mobile (375x667): Button fits screen, smaller padding
- [ ] Mobile (320x568): Minimum size, still readable

**Expected Results:**
- [ ] Button is always visible
- [ ] Button text is readable
- [ ] Button is clickable (touch targets adequate)
- [ ] Scroll behavior works on all devices

### Test 6: Hover and Active States

**Steps:**
1. Navigate to test page
2. Hover mouse over sticky button
3. Click and hold button
4. Release button

**Expected Results:**
- [ ] Hover: Button elevates (translateY -2px)
- [ ] Hover: Box shadow increases
- [ ] Hover: Background color changes to lighter shade
- [ ] Active: Button returns to normal position
- [ ] Transitions are smooth

### Test 7: Multiple Clicks

**Steps:**
1. Log in to WordPress
2. Navigate to test page
3. Click sticky button rapidly 5 times
4. Click sticky button, wait, click again

**Expected Results:**
- [ ] No JavaScript errors
- [ ] Scroll behavior handles multiple clicks gracefully
- [ ] No duplicate event handlers
- [ ] Page performance remains good

### Test 8: Dynamic Content Loading

**Steps:**
1. Create a page where form loads via AJAX
2. Navigate to that page
3. Wait for form to load dynamically
4. Click sticky button

**Expected Results:**
- [ ] Script waits for element (retry mechanism)
- [ ] Finds element after it loads
- [ ] Scrolls to correct position
- [ ] Focus works correctly

**Browser Console:** Check for:
```
Element found after X retries
Publicar section detected in DOM
```

### Test 9: Browser Compatibility

Test on multiple browsers:

**Chrome:**
- [ ] All functionality works
- [ ] Smooth scroll works
- [ ] No console errors

**Firefox:**
- [ ] All functionality works
- [ ] Smooth scroll works
- [ ] No console errors

**Safari:**
- [ ] All functionality works
- [ ] Smooth scroll works
- [ ] No console errors

**Edge:**
- [ ] All functionality works
- [ ] Smooth scroll works
- [ ] No console errors

### Test 10: Performance Testing

**Steps:**
1. Open browser Developer Tools
2. Go to Performance tab
3. Record page load
4. Click sticky button
5. Stop recording

**Expected Results:**
- [ ] Page load time < 3 seconds
- [ ] JavaScript execution time < 100ms
- [ ] No memory leaks
- [ ] Scroll animation smooth (60fps)

### Test 11: Accessibility Testing

**Steps:**
1. Use keyboard navigation only
2. Use screen reader (NVDA, JAWS, or VoiceOver)
3. Test with high contrast mode
4. Test color blind simulation

**Expected Results:**
- [ ] Button is focusable with Tab key
- [ ] Button activates with Enter or Space
- [ ] Screen reader announces button purpose
- [ ] Color contrast meets WCAG AA standards
- [ ] Focus indicator is visible

**Keyboard Navigation:**
- [ ] Tab to button
- [ ] Enter/Space activates button
- [ ] After scroll, focus moves to form input

### Test 12: Ultimate Member Integration

**Prerequisites:** Ultimate Member plugin installed

**Steps:**
1. Install Ultimate Member
2. Configure login page
3. Log out
4. Click sticky button

**Expected Results:**
- [ ] UM login modal opens
- [ ] Modal is properly styled
- [ ] Can log in through modal
- [ ] After login, button works normally

**Fallback Test:**
1. Deactivate Ultimate Member
2. Click sticky button while logged out

**Expected Results:**
- [ ] Redirects to WordPress login page
- [ ] Login URL is correct

## Automated Testing

### JavaScript Unit Tests (Optional)

Create a test file `footer-tests.js`:

```javascript
describe('Publicar Button Tests', () => {
    beforeEach(() => {
        // Setup DOM
        document.body.innerHTML = `
            <div id="publicar-section" style="display:none;">
                <input type="text" id="test-input">
            </div>
            <button id="sticky-publicar-btn">Publicar</button>
        `;
    });

    test('Button exists in DOM', () => {
        const btn = document.getElementById('sticky-publicar-btn');
        expect(btn).toBeTruthy();
    });

    test('Section exists in DOM', () => {
        const section = document.getElementById('publicar-section');
        expect(section).toBeTruthy();
    });

    // Add more tests...
});
```

### PHP Unit Tests (Optional)

Create a test file `test-footer-functions.php`:

```php
<?php
class FooterFunctionsTest extends WP_UnitTestCase {
    
    public function test_show_sticky_footer() {
        $this->assertTrue( astra_child_show_sticky_footer() );
    }

    public function test_get_publicar_button_text() {
        $text = astra_child_get_publicar_button_text();
        $this->assertStringContainsString( 'Publicar', $text );
    }

    // Add more tests...
}
```

## Browser Console Tests

### Test JavaScript Initialization

Open console (F12) and run:

```javascript
// Check if jQuery is loaded
console.log('jQuery version:', jQuery.fn.jquery);

// Check if button exists
console.log('Button:', document.getElementById('sticky-publicar-btn'));

// Check if section exists
console.log('Section:', document.getElementById('publicar-section'));

// Test smooth scroll function
const section = document.getElementById('publicar-section');
if (section) {
    section.scrollIntoView({ behavior: 'smooth' });
}
```

### Test Configuration

```javascript
// View configuration (add to footer.php temporarily for debugging)
console.log('Config:', config);
```

### Monitor DOM Changes

```javascript
// Monitor mutations
const observer = new MutationObserver((mutations) => {
    console.log('DOM changed:', mutations);
});
observer.observe(document.body, { childList: true, subtree: true });
```

## Common Issues and Solutions

### Issue 1: Button Not Appearing

**Debugging Steps:**
1. Check browser console for errors
2. Verify footer.php is being used
3. Check if theme is active
4. Clear all caches

**Console Commands:**
```javascript
// Check if sticky button wrapper exists
document.querySelector('.sticky-publicar-wrapper')
```

### Issue 2: Scroll Not Working

**Debugging Steps:**
1. Verify section ID matches config
2. Check if section is in DOM
3. Test scroll manually

**Console Commands:**
```javascript
// Manual scroll test
document.getElementById('publicar-section')?.scrollIntoView({ behavior: 'smooth' });
```

### Issue 3: Login Modal Not Showing

**Debugging Steps:**
1. Check if Ultimate Member is active
2. Verify UM version compatibility
3. Check browser console for errors

**Console Commands:**
```php
// In WordPress
var_dump(function_exists('um_get_core_page_id'));
```

## Performance Benchmarks

Expected performance metrics:

| Metric | Target | Acceptable |
|--------|--------|------------|
| Page Load | < 2s | < 3s |
| Time to Interactive | < 3s | < 5s |
| Button Click Response | < 100ms | < 200ms |
| Scroll Duration | 800ms | 800ms |
| Memory Usage | < 5MB | < 10MB |

## Security Testing

### XSS Prevention

Test that all inputs are properly escaped:

```javascript
// Try injecting script
document.getElementById('titulo').value = '<script>alert("XSS")</script>';
// Submit form and verify it's escaped
```

### CSRF Protection

Verify that AJAX requests (if any) use nonces:

```php
check_ajax_referer( 'astra-child-nonce', 'nonce' );
```

## Test Results Template

```
Test Date: YYYY-MM-DD
Tester: Name
Environment: Local/Staging/Production
WordPress Version: X.X.X
Astra Version: X.X.X
PHP Version: X.X.X
Browser: Chrome/Firefox/Safari XX

Test Results:
[ ] Test 1: Button Visibility - PASS/FAIL
[ ] Test 2: Click Logged Out - PASS/FAIL
[ ] Test 3: Click Logged In (Hidden) - PASS/FAIL
[ ] Test 4: Click Logged In (Visible) - PASS/FAIL
[ ] Test 5: Responsive Design - PASS/FAIL
[ ] Test 6: Hover/Active States - PASS/FAIL
[ ] Test 7: Multiple Clicks - PASS/FAIL
[ ] Test 8: Dynamic Loading - PASS/FAIL
[ ] Test 9: Browser Compatibility - PASS/FAIL
[ ] Test 10: Performance - PASS/FAIL
[ ] Test 11: Accessibility - PASS/FAIL
[ ] Test 12: UM Integration - PASS/FAIL

Issues Found:
1. [Description]
2. [Description]

Notes:
- [Any additional observations]
```

## Continuous Testing

For ongoing development:

1. **Regression Testing**: Re-run all tests after any changes
2. **User Acceptance Testing**: Get feedback from real users
3. **A/B Testing**: Test different button texts or positions
4. **Analytics**: Monitor actual user interactions

## Tools Recommended

- **Browser DevTools**: Built-in debugging
- **Lighthouse**: Performance auditing
- **axe DevTools**: Accessibility testing
- **BrowserStack**: Cross-browser testing
- **GTmetrix**: Performance analysis
- **Query Monitor**: WordPress debugging plugin

---

**Document Version**: 1.0.0  
**Last Updated**: 2026-01-25  
**Next Review**: After first production deployment

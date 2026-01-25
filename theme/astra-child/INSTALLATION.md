# Installation Guide - Astra Child Theme with Fixed Publicar Button

This guide will help you install and configure the Astra child theme with the improved "Publicar" button functionality for the Zoomubik website.

## Prerequisites

Before you begin, ensure you have:

- WordPress 5.0 or higher installed
- Astra theme (parent theme) installed and activated
- FTP/SFTP access to your server OR WordPress admin access
- (Optional) Ultimate Member plugin for advanced login functionality

## Installation Methods

### Method 1: Direct File Upload (Recommended)

1. **Prepare the theme files**
   
   From the `theme/astra-child/` directory in this repository, you'll need:
   - `footer.php`
   - `style.css`
   - `functions.php`
   - `README.md` (optional, for reference)

2. **Access your WordPress installation**
   
   Using FTP/SFTP, navigate to:
   ```
   /wp-content/themes/
   ```

3. **Create the child theme directory**
   
   Create a new folder named `astra-child`:
   ```
   /wp-content/themes/astra-child/
   ```

4. **Upload the files**
   
   Copy all files from `theme/astra-child/` to `/wp-content/themes/astra-child/`

5. **Activate the child theme**
   
   - Log in to WordPress admin
   - Go to **Appearance > Themes**
   - Find "Astra Child - Zoomubik"
   - Click **Activate**

### Method 2: Create ZIP and Upload via WordPress Admin

1. **Create a ZIP file**
   
   Compress the `theme/astra-child/` directory contents into `astra-child.zip`
   
   Make sure the ZIP contains:
   ```
   astra-child.zip
   ├── footer.php
   ├── style.css
   ├── functions.php
   └── README.md
   ```

2. **Upload via WordPress**
   
   - Log in to WordPress admin
   - Go to **Appearance > Themes**
   - Click **Add New**
   - Click **Upload Theme**
   - Choose your `astra-child.zip` file
   - Click **Install Now**
   - Click **Activate**

### Method 3: WordPress CLI (For Advanced Users)

If you have WP-CLI installed:

```bash
# Navigate to WordPress themes directory
cd /path/to/wordpress/wp-content/themes/

# Create child theme directory
mkdir astra-child

# Copy files (adjust path as needed)
cp /path/to/Zoomubik/theme/astra-child/* astra-child/

# Activate the theme
wp theme activate astra-child
```

## Verification

After installation, verify the theme is working:

1. **Check theme activation**
   - Go to **Appearance > Themes**
   - Confirm "Astra Child - Zoomubik" is active

2. **View your website**
   - Visit your website's homepage
   - You should see a sticky "📝 Publicar Anuncio" button at the bottom

3. **Test the button**
   - Click the button
   - If logged out: You should see a login modal/page
   - If logged in: The page should scroll to the publication section

## Configuration

### Customizing the Button

Edit `footer.php` to customize:

**Button Text:**
```php
<button class="sticky-publicar-btn" id="sticky-publicar-btn">
    📝 Publicar Anuncio  <!-- Change this -->
</button>
```

**Target Section:**
```javascript
const config = {
    targetSectionId: 'publicar-section',  // Change this to match your section ID
    // ... other config
};
```

### Styling Customization

Edit `style.css` to modify:

```css
/* Change colors */
.sticky-publicar-wrapper {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    /* Change to your brand colors */
}

.sticky-publicar-btn {
    color: #667eea;
    /* Customize button colors */
}
```

### Advanced Configuration

Edit `functions.php` to add custom functionality:

```php
// Change button text via filter
add_filter( 'astra_child_publicar_button_text', function() {
    return '✨ Crear Publicación';
});

// Hide sticky footer on specific pages
add_filter( 'astra_child_show_sticky_footer', function( $show ) {
    if ( is_page('about') ) {
        return false; // Hide on about page
    }
    return $show;
});
```

## Required Page Setup

For the button to work properly, you need to ensure:

1. **Create a publication section**
   
   Add a section with ID `publicar-section` to your page:
   ```html
   <div id="publicar-section">
       <!-- Your publication form here -->
   </div>
   ```

2. **Add a form toggle button** (if using dynamic form)
   
   Add a button with class `mostrar-formulario-btn`:
   ```html
   <button class="mostrar-formulario-btn">
       Mostrar Formulario
   </button>
   ```

## Ultimate Member Integration (Optional)

If you're using Ultimate Member for user management:

1. **Install Ultimate Member**
   - Go to **Plugins > Add New**
   - Search for "Ultimate Member"
   - Install and activate

2. **Configure Login Page**
   - Go to **Ultimate Member > Settings > General > Pages**
   - Set your Login page
   - The footer script will automatically use this page

3. **Test Login Modal**
   - Log out of WordPress
   - Click the "Publicar" button
   - You should see the UM login modal

## Troubleshooting

### Button Doesn't Appear

**Check:**
- Theme is activated correctly
- No JavaScript errors in browser console (F12)
- Footer template is being used

**Solution:**
```bash
# Clear WordPress cache
wp cache flush

# Clear browser cache
# Press Ctrl+Shift+R (or Cmd+Shift+R on Mac)
```

### Button Doesn't Scroll

**Check:**
- Target section ID matches configuration
- Section exists in the page HTML

**Solution:**
Edit `footer.php` config:
```javascript
const config = {
    targetSectionId: 'your-actual-section-id',  // Update this
};
```

### Login Modal Doesn't Show

**Check:**
- Ultimate Member is installed and activated
- Login page is configured

**Solution:**
The script will fallback to WordPress default login if UM is not available.

### Styling Issues

**Check:**
- Child theme stylesheet is loading
- No CSS conflicts with plugins

**Solution:**
```css
/* Add to style.css with higher specificity */
body .sticky-publicar-wrapper {
    /* Your styles here */
    z-index: 999999 !important;
}
```

## Browser Console Checks

Open browser console (F12) and look for:

```
Sticky Publicar button initialized
Footer script initialized
```

If you see errors, they will help identify the issue.

## Performance Optimization

### Caching Plugins

If using caching plugins (W3 Total Cache, WP Super Cache, etc.):

1. Clear all caches after installation
2. Exclude footer JavaScript from minification if issues occur

### CDN Configuration

If using a CDN:

1. Ensure theme files are synced to CDN
2. Clear CDN cache after updates

## Security Considerations

The theme includes security best practices:

- ✅ ABSPATH check to prevent direct access
- ✅ Escaped output with `esc_js()`
- ✅ Nonce verification for AJAX (if enabled)
- ✅ WordPress version removed from header
- ✅ Capability checks for debug mode

## Updating the Theme

To update the theme:

1. **Backup your customizations** if you made any changes
2. Download the latest files from the repository
3. Replace the files via FTP or re-upload via WordPress
4. Clear all caches
5. Test functionality

## Support Resources

- **Theme Documentation**: See `README.md` in the theme directory
- **WordPress Codex**: https://codex.wordpress.org/Child_Themes
- **Astra Documentation**: https://wpastra.com/docs/
- **Browser Console**: Check for JavaScript errors (F12)

## Rollback Instructions

If you need to rollback:

1. Go to **Appearance > Themes**
2. Activate the parent "Astra" theme
3. (Optional) Delete the child theme if needed

Your site will revert to the default Astra footer.

## Next Steps

After successful installation:

1. ✅ Test the button functionality
2. ✅ Customize colors to match your brand
3. ✅ Configure the target section ID
4. ✅ Set up Ultimate Member (optional)
5. ✅ Test on mobile devices
6. ✅ Monitor browser console for any errors

## Additional Resources

- **Astra Theme**: https://wpastra.com/
- **Ultimate Member**: https://ultimatemember.com/
- **WordPress Child Themes**: https://developer.wordpress.org/themes/advanced-topics/child-themes/

---

**Version**: 1.0.0  
**Last Updated**: 2026-01-25  
**License**: MIT

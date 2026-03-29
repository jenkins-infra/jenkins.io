/**
 * Loading Animation Handler
 * Shows a loading spinner during page navigation and on page reload
 */

(function() {
  // Create loading overlay element
  const loadingOverlay = document.createElement('div');
  loadingOverlay.id = 'loading-overlay';
  loadingOverlay.className = 'loading-overlay';
  loadingOverlay.innerHTML = `
    <div class="loading-spinner">
      <div class="spinner"></div>
      <p class="loading-text">Loading...</p>
    </div>
  `;

  // Append to body when DOM is ready
  if (document.body) {
    document.body.appendChild(loadingOverlay);
  } else {
    document.addEventListener('DOMContentLoaded', function() {
      document.body.appendChild(loadingOverlay);
    });
  }

  // Show loading overlay on page unload (navigation)
  window.addEventListener('beforeunload', function() {
    const overlay = document.getElementById('loading-overlay');
    if (overlay) {
      overlay.classList.add('show');
    }
  });

  // Hide loading overlay when page has fully loaded
  window.addEventListener('load', function() {
    const overlay = document.getElementById('loading-overlay');
    if (overlay) {
      // Small delay for smooth fade out effect
      setTimeout(function() {
        overlay.classList.remove('show');
      }, 300);
    }
  });

  // Also handle visibility changes (optional)
  document.addEventListener('visibilitychange', function() {
    if (document.hidden) {
      const overlay = document.getElementById('loading-overlay');
      if (overlay) {
        overlay.classList.add('show');
      }
    }
  });

  // Expose a function to manually trigger loading state
  window.showLoadingAnimation = function() {
    const overlay = document.getElementById('loading-overlay');
    if (overlay) {
      overlay.classList.add('show');
    }
  };

  window.hideLoadingAnimation = function() {
    const overlay = document.getElementById('loading-overlay');
    if (overlay) {
      overlay.classList.remove('show');
    }
  };
})();

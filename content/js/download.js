function changeIcon(icon) {
    if (!icon) {
        return;
    }

    icon.setAttribute("name", "checkmark-done-outline");
    setTimeout(function () {
        icon.setAttribute("name", "copy-outline");
    }, 2000);
}

function announceCopyStatus(message) {
    var statusRegion = document.getElementById("download-copy-status");
    if (statusRegion) {
        statusRegion.textContent = message;
    }
}

function copyShaForButton(button) {
    var wrapper = button.closest(".sha-256");
    if (!wrapper) {
        announceCopyStatus("Unable to locate checksum text to copy.");
        return;
    }

    var text = wrapper.getAttribute("data-clipboard-text");
    if (!text) {
        announceCopyStatus("Unable to locate checksum text to copy.");
        return;
    }

    if (!navigator.clipboard || typeof navigator.clipboard.writeText !== "function") {
        announceCopyStatus("Clipboard not available. Please copy the checksum manually.");
        return;
    }

    navigator.clipboard.writeText(text).then(
        function () {
            changeIcon(button.querySelector("ion-icon"));
            announceCopyStatus("SHA-256 copied to clipboard.");
        },
        function () {
            announceCopyStatus("Copy failed. Please copy the checksum manually.");
        }
    );
}

function initializeDownloadPageInteractions() {
    var tooltipNodes = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    Array.prototype.forEach.call(tooltipNodes, function (node) {
        new bootstrap.Tooltip(node);
    });

    document.addEventListener("click", function (event) {
        var button = event.target.closest(".js-copy-sha");
        if (!button) {
            return;
        }

        event.preventDefault();
        copyShaForButton(button);
    });
}

// Initialize when DOM is ready to ensure buttons are functional immediately
if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initializeDownloadPageInteractions);
} else {
    initializeDownloadPageInteractions();
}
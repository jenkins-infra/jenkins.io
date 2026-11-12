function copyToClipboard(event) {
    const text = event.currentTarget.parentNode.getAttribute('data-clipboard-text');
    navigator.clipboard.writeText(text);
}
function changeIcon(iconId) {
    var icon = document.getElementById(iconId);
    if (icon) {
    icon.setAttribute('name', 'checkmark-done-outline');
    setTimeout(function() {
    icon.setAttribute('name', 'copy-outline');
    }, 2000); 
    }
}

$(function () {
    $('[data-toggle="tooltip"]').tooltip({trigger: 'hover'});
  });

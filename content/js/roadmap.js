function filterRoadmap() {
    // Declare variables
    var input, filter, table, tr, td, i, txtValue;
    selectors = document.getElementsByClassName("initiative-selector");
    filters = []
    filterInitiatives = false
    for (i = 0; i < selectors.length; i++) {
        selector = selectors[i]
        if (selector.checked == true){
            filters.push(selector.id)
            filterInitiatives = true
        }
    }

  //table = document.getElementsByClassName("roadmap-table");
  categoryHeaders = document.getElementsByClassName("status-category")
  categoryInitiatives = document.getElementsByClassName("category-initiatives")
    
  for (categoryId = 0; categoryId < categoryInitiatives.length; categoryId++) {
    initiatives = categoryInitiatives[categoryId].getElementsByClassName("initiative");
    hasInitiativesToDisplay = false

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 0; i < initiatives.length; i++) {
      initiative = initiatives[i];
      display = !filterInitiatives
      for (j = 0; j < filters.length; j++) {
        if (initiative.classList.contains(filters[j])) {
            display = true
            break
        }
      }
      if (display) {
        hasInitiativesToDisplay = true
        initiative.style.display = "";
      } else {
        initiative.style.display = "none";
      }
    }

    if (hasInitiativesToDisplay) {
      categoryHeaders[categoryId].style.display = "";
    } else {
      categoryHeaders[categoryId].style.display = "none";
    }
  }
}

window.addEventListener("load", function() {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });
})

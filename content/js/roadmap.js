function filterRoadmap() {
    // Declare variables
    const selectors = document.getElementsByClassName("initiative-selector");
    const filters = [];
    let filterInitiatives = false;
    for (let i = 0; i < selectors.length; i++) {
        const selector = selectors[i];
        if (selector.checked == true){
            filters.push(selector.id);
            filterInitiatives = true;
        }
    }

  //table = document.getElementsByClassName("roadmap-table");
  const categoryHeaders = document.getElementsByClassName("status-category");
  const categoryInitiatives = document.getElementsByClassName("category-initiatives");
    
  for (let categoryId = 0; categoryId < categoryInitiatives.length; categoryId++) {
    const initiatives = categoryInitiatives[categoryId].getElementsByClassName("initiative");
    let hasInitiativesToDisplay = false;

    // Loop through all table rows, and hide those who don't match the search query
    for (let i = 0; i < initiatives.length; i++) {
      const initiative = initiatives[i];
      let display = !filterInitiatives;
      for (let j = 0; j < filters.length; j++) {
        if (initiative.classList.contains(filters[j])) {
            display = true;
            break;
        }
      }
      if (display) {
        hasInitiativesToDisplay = true;
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
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });
});

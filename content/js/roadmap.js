function getSelectedLabels(selectors) {
  const labels = [];
  for (let i = 0; i < selectors.length; i++) {
    const selector = selectors[i];
    if (selector.checked === true) {
      labels.push(selector.dataset.label || selector.id);
    }
  }
  return labels;
}

function setSelectedFromQuery(selectors) {
  const params = new URLSearchParams(window.location.search);
  const labelParam = params.get("labels");
  if (!labelParam) return;

  const selected = labelParam.split(",");
  for (let i = 0; i < selectors.length; i++) {
    const selector = selectors[i];
    const label = selector.dataset.label || selector.id;
    selector.checked = selected.indexOf(label) !== -1;
  }
}

function updateQuery(labels) {
  const url = new URL(window.location.href);
  if (labels.length) {
    url.searchParams.set("labels", labels.join(","));
  } else {
    url.searchParams.delete("labels");
  }
  window.history.replaceState({}, "", url);
}

function filterRoadmap() {
  const selectors = document.getElementsByClassName("initiative-selector");
  const filters = getSelectedLabels(selectors);
  const filterInitiatives = filters.length > 0;
  const clearButton = document.getElementById("roadmap-clear-filters");
  const noResults = document.getElementById("roadmap-no-results");

  const categoryHeaders = document.getElementsByClassName("status-category");
  const categoryInitiatives = document.getElementsByClassName("category-initiatives");

  let anyVisible = false;

  for (let categoryId = 0; categoryId < categoryInitiatives.length; categoryId++) {
    const initiatives = categoryInitiatives[categoryId].getElementsByClassName("initiative");
    let hasInitiativesToDisplay = false;

    for (let i = 0; i < initiatives.length; i++) {
      const initiative = initiatives[i];
      let display = !filterInitiatives;
      for (let j = 0; j < filters.length; j++) {
        if (initiative.classList.contains("initiative-label-" + filters[j])) {
          display = true;
          break;
        }
      }
      if (display) {
        hasInitiativesToDisplay = true;
        anyVisible = true;
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

  if (noResults) {
    noResults.style.display = anyVisible ? "none" : "";
  }
  if (clearButton) {
    clearButton.disabled = filters.length === 0;
  }
  updateQuery(filters);
}

function clearRoadmapFilters() {
  const selectors = document.getElementsByClassName("initiative-selector");
  for (let i = 0; i < selectors.length; i++) {
    selectors[i].checked = false;
  }
  filterRoadmap();
}

window.addEventListener("load", function () {
  const selectors = document.getElementsByClassName("initiative-selector");
  setSelectedFromQuery(selectors);
  filterRoadmap();

  for (let i = 0; i < selectors.length; i++) {
    selectors[i].addEventListener("change", filterRoadmap);
  }

  const clearButton = document.getElementById("roadmap-clear-filters");
  if (clearButton) {
    clearButton.addEventListener("click", clearRoadmapFilters);
  }

  const tooltipTriggerList = [].slice.call(
    document.querySelectorAll('[data-bs-toggle="tooltip"]')
  );
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });
});

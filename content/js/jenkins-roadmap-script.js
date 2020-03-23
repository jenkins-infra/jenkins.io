(function() {
  function createRoadmapCategory(categoryName) {
    return $('<tr class="status-category"><td class="cat-name"><span>' + categoryName + '</span></td><td></td><td></td><td></td><td></td><td></td></tr>');
  }

  function tooltip(item) {
    if (item['description']) {
      return item.description;
    } else {
      switch (item.status) {
        case 'not_planned':
          return 'Not planned to be delivered<br>in the next 12 months.';
        case 'current':
          return 'Things being worked on presently with a specific scope, typically a JEP, though no specific delivery dates';
        case 'near-term':
          return 'We intend to work on that in the short term, but there is no ongoing development';
        case 'future':
          return 'There is an interest to work on that in the community, but no confirmed plans';
        case 'released':
          return 'Released';
        default:
          return 'Unknown';
      }
    }
  }

  function mapStatusToStyle(status) {
    switch (status) {
        case 'released':
            return 'released';
        case 'current':
            return "in-progress";
        case 'near-term':
            return 'ready-soon';
        case 'future':
            return 'planned';
        default:
            return 'unknown';
    }
  }

  function createRoadmapItem(item) {
    var tipAttrs = 'data-delay="200" data-html="true" data-offset="2 0" data-placement="top" data-toggle="tooltip" title=""';
    var inner = '<td class="feat-name"><a href="' + item.link + '">' + item.name + '</a></td>';
    inner += '<td class="status released"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>Released</span></td>';
    inner += '<td class="status in-progress"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>Current</span></td>';
    inner += '<td class="status ready-soon"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>Near Term</span></td>';
    inner += '<td class="status planned"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>Future</span></td>';
    return $('<tr class="status-' + mapStatusToStyle(item.status) + '">' + inner + '</tr>')
  }



  function buildTable(roadmap) {
    var rows = [];
    for (var categoryName in roadmap.categories) {
      if (roadmap.categories.hasOwnProperty(categoryName)) {
          rows.push(createRoadmapCategory(categoryName));
      }
      var items = roadmap.categories[categoryName];
      for (var i = 0; i < items.length; i++) {
        rows.push(createRoadmapItem(items[i]));
      }
    }
    $('.roadmap-table tbody').append(rows);
    initToolTips();
  }

  function fetchRoadmap() {
    // $('.roadmap-table tbody').empty();
    var req = new XMLHttpRequest();
    req.onload = function() {
      buildTable(JSON.parse(req.responseText));
    };
    //TODO(oleg_nenashev): Use separate repo and a CDN like jsdelivr?
    req.open("GET", '/project/roadmap/data.json');
    req.send();
  }

  $(document).ready(fetchRoadmap);
})();

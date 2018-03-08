
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
      case 'planned':
        return 'Planned to be delivered<br>within the next 12 months.';
      case 'in_progress':
        return 'Design and development has started';
      case 'ready_soon':
        return 'Ready for release in the next month';
      case 'released':
        return 'Released';
      default:
        return 'Unknown';
    }
  }
}

function createRoadapItem(item) {
  var tipAttrs = 'data-delay="200" data-html="true" data-offset="2 0" data-placement="top" data-toggle="tooltip" title=""';
  var inner = '<td class="feat-name"><a href="' + item.link + '">' + item.name + '</a></td>';
  inner += '<td class="status not-planned"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>Not planned</span></td>';
  inner += '<td class="status planned"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>Planned</span></td>';
  inner += '<td class="status in-progress"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>In Progress</span></td>';
  inner += '<td class="status ready-soon"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>Ready soon</span></td>';
  inner += '<td class="status released"><span data-original-title="' + tooltip(item) + '" ' + tipAttrs + '>Released</span></td>';
  return $('<tr class="status-' + item.status.replace('_', '-') + '">' + inner + '</tr>')
}

function buildTable(roadmap) {
  var rows = [];
  for (var categoryName in roadmap.categories) {
    if (roadmap.categories.hasOwnProperty(categoryName)) {
        rows.push(createRoadmapCategory(categoryName));
    }
    var items = roadmap.categories[categoryName];
    for (var i = 0; i < items.length; i++) {
      rows.push(createRoadapItem(items[i]));
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
  req.open("GET", '/projects/jcasc/roadmap/data.json');
  req.send();
}

$(fetchRoadmap);

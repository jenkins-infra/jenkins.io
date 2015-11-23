 $.fn.cjpGrid = function(data,config){

    // important properties...
    var config = config || {
      cols:[
            {id:'icon', title:'icon', path:'title', renderer:drawIcon},
            {id:'title',title:'Title',renderer:titleRenderer, grouper:titleGrouper},
            {id:'excerpt',title:'Description'},
            {id:'buildDate',title:'Created',renderer:fromNowRenderer},
            {id:'dependencies',title:'Dependencies',renderer:dependencyRenderer},
            {id:'developers',title:'Maintainers',renderer:maintainerRenderer}
            ],
      groups:[]
    }
    // each col has the following options:
    //
    // id: logical name for the attribute, also assigned as a css class (defaults to the title)
    // title: the display title for the attribute label or column header (defaults to the id)
    // className: to be applied to each cell in the column
    // path: the reference path to the property data from the json source (assumed to be the id if not specified)
    // labelRenderer: a function that returns the $elem to be displayed in the header
    // renderer: a function that returns the $elem to be displayed in each column or result set
    // sorter: a function that returns the logical value by which the attribute should be sorted or grouped (presumed to be the value)
    // grouper: a function that return the logical value by which the attribute should be grouped (presumed to match the sorter)
    // defaultValue: what goes in cells or properties that are not specified by the data
    
    // if not specified columns will be infered using the property name as the id.
    
    var cols = config.cols;
    var groups = config.groups;
    var colIdMap = []; 
    var pathMap = [];
    
    // important table elements I will want to grab easily...
    var $this = this
      .addClass('bootstrap3')
      .addClass('cjp-grid-box smart-grid');
    var elem = $(this)[0];
    
    
    var $colgroup;
    var $thead;
    var $headers;
    var $tbodies;
    var $box;
    var $toolbar = $this.children('.toolbar-box');
    var $grouper;
    var $sorter;
    var $filter;
    var $frame;

    elem.properties = {
        config:{},  
        viewType:elem.properties || 'list',
        isGrouped:false
    
    }
    
    elem.methods = {
        
        init:function(data,config){
          if(data)
            _init(data,config);
          elem.properties.data = data || $this.properties.data;
          elem.properties.config = config || $this.properties.config;
          return $this;
        },
        
        configure:function(config){
          elem.properties.config = config;
          return $this;
        },
        
        setCols:function(cols){
          elem.properties.config = cols;
          return $this;
        },
        
        setViewType: function(type){
          elem.properties.viewType = type;
          _drawBox();
          _drawGroups(data);
          return $this;
        },
          
        getViewType: function(){
          return elem.properties.viewType || 'table';         
        }
    
    };
    
    
    
    
    
    
    ///////////////////////////////////////////
    //
    // Internal methods and properties...
    //    
    //////////////////////////////////////////
 
    function _init(data,config){
      _setCols(config);
      _draw(data);
    }      
    
    function _draw(data){
      _drawBox();
      _drawGroups(data);
      _drawHeaders();
      _drawToolbar();        
    }

    // often, I will be unsure of what format a sent element will take, so I will always transform it into a uniform object...
    function _makeObj(stringOrObjOrArr,key){
      var obj = stringOrObjOrArr;
      if(typeof obj === 'string' || typeof obj === 'number') {
      
        // Here is the format for my all prupose object...
        obj = {
            id:key || obj, 
            title:obj || key, 
            value:obj,
            path:obj,
            type:'string'
          };
        
      }
      else if($.isArray(obj)){
        obj = {
            type:'array', 
            items:obj
          };
      }
      else if($.isPlainObject(obj)){
        if((typeof obj.id === 'string' ||typeof obj.id === 'number' ) && typeof obj.items === 'object' && typeof obj.type === 'string')
          obj = $.extend(obj, {
            id:obj.id||obj.name,
            title:obj.title || obj.name || obj.id,
            type:'object'
          });
        else
          obj = {
            type:'objects',
            items:obj,
            id:key || ''
          };
      }
        
      return obj;
      
    }
    
    function _setCols(config){
      cols = config.cols;
      groups = config.groups;
      colIdMap = [];
      $.each(cols,function(i,col){
        if(typeof col === 'string' || typeof col === 'number' ) colIdMap.push(col);
        else{
          colIdMap.push(col.id);
          pathMap.push(col.path); 
        }        
      });
    }    
    
    function _getCol(key,isPath){
      if(!key)
        return false;
      if(isPath){
        return cols[pathMap.indexOf(key)] || false;
      }
      else{
        return cols[colIdMap.indexOf(key)] || false;
      }
    }
    
    // For zero config, this will generate headers from rows of objects...
    function _generateCols(row,reset){
      if(reset){
        cols = [];
        colIdMap = [];
      }
      if(typeof row === 'string'){
        if(colIdMap.indexOf(row) !== -1) return false;
        colIdMap.push(row);
        cols.push($.extend(
            _makeObj(row), {lostNFound:true,className:'lost-n-found'}
          )
        );
      }
      else
        $.each(row,function(key,cell){
          var col = _makeObj(cell.id || cell.name || key);
          if(colIdMap.indexOf(col.id) < 0){
            colIdMap.push(col.id);
            cols.push(col);
          }
        });      
      groups = cols;
    }
    
    // For handling cells in a variety of data formats...
    function _makeCellObj(cell,col,key){
      var newCell = cell;
      var newCol =col;
      
      // check if the value is a complex object or array...
      if($.isArray(cell) && cell.length < 1) cell = '';
      if(!$.isPlainObject(cell))
        newCell = {
          id:key||cell,
          path:key||cell,
          value:cell,
          displayValue:cell
        }
      if($.isArray(cell) && cell.length > 0){
        if(typeof cell[0] === 'string'){
          newCell.displayValue=cell.join();
          newCell.type = 'strings';
        }
        else{
          newCell.displayValue=cell.length+' items';
          newCell.type = 'objects';
        }
      }
      
      // If it is a string, check to see what kind of string it might be...
      var newVal = newCell.value;
      if(typeof newVal === 'string'){
        newCell.type = 'string';
        
        //check for date...
        var date = moment(newVal);
        if(date.isValid()){
         // newCell.value = date;
          newCell.type = 'date';
        }
        
        //check for email...
        else if (newVal.indexOf('@') > 1 && newVal.indexOf('.') > 3)
          newCell.type = 'email';
        
        //check for url...
        else if (newVal.indexOf('www.') === 0 || newVal.indexOf('http://') === 0 || newVal.indexOf('https://') === 0){
          newCell.type = 'url';
          newCell.displayValue = ['<a href="',newVal,'" target="_blank">',newVal.replace('http://','').replace('https://',''),'</a>'].join('');
        }
      }
      if(typeof col === 'string')
        newCol = {
          id:col,
          path:col
      }
      
      $.extend(newCell,newCol); 
      
      return newCell;
    }
    
    //////////////////////////////////////
    // INTERNAL DRAW ELEMENT METHODS....
    /////////////////////////////////////

    // map domtype options...

    function _$getDomType(childElemName){
      var viewType = elem.methods.getViewType();
      
      if(viewType === 'table'){
        if(childElemName === 'root') return $('<table/>').addClass('grid table cjp-inner-grid');
        else if (childElemName === 'group') return $('<tbody/>').addClass('group');
        else if (childElemName === 'groupTitle') return $('<tr/>').addClass('groupTitle group-header');
        else if (childElemName === 'row') return $('<tr/>').addClass('grid-row item');
        else return $('<td/>').addClass('cell');
      }
      else if(viewType === 'list'){
        if(childElemName === 'root') return $('<ul/>').addClass('cjp-inner-grid');
        else if (childElemName === 'group') return $('<li/>').addClass('group');
        else if (childElemName === 'groupTitle') return $('<div/>').addClass('groupTitle group-header');
        else if (childElemName === 'row') return $('<ul/>').addClass('grid-row tile'); 
        else  return $('<li/>').addClass('cell');
      }
      else if(viewType === 'count'){
        if(childElemName === 'root') return $('<ol/>').addClass('cjp-inner-grid');
        else if (childElemName === 'group') return $('<li/>').addClass('tbody');
        else if (childElemName === 'groupTitle') return $('<div/>').addClass('groupTitle group-header');
        else if (childElemName === 'row') return $('<ol/>').addClass('grid-row'); 
        else return $('<li/>').addClass('cell');
      }      
      else if(viewType === 'block'){
        if(childElemName === 'root') return $('<div/>').addClass('cjp-inner-grid');
        else if (childElemName === 'group') return $('<div/>').addClass('group');
        else if (childElemName === 'groupTitle') return $('<div/>').addClass('groupTitle group-header');
        else if (childElemName === 'row') return $('<div/>').addClass('grid-row tile');
        else  return $('<div/>').addClass('cell');
      }
      else{
        if(childElemName === 'root') return $('<table/>').addClass('grid table cjp-inner-grid');
        else if (childElemName === 'group') return $('<tbody/>').addClass('group');
        else if (childElemName === 'groupTitle') return $('<tr/>').addClass('groupTitle group-header');
        else if (childElemName === 'row') return $('<tr/>').addClass('grid-row item');
        else return $('<td/>').addClass('cell');        
      }
      
      
    }
    
    
    // default renderers...
    function _arrayRenderer(cell,row,col){
      var $cell = _baseRenderer(cell,row,col);
      return $cell;
    }
    
    function _dateRenderer(cell,row,col){
      var $cell = _baseRenderer(cell,row,col);
      return $cell;
    }
    
    function _htmlRenderer(cell,row,col){
      var $cell = _baseRenderer(cell,row,col);
      return $cell;
    }
    function _linkRenderer(cell,row,col){
      var $cell = _baseRenderer(cell,row,col);
      return $cell;
    }
    function _baseRenderer(cell,row,col,customRenderer){
      var $cell = 
        _$getDomType()
          .attr('data-cell-id',cell.id)
          .attr('data-cell-path',cell.path)
          .attr('data-cell-value',cell.value)
          .addClass(cell.className)
          .addClass(cell.id)
          .addClass('attr');
      
      if($.isFunction(customRenderer))
        $cell.append($(customRenderer(cell,row,col)));
      else
        $cell.html(cell.displayValue);  
      
      return $cell;      
    }
    
    /////////////////////////////////
    //  draw grid parts
    
    // draw cell...
    function _drawCell(key,cell,row){ 
      cell = cell || {};
      var path = cell.path;
      if(typeof path ==='string' && row)
        cell.value = row.items[path];
        
      return _baseRenderer(cell,row,_getCol(key),cell.renderer);
    }
    
    // draw row...
    function _drawRow(key,row){
      
      var $row = _$getDomType('row');      
      var rowObj = _makeObj(row,key);
      var cells = rowObj.items;
      
      if(colIdMap.length === 0)
        _generateCols(row);
      
      var $cells = Array.apply(null, Array(colIdMap.length)).map(_$getDomType); //new Array(colIdMap.length);/
      var cellCount = 0;
      var unfoundRows = $.extend([],colIdMap);
      
      if(cells.length > 0 || $.isPlainObject(cells)){        
        $.each(cells,function(key,cell){
          // Check each cell and see if it fits into a defined column...
          var colAtPos = cols[cellCount];
          var newCol = {};
          if(colIdMap.indexOf(key) === -1){
            // if it does NOT, add the column...
            _generateCols(key);
            newCol = _getCol(key) || colAtPos;
            $cells[cellCount] = _drawCell(key,newCol,rowObj);
          } 
          else
            // if it does, remove the column from the unfound list, so we know what columns need values when we are done...
            unfoundRows.splice(unfoundRows.indexOf(key), 1);
          
          var colObj = _getCol(key);
          var cellObj = _makeCellObj(cell,colObj,key);
          
          // if the cell calls for data from a specific path, draw the cell with the path reference...
          if(cellObj.path !== cellObj.id){
            pathCellObj = $.extend({},colObj,cellObj,_getCol(key,true));
            $cells[cellCount] = _drawCell(key,pathCellObj,rowObj);
          }

          // if the cell is previously defined, render it in the correct colum spot...
          if($cells[colIdMap.indexOf(key)]){
            $cells[colIdMap.indexOf(key)] = _drawCell(key,cellObj,rowObj);
            elem.properties.isGrouped = false; /// <---- TODO: This isn't right
          }
          // if the cell is not defined, draw it and push it onto the list of defined columns...
          else {
            $cells.push(_drawCell(key,cellObj));
            elem.properties.isGrouped = true;
          }
          
          cellCount++;        

        });
        
      }
      if(unfoundRows.length > 0){
        $.each(unfoundRows,function(i,colId){
          var col = _getCol(colId);
          var colPos = colIdMap.indexOf(colId);
          $cells[colPos] = _drawCell(colId,col,rowObj);
        });
      }
      
      $row
        .attr('data-row-id',rowObj.id)
        .addClass(rowObj.className)
        .addClass(rowObj.id)
        .addClass('item')
        .append($cells);

      var $newRow = (elem.methods.getViewType() === 'count')? 
          $('<li/>').append($row):
          $row;
    
      return $newRow;
    
    }
    
    // draw groups...
    function _drawGroups(groups){      
      groups = groups || [];
      
      // remove old elements...
      if($tbodies && $tbodies !== 0) $tbodies.remove();
      
      // draw the group...
      function drawGroup(i,groupObj){
        group = groupObj || group;
        
        // Each group will have a label...
        var $label = _$getDomType('groupTitle');
        var $labelLink = (group.id)?
          $([
             '<a href="">',
             '<span class="title">',(group.title || group.id),'</span>',
             '<span class="description">',group.description,'</span>',
             '</a>'
           ].join('')).appendTo($label)
           :{};        

        // Each group will be a $tbody...
        var $tbody = _$getDomType('group')
          .attr('data-group-id',group.id)
          .addClass(group.className)
          .addClass(group.id)
          .append($label);
        
        var $tbodyInner = (elem.methods.getViewType()==='count')?
          $('<ol/>').appendTo($tbody):
          $tbody;
        
        if(group.rows) $.each(group.rows,function(i,row){
          var $row = _drawRow(i,row).appendTo($tbodyInner);
        });
        
        $tbodyInner.appendTo($box);
        
        return $tbody;
      }
      
      var rows = [];
      
      //Check to see if data is actually in a group format...
      if(!($.isArray(groups) && ($.isArray(groups[0]) || groups[0].rows))){
        // if the data is not in a group format, mark the data so I know...
        groups = [{rows:groups,notGrouped:true}];
        
        
      } 
      
      $.each(groups,drawGroup);
      $tbodies = $box.children('.group');
    }
    
    // draw headers...    
    function _drawHeaders(localCols){
      cols = localCols || cols;
      
      var renderer = cols.labelRenderer ||
      function(col){
        var $th = $('<th/>')
          .attr('data-col-id',col.id)
          .attr('data-col-path',col.path)
          .addClass(col.className)
          .addClass(col.id);
        $('<a/>').attr('href',('#sortby='+col.id)).text(col.title).appendTo($th);
      
        return $th;
      }
      
      // draw the headers and setup cell drawing...      
      $.each(cols,function(i,col){ 
        if(typeof col === 'string'){
          col = {
              id:col,
              title:col
          }
        }
        var title = col.title || col.name || col.id;
        var id = col.id || col.name || col.title;
        var newCol = $.extend({id:id,title:title},col)
        var $th = renderer(newCol);
        $th.appendTo($headers);
        
        var $col = $('<col/>')
          .width(col.width)
          .addClass(id)
          .addClass(col.className)
          .appendTo($colgroup);
      });    
    }
    
    // draw table box...
    function _drawBox(){
      $frame = $frame|| $('<div class="frame" />');
      $frame.empty();
      $box = _$getDomType('root');
      
      if(_$getDomType('root').hasClass('table')){
        $box.addClass('table');
        $colgroup = $('<colgroup />').appendTo($box);
        $headers = $('<tr class="__cols__"></tr>');
        $thead = $('<thead/>').append($headers).appendTo($box);
        $tbodies = $('<tbody/>').appendTo($box);
      }
      else if (_$getDomType('root').hasClass('ul')){
        $box.addClass('list');
        $tbodies = $('<ul class="body"/>').append('<li/>').appendTo($box);
      }
      $frame.append($box);
      $this.append($frame);
    }
    
    ///////////////////////////////////////////
    // draw toolbar parts
    
    // draw toolbar...
    function _drawToolbar(localConfig){
      config = localConfig || config;
      // create place for hovers to work...
      if($('#hover-space').length < 1) $('body').append('<div id="cbp-hover-space" class="bootstrap3" />');
      
      // reset toolbar if necissary...
      if($toolbar !== 0) $toolbar.remove();
      
      // control will have a grouper and a sorter control...
      $grouper = _drawPulldowns(groups,'Group');
      $sorter = _drawPulldowns(cols,'Sort');
      $filter = _drawFilterControl();

      $toolbar = $(['<div class="toolbar-box"><div class="toolbar">',
         '<div class="hidden table-hovers"></div>',
         '<nav class="navbar navbar-default navbar-condensed nav-condensed attached" ><div class="container-fluid __form__">',
           '<ul class="nav navbar-nav navbar-right __pulldowns__">',
            '</ul>',
         '</div></nav></div></div>'].join(''));
      
      $toolbar.find('.__form__').append($filter);
      $toolbar.find('.__pulldowns__').append($grouper).append($sorter);
      
      $this.prepend($toolbar);
    }
    
    // draw pulldowns...
    function _drawPulldowns(options,config_title){
      options = options || [];
      var id = (typeof config_title ==='string')? 
          config_title.toLowerCase().replace(/\ /g,'-') 
          : config_title.id;
      var title = (typeof config_title ==='string')? 
          config_title
          : config_title.title;
      //both will use the same HTML wrapper...
      var $pullDownWrapper = $('<li class="dropdown" />')
        .attr('data-action',id)
        .append($(['<a href="#" class="dropdown btn-sm" data-toggle="dropdown" role="button" aria-expanded="false">',title,'<span class="caret"></span></a>'].join('')));
      
      var $ul = $('<ul class="dropdown-menu" role="menu"/>')
        .append($(['<li data-effect="none"><a class="btn-sm" href="#',id,'=__none__">None</a></li>'].join(''))  )
        .appendTo($pullDownWrapper);
      
      // ...and the options will also use the same format...
      function optionRenderer(i,opt){
        //if(i===0) $ul.empty();
        var o = (typeof opt === 'string')?{id:opt}:opt;
        var $Html = $(['<li data-effect="',o.id,'"><a class="btn-sm ',o.id,'" href="#',id,'=',o.id,'">',o.title || o.id,'</a></li>'].join(''));
        $ul.append($Html);
      }
       
    
      $.each(options,optionRenderer);
      
      return $pullDownWrapper;
    }
    
    // draw filter...
    function _drawFilterControl(){
      var $form = $([
        '<form class="nav navbar-form navbar-left">',
          '<fieldset class="form-group">',
            '<div class="input-group input-group-sm">',
              '<input type="text" class="form-control input-sm" placeholder="Find plugins...">',
              '<span class="input-group-btn"><button class="btn btn-default" type="button">Go!</button></span>',
            '</div>',
          '</fieldset>',
        '</form>'
        ].join(''));
      
      $form.submit(function(e){e.preventDefault()});
      
      $form.find('.input-group input.form-control').change(function(e){
        // here I am....
        e.preventDefault();

        var searchString = $(this).val().toLowerCase();
        
        return _filterBy(searchString);
        
      });
      
      return $form;
    }
    
    
    // functional processes...
    
    var hashOps = {
        group:function(group){

          var col = _getCol(group);
          var foundGroups = [];
          var groupedRows = [];
          
          function makeGrouping(i,item){
            
            var rowObj = _makeObj(item);
            var cellObj = _makeObj(rowObj.items[group]) || {};
            var cellId = cellObj.id;
            var renderer = col.grouper || defaultGrouper;
            
            function defaultGrouper(cell,row,col){
              var group = {
                id:cell,
                title:cell,
                value:cell,
                rows:[]
              }
              
              return group;
            }
            
            var groupObj = {};
            var groupKey =  foundGroups.indexOf(cellId);
            if(groupKey === -1){
              
              // put this group reference into my index...
              foundGroups.push(cellId);
              
              // make the groupObject
              groupObj = renderer(rowObj.items[group],rowObj,cellObj);
              groupedRows.push(groupObj);
            }
            else 
              groupObj = groupedRows[groupKey];
            
            // make the row object and stick it into the group...              
            var newRow = $.extend({type:'row',value:cellId},rowObj);
            groupObj.rows.push(newRow);  
            
            
          }
          
          $.each(data,makeGrouping);
          
          _drawGroups(groupedRows,config);
        }     
          
    }
    
    $(window).on( 'hashchange', function(e) {
      var hashArr = window.location.hash.substring(1).split('&');
      $.each(hashArr,function(i,q){
        var qArr = q.split('=');
        hashOps[qArr[0]](qArr[1]);
      })
    });
    
    
    
    function _groupBy(string){
      debugger;
    }
    
    
    function _filterBy(string){
      debugger;
    }
    
      
    return elem.methods.init(data,config);
  };
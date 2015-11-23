var updateCenter = {loaded:false, featuredLoaded:false, postLoaded:false};
updateCenter.post = function(data){
  
  function cleanObj(obj){
    obj.title = $.trim(obj.title.replace('Jenkins ','').replace('Plugin',''));
    return obj;
  }
  
  var pluginsObj = data.plugins;
  var plugins = Object.keys(pluginsObj).map(
      function (key) {
        return cleanObj(pluginsObj[key]);
      }); 
  updateCenter.pluginsObj = pluginsObj;
  updateCenter.plugins = plugins;

  updateCenter.postLoaded = true;
  if(updateCenter.featuredLoaded) updateCenter.loaded = true;
  
  $(window).trigger('loadComplete',updateCenter);
  
  return updateCenter;
};

updateCenter.featured = function(data){

  updateCenter.featuredLoaded = true;
  updateCenter.featuredPlugins = data;
  if(updateCenter.postLoaded) updateCenter.loaded = true;
  
  $(window).trigger('loadComplete',updateCenter);
  return data
}

updateCenter.cleanData = function(data){
  
  var newData = $.extend({},data.featuredPlugins);
  var sourceData = $.extend({},data.pluginsObj);
  
  $.each(data.featuredPlugins,function(i,group){
    $.each(group.rows,function(j,row){
      var pluginName = row.items.id;
      var pluginSource = sourceData[pluginName]
      var pluginDetails = $.extend({},pluginSource);
      var newPlugin = $.extend(newData[i].rows[j].items,row.items,pluginDetails,{scope:'featured',category:group.title});
      
      pluginSource.scope = 'featured';
      pluginSource.category = group.title;
      
    });
  });

  
  
  $('<div id="test" />').appendTo('body').cjpGrid(data.plugins);
}
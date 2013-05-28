var metersContent;
$(document).ready(function() {

  //Backup templates and initialize with default view
  metersContent = $('.tab-content').clone();
  ko.applyBindings(new MetersViewModel(), $("#meters")[0]);

  $('#main-tabs a[data-toggle="tab"]').on('shown', function (e) {
    switch(e.target.hash) {
      case "#meters" :
        var vm = new MetersViewModel();
        var target = e.target.hash;
        ko.unBind($(target)[0]);
        $(target).replaceWith($(target, metersContent).clone());
        ko.applyBindings(vm, $(target)[0]);
        break;
    }
  });

});


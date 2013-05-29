
$(document).ready(function() {

  $('#main-tabs a[data-toggle="tab"]').on('shown', function (e) {
    switchView(e.target.hash);
  });

  switchView('#meters');

  toastr.options.newestOnTop = false;
  toastr.options.positionClass = 'toast-bottom-right';
});

function switchView(anchor) {

  var replaceView = function (viewURL, vm) {
    $.get(viewURL, function(data) {
      $('.tab-content').empty();
      $('.tab-content').append($(data));
      ko.applyBindings(vm, $(anchor)[0]);
    });
  }

  switch(anchor) {
    case "#meters" :
      replaceView('_meters.htm', new MetersViewModel());
      break;
    case "#reports" :
      replaceView('_reports.htm', new ReportsViewModel());
      break;
    case "#simulation" :
      replaceView('_simulation.htm', new SimulationViewModel());
      break;
  }

}


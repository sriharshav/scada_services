/*
 * Meter energy line view model
 */
function MeterLinesViewModel(direction, lines) {
  var self = this;
  self.direction = direction;
  self.lines = ko.observableArray([]);
  $.each(lines, function(i, v) {
    self.lines.push({'caption': ko.observable(i),
      'energy' : ko.observable(v)});
  });
}

/*
 * Each meter view model
 */
function MeterViewModel(id) {
  var self = this;

  self.id = "EM "+id;
 
  self.energies = ko.observableArray([]);

  $.get('/meters/'+id+'/energy', function(data) {
    $.each(data.energy, function(i, v) {
      self.energies.push(new MeterLinesViewModel(i, v));
    });
  });

  self.ct = ko.observable();
  self.vt = ko.observable();

  self.powerfailcounter = ko.observable();
  self.poweroutagetime = ko.observable();

  self.activetariff = ko.observable();

  self.refresh = function() {
    $.get('/meters/'+id+'/energy', function(data) {
      $.each(self.energies(), function(i, v) {
        var lines = data.energy[v.direction];
        $.each(v.lines(), function(j, w) {
          w.energy(lines[w.caption()]);
        });
      });
    });    
  }

}

/*
 * Container for all meters
 */
function MetersViewModel() {
  var self = this;

  self.meters = ko.observableArray([]);
  for(var i=1; i <= 6; i+=1) {
    self.meters.push(new MeterViewModel(i));
  }
}




/*
 * Modubus holding register simulation
 */
function SimulationViewModel() {
  var self = this;
  var cache;

  var getHRSet = function() {
    var data = [];
    for(var i=0; i<120; i+=1) {
      data.push({'val':ko.observable()});
    }
    return data;
  }

  self.holding_registers = ko.observableArray(getHRSet());

  self.refresh = function() {
    $.get('/modbus/holdingregisters', function(data) {
      cache = data;
      $.each(self.holding_registers(), function(i, v) {
        v.val(data[i]);
      });
    });
  }

  self.update = function() {
    var data = {};
    for(var i=0; i<120; i+=1) {
      var val = self.holding_registers()[i].val();
      if (cache[i] != val) {
        data[i] = val;
      }
    }
    if (Object.keys(data).length > 0) {
      $.post('/modbus/holdingregisters', JSON.stringify(data),
          function(data) {  toastr.success(JSON.stringify(data)); self.refresh();  }, 'json');
    } else {
      toastr.info("Nothing changed");
    }
  }

  self.refresh();
}

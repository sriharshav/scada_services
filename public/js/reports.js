/*
 * Reports
 */
function ReportsViewModel() {
  var self = this;

  self.summaryreport = ko.observable();

  self.refresh = function() {
    $.get('/meters/energy', function(data) {
      self.summaryreport(data);
    });
  }

  self.refresh();

}

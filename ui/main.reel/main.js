var Component;

Component = require("montage/ui/component").Component;

exports.Main = Component.specialize({
  templateDidLoad: {
    value: function(e) {
      console.log("Test");
      return this.templateObjects.dataForum.initializeForum();
    }
  },
  debugValue: {
    set: function(e) {
      return console.log("Debug: ", e);
    }
  }
});

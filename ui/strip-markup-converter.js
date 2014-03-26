var Montage = require("montage").Montage;
var Converter = require('montage/core/converter/converter').Converter;

exports.StripMarkupConverter = Converter.specialize({
  _convert: {
    value: function(v) {
      if (v && typeof v == "string") {
        var el = document.createElement("div");
        el.innerHTML = v;
        return el.textContent || el.innerText || "";
      }
      else return "";
    }
  },
  
  convert: {value: function(v) {
    return this._convert(v);
  }},

  revert: {value: function(v) {
    return this._convert(v);
  }}
});

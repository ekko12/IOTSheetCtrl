$(document).ready(function() {
    if ($("#hid_pmProducts").val()) {
        var countriesArray = $.map($.parseJSON($("#hid_pmProducts").val()), function(value, key) {
            return {
                value : value,
                data : key
            };
        });
    }
    $('#skuCodeAuto').autocomplete({
        lookup : countriesArray,
        onSelect : function(suggestion) {
            $('#skuCode').val(suggestion.data);
        },
        onHint : function(hint) {
            $('#skuCodeAuto-x').val(hint);
        },
        onInvalidateSelection : function() {
            $('#skuCode').val('');
        }
    });
});
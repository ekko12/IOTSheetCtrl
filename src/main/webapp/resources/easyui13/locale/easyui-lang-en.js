if ($.fn.pagination){
	$.fn.pagination.defaults.beforePageText = '页码';
	$.fn.pagination.defaults.afterPageText = '总共 {pages}页';
	$.fn.pagination.defaults.displayMsg = '显示 {from} 到 {to} 总共 {total} 条';
}
if ($.fn.datagrid){
	$.fn.datagrid.defaults.loadMsg = 'Processing, please wait ...';
}
if ($.fn.treegrid && $.fn.datagrid){
	$.fn.treegrid.defaults.loadMsg = $.fn.datagrid.defaults.loadMsg;
}
if ($.messager){
	$.messager.defaults.ok = '确定';
	$.messager.defaults.cancel = '取消';
}
if ($.fn.validatebox){
	$.fn.validatebox.defaults.missingMessage = 'This field is required.';
	$.fn.validatebox.defaults.rules.email.message = 'Please enter a valid email address.';
	$.fn.validatebox.defaults.rules.url.message = 'Please enter a valid URL.';
	$.fn.validatebox.defaults.rules.length.message = 'Please enter a value between {0} and {1}.';
	$.fn.validatebox.defaults.rules.remote.message = 'Please fix this field.';
}
if ($.fn.numberbox){
	$.fn.numberbox.defaults.missingMessage = 'This field is required.';
}
if ($.fn.combobox){
	$.fn.combobox.defaults.missingMessage = 'This field is required.';
}
if ($.fn.combotree){
	$.fn.combotree.defaults.missingMessage = 'This field is required.';
}
if ($.fn.combogrid){
	$.fn.combogrid.defaults.missingMessage = 'This field is required.';
}
if ($.fn.calendar){
	$.fn.calendar.defaults.weeks = ['S','M','T','W','T','F','S'];
	$.fn.calendar.defaults.months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
}
if ($.fn.datebox){
	$.fn.datebox.defaults.currentText = 'Today';
	$.fn.datebox.defaults.closeText = 'Close';
	$.fn.datebox.defaults.okText = 'Ok';
	$.fn.datebox.defaults.missingMessage = 'This field is required.';
}
if ($.fn.datetimebox && $.fn.datebox){
	$.extend($.fn.datetimebox.defaults,{
		currentText: $.fn.datebox.defaults.currentText,
		closeText: $.fn.datebox.defaults.closeText,
		okText: $.fn.datebox.defaults.okText,
		missingMessage: $.fn.datebox.defaults.missingMessage
	});
}

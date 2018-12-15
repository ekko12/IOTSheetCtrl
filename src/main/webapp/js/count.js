
function updatePv(){
	var url = document.location.toString();
	var arrUrl = url.split("//");

	var start = arrUrl[1].indexOf("/");
	var rlUrl = arrUrl[1].substring(start)
    
	
		$.ajax({
			type:"POST",
			url:"/api/pv/updatePv", 
			contentType : "text/plain;charset=UTF-8", 
			data:encodeURIComponent(rlUrl),
			datatype: "json",
			success:function(data){
				if (data.Result == 'success') {
			 		alert("操作成功");//请求传输成功回调函数
				}
				else 
				{
			  		alert("操作失败");//请求传输失败回调函数
			 	}
			},
		 	error: function (msg) {
		 		alert(msg); //错误信息
			
			}
	});
}



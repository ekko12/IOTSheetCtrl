function format(time)
{//Mon Apr 01 15:28:47 CST 2014
    if('' == time || null == time)
	{
	    return '';
	}
    var year = time.substr(24,4);
	var monthMap = {"Jan":"01","Feb":"02","Mar":"03","Apr":"04","May":"05","Jun":"06","Jul":"07","Aug":"08","Sep":"09","Oct":"10","Nov":"11","Dec":"12"};
    var month = monthMap[time.substr(4,3)];
    var day = time.substr(8,2);
    var hour = time.substr(11,2);
    var minute = time.substr(14,2);
    var second = time.substr(17,2);
	return year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
}

function format2(time)
{//Thu Jan 01 1970 08:00:00 GMT+0800
    if('' == time || null == time)
	{
	    return '';
	}
    var year = time.substr(11,4);
	var monthMap = {"Jan":"01","Feb":"02","Mar":"03","Apr":"04","May":"05","Jun":"06","Jul":"07","Aug":"08","Sep":"09","Oct":"10","Nov":"11","Dec":"12"};
    var month = monthMap[time.substr(4,3)];
    var day = time.substr(8,2);
    var hour = time.substr(16,2);
    var minute = time.substr(19,2);
    var second = time.substr(22,2);
	return year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
}

function toJavaDateStr(str)
{//"2014-04-22 19:28:45";
if('' == str || null == str)
	{
	    return 'Mon Jan 01 00:00:00 GMT+0700 1970';
	}
var year = str.substr(0,4);
var month = str.substr(5,2);
var day = str.substr(8,2);
var hour = str.substr(11,2);
var minute = str.substr(14,2);
var second = str.substr(17,2);
var date = new Date(year+"/"+month+"/"+day);
var weekMap = {"0":"Sun","1":"Mon","2":"Tue","3":"Wed","4":"Thu","5":"Fri","6":"Sat"};
var monthMap = {"0":"Jan","1":"Feb","2":"Mar","3":"Apr","4":"May","5":"Jun","6":"Jul","7":"Aug","8":"Sep","9":"Oct","10":"Nov","11":"Dec"};
var monthEN = monthMap[date.getMonth()];
var weekEN = weekMap[date.getDay()];
return weekEN +" "+ monthEN +" "+ day +" "+ hour +":"+ minute +":"+ second + " GMT+0700 " + year;
}

function initAdsOptions()
{
    var options = $("#adsPostion .enabled_options");
    for(i in options)
    {
        options[i].innerHTML = getCNPosition(options[i].value);
    }
    options = $("#adsType .enabled_options");
    for(i in options)
    {
        options[i].innerHTML = getCNType(options[i].value);
    }
    options = $("#adsStatus .enabled_options");
    for(i in options)
    {
        options[i].innerHTML = getCNStatus(options[i].value);
    }
}

function initNtyOptions()
{
    var options = $("#ntyType .enabled_options");
    for(i in options)
    {
        options[i].innerHTML = getCNNtyType(options[i].value);
    }
    options = $("#ifTop .enabled_options");
    for(i in options)
    {
        options[i].innerHTML = getCNIfTop(options[i].value);
    }
    options = $("#status .enabled_options");
    for(i in options)
    {
        options[i].innerHTML = getCNNtyStatus(options[i].value);
    }
}

function getCNStatus(key)
{
    map = {"0":"Off-shelf","1":"On-shelf"};
    return map[key];
}

function getCNType(key)
{
    map = {"picture":"picture","flash":"flash"};
    return map[key];
}

function getCNPosition(key)
{
    map = {"left":"Left","center":"Center","right":"Right","top":"Top","large":"big picture"};
    return map[key];
}

function getCNNtyType(key)
{
    map = {"0":"Notice","1":"News"};
    return map[key];
}

function getCNIfTop(key)
{
    map = {"0":"No","1":"Yes"};
    return map[key];
}

function getCNNtyStatus(key)
{
    map = {"1":"Not on-shelf","2":"On-shelf","3":"Off-shelf"};
    return map[key];
}
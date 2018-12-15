/**
 * com.chinauicom.research.iotoperation.system.reportforms.dao.DmCustomDao.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.dao;
 

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date; 
import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinauicom.research.commons.dao.BaseDao;
import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.busAccSnap.entity.BusAccSnapInfo;
import com.chinauicom.research.iotoperation.busAccSnap.entity.BusAccSnapResponse;
import com.chinauicom.research.iotoperation.busAccSnap.entity.BusAccSnapResquest;
import com.chinauicom.research.iotoperation.busAccSnap.entity.HomePgFourTbInfo;
import com.chinauicom.research.iotoperation.busAccSnap.entity.HomePgFourTbResponse;
import com.chinauicom.research.iotoperation.busAccSnap.entity.PieChartInfo;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomARPU;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomActiCompare;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomAvagData;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomIndustryProvince;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomListCompare;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomNewAndCurrent;
import com.chinauicom.research.iotoperation.system.reportforms.entity.DmCustom;
import com.fasterxml.jackson.databind.deser.std.DateDeserializers.CalendarDeserializer;
import com.thoughtworks.xstream.mapper.Mapper.Null;

/**
 * 自定义报表DAO
 * @author zhaich5
 * @since 2018/1/22
 *
 */
@Repository
public class DmCustomDao extends BaseDao {
	
	/**
	 * 根据条件查询自定义列的自定义报表信息列表（分页）</br>
	 * 本查询采用动态输入查询条件。动态输入被查字段，注：被查字段必须是表中的字段否则报错。动态输入表名（涉及分表）
	 * @param params 输入参数，含以下三部分：</br>
	 * 			<p>查询条件</p>
	 * 			params.acctCycle：数据日期(必输)</br>
	 * 			params.province：商机-用户归属省(非必输)</br>
	 * 			params.city：商机-用户归属市(非必输)</br>
	 * 			params.principleIndustry：商机-主要行业(非必输)</br>
	 * 			params.industryDetailProduct：商机-行业细分产品 (非必输)</br>
	 * 			<p>查询字段</p>
	 * 			params.customColumnsList：字段名称集合</br>
	 * 			<p>查询表名</p>
	 * 			params.tableName:表名(必输)</br>
	 * @param currPage 
	 * 			当前页码
	 * @param pageSize
	 * 			当前页记录数
	 * @return page 
	 * 			当前页对象
	 * @throws Exception
	 */
	public Page selectDmCustomListForColumnsByParams(DmCustom params, 
			int currPage, int pageSize) throws Exception {
		return queryForPage("DM_CUSTOM.selectDmCustomListForColumnsByParams", 
				params, 
				currPage, 
				pageSize);
	}
	
	/**
	 * 根据条件查询自定义列的自定义报表信息列表</br>
	 * 本查询采用动态输入查询条件。动态输入被查字段，注：被查字段必须是表中的字段否则报错。动态输入表名（涉及分表）
	 * @param params 输入参数，含以下三部分：</br>
	 * 			<p>查询条件</p>
	 * 			params.acctCycle：数据日期(必输)</br>
	 * 			params.province：商机-用户归属省(非必输)</br>
	 * 			params.city：商机-用户归属市(非必输)</br>
	 * 			params.principleIndustry：商机-主要行业(非必输)</br>
	 * 			params.industryDetailProduct：商机-行业细分产品 (非必输)</br>
	 * 			<p>查询字段</p>
	 * 			params.customColumnsList：字段名称集合</br>
	 * 			<p>查询表名</p>
	 * 			params.tableName:表名(必输)</br>
	 * @return list 
	 * 			结果集
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<DmCustom> selectDmCustomListForColumnsByParams(
			DmCustom params) throws Exception {
		return (List<DmCustom>) queryForList(
				"DM_CUSTOM.selectDmCustomListForColumnsByParams", 
				params);
	}
	
	@SuppressWarnings("unchecked")
	public List<CustomActiCompare> selectDmCustomActiForCompareByDate(
			CustomActiCompare params) throws Exception { 		
		if(params.getPro()==null)
			return (List<CustomActiCompare>) queryForList(
					"DM_CUSTOM.selectDmCustomActiForCompareByDate", 
					params);
			else
				return (List<CustomActiCompare>) queryForList(
						"DM_CUSTOM.selectDmCustomActiForCompareByDateCity", 
						params); 
	}
	@SuppressWarnings("unchecked")
	public List<CustomNewAndCurrent> selectDmCustomNewAndCurrent(
			CustomNewAndCurrent params) throws Exception {		
		if(params.getPro()==null)
			return (List<CustomNewAndCurrent>) queryForList(
					"DM_CUSTOM.selectDmCustomNewAndCurrent", 
					params);
			else
				return (List<CustomNewAndCurrent>) queryForList(
						"DM_CUSTOM.selectDmCustomNewAndCurrentCity", 
						params); 
	}
	@SuppressWarnings("unchecked")
	public List<CustomIndustryProvince> selectDmCustomIndustryProvince(
			CustomIndustryProvince params) throws Exception { 
		if(params.getPro()==null)
			return (List<CustomIndustryProvince>) queryForList(
					"DM_CUSTOM.selectDmCustomIndustryProvince", 
					params);
			else
				return (List<CustomIndustryProvince>) queryForList(
						"DM_CUSTOM.selectDmCustomIndustryProvinceCity", 
						params); 
	}
	
	@SuppressWarnings("unchecked")
	public List<CustomAvagData> selectDmCustomAvagData(
			CustomAvagData params) throws Exception { 
		if(params.getPro()==null)
			return (List<CustomAvagData>) queryForList(
					"DM_CUSTOM.selectDmCustomAvagData", 
					params);
			else
				return (List<CustomAvagData>) queryForList(
						"DM_CUSTOM.selectDmCustomAvagDataCity", 
						params); 
	}
	
	@SuppressWarnings("unchecked")
	public List<CustomARPU> selectDmCustomARPU(
			CustomARPU params) throws Exception { 
		if(params.getPro()==null)
			return (List<CustomARPU>) queryForList(
					"DM_CUSTOM.selectDmCustomARPU", 
					params);
			else
				return (List<CustomARPU>) queryForList(
						"DM_CUSTOM.selectDmCustomARPUCity", 
						params);
	}
	
	@SuppressWarnings("unchecked")
	public List<CustomListCompare> selectDmCustomListForCompareByDate(
			CustomListCompare params) throws Exception {
		if(params.getPro()==null)
		return (List<CustomListCompare>) queryForList(
				"DM_CUSTOM.selectDmCustomListForCompareByDate", 
				params);
		else
			return (List<CustomListCompare>) queryForList(
					"DM_CUSTOM.selectDmCustomListForCompareByDateCity", 
					params);
	}
	
	
	/*
	 * add in 20180504
	 * 
	 */
	public HomePgFourTbResponse selectHomePgFourTb(BusAccSnapResquest request) throws ParseException {
		
		HomePgFourTbResponse resp = new HomePgFourTbResponse();

		Calendar cal = Calendar.getInstance(); //它的作用是获得一个Calendar类型的通用对象，getInstance()将返回一个Calendar的对象。
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 
		String provinceCode = request.getProvinceCode();
	    String cityCode = request.getCityCode();
	    String isFlag= request.getIsFlag();
	    //是否为默认firstFlag=0页面，或者查询界面 （）
	    String firstFlag = request.getFirstFlag();
	    String monthDay = request.getMonthDay();
	    String industry = request.getIndustry();
	    String customerType = request.getCustomerType();
		BusAccSnapInfo vo = new BusAccSnapInfo(); //一个集成商业累计信息的类 ？？？
	    //是否为默认firstFlag=0,没有月份
		Date busTime = null;
		if(firstFlag!=null && !firstFlag.equals("0")){
			DateFormat format1 = new SimpleDateFormat("yyyy-MM");    
		    //busTime = format1.parse(busAccYear +"-"+ busAccMonth);
			vo.setBusTime(busTime);
		}
	    
    	if (provinceCode==null || provinceCode.equals("1")){
    		vo.setProvinceCode(null);
    	}else{
    		vo.setProvinceCode(provinceCode);//provinceCode.substring(1, provinceCode.length())
    	}
    	
    	if (cityCode==null||cityCode.equals("1")){
    		vo.setCityCode(null);
    	}else{
    		vo.setCityCode(cityCode);
    	}
    	 
    	if (industry==null||industry.equals("1")){
    		vo.setIndustry(null);
    	}else{
    		vo.setIndustry(industry);
    	}
    	if (customerType==null||customerType.equals("1")){
    		vo.setCustomerType(null);
    	}else{
    		vo.setCustomerType(customerType);
    	}
    	if (monthDay==null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	String year = monthDay.substring(0, 4);

    	
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
		
	    try {
		    //1-运营商 2-省份 3-地市
	    	List data  = new ArrayList();
	    	HomePgFourTbInfo dataVo = new HomePgFourTbInfo();
	    	HomePgFourTbInfo info = new HomePgFourTbInfo();
	    	HomePgFourTbInfo info1 = new HomePgFourTbInfo();
	    	HomePgFourTbInfo info2 = new HomePgFourTbInfo();
	    	HomePgFourTbInfo info3 = new HomePgFourTbInfo();
	    	
	    
	    	//根据前台输入的月份、日期、省、地市、行业、客户类型进行查询
	    	info = (HomePgFourTbInfo)getSqlSession().selectOne("DM_CUSTOM.selectTrendGraphByFlag",vo);//select语传入一个参数,返回info对象, 查询结果为connectNum(连接数)、activityTrend激活率、incomeTrend收入
	    	info2 = (HomePgFourTbInfo)getSqlSession().selectOne("DM_CUSTOM.selectAccountNumOrderTrend",vo);//结果为账户数accountNum、订单订购orderTrend
	    	      	        	    	
	    	int customerNum = ((Integer)getSqlSession().selectOne("DM_CUSTOM.selectCustomerNum",vo)).intValue();
	     	
	    	//add 2018-09-21
	    	//计算上账期环比值
	        Date curDate = sdf.parse(monthDay);
	        cal.setTime(curDate);
	        cal.add(Calendar.MONTH, -1);
	        Date lastDate = cal.getTime();
	        String lastMonthDay = sdf.format(lastDate);
	        vo.setMonthDay(lastMonthDay);
	        info1 = (HomePgFourTbInfo)getSqlSession().selectOne("DM_CUSTOM.selectTrendGraphByFlag",vo);	 

	        info3 = (HomePgFourTbInfo)getSqlSession().selectOne("DM_CUSTOM.selectAccountNumOrderTrend",vo);//add in 2018-09-29	        
	        int customerNum2 = ((Integer)getSqlSession().selectOne("DM_CUSTOM.selectCustomerNum",vo)).intValue();//add in 2018-09-29
	       
	        
	        //设置 新的返回参数
	        if (null == info){
	    		info = new HomePgFourTbInfo();
	    		info.setConnectNum("0");
	    		info.setActivityTrend("0");
	    		info.setIncomeTrend("0");
	    		info.setCustomerNumber("0");
	    	}
	        if (null == info2){
	    		info2 = new HomePgFourTbInfo();
	    		info2.setAccountNum("0");
	    		info2.setOrderTrend("0");
	    	}

	   
	        
	    	if (null == info2.getAccountNum()){
	    		dataVo.setAccountNum("0");
	    	}else{
	    		dataVo.setAccountNum(info2.getAccountNum());
	    	}
	    	
	    	if (null == info.getConnectNum()){
	    		dataVo.setConnectNum("0");
	    	}else{
	    		dataVo.setConnectNum(info.getConnectNum());
	    	}
	    	if (null == info.getActivityTrend()){
	    		dataVo.setActivityTrend("0");
	    	}else{
	    		dataVo.setActivityTrend(info.getActivityTrend());
	    	}
	    	
	    	if (null == info2.getOrderTrend()){
	    		dataVo.setOrderTrend("0");
	    	}else{
	    		dataVo.setOrderTrend(info2.getOrderTrend());
	    	}
	    	if (null == info.getIncomeTrend()){
	    		dataVo.setIncomeTrend("0");
	    	}else{
	    		dataVo.setIncomeTrend(info.getIncomeTrend());
	    	}
	    	if (customerNum == 0){
	    		dataVo.setCustomerNumber("0");
	    	}else{
	    		dataVo.setCustomerNumber( String.valueOf(customerNum));
	    	}
	    	if(null == info.getIncomeTrend() || null == info1.getIncomeTrend()) {
	    		dataVo.setIncomeTrendRate("0");
	    	}else {	    		
	    		String incomeTreadRate =(Double.parseDouble(info.getIncomeTrend()) - Double.parseDouble(info1.getIncomeTrend())) / Double.parseDouble(info1.getIncomeTrend()) + "";	    	
	    		dataVo.setIncomeTrendRate(incomeTreadRate);
	    	}
	    	if(null == info.getConnectNum() || null == info1.getConnectNum()) {
	    		dataVo.setConnectNumRate("0");
	    	}else {
	    		String connectNumRate = (Double.parseDouble(info.getConnectNum()) - Double.parseDouble(info1.getConnectNum())) / Double.parseDouble(info1.getConnectNum()) + "";
	    		dataVo.setConnectNumRate(connectNumRate);
	    	//add in 2018-09-29
	    	if(null == info.getAccountNum() || null == info3.getAccountNum()) {
	    		dataVo.setAccountNumRate("0");
	    	}else {
	    		String accountNumRate = (Double.parseDouble(info.getAccountNum()) - Double.parseDouble(info3.getAccountNum())) / Double.parseDouble(info3.getAccountNum()) + "";
	    		dataVo.setAccountNumRate(accountNumRate);
	    	}
	    	
	    	if( customerNum == 0|| customerNum2 == 0) {
	    		dataVo.setCustomerNumRate("0");
	    	}else {
	    		String customerNumRate = (Double.parseDouble(String.valueOf(customerNum)) - Double.parseDouble(String.valueOf(customerNum2))) / Double.parseDouble(String.valueOf(customerNum2)) + "";
	    		dataVo.setCustomerNumRate(customerNumRate);
	    	}
	    	
	    	}
	    	
	    	//首页五个参数方式list
	    	data.add(dataVo); //将data转换成一个list值
	    	
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());//e.getMessage() ; 只会获得异常的名称。 
			                           // e.printStackTrace(); 会打印出详细的异常信息，异常名称。便于调试
	    }
	
	    return resp;
    }
	
	/*
	 * add in 20181017
	 * 
	 */
	 public HomePgFourTbResponse selectHomeRate(BusAccSnapResquest request) throws ParseException {
		
		HomePgFourTbResponse resp = new HomePgFourTbResponse();

		Calendar cal = Calendar.getInstance(); //它的作用是获得一个Calendar类型的通用对象，getInstance()将返回一个Calendar的对象。
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		 
		//String provinceCode = request.getProvinceCode();
	   // String cityCode = request.getCityCode();
	    //String isFlag= request.getIsFlag();
	    //是否为默认firstFlag=0页面，或者查询界面 （）
	    //String firstFlag = request.getFirstFlag();
	    String monthDay = request.getMonthDay();
	    //String industry = request.getIndustry();
	    String customerType = request.getCustomerType();
		BusAccSnapInfo vo = new BusAccSnapInfo(); //一个集成商业累计信息的类 ？？？
	    //是否为默认firstFlag=0,没有月份
		Date busTime = null;
	
    	if (customerType==null||customerType.equals("1")){
    		vo.setCustomerType(null);
    	}else{
    		vo.setCustomerType(customerType);
    	}
    	if (monthDay==null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	String year = monthDay.substring(0, 4);
    	//add in 20181017
    	String month1 = monthDay.substring(0, 7);
		String month = month1.replace("-", "");
    	if (month==null){
    		vo.setMonth(null);
    	}else{
    		vo.setMonth(month);
    	}
    	String tableNameM="dm_custom_month_"+year;
    	//end add
    	
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
		//add in 20181017
		vo.setTableNameM(tableNameM);
		// end  add
	    try {
		    //1-运营商 2-省份 3-地市
	    	List data  = new ArrayList();
	    	HomePgFourTbInfo dataVo = new HomePgFourTbInfo();
	    	HomePgFourTbInfo info4 = new HomePgFourTbInfo();//add in 20181015 连接出账率 
	    	HomePgFourTbInfo info5 = new HomePgFourTbInfo(); //add in 20181015 连接活跃率
	    	//根据前台输入的月份、日期、省、地市、行业、客户类型进行查询
	    	      	        	    	
	    	//int customerNum = ((Integer)getSqlSession().selectOne("DM_CUSTOM.selectCustomerNum",vo)).intValue();
	     	//add in 20181017
	    	info4 = (HomePgFourTbInfo)getSqlSession().selectOne("DM_CUSTOM.selectChargeConnectRate",vo);//add in 20181015
	    	info5 = (HomePgFourTbInfo)getSqlSession().selectOne("DM_CUSTOM.selectAcctChargeLiveRate",vo);//add in 20181015 
	        //设置 新的返回参数
	       //ADD in 20181015
	      if (null == info4){
	    		info4 = new HomePgFourTbInfo();
	    		info4.setChargeConnectRate("0");
	    	}
	        if (null == info5){
	    		info5 = new HomePgFourTbInfo();
	    		info5.setAcctChargeLiveRate("0");
	    	} 

	    	/*if (null == info.getActivityTrend()){
	    		dataVo.setActivityTrend("0");
	    	}else{
	    		dataVo.setActivityTrend(info.getActivityTrend());
	    	}*/

	    	//add in 20181015
	    	if (null == info4.getChargeConnectRate()){
	    		dataVo.setChargeConnectRate("0");
	    	}else{
	    		dataVo.setChargeConnectRate(info4.getChargeConnectRate());
	    	}
	     	if (null == info5.getAcctChargeLiveRate()){
	    		dataVo.setAcctChargeLiveRate("0");
	    	}else{
	    		dataVo.setAcctChargeLiveRate(info5.getAcctChargeLiveRate());
	    	}
	    	//}
	    	
	    	//首页参数方式list
	    	data.add(dataVo); //将data转换成一个list值
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());//e.getMessage() ; 只会获得异常的名称。 
			                           // e.printStackTrace(); 会打印出详细的异常信息，异常名称。便于调试
	    }
	
	    return resp;
    }

/*add in 2018.11.7  8.7.3 全国各省商用计费、商用不计费、测试账户数（个）*/	 
	 public BusAccSnapResponse selectCustomAccountByType(BusAccSnapResquest request) throws ParseException {
		
		    BusAccSnapResponse resp = new BusAccSnapResponse();
			Calendar cal = Calendar.getInstance(); //它的作用是获得一个Calendar类型的通用对象，getInstance()将返回一个Calendar的对象。
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String monthDay = request.getMonthDay();
		    //String industry = request.getIndustry();
		   // String customerType = request.getCustomerType();
			BusAccSnapInfo vo = new BusAccSnapInfo(); //一个集成商业累计信息的类 ？？？
		    //是否为默认firstFlag=0,没有月份
			Date busTime = null;
			String provinceCode = request.getProvinceCode();
	    	if (monthDay==null){
	    		vo.setMonthDay(null);
	    	}else{
	    		vo.setMonthDay(monthDay);
	    	}
	    	if (provinceCode==null){
	    		vo.setProvinceCode(null);
	    	}else{
	    		vo.setProvinceCode(provinceCode);
	    	}
	  	
		    try {
		    	List data  = new ArrayList();
		    	String year = monthDay.substring(0, 4);
				String tableName="dm_custom_"+year;
				vo.setTableName(tableName);
				if (provinceCode==null){
					data = queryForList("DM_CUSTOM.selectCustomAccountByType", vo);
		    	}else{
		    		vo.setMonthDay(vo.getMonthDay().replace("-", ""));
					data = queryForList("DM_CUSTOM.selectCustomAccountByTypeCity", vo);
		    	}
			    resp.setCode("200");
				resp.setMsg("success");
				resp.setDatas(data);
		    }catch(Exception e){
		    	e.printStackTrace();
		    	resp.setCode("-1");
				resp.setMsg(e.getMessage());
		    }
		
		    return resp;
		}

	 
	 
	public BusAccSnapResponse selectByPieChart(BusAccSnapResquest request) {
		
		BusAccSnapResponse resp = new BusAccSnapResponse();
		String provinceCode = request.getProvinceCode();
	    String cityCode = request.getCityCode();
	    String companyCode = request.getCompanyCode();
	    String isFlag= request.getIsFlag();
	    String monthDay = request.getMonthDay();
	    String industry = request.getIndustry();
	    String customerType = request.getCustomerType();
	    String displayContent=request.getDisplayContent();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

    	if (provinceCode==null||provinceCode.equals("1")){
    		vo.setProvinceCode(null);
    	}else{
    		vo.setProvinceCode(provinceCode);//provinceCode.substring(1, provinceCode.length())
    	}
    	if (cityCode==null||cityCode.equals("1")){
    		vo.setCityCode(null);
    	}else{
    		vo.setCityCode(cityCode);
    	}
    	if (companyCode == null || companyCode.length() == 0){
    		vo.setCompanyCode(null);
    	}else{
    		vo.setCompanyCode(companyCode);
    	}
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	if (industry == null || industry.length() == 0){
    		vo.setIndustry(null);
    	}else{
    		vo.setIndustry(industry);
    	}
    	if (customerType == null || customerType.length() == 0){
    		vo.setCustomerType(null);
    	}else{
    		vo.setCustomerType(customerType);
    	}
    	String year = monthDay.substring(0, 4);
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
	    try {
	    	List data  = new ArrayList();
	    	if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
	    		data = queryForList("DM_CUSTOM.selectAccountNumByCustomer", vo);
	    	}else if(displayContent.equals("2")){//点击查看连接数
	    		data = queryForList("DM_CUSTOM.selectConnectNumByCustomer", vo);
	    	}else if(displayContent.equals("3")){//点击查看激活率
	    		data = queryForList("DM_CUSTOM.selectActivityTrendByCustomer", vo);
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
	    		data = queryForList("DM_CUSTOM.selectOrderNumByCustomer", vo);
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
	    		data = queryForList("DM_CUSTOM.selectIncomeByCustomer", vo);
	    	}else{
	    		data = queryForList("DM_CUSTOM.selectCustomerNumByCustomer", vo);
	    	}
		    
		    
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	
	    return resp;
    }
	/*
	 * 时间维度
	 * 
	 */
	public BusAccSnapResponse selectByLineChart(BusAccSnapResquest request) {
		
		BusAccSnapResponse resp = new BusAccSnapResponse();
		String provinceCode = request.getProvinceCode();
	    String cityCode = request.getCityCode();
	    String companyCode = request.getCompanyCode();
	    String isFlag= request.getIsFlag();
	    String industry = request.getIndustry();
	    String customerType = request.getCustomerType();
	    String displayContent=request.getDisplayContent();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	if (provinceCode==null || provinceCode.equals("1")){
    		vo.setProvinceCode(null);
    	}else{
    		vo.setProvinceCode(provinceCode);//provinceCode.substring(1, provinceCode.length())
    	}
    	if (cityCode==null||cityCode.equals("1")){
    		vo.setCityCode(null);
    	}else{
    		vo.setCityCode(cityCode);
    	}
    	if (companyCode == null || companyCode.length() == 0){
    		vo.setCompanyCode(null);
    	}else{
    		vo.setCompanyCode(companyCode);
    	}
    	if (industry == null || industry.length() == 0){
    		vo.setIndustry(null);
    	}else{
    		vo.setIndustry(industry);
    	}
    	if (customerType == null || customerType.length() == 0){
    		vo.setCustomerType(null);
    	}else{
    		vo.setCustomerType(customerType);
    	}
    	String year = monthDay.substring(0, 4);
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
	    try {
	    	List data  = new ArrayList();
	    	if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
	    		data = queryForList("DM_CUSTOM.selectAccountNumByDate", vo);
	    	}else if(displayContent.equals("2")){//点击查看连接数
	    		data = queryForList("DM_CUSTOM.selectConnectNumByDate", vo);
	    	}else if(displayContent.equals("3")){//点击查看激活率
	    		data = queryForList("DM_CUSTOM.selectActivityTrendByDate", vo);
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
	    		data = queryForList("DM_CUSTOM.selectOrderNumByDate", vo);
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
	    		data = queryForList("DM_CUSTOM.selectIncomeByDate", vo);
	    	}else{
	    		data = queryForList("DM_CUSTOM.selectCustomerNumByDate", vo);
	    	}
		    
		    
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	
	    return resp;
	}
	/*
	 * 地域维度
	 * 
	 */
	public BusAccSnapResponse selectBarGraphByCity(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
		String provinceCode = request.getProvinceCode();
	    String cityCode = request.getCityCode();
	    String companyCode = request.getCompanyCode();
	    String isFlag= request.getIsFlag();
	    String industry = request.getIndustry();
	    String customerType = request.getCustomerType();
	    String displayContent=request.getDisplayContent();
	    BusAccSnapInfo vo = new BusAccSnapInfo();
	    
	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	
    	if (provinceCode==null || provinceCode.equals("1")){
    		vo.setProvinceCode(null);
    	}else{
    		vo.setProvinceCode(provinceCode);//provinceCode.substring(1, provinceCode.length())
    	}
    	if (cityCode==null||cityCode.equals("1")){
    		vo.setCityCode(null);
    	}else{
    		vo.setCityCode(cityCode);
    	}
    	if (companyCode == null || companyCode.length() == 0){
    		vo.setCompanyCode(null);
    	}else{
    		vo.setCompanyCode(companyCode);
    	}
    	if (industry == null || industry.length() == 0){
    		vo.setIndustry(null);
    	}else{
    		vo.setIndustry(industry);
    	}
    	if (customerType == null || customerType.length() == 0){
    		vo.setCustomerType(null);
    	}else{
    		vo.setCustomerType(customerType);
    	}
    	String year = monthDay.substring(0, 4);
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
	    try {
	    	List data  = new ArrayList();
	    	if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
	    		if (isFlag.equals("1")){
			    	data = queryForList("DM_CUSTOM.selectAccountNumByAllCity", vo);
			    }else if(isFlag.equals("2")){
			    	data = queryForList("DM_CUSTOM.selectAccountNumByCity", vo);
			    }else if(isFlag.equals("3")){
			    	data = queryForList("DM_CUSTOM.selectAccountNumByCompany", vo);
			    }
	    	}else if(displayContent.equals("2")){//点击查看连接数
	    		if (isFlag.equals("1")){
			    	data = queryForList("DM_CUSTOM.selectConnectNumByAllCity", vo);
			    }else if(isFlag.equals("2")){
			    	data = queryForList("DM_CUSTOM.selectConnectNumByCity", vo);
			    }else if(isFlag.equals("3")){
			    	data = queryForList("DM_CUSTOM.selectConnectNumByCompany", vo);
			    }
	    	}else if(displayContent.equals("3")){//点击查看激活率
	    		if (isFlag.equals("1")){
			    	data = queryForList("DM_CUSTOM.selectActivityTrendByAllCity", vo);
			    }else if(isFlag.equals("2")){
			    	data = queryForList("DM_CUSTOM.selectActivityTrendByCity", vo);
			    }else if(isFlag.equals("3")){
			    	data = queryForList("DM_CUSTOM.selectActivityTrendByCompany", vo);
			    }
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
	    		if (isFlag.equals("1")){
			    	data = queryForList("DM_CUSTOM.selectOrderNumByAllCity", vo);
			    }else if(isFlag.equals("2")){
			    	data = queryForList("DM_CUSTOM.selectOrderNumByCity", vo);
			    }else if(isFlag.equals("3")){
			    	data = queryForList("DM_CUSTOM.selectOrderNumByCompany", vo);
			    }
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
	    		if (isFlag.equals("1")){
			    	data = queryForList("DM_CUSTOM.selectIncomeByAllCity", vo);
			    }else if(isFlag.equals("2")){
			    	data = queryForList("DM_CUSTOM.selectIncomeByCity", vo);
			    }else if(isFlag.equals("3")){
			    	data = queryForList("DM_CUSTOM.selectIncomeByCompany", vo);
			    }
	    	}else{
	    		if (isFlag.equals("1")){
			    	data = queryForList("DM_CUSTOM.selectCustomerNumByAllCity", vo);
			    }else if(isFlag.equals("2")){
			    	data = queryForList("DM_CUSTOM.selectCustomerNumByCity", vo);
			    }else if(isFlag.equals("3")){
			    	data = queryForList("DM_CUSTOM.selectCustomerNumByCompany", vo);
			    }
	    	}
		    
		    
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	
	    return resp;
		
	}
	/*
	 *行业维度 
	 * 
	 */
	public BusAccSnapResponse selectBarGraphByIndustry(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
		String provinceCode = request.getProvinceCode();
	    String cityCode = request.getCityCode();
	    String companyCode = request.getCompanyCode();
	    String isFlag= request.getIsFlag();
	    String industry = request.getIndustry();
	    String customerType = request.getCustomerType();
	    String displayContent=request.getDisplayContent();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	if (provinceCode==null || provinceCode.equals("1")){
    		vo.setProvinceCode(null);
    	}else{
    		vo.setProvinceCode(provinceCode);//provinceCode.substring(1, provinceCode.length())
    	}
    	if (cityCode==null ||cityCode.equals("1")){
    		vo.setCityCode(null);
    	}else{
    		vo.setCityCode(cityCode);
    	}
    	if (companyCode == null || companyCode.length() == 0){
    		vo.setCompanyCode(null);
    	}else{
    		vo.setCompanyCode(companyCode);
    	}
    	if (industry == null || industry.length() == 0){
    		vo.setIndustry(null);
    	}else{
    		vo.setIndustry(industry);
    	}
    	if (customerType == null || customerType.length() == 0){
    		vo.setCustomerType(null);
    	}else{
    		vo.setCustomerType(customerType);
    	}
    	String year = monthDay.substring(0, 4);
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
	    try {
	    	List data  = new ArrayList();
	    	if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
	    		data = queryForList("DM_CUSTOM.selectAccountNumByIndustry", vo);
	    	}else if(displayContent.equals("2")){//点击查看连接数
	    		data = queryForList("DM_CUSTOM.selectConnectNumByIndustry", vo);
	    	}else if(displayContent.equals("3")){//点击查看激活率
	    		data = queryForList("DM_CUSTOM.selectActivityTrendByIndustry", vo);
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
	    		data = queryForList("DM_CUSTOM.selectOrderNumByIndustry", vo);
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
	    		data = queryForList("DM_CUSTOM.selectIncomeByIndustry", vo);
	    	}else{
			    data = queryForList("DM_CUSTOM.selectCustomerNumByIndustry", vo);
	    	}
		    
		   
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	
	    return resp;
		
	}

	/*
	 * 
	 * 获取数据库中记录的最新日期
	 */
	public String getDate() {
		String dateStr ="";
		/*SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");  */
        try { 
        	dateStr = (String) getSqlSession().selectOne("DM_CUSTOM.getDate",null);
        	dateStr = dateStr.substring(0, 10);
            //使用SimpleDateFormat的parse()方法生成Date  
           /* Date date = sf.parse(dateStr);  
            dateStr=  date.toString();*/
        } catch (Exception e) {  //ParseException
            e.printStackTrace();  
        }
		return dateStr;
	}
	/*
	 *连接数-激活率-活跃率  20180621
	 * 
	 */
	public BusAccSnapResponse getConNumActivityTrend(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	String year = monthDay.substring(0, 4);
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
	    try {
	    	List data  = new ArrayList();
			data = queryForList("DM_CUSTOM.getConNumActivityTrend", vo);
		    
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	/*
	 *平台商机和客户情况  20180621
	 * 
	 */
	public BusAccSnapResponse getPlatformBusiness(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();
	    CustomARPU vo2 = new CustomARPU();

	    vo2.setMonthDay(request.getMonthDay().replace("-", ""));
	    String month = vo2.getMonthDay().substring(0, 6);
		String tableNameMonth = "dm_custom_month_"+ vo2.getMonthDay().substring(0, 4);
		vo2.setMonth(month);
		vo2.setTableNameMonth(tableNameMonth); 
	     
    	String pro = request.getProvinceCode();
    	if (pro == null){
    		vo2.setPro(null);
    	}else{
    		vo2.setPro(pro);
    	}
    	String tableName = "dm_custom_"+ vo2.getMonthDay().substring(0, 4);
    	vo2.setTableName(tableName);
//	    try {
//	    	List data  = new ArrayList();
//			data = queryForList("DM_CUSTOM.getPlatformBusiness", vo);
    	 
	    try {
	    	List data  = new ArrayList();
	    	String displayContent=request.getDisplayContent();
	    	if (displayContent.equals("7")){
	    		 
	    		 
	    	}else{
	    		if (pro == null){
	        		data = queryForList("DM_CUSTOM.getPlatformBusiness", vo2);
	        		}else{
	    	    		data = queryForList("DM_CUSTOM.getPlatformBusinessCity", vo2);
	        		}
	    	}
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	public BusAccSnapResponse getPlatformBusiCust(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	String provinceCode = request.getProvinceCode();
    	if (provinceCode == null){
    		vo.setProvinceCode(null);
    	}else{
    		vo.setProvinceCode(provinceCode);
    	}
    	String year = monthDay.substring(0, 4);
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
//	    try {
//	    	List data  = new ArrayList();
//			data = queryForList("DM_CUSTOM.getPlatformBusiness", vo);
		    
	    try {
	    	List data  = new ArrayList();
	    	String displayContent=request.getDisplayContent();
	    	String tableName1="DM_CUSTOM_MONTH_"+year;
    		vo.setTableNameM(tableName1);
    		vo.setBusAccYear(year);
    		if (provinceCode == null){
    		data = queryForList("DM_CUSTOM.getPlatformBusinessCust", vo);
    		}else{
	    		data = queryForList("DM_CUSTOM.getPlatformBusinessCustCity", vo);
    		}
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	/*
	 *平台收入分省情况  20180621
	 * 
	 */
	public BusAccSnapResponse getPlatformIncome(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	String year = monthDay.substring(0, 4);
		String tableName="dm_custom_"+year;
		vo.setTableName(tableName);
	    try {
	    	List data  = new ArrayList();
			data = queryForList("DM_CUSTOM.getPlatformIncome", vo);
		    
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	/*
	 *全国连接数趋势  20180621
	 * 
	 */
	public BusAccSnapResponse getConNum(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	    try {
	    	List data  = new ArrayList();
	    	//使用SimpleDateFormat的parse()方法生成Date  
            Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String tableName="dm_custom_"+year;
			vo.setTableName(tableName);
			
            Calendar rightNow = Calendar.getInstance();
            rightNow.setTime(date);
            //rightNow.add(Calendar.YEAR,-1);//日期减1年
            rightNow.add(Calendar.MONTH,-6);//日期加3个月
            //rightNow.add(Calendar.DAY_OF_YEAR,10);//日期加10天
            Date dt1=rightNow.getTime();
            String reStr = sf.format(dt1);
            String year1 = reStr.substring(0, 4);
            String tableName1="dm_custom_"+year1;
			vo.setTableName1(tableName1);
			data = queryForList("DM_CUSTOM.selectConnectNumOneYear", vo);
			/*if(year1.equals("2017")){
            	data = queryForList("DM_CUSTOM.selectConnectNumLessHalfYear", vo);
            }else if(year.equals(year1)){//半年时间段不跨年
            	data = queryForList("DM_CUSTOM.selectConnectNumOneYear", vo);
            }else{
            	data = queryForList("DM_CUSTOM.getConNumCrossYear", vo);
            }*/
            
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	/*
	 *全国客户数趋势  20180621
	 * 
	 */
	public BusAccSnapResponse getCustomerNum(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	    try {
	    	List data  = new ArrayList();
	    	
	    	//使用SimpleDateFormat的parse()方法生成Date  
            Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String tableName="dm_custom_"+year;
			vo.setTableName(tableName);
			
            Calendar rightNow = Calendar.getInstance();
            rightNow.setTime(date);
            //rightNow.add(Calendar.YEAR,-1);//日期减1年
            rightNow.add(Calendar.MONTH,-6);//日期加3个月
            //rightNow.add(Calendar.DAY_OF_YEAR,10);//日期加10天
            Date dt1=rightNow.getTime();
            String reStr = sf.format(dt1);
            String year1 = reStr.substring(0, 4);
            String tableName1="dm_custom_"+year1;
			vo.setTableName1(tableName1);
			data = queryForList("DM_CUSTOM.selectCustomerNumOneYear", vo);
			/*if(year1.equals("2017")){
            	data = queryForList("DM_CUSTOM.selectCustomerNumLessHalfYear", vo);
            }else if(year.equals(year1)){//半年时间段不跨年
            	data = queryForList("DM_CUSTOM.selectCustomerNumOneYear", vo);
            }else{
            	data = queryForList("DM_CUSTOM.getCustomerNumCrossYear", vo);
            }*/
            
            
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	/*
	 *全国收入趋势  20180621
	 * 
	 */
	public BusAccSnapResponse getIncome(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            
	    try {
	    	List data  = new ArrayList();
	    	
	    	//使用SimpleDateFormat的parse()方法生成Date  
            Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String tableName="dm_custom_"+year;
			vo.setTableName(tableName);
			
            Calendar rightNow = Calendar.getInstance();
            rightNow.setTime(date);
            //rightNow.add(Calendar.YEAR,-1);//日期减1年
            rightNow.add(Calendar.MONTH,-6);//日期加3个月
            //rightNow.add(Calendar.DAY_OF_YEAR,10);//日期加10天
            Date dt1=rightNow.getTime();
            String reStr = sf.format(dt1);
            String year1 = reStr.substring(0, 4);
            String tableName1="dm_custom_"+year1;
			vo.setTableName1(tableName1);
			
			data = queryForList("DM_CUSTOM.selectIncomeOneYear", vo);
			
            /*if(year1.equals("2017")){
            	data = queryForList("DM_CUSTOM.selectIncomeLessHalfYear", vo);
            }else if(year.equals(year1)){//半年时间段不跨年
            	data = queryForList("DM_CUSTOM.selectIncomeOneYear", vo);
            }else{
            	data = queryForList("DM_CUSTOM.getIncomeCrossYear", vo);
            }*/
		    
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	/*
	 *二级页面-地域top  20180621
	 * 
	 */
	public BusAccSnapResponse getAreaTop(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	
    	String displayContent=request.getDisplayContent();
    	
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");	
	    try {
	    	List data  = new ArrayList();
	    	
	    	Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String tableName="dm_custom_"+year;
			vo.setTableName(tableName);
			
            if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
	    		data = queryForList("DM_CUSTOM.selectAccountNumByArea", vo);
	    	}else if(displayContent.equals("2")){//点击查看连接数
	    		String daPingFlag=request.getDaPingFlag();
	    		if (daPingFlag.equals("1")){
	    			vo.setDaPingFlag(daPingFlag);
	    		}
	    		data = queryForList("DM_CUSTOM.selectConnectNumByArea", vo);
	    	}else if(displayContent.equals("3")){//点击查看激活率
	    		data = queryForList("DM_CUSTOM.selectActivityTrendByArea", vo);
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
	    		data = queryForList("DM_CUSTOM.selectOrderByArea", vo);
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
	    		data = queryForList("DM_CUSTOM.selectIncomeByArea", vo);
	    	}else{//点击查看客户数趋势
	    		data = queryForList("DM_CUSTOM.selectCustomerNumByArea", vo);
	    	}
		    
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	/*
	 *二级页面-行业top  20180621
	 * 
	 */
	public BusAccSnapResponse getIndustryTop(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();
	    String provinceCode = request.getProvinceCode();
	    if (provinceCode == null){
    		vo.setProvinceCode(null);
    	}else{
    		vo.setProvinceCode(provinceCode);
    	}
	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	String displayContent=request.getDisplayContent();
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
    	
	    try {
	    	List data  = new ArrayList();
	    	
	    	Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String tableName="dm_custom_"+year;
			vo.setTableName(tableName);
			
	    	if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
	    		data = queryForList("DM_CUSTOM.selectAccountNumByIndustry", vo);
	    	}else if(displayContent.equals("2")){//点击查看连接数
	    		data = queryForList("DM_CUSTOM.selectConnectNumByIndustry", vo);
	    	}else if(displayContent.equals("3")){//点击查看激活率
	    		data = queryForList("DM_CUSTOM.selectActivityTrendByIndustry", vo);
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
	    		data = queryForList("DM_CUSTOM.selectOrderNumByIndustry", vo);
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
	    		data = queryForList("DM_CUSTOM.selectIncomeByIndustry", vo);
	    	}else{//点击查看客户数趋势
	    		data = queryForList("DM_CUSTOM.selectCustomerNumByIndustry", vo);
	    	}		    
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	
	
	/*
	 *全国应收按细分行业  20181022
	 * 
	 */
	public BusAccSnapResponse getIncomeByDetailIndustry(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	String provinceCode = request.getProvinceCode();
    	if (provinceCode == null){
    		vo.setProvinceCode(null);
    	}else{
    		vo.setProvinceCode(provinceCode);
    	}
    	//String displayContent=request.getDisplayContent();
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
    	
	    try {
	    	List data  = new ArrayList();
	    	
	    	Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String month1 = monthDay.substring(0, 7);
			String month = month1.replace("-", "");
			if (month == null){
	    		vo.setMonth(null);
	    	}else{
	    		vo.setMonth(month);
	    	}
			String tableName="dm_custom_"+year;
			String tableNameM="dm_custom_month_"+year;
			vo.setTableName(tableName);
			vo.setTableNameM(tableNameM);
	    
	    	data = queryForList("DM_CUSTOM.selectIncomeByDetailIndustry", vo);
	    	
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	
	
	/*
	 *二级页面-同比top  20180621
	 * 
	 */
	public BusAccSnapResponse getYearOnYear(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
    	String displayContent=request.getDisplayContent();
	    	
	    try {
	    	List data  = new ArrayList();
	    	
	    	//使用SimpleDateFormat的parse()方法生成Date  
	    	Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String tableName="dm_custom_"+year;
			vo.setTableName(tableName);
			
            Calendar rightNow = Calendar.getInstance();
            rightNow.setTime(date);
            rightNow.add(Calendar.YEAR,-1);//日期减1年
            //rightNow.add(Calendar.MONTH,-6);//日期加3个月
            //rightNow.add(Calendar.DAY_OF_YEAR,10);//日期加10天
            Date dt1=rightNow.getTime();
            String reStr = sf.format(dt1);
            String year1 = reStr.substring(0, 4);
            String tableName1;
            if(year1.equals("2017")){
            	tableName1="v_dm_custom_2017";
            }else{
            	tableName1="dm_custom_"+year1;
            }
			vo.setTableName1(tableName1);
			/*
            if(year1.equals("2017")){
            	data = queryForList("DM_CUSTOM.selectIncomeLessHalfYear", vo);
            }else if(year.equals(year1)){//半年时间段不跨年
            	data = queryForList("DM_CUSTOM.selectIncomeOneYear", vo);
            }else{
            	data = queryForList("DM_CUSTOM.getIncomeCrossYear", vo);
            }*/
		    
            if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
	    		data = queryForList("DM_CUSTOM.selectAccountNumYearOnYear", vo);
	    	}else if(displayContent.equals("2")){//点击查看连接数
	    		data = queryForList("DM_CUSTOM.selectConnectNumYearOnYear", vo);
	    	}else if(displayContent.equals("3")){//点击查看激活率
	    		data = queryForList("DM_CUSTOM.selectActivityTrendYearOnYear", vo);
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
	    		data = queryForList("DM_CUSTOM.selectOrderNumYearOnYear", vo);
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
	    		data = queryForList("DM_CUSTOM.selectIncomeYearOnYear", vo);
	    	}else{//点击查看客户数趋势
	    		data = queryForList("DM_CUSTOM.selectCustomerNumYearOnYear", vo);
	    	}
            
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	
	
	
	
	/*
	 *二级页面-环比top  20180621
	 * 
	 */
	public BusAccSnapResponse getMonthOnMonth(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        
    	String displayContent=request.getDisplayContent();
    	
	    try {
	    	List data  = new ArrayList();
	    	
	    	//使用SimpleDateFormat的parse()方法生成Date  
            Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String tableName="dm_custom_"+year;
			vo.setTableName(tableName);
			
            Calendar rightNow = Calendar.getInstance();
            rightNow.setTime(date);
            //rightNow.add(Calendar.YEAR,-1);//日期减1年
            rightNow.add(Calendar.MONTH,-1);//日期加3个月
            //rightNow.add(Calendar.DAY_OF_YEAR,10);//日期加10天
            Date dt1=rightNow.getTime();
            String reStr = sf.format(dt1);
            String year1 = reStr.substring(0, 4);

            String tableName1;
            if(year1.equals("2017")){
            	tableName1="v_dm_custom_2017";
            }else{
            	tableName1="dm_custom_"+year1;
            }
			vo.setTableName1(tableName1);
			/*
            if(year1.equals("2017")){
            	data = queryForList("DM_CUSTOM.selectIncomeLessHalfYear", vo);
            }else if(year.equals(year1)){//半年时间段不跨年
            	data = queryForList("DM_CUSTOM.selectIncomeOneYear", vo);
            }else{
            	data = queryForList("DM_CUSTOM.getIncomeCrossYear", vo);
            }*/
		    
            if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
            	data = queryForList("DM_CUSTOM.selectAccountNumMonthOnMonth", vo);
	    		
	    	}else if(displayContent.equals("2")){//点击查看连接数
            	data = queryForList("DM_CUSTOM.selectConnectNumMonthOnMonth", vo);
	    	}else if(displayContent.equals("3")){//点击查看激活率
            	data = queryForList("DM_CUSTOM.selectActivityTrendMonthOnMonth", vo);
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
            	data = queryForList("DM_CUSTOM.selectOrderNumMonthOnMonth", vo);
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
            	data = queryForList("DM_CUSTOM.selectIncomeMonthOnMonth", vo);
	    	}else{//点击查看客户数趋势
            	data = queryForList("DM_CUSTOM.selectCustomerNumMonthOnMonth", vo);
	    	}
            
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	/*
	 *二级页面- 地图  20180702
	 * 
	 */
	public BusAccSnapResponse getMapData(BusAccSnapResquest request) {
		BusAccSnapResponse resp = new BusAccSnapResponse();
	    BusAccSnapInfo vo = new BusAccSnapInfo();

	    String monthDay = request.getMonthDay();
    	if (monthDay == null){
    		vo.setMonthDay(null);
    	}else{
    		vo.setMonthDay(monthDay);
    	}
    	
    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        
    	String displayContent=request.getDisplayContent();
    	
	    try {
	    	List data  = new ArrayList();
	    	
	    	//使用SimpleDateFormat的parse()方法生成Date  
            Date date = sf.parse(monthDay);  
			String year = monthDay.substring(0, 4);
			String tableName="dm_custom_"+year;
			vo.setTableName(tableName);
		    
            if(displayContent.equals("0")||displayContent.equals("1")){//首次访问=点击查看账户数
	    		data = queryForList("DM_CUSTOM.selectAccountNumByAllCity", vo);
	    	}else if(displayContent.equals("2")){//点击查看连接数
	    		data = queryForList("DM_CUSTOM.selectConnectNumByAllCity", vo);
	    	}else if(displayContent.equals("3")){//点击查看激活率
	    		data = queryForList("DM_CUSTOM.selectActivityTrendByAllCity", vo);
	    	}else if(displayContent.equals("4")){//点击查看订单订购趋势
	    		data = queryForList("DM_CUSTOM.selectOrderNumByAllCity", vo);
	    	}else if(displayContent.equals("5")){//点击查看收入趋势
	    		data = queryForList("DM_CUSTOM.selectIncomeByAllCity", vo);
	    	}else{//点击查看客户数趋势
	    		data = queryForList("DM_CUSTOM.selectCustomerNumByAllCity", vo);
	    	}
            
		    resp.setCode("200");
			resp.setMsg("success");
			resp.setDatas(data);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	resp.setCode("-1");
			resp.setMsg(e.getMessage());
	    }
	    return resp;
	}
	
	@SuppressWarnings("unchecked")
	public List<PieChartInfo> selectSumAccuList(
			BusAccSnapResquest params) throws Exception { 
		if(params.getProvinceCode()==null)
			return (List<PieChartInfo>) queryForList(
					"DM_CUSTOM.selectSumAccuList", 
					params);
			else
				return (List<PieChartInfo>) queryForList(
						"DM_CUSTOM.selectSumAccuListCity", 
						params); 
	}
	
}
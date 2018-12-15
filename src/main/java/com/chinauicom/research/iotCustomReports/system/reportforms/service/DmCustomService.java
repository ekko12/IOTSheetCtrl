package com.chinauicom.research.iotoperation.system.reportforms.service;


import java.util.List;

import com.chinauicom.research.iotoperation.busAccSnap.entity.BusAccSnapResponse;
import com.chinauicom.research.iotoperation.busAccSnap.entity.BusAccSnapResquest;
import com.chinauicom.research.iotoperation.busAccSnap.entity.HomePgFourTbResponse;
import com.chinauicom.research.iotoperation.busAccSnap.entity.PieChartInfo;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomARPU;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomActiCompare;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomAvagData;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomIndustryProvince;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomListCompare;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomNewAndCurrent;

public interface DmCustomService { 
	public List<CustomAvagData> selectDmCustomAvagData(CustomAvagData params) throws Exception ;
	public List<CustomNewAndCurrent> selectDmCustomNewAndCurrent(CustomNewAndCurrent params) throws Exception ;
	public List<CustomListCompare> selectDmCustomListForCompareByDate(CustomListCompare params) throws Exception;
	public List<CustomActiCompare> selectDmCustomActiForCompareByDate(CustomActiCompare params) throws Exception;
	public List<CustomARPU> selectDmCustomARPU(CustomARPU params) throws Exception;
	public List<CustomIndustryProvince> selectDmCustomIndustryProvince(CustomIndustryProvince params) throws Exception;
	public List<PieChartInfo> selectHomeSumAccuList(@SuppressWarnings("rawtypes") BusAccSnapResquest params) throws Exception;
	/**
	 * 饼图-客户维度
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getPieChart(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    
    
    /**
	 * 折线图-时间维度
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getLineChart(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    
    /**
	 * 柱图-地域维度
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getBarGraphByCity(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
   	 * 趋势图分析计算五个指标：账户数 连接数 激活率 订购趋势 收入趋势
   	 * 
    * @return type BusAccSnapResponse
    */
    public abstract HomePgFourTbResponse getHomePgFourTb(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
   	 * add in 2018.10.31 连接出账率/连接活跃率
   	 * 
    * @return type BusAccSnapResponse
    */
    public abstract HomePgFourTbResponse getHomeRate(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    
    /**
   	 * 连接出账率/连接活跃率
   	 * 
    * @return type BusAccSnapResponse
    */
    public abstract BusAccSnapResponse getCustomAccountByType(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    
    
    /**
	 * 柱图-行业维度
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getBarGraphByIndustry(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;

    /**
     * 获取数据库中最新日期
     */
    public abstract String getDate() throws Exception;
    
    /**
	 * 连接数-激活率-活跃率
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getConNumActivityTrend(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 * 平台商机和客户情况
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getPlatformBusiness(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    public abstract BusAccSnapResponse getPlatformBusiCust(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 * 平台收入分省情况
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getPlatformIncome(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 * 全国连接数趋势
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getConNum(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 * 全国客户数趋势
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getCustomerNum(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 * 全国收入趋势
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getIncome(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 * 二级页面-地域top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getAreaTop(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 * 二级页面-行业top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getIndustryTop(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 *全国应收按细分行业  20181022
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getIncomeByDetailIndustry(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    
    /**
	 * 二级页面-同比top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getYearOnYear(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    /**
	 * 二级页面-环比top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getMonthOnMonth(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;
    
    /**
	 * 二级页面-环比top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
    public abstract BusAccSnapResponse getMapData(@SuppressWarnings("rawtypes") BusAccSnapResquest request) throws Exception;

}

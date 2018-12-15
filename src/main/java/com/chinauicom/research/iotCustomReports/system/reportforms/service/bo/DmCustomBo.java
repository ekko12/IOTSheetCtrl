package com.chinauicom.research.iotoperation.system.reportforms.service.bo;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinauicom.research.commons.JsonUtils;
import com.chinauicom.research.iotoperation.busAccSnap.entity.BusAccSnapResponse;
import com.chinauicom.research.iotoperation.busAccSnap.entity.BusAccSnapResquest;
import com.chinauicom.research.iotoperation.busAccSnap.entity.HomePgFourTbResponse;
import com.chinauicom.research.iotoperation.busAccSnap.entity.PieChartInfo;
import com.chinauicom.research.iotoperation.busAccSnap.service.BusAccSnapService;
import com.chinauicom.research.iotoperation.system.reportforms.dao.DmCustomDao;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomARPU;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomActiCompare;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomAvagData;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomIndustryProvince;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomListCompare;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomNewAndCurrent;
import com.chinauicom.research.iotoperation.system.reportforms.service.DmCustomService;

@Service
public class DmCustomBo  implements  DmCustomService {
	
	@Autowired
	private DmCustomDao dmCustomDao;
	
	@Override
	public List<CustomListCompare> selectDmCustomListForCompareByDate(
			CustomListCompare params) throws Exception {
		return dmCustomDao.selectDmCustomListForCompareByDate(params);
	}
	@Override
	public List<CustomIndustryProvince> selectDmCustomIndustryProvince(
			CustomIndustryProvince params) throws Exception {
		return dmCustomDao.selectDmCustomIndustryProvince(params);
	}
	@Override
	public List<CustomNewAndCurrent> selectDmCustomNewAndCurrent(
			CustomNewAndCurrent params) throws Exception {
		return dmCustomDao.selectDmCustomNewAndCurrent(params);
	}
	@Override
	public List<CustomAvagData> selectDmCustomAvagData(
			CustomAvagData params) throws Exception {
		return dmCustomDao.selectDmCustomAvagData(params);
	}
	
	@Override
	public List<CustomARPU> selectDmCustomARPU(
			CustomARPU params) throws Exception {
		return dmCustomDao.selectDmCustomARPU(params);
	}
	
	@Override
	public List<CustomActiCompare> selectDmCustomActiForCompareByDate(
			CustomActiCompare params) throws Exception {
		return dmCustomDao.selectDmCustomActiForCompareByDate(params);
	}

	
	public void setdmCustomDao(DmCustomDao dmCustomDao) {
		this.dmCustomDao = dmCustomDao;
	}


	@Override
	public BusAccSnapResponse getPieChart(BusAccSnapResquest request) throws Exception {
	    if(request == null) return null;
	    return dmCustomDao.selectByPieChart(request);
	}


	@Override
	public BusAccSnapResponse getLineChart(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
	    return dmCustomDao.selectByLineChart(request);
	}


	@Override
	public BusAccSnapResponse getBarGraphByCity(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.selectBarGraphByCity(request);
	}

    ////////
	@Override
	public HomePgFourTbResponse getHomePgFourTb(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.selectHomePgFourTb(request);
	}
	
	@Override
	public HomePgFourTbResponse getHomeRate(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.selectHomeRate(request);
	}
	
	@Override
	public BusAccSnapResponse getCustomAccountByType(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.selectCustomAccountByType(request);
	}
	
	@Override
	public String getDate() throws Exception {
		return dmCustomDao.getDate();
	}


	@Override
	public BusAccSnapResponse getBarGraphByIndustry(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.selectBarGraphByIndustry(request);
	}
	
	/**
	 * 连接数-激活率-活跃率
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getConNumActivityTrend(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getConNumActivityTrend(request);
	}
    /**
	 * 平台商机和客户情况
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getPlatformBusiness(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getPlatformBusiness(request);
	}
	@Override
    public BusAccSnapResponse getPlatformBusiCust(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getPlatformBusiCust(request);
	}
    /**
	 * 平台收入分省情况
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getPlatformIncome(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getPlatformIncome(request);
	}
    /**
	 * 全国连接数趋势
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getConNum(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getConNum(request);
	}
    /**
	 * 全国客户数趋势
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getCustomerNum(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getCustomerNum(request);
	}
    /**
	 * 全国收入趋势
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getIncome(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getIncome(request);
	}
	
	 /**
	 * 二级页面-地域top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getAreaTop(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getAreaTop(request);
	}
	/**
	 *全国应收按细分行业  20181022
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getIncomeByDetailIndustry(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getIncomeByDetailIndustry(request);
	}
	
	/**
	 * 二级页面-行业top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getIndustryTop(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getIndustryTop(request);
	}
	
	/**
	 * 二级页面-同比top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getYearOnYear(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getYearOnYear(request);
	}
	/**
	 * 二级页面-环比top 20180628
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getMonthOnMonth(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getMonthOnMonth(request);
	}
	/**
	 * 二级页面-地图 20180702
	 * 
     * @return type BusAccSnapResponse
     */
	@Override
    public BusAccSnapResponse getMapData(BusAccSnapResquest request) throws Exception {
		if(request == null) return null;
		return dmCustomDao.getMapData(request);
	}
	@Override
	public List<PieChartInfo> selectHomeSumAccuList(BusAccSnapResquest params) throws Exception {
		if(params == null) return null;
		return dmCustomDao.selectSumAccuList(params);
	}



}

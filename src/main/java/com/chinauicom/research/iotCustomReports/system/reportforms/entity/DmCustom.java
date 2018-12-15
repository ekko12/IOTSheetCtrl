/**
 * com.chinauicom.research.iotoperation.system.reportforms.entity.DmCustom.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

import java.util.Date;
import java.util.List;

import com.chinauicom.research.commons.utils.BaseVO;

/**
 * 自定义报表实体
 * @author zhaich5
 * @since 2018/1/22
 *
 */
public class DmCustom extends BaseVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8890248624264254865L;

	/**出不来根据配置得出(varchar(15) null) */
	private String wlwArea;
	/** 出不来根据指标计算量产成熟度(varchar(15) null) */
	private String stage;
	/** 商机-用户归属省(varchar(6) null) */
	private String province;
	/** 商机-用户归属市(varchar(6) null) */
	private String city;
	/** 留空 主要领域(varchar(15) null) */
	private String principleArea;
	/** 商机-主要行业(varchar(15) null) */
	private String principleIndustry;
	/** 商机-行业重点产品(varchar(200) null) */
	private String industryMainProduct;
	/** 商机-行业细分产品(varchar(200) null) */
	private String industryDetailProduct;
	/** 商机-客户分级(varchar(15) null) */
	private String customerDegree;
	/** 商机-客户名称(varchar(300) null) */
	private String customerName;
	/** 商机-集团客户ID(varchar(50) null) */
	private String customerGroupId;
	/** 商机-客户编号(varchar(50) null) */
	private String customerId;
	/** 虚拟id account id(varchar(15) null) */
	private String virtureId;
	/** 首单交付时间(varchar(20) null) */
	private String firstOrderTime;
	/** 是否重点关注产品(varchar(15) null) */
	private String isCareProduct;
	/** 商机 上线类型(varchar(15) null) */
	private String onlineType;
	/** 商机 商业模式(varchar(200) null) */
	private String commerceModel;
	/** 商机 设备类型(varchar(15) null) */
	private String facilityType;
	/** 上线订单的购买数 首单连接数(int(11) null) */
	private Integer firstOrderConnectNum;
	/** 保留 预计量产时间(varchar(20) null) */
	private String preBatchTime;
	/** 保留 实现量产时间(varchar(20) null) */
	private String realizeBatchTime;
	/** 保留 实现成熟时间(varchar(20) null) */
	private String realizeMatureTime;
	/** 累计订单数 订单系统-订单数累计（非集客）(varchar(15) null) */
	private String accOrderNum;
	/** 累计订单数（>=100）订单系统-订单数累计（数量>100)（非集客）(int(11) null) */
	private Integer accOrderNumGe100;
	/** 实际到达连接数（周更）(int(11) null) */
	private Integer actualConnect;
	/** 保留 累计迁移连接数（周更）(int(11) null) */
	private Integer accTranConnectNum;
	/** 本月新增激活连接数（周更）(int(11) null) */
	private Integer newConnectNum;
	/** 累计离网连接数（周更）待确认(int(11) null) */
	private Integer accOffConnectNum;
	/** 累计激活连接数（周更）(int(11) null) */
	private Integer accActiConnectNum;
	/** 本月活跃连接数（月更）(int(11) null) */
	private Integer liveConnectNum;
	/** 当月活跃用户占比(float null) */
	private Float liveConnectProp;
	/** 本月离网连接数（周更）(int(11) null) */
	private Integer offConnectNum;
	/** 本月计费连接数（月更）(int(11) null) */
	private Integer chargConnectNum;
	/** 上月平台出帐收入（月更）(float null) */
	private Float lastMonthIncome;
	/** 本月api调用次数（月更） csv文件入库(int(11) null) */
	private Integer apiCallNum;
	/** 每活跃连接api调用次数(int(11) null) */
	private Integer liveApiCallNum;
	/** 暂无 本月自动化规则条目（月更）(varchar(15) null) */
	private String autoRuleItem;
	/** 暂无 本月自动化规则触发次数（月更）(int(11) null) */
	private Integer autoTriggerNum;
	/** 保留（后续商机有） 企业共计存量连接数(int(11) null) */
	private Integer companyStockConnectNum;
	/** 保留（后续商机有） 是否联通独家(varchar(15) null) */
	private String isChinaunicomSole;
	/** 保留（后续商机有） 年内连接数预测 (int(11) null)*/
	private Integer yearPreConnectNum;
	/** 商机 客户经理(varchar(15) null) */
	private String customerManager;
	/** 商机 电话(varchar(11) null) */
	private String telephone;
	/** 商机 邮箱(varchar(30) null) */
	private String email;
	/** 商机 支撑经理(varchar(30) null) */
	private String supportManager;
	/** 商机 电话(varchar(11) null) */
	private String telephone2;
	/** 商机 邮箱(varchar(30) null) */
	private String email2;
	/** jpo报表 账户下发展连接数(int(11) null) */
	private Integer jpoAcctExpandJoinNum;
	/** jpo报表 账户下存量连接数(int(11) null) */
	private Integer jpoAcctStockJoinNum;
	/** jpo报表 账户下失效连接数(int(11) null) */
	private Integer jpoAcctInvalJoinNum;
	/** jpo报表 账户下清除连接数(int(11) null) */
	private Integer jpoAcctClearJoinNum;
	/** jpo报表 账户下资费计划相关设备数(int(11) null) */
	private Integer jpoAcctPlanFacilityNum;
	/** jpo报表 账户数据总用量(int(11) null) */
	private Integer jpoAcctDataNum;
	/** jpo报表 账户短信总用量(int(11) null) */
	private Integer jpoAcctSmsNum;
	/** jpo报表 账户语音总用量(int(11) null) */
	private Integer jpoAcctVoiNum;
	/** jpo报表 账户当月出账金额(float null) */
	private Float jpoAcctBillAmount;
	/** jpo报表 账户当月超套费用(float null) */
	private Float jpoAcctUltraPackageNum;
	/** jpo报表 账户arpu(float null) */
	private Float jpoAcctArpu;
	/** jpo报表 账户出账短信用量(int(11) null) */
	private Integer jpoAcctSmsAmount;
	/** jpo报表 账户出账数据用量(int(11) null) */
	private Integer jpoAcctDataAmount;
	/** jpo报表 账户出账语音用量(int(11) null) */
	private Integer jpoAcctVoiAmount;
	/** 入库时间(datetime null) */
	private Date insertDate;
	/** 数据日期到日yyyymmdd(varchar(8) null) */
	private String acctCycle;
	/** 自定义列集合 */
	private List<CustomColumns> customColumnsList;
	/** 固定列集合 */
	private List<CustomColumns> fixedColumnsList;
	/** 访问表名 */
	private String tableName;
	/** 本月新增连接数（周更）(int(11) null) */
	private Integer addConnectNum;
	
	public List<CustomColumns> getFixedColumnsList() {
		return fixedColumnsList;
	}
	
	public void setFixedColumnsList(List<CustomColumns> fixedColumnsList) {
		this.fixedColumnsList = fixedColumnsList;
	}
	
	public String getTableName() {
		return tableName;
	}
	
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	public List<CustomColumns> getCustomColumnsList() {
		return customColumnsList;
	}
	
	public void setCustomColumnsList(List<CustomColumns> customColumnsList) {
		this.customColumnsList = customColumnsList;
	}
	
	public String getWlwArea() {
		return wlwArea;
	}
	
	public void setWlwArea(String wlwArea) {
		this.wlwArea = wlwArea;
	}
	
	public String getStage() {
		return stage;
	}
	
	public void setStage(String stage) {
		this.stage = stage;
	}
	
	public String getProvince() {
		return province;
	}
	
	public void setProvince(String province) {
		this.province = province;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getPrincipleArea() {
		return principleArea;
	}
	
	public void setPrincipleArea(String principleArea) {
		this.principleArea = principleArea;
	}
	
	public String getPrincipleIndustry() {
		return principleIndustry;
	}
	
	public void setPrincipleIndustry(String principleIndustry) {
		this.principleIndustry = principleIndustry;
	}
	
	public String getIndustryMainProduct() {
		return industryMainProduct;
	}
	
	public void setIndustryMainProduct(String industryMainProduct) {
		this.industryMainProduct = industryMainProduct;
	}
	
	public String getIndustryDetailProduct() {
		return industryDetailProduct;
	}
	
	public void setIndustryDetailProduct(String industryDetailProduct) {
		this.industryDetailProduct = industryDetailProduct;
	}
	
	public String getCustomerDegree() {
		return customerDegree;
	}
	
	public void setCustomerDegree(String customerDegree) {
		this.customerDegree = customerDegree;
	}
	
	public String getCustomerName() {
		return customerName;
	}
	
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	
	public String getCustomerId() {
		return customerId;
	}
	
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	
	public String getVirtureId() {
		return virtureId;
	}
	
	public void setVirtureId(String virtureId) {
		this.virtureId = virtureId;
	}
	
	public String getFirstOrderTime() {
		return firstOrderTime;
	}
	
	public void setFirstOrderTime(String firstOrderTime) {
		this.firstOrderTime = firstOrderTime;
	}
	
	public String getIsCareProduct() {
		return isCareProduct;
	}
	
	public void setIsCareProduct(String isCareProduct) {
		this.isCareProduct = isCareProduct;
	}
	
	public String getOnlineType() {
		return onlineType;
	}
	
	public void setOnlineType(String onlineType) {
		this.onlineType = onlineType;
	}
	
	public String getCommerceModel() {
		return commerceModel;
	}
	
	public void setCommerceModel(String commerceModel) {
		this.commerceModel = commerceModel;
	}
	
	public String getFacilityType() {
		return facilityType;
	}
	
	public void setFacilityType(String facilityType) {
		this.facilityType = facilityType;
	}
	
	public Integer getFirstOrderConnectNum() {
		return firstOrderConnectNum;
	}
	
	public void setFirstOrderConnectNum(Integer firstOrderConnectNum) {
		this.firstOrderConnectNum = firstOrderConnectNum;
	}
	
	public String getPreBatchTime() {
		return preBatchTime;
	}
	
	public void setPreBatchTime(String preBatchTime) {
		this.preBatchTime = preBatchTime;
	}
	
	public String getRealizeBatchTime() {
		return realizeBatchTime;
	}
	
	public void setRealizeBatchTime(String realizeBatchTime) {
		this.realizeBatchTime = realizeBatchTime;
	}
	
	public String getRealizeMatureTime() {
		return realizeMatureTime;
	}
	
	public void setRealizeMatureTime(String realizeMatureTime) {
		this.realizeMatureTime = realizeMatureTime;
	}
	
	public String getAccOrderNum() {
		return accOrderNum;
	}
	
	public void setAccOrderNum(String accOrderNum) {
		this.accOrderNum = accOrderNum;
	}
	
	public Integer getAccOrderNumGe100() {
		return accOrderNumGe100;
	}
	
	public void setAccOrderNumGe100(Integer accOrderNumGe100) {
		this.accOrderNumGe100 = accOrderNumGe100;
	}
	
	public Integer getActualConnect() {
		return actualConnect;
	}
	
	public void setActualConnect(Integer actualConnect) {
		this.actualConnect = actualConnect;
	}
	
	public Integer getAccTranConnectNum() {
		return accTranConnectNum;
	}
	
	public void setAccTranConnectNum(Integer accTranConnectNum) {
		this.accTranConnectNum = accTranConnectNum;
	}
	
	public Integer getNewConnectNum() {
		return newConnectNum;
	}
	
	public void setNewConnectNum(Integer newConnectNum) {
		this.newConnectNum = newConnectNum;
	}
	
	public Integer getAccOffConnectNum() {
		return accOffConnectNum;
	}
	
	public void setAccOffConnectNum(Integer accOffConnectNum) {
		this.accOffConnectNum = accOffConnectNum;
	}
	
	public Integer getAccActiConnectNum() {
		return accActiConnectNum;
	}
	
	public void setAccActiConnectNum(Integer accActiConnectNum) {
		this.accActiConnectNum = accActiConnectNum;
	}
	
	public Integer getLiveConnectNum() {
		return liveConnectNum;
	}
	
	public void setLiveConnectNum(Integer liveConnectNum) {
		this.liveConnectNum = liveConnectNum;
	}
	
	public Float getLiveConnectProp() {
		return liveConnectProp;
	}
	
	public void setLiveConnectProp(Float liveConnectProp) {
		this.liveConnectProp = liveConnectProp;
	}
	
	public Integer getOffConnectNum() {
		return offConnectNum;
	}
	
	public void setOffConnectNum(Integer offConnectNum) {
		this.offConnectNum = offConnectNum;
	}
	
	public Integer getChargConnectNum() {
		return chargConnectNum;
	}
	
	public void setChargConnectNum(Integer chargConnectNum) {
		this.chargConnectNum = chargConnectNum;
	}
	
	public Float getLastMonthIncome() {
		return lastMonthIncome;
	}
	
	public void setLastMonthIncome(Float lastMonthIncome) {
		this.lastMonthIncome = lastMonthIncome;
	}
	
	public Integer getApiCallNum() {
		return apiCallNum;
	}
	
	public void setApiCallNum(Integer apiCallNum) {
		this.apiCallNum = apiCallNum;
	}
	
	public Integer getLiveApiCallNum() {
		return liveApiCallNum;
	}
	
	public void setLiveApiCallNum(Integer liveApiCallNum) {
		this.liveApiCallNum = liveApiCallNum;
	}
	
	public String getAutoRuleItem() {
		return autoRuleItem;
	}
	
	public void setAutoRuleItem(String autoRuleItem) {
		this.autoRuleItem = autoRuleItem;
	}
	
	public Integer getAutoTriggerNum() {
		return autoTriggerNum;
	}
	
	public void setAutoTriggerNum(Integer autoTriggerNum) {
		this.autoTriggerNum = autoTriggerNum;
	}
	
	public Integer getCompanyStockConnectNum() {
		return companyStockConnectNum;
	}
	
	public void setCompanyStockConnectNum(Integer companyStockConnectNum) {
		this.companyStockConnectNum = companyStockConnectNum;
	}
	
	public String getIsChinaunicomSole() {
		return isChinaunicomSole;
	}
	
	public void setIsChinaunicomSole(String isChinaunicomSole) {
		this.isChinaunicomSole = isChinaunicomSole;
	}
	
	public Integer getYearPreConnectNum() {
		return yearPreConnectNum;
	}
	
	public void setYearPreConnectNum(Integer yearPreConnectNum) {
		this.yearPreConnectNum = yearPreConnectNum;
	}
	
	public String getCustomerManager() {
		return customerManager;
	}
	
	public void setCustomerManager(String customerManager) {
		this.customerManager = customerManager;
	}
	
	public String getTelephone() {
		return telephone;
	}
	
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getSupportManager() {
		return supportManager;
	}
	
	public void setSupportManager(String supportManager) {
		this.supportManager = supportManager;
	}
	
	public String getTelephone2() {
		return telephone2;
	}
	
	public void setTelephone2(String telephone2) {
		this.telephone2 = telephone2;
	}
	
	public String getEmail2() {
		return email2;
	}
	
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	
	public Integer getJpoAcctExpandJoinNum() {
		return jpoAcctExpandJoinNum;
	}
	
	public void setJpoAcctExpandJoinNum(Integer jpoAcctExpandJoinNum) {
		this.jpoAcctExpandJoinNum = jpoAcctExpandJoinNum;
	}
	
	public Integer getJpoAcctStockJoinNum() {
		return jpoAcctStockJoinNum;
	}
	
	public void setJpoAcctStockJoinNum(Integer jpoAcctStockJoinNum) {
		this.jpoAcctStockJoinNum = jpoAcctStockJoinNum;
	}
	
	public Integer getJpoAcctInvalJoinNum() {
		return jpoAcctInvalJoinNum;
	}
	
	public void setJpoAcctInvalJoinNum(Integer jpoAcctInvalJoinNum) {
		this.jpoAcctInvalJoinNum = jpoAcctInvalJoinNum;
	}
	
	public Integer getJpoAcctClearJoinNum() {
		return jpoAcctClearJoinNum;
	}
	
	public void setJpoAcctClearJoinNum(Integer jpoAcctClearJoinNum) {
		this.jpoAcctClearJoinNum = jpoAcctClearJoinNum;
	}
	
	public Integer getJpoAcctPlanFacilityNum() {
		return jpoAcctPlanFacilityNum;
	}
	
	public void setJpoAcctPlanFacilityNum(Integer jpoAcctPlanFacilityNum) {
		this.jpoAcctPlanFacilityNum = jpoAcctPlanFacilityNum;
	}
	
	public Integer getJpoAcctDataNum() {
		return jpoAcctDataNum;
	}
	
	public void setJpoAcctDataNum(Integer jpoAcctDataNum) {
		this.jpoAcctDataNum = jpoAcctDataNum;
	}
	
	public Integer getJpoAcctSmsNum() {
		return jpoAcctSmsNum;
	}
	
	public void setJpoAcctSmsNum(Integer jpoAcctSmsNum) {
		this.jpoAcctSmsNum = jpoAcctSmsNum;
	}
	
	public Integer getJpoAcctVoiNum() {
		return jpoAcctVoiNum;
	}
	
	public void setJpoAcctVoiNum(Integer jpoAcctVoiNum) {
		this.jpoAcctVoiNum = jpoAcctVoiNum;
	}
	
	public Float getJpoAcctBillAmount() {
		return jpoAcctBillAmount;
	}
	
	public void setJpoAcctBillAmount(Float jpoAcctBillAmount) {
		this.jpoAcctBillAmount = jpoAcctBillAmount;
	}
	
	public Float getJpoAcctUltraPackageNum() {
		return jpoAcctUltraPackageNum;
	}
	
	public void setJpoAcctUltraPackageNum(Float jpoAcctUltraPackageNum) {
		this.jpoAcctUltraPackageNum = jpoAcctUltraPackageNum;
	}
	
	public Float getJpoAcctArpu() {
		return jpoAcctArpu;
	}
	
	public void setJpoAcctArpu(Float jpoAcctArpu) {
		this.jpoAcctArpu = jpoAcctArpu;
	}
	
	public Integer getJpoAcctSmsAmount() {
		return jpoAcctSmsAmount;
	}
	
	public void setJpoAcctSmsAmount(Integer jpoAcctSmsAmount) {
		this.jpoAcctSmsAmount = jpoAcctSmsAmount;
	}
	
	public Integer getJpoAcctDataAmount() {
		return jpoAcctDataAmount;
	}
	
	public void setJpoAcctDataAmount(Integer jpoAcctDataAmount) {
		this.jpoAcctDataAmount = jpoAcctDataAmount;
	}
	
	public Integer getJpoAcctVoiAmount() {
		return jpoAcctVoiAmount;
	}
	
	public void setJpoAcctVoiAmount(Integer jpoAcctVoiAmount) {
		this.jpoAcctVoiAmount = jpoAcctVoiAmount;
	}
	
	public Date getInsertDate() {
		return insertDate;
	}
	
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}
	
	public String getAcctCycle() {
		return acctCycle;
	}
	
	public void setAcctCycle(String acctCycle) {
		this.acctCycle = acctCycle;
	}

	public String getCustomerGroupId() {
		return customerGroupId;
	}

	public void setCustomerGroupId(String customerGroupId) {
		this.customerGroupId = customerGroupId;
	}

	public Integer getAddConnectNum() {
		return addConnectNum;
	}

	public void setAddConnectNum(Integer addConnectNum) {
		this.addConnectNum = addConnectNum;
	}
	
}

/**
 * com.chinauicom.research.iotoperation.system.reportforms.entity.DmCustom.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;
 
import com.chinauicom.research.commons.utils.BaseVO;

/**
 * 自定义报表实体
 * @author zhaich5
 * @since 2018/1/22
 *
 */
public class CustomIndustryProvince extends BaseVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8890248624264254865L;
 
	/**  数据日期到日yyyymmdd(varchar(8) null) 
	 * PROVINCE_NAME | ACTI_NUM_QOQ | ACTI_NUM_QOQ_FLAG | ACTI_ACTUAL_DUTY | 
	ACTI_ACTUAL_DUTY_FLAG | ACTI_NUM_DUTY | ACTI_NUM_DUTY_FLAG | NEW_ACTI_DUTY | NEW_ACTI_DUTY_FLAG
	 * */
	private String monthDay;  
	private String tableName;  
	private String provinceName; 
	private String industryDetailProductName; 
	private double currentActiCuty; 
	private double currentActiNum;
	private double currentActiYoy;
	
	private String pro;
	
	public String getPro() {
		return pro;
	}
	public void setPro(String pro) {
		this.pro = pro;
	}
	public String getMonthDay() {
		return monthDay;
	}
	public void setMonthDay(String monthDay) {
		this.monthDay = monthDay;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	} 
	
	public String getIndustryDetailProductName() {
		return industryDetailProductName;
	}
	public void setIndustryDetailProductName(String industryDetailProductName) {
		this.industryDetailProductName = industryDetailProductName;
	}
	public double getCurrentActiCuty() {
		return currentActiCuty;
	}
	public void setCurrentActiCuty(double currentActiCuty) {
		this.currentActiCuty = currentActiCuty;
	}
	public double getCurrentActiNum() {
		return currentActiNum;
	}
	public void setCurrentActiNum(double currentActiNum) {
		this.currentActiNum = currentActiNum;
	}
	public double getCurrentActiYoy() {
		return currentActiYoy;
	}
	public void setCurrentActiYoy(double currentActiYoy) {
		this.currentActiYoy = currentActiYoy;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	} 	
}

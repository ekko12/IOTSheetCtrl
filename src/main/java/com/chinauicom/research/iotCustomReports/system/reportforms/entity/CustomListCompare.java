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
public class CustomListCompare extends BaseVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8890248624264254865L;
 
	/**  数据日期到日yyyymmdd(varchar(8) null) */
	private String monthDay; 
	/**  访问表名 */
	private String tableName; 
	/**  省份 */
	private String provinceName;
	private String pro ;
	/**  环比   */
	private double incomeQoq;
	/**  环比箭头 */
	private int incomeQoqFlag;
	/**  占比 */
	private double incomeDuty;
	/**  占比箭头 */
	private int incomeDutyFlag;
	
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
	public double getIncomeQoq() {
		return incomeQoq;
	}
	public void setIncomeQoq(double incomeQoq) {
		this.incomeQoq = incomeQoq;
	}
	public int getIncomeQoqFlag() {
		return incomeQoqFlag;
	}
	public void setIncomeQoqFlag(int incomeQoqFlag) {
		this.incomeQoqFlag = incomeQoqFlag;
	}
	public double getIncomeDuty() {
		return incomeDuty;
	}
	public void setIncomeDuty(double incomeDuty) {
		this.incomeDuty = incomeDuty;
	}
	public int getIncomeDutyFlag() {
		return incomeDutyFlag;
	}
	public void setIncomeDutyFlag(int incomeDutyFlag) {
		this.incomeDutyFlag = incomeDutyFlag;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}

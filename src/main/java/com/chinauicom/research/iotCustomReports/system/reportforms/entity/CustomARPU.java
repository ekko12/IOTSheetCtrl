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
public class CustomARPU extends BaseVO implements java.io.Serializable , Comparable<CustomARPU>{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8890248624264254865L;
 
	/**  数据日期到日yyyymmdd(varchar(8) null)  
	 * */
	private String monthDay; 
	private String month; 
	/**  访问表名 */
	private String tableName; 
	private String tableNameMonth;  
	private String arpu;
	private double ChargConnectNum;
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
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableNameMonth() {
		return tableNameMonth;
	}
	public void setTableNameMonth(String tableNameMonth) {
		this.tableNameMonth = tableNameMonth;
	}
	public String getArpu() {
		return arpu;
	}
	public void setArpu(String arpu) {
		this.arpu = arpu;
	}
	public double getChargConnectNum() {
		return ChargConnectNum;
	}
	public void setChargConnectNum(double chargConnectNum) {
		ChargConnectNum = chargConnectNum;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public int compareTo(CustomARPU s) {
		//自定义比较方法，如果认为此实体本身大则返回1，否则返回-1
		if(Double.parseDouble(this.arpu) >= Double.parseDouble(s.getArpu())){
			return 1;
		}
		return -1;
	}
}

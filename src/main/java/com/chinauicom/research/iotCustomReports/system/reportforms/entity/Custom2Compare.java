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
public class Custom2Compare extends BaseVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8890248624264254865L;
 
	/**  数据日期到日yyyymmdd(varchar(8) null) 
	 * PROVINCE_NAME | ACTI_NUM_QOQ | ACTI_NUM_QOQ_FLAG | ACTI_ACTUAL_DUTY | 
	ACTI_ACTUAL_DUTY_FLAG | ACTI_NUM_DUTY | ACTI_NUM_DUTY_FLAG | NEW_ACTI_DUTY | NEW_ACTI_DUTY_FLAG
	 * */
	private String monthDay; 
	/**  访问表名 */
	private String tableName; 
	/**  省份 */
	private String provinceName;
	/**  激活连接数环比   */
	private double actiNumQoq;
	/**  激活连接数环比 flag */
	private int actiNumQoqFlag;
	/**  激活连接占发卡连接数占比 */
	private double actiActualDuty;
	/**  激活连接占发卡连接数占比flag */
	private int actiActualDutyFlag;
	/**  激活连接数环比   */
	private double actiNumDuty;
	/**  激活连接数环比 flag */
	private int actiNumDutyFlag;
	/**  激活连接占发卡连接数占比 */
	private double newActiDuty;
	/**  激活连接占发卡连接数占比flag */
	private int newActiDutyFlag;
	/**  环比   */
	private double incomeQoq;
	/**  环比箭头 */
	private int incomeQoqFlag;
	/**  占比 */
	private double incomeDuty;
	/**  占比箭头 */
	private int incomeDutyFlag;
	
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
	public double getActiNumQoq() {
		return actiNumQoq;
	}
	public void setActiNumQoq(double actiNumQoq) {
		this.actiNumQoq = actiNumQoq;
	}
	public int getActiNumQoqFlag() {
		return actiNumQoqFlag;
	}
	public void setActiNumQoqFlag(int actiNumQoqFlag) {
		this.actiNumQoqFlag = actiNumQoqFlag;
	}
	public double getActiActualDuty() {
		return actiActualDuty;
	}
	public void setActiActualDuty(double actiActualDuty) {
		this.actiActualDuty = actiActualDuty;
	}
	public int getActiActualDutyFlag() {
		return actiActualDutyFlag;
	}
	public void setActiActualDutyFlag(int actiActualDutyFlag) {
		this.actiActualDutyFlag = actiActualDutyFlag;
	}
	public double getActiNumDuty() {
		return actiNumDuty;
	}
	public void setActiNumDuty(double actiNumDuty) {
		this.actiNumDuty = actiNumDuty;
	}
	public int getActiNumDutyFlag() {
		return actiNumDutyFlag;
	}
	public void setActiNumDutyFlag(int actiNumDutyFlag) {
		this.actiNumDutyFlag = actiNumDutyFlag;
	}
	public double getNewActiDuty() {
		return newActiDuty;
	}
	public void setNewActiDuty(double newActiDuty) {
		this.newActiDuty = newActiDuty;
	}
	public int getNewActiDutyFlag() {
		return newActiDutyFlag;
	}
	public void setNewActiDutyFlag(int newActiDutyFlag) {
		this.newActiDutyFlag = newActiDutyFlag;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	
}

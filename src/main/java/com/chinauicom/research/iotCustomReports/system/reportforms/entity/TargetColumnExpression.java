/**
 * 
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

/**
 * 目标列表达式
 * @author zhaich5
 * @since 2018/5/23
 *
 */
public class TargetColumnExpression {
	
	/** 序号 */
	private Integer num;
	
	/** 列表达式 */
	private String columnExpression;
	
	/** 是否有别名 */
	private boolean isAs = false;
	
	/** 别名 */
	private String asName;

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getColumnExpression() {
		return columnExpression;
	}

	public void setColumnExpression(String columnExpression) {
		this.columnExpression = columnExpression;
	}

	public boolean getIsAs() {
		return isAs;
	}

	public void setIsAs(boolean isAs) {
		this.isAs = isAs;
	}

	public String getAsName() {
		return asName;
	}

	public void setAsName(String asName) {
		this.asName = asName;
	}
	
}

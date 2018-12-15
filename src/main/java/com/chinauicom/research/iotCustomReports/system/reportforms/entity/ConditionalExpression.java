/**
 * 
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

/**
 * 条件表达式
 * @author zhaich5
 * @since 2018/5/23
 *
 */
public class ConditionalExpression {

	/** 序号 */
	private Integer num;
	
	/** 多重条件 AND,OR,NOT */
	private String multipleCondition;
	
	/** 条件名称 */
	private String name;
	
	/** 谓词 */
	private String predicate;
	
	/** 条件值 */
	private Object value;

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getMultipleCondition() {
		return multipleCondition;
	}

	public void setMultipleCondition(String multipleCondition) {
		this.multipleCondition = multipleCondition;
	}

	public String getPredicate() {
		return predicate;
	}

	public void setPredicate(String predicate) {
		this.predicate = predicate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}

}

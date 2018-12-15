/**
 * 
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

import java.util.List;

/**
 * 分组
 * @author zhaich5
 *
 */
public class Group {
	
	/** 名称列表 */
	private List<String> byNameList;
	
	/** Having 条件表达式 */
	private List<ConditionalExpression> conditionalExpressionList;

	public List<String> getByNameList() {
		return byNameList;
	}

	public void setByNameList(List<String> byNameList) {
		this.byNameList = byNameList;
	}

	public List<ConditionalExpression> getConditionalExpressionList() {
		return conditionalExpressionList;
	}

	public void setConditionalExpressionList(List<ConditionalExpression> conditionalExpressionList) {
		this.conditionalExpressionList = conditionalExpressionList;
	}
	
}

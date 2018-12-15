/**
 * 
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

/**
 * 排序
 * @author zhaich5
 * @since 2018/5/23
 *
 */
public class Order {

	/** 名称 */
	private String byName;
	
	/** 排序 DESC或ASC */
	private String order;

	public String getByName() {
		return byName;
	}

	public void setByName(String byName) {
		this.byName = byName;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}
	
}

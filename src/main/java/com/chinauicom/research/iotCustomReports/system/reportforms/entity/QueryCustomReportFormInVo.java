/**
 * 
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

/**
 * 查询自定义报表请求参数对象
 * @author zhaich5
 * @since 2018/5/25
 *
 */
public class QueryCustomReportFormInVo {
	
	/** 自定义SQL实体 */
	private CustomSql customSql;
	
	/** 查询方式  */
	private String mode;
	
	/** 模板编码  */
	private String templateId;
	
	/** 当前页码 */
	private String pageNo;
	
	/** 日期 */
	private String queryDate;

	public String getQueryDate() {
		return queryDate;
	}

	public void setQueryDate(String queryDate) {
		this.queryDate = queryDate;
	}

	public CustomSql getCustomSql() {
		return customSql;
	}

	public void setCustomSql(CustomSql customSql) {
		this.customSql = customSql;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getPageNo() {
		return pageNo;
	}

	public void setPageNo(String pageNo) {
		this.pageNo = pageNo;
	}
	
}

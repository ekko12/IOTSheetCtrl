/**
 * com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplatesColumns.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

import java.io.Serializable;
import java.util.Date;

import com.chinauicom.research.commons.utils.BaseVO;

/**
 * 自定义模板列实体
 * @author zhaich5
 * @since 2018/1/16
 *
 */
public class CustomTemplatesColumns extends BaseVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1135936186070642755L;
	
	/** 模板与列关系ID(int(12) NOT NULL) */
	private Integer templateColumnRelId;

	/** 模板ID(varchar(32) NULL) */
	private String templateId;
	
	/** 表编码(varchar(32) null) */
	private String tableCode;

	/** 列编码(varchar(32) NULL) */
	private String columnCode;

	/** 创建人(varchar(32) NULL) */
	private String creater;

	/** 创建时间(datetime NULL) */
	private Date createTime;

	/** 修改人(varchar(32) NULL) */
	private String modifier;

	/** 修改时间(datetime NULL) */
	private Date modifyTime;

	/** 备注(varchar(500) NULL) */
	private String remark;

	public Integer getTemplateColumnRelId() {
		return templateColumnRelId;
	}

	public void setTemplateColumnRelId(Integer templateColumnRelId) {
		this.templateColumnRelId = templateColumnRelId;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getColumnCode() {
		return columnCode;
	}

	public void setColumnCode(String columnCode) {
		this.columnCode = columnCode;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getModifier() {
		return modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getTableCode() {
		return tableCode;
	}

	public void setTableCode(String tableCode) {
		this.tableCode = tableCode;
	}

}

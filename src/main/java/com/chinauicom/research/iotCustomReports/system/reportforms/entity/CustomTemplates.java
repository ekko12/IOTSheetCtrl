/**
 * com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplates.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.chinauicom.research.commons.utils.BaseVO;

/**
 * 自定义模板实体
 * @author zhaich5
 * @since 2018/1/15
 *
 */
public class CustomTemplates extends BaseVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 238117345128844106L;
	
	/** 检索模板名称关键字(varchar(100) null)  */
	private String keywordTemplateName;

	/** 检索状态关键字（1：有效，0：无效）(char(1) null) */
	private String keywordStatus;
	
	/** 表编码关键字(char(32) null) */
	private String keywordTableCode;
	
	/** 模板ID(varchar(32) not null) */
	private String templateId;

	/** 模板名称(varchar(100) null)  */
	private String templateName;

	/** 是否有效状态（1：有效，0：无效）(char(1) null) */
	private String status;
	
	/** 类型（00：日报，01：月报，02：年报）(char(2) null) */
	private String templateType;
	
	/** 表编码(varchar(32) null) */
	private String tableCode;

	/** 模板描述(varchar(300) null) */
	private String templateDesc;

	/** 用户id(varchar(32) null) */
	private String operId;

	/** 创建人(varchar(32) null) */
	private String creater;

	/** 创建时间(datetime null) */
	private Date createTime;

	/** 修改人(varchar(32) null) */
	private String modifier;

	/** 修改时间(datetime null) */
	private Date modifyTime;

	/** 使用次数(decimal(12,0) null) */
	private Long reorder;

	/** 备注(varchar(500) null) */
	private String remark;
	
	/** 自定义模板与列关系集合 */
	private List<CustomTemplatesColumns> customTemplatesColumnsList;
	
	/** 自定义列集合 */
	private List<CustomColumns> customColumnsList;
	
	/** 已选自定义列树  */
	//private List<Map<String, Object>> selectedCustomColumnsTree;
	
	/** 自定义列树  */
	private List<Map<String, Object>> customColumnsTree;

	public String getKeywordTableCode() {
		return keywordTableCode;
	}

	public void setKeywordTableCode(String keywordTableCode) {
		this.keywordTableCode = keywordTableCode;
	}

	public String getKeywordTemplateName() {
		return keywordTemplateName;
	}

	public void setKeywordTemplateName(String keywordTemplateName) {
		this.keywordTemplateName = keywordTemplateName;
	}

	public String getKeywordStatus() {
		return keywordStatus;
	}

	public void setKeywordStatus(String keywordStatus) {
		this.keywordStatus = keywordStatus;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTemplateDesc() {
		return templateDesc;
	}

	public void setTemplateDesc(String templateDesc) {
		this.templateDesc = templateDesc;
	}

	public String getOperId() {
		return operId;
	}

	public void setOperId(String operId) {
		this.operId = operId;
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

	public Long getReorder() {
		return reorder;
	}

	public void setReorder(Long reorder) {
		this.reorder = reorder;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<CustomTemplatesColumns> getCustomTemplatesColumnsList() {
		return customTemplatesColumnsList;
	}

	public void setCustomTemplatesColumnsList(
			List<CustomTemplatesColumns> customTemplatesColumnsList) {
		this.customTemplatesColumnsList = customTemplatesColumnsList;
	}

	public List<CustomColumns> getCustomColumnsList() {
		return customColumnsList;
	}

	public void setCustomColumnsList(
			List<CustomColumns> customColumnsList) {
		this.customColumnsList = customColumnsList;
	}
	
	public List<Map<String, Object>> getCustomColumnsTree() {
		return customColumnsTree;
	}

	public void setCustomColumnsTree(List<Map<String, Object>> customColumnsTree) {
		this.customColumnsTree = customColumnsTree;
	}

	public String getTemplateType() {
		return templateType;
	}

	public void setTemplateType(String templateType) {
		this.templateType = templateType;
	}

	public String getTableCode() {
		return tableCode;
	}

	public void setTableCode(String tableCode) {
		this.tableCode = tableCode;
	}

}

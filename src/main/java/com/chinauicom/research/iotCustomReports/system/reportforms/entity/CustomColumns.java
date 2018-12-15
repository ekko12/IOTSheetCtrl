/**
 * com.chinauicom.research.iotoperation.system.reportforms.entity.CustomColumns.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;

import java.util.Date;
import java.util.List;

import com.chinauicom.research.commons.utils.BaseVO;

/**
 * 自定义列实体
 * @author zhaich5
 * @since 2018/1/9
 *
 */
public class CustomColumns extends BaseVO implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4236083336464309798L;
	
	/** ID(int(8) NOT NULL) */
	private Integer id;
	
	/** 列编码(varchar(32) NOT NULL) */
	private String columnCode;

	/** 列名称(varchar(100) NULL) */
	private String columnName;

	/** 父级列编码，一级“-1”(varchar(32) NULL) */
	private String parentColumnCode;

	/** 列类型,1：固定列，0：自定义列(char(1) NULL) */
	private String status;
	
	/** 权限 (char(1) NULL) */
	private String authority;
	
	/** 标识（0：字段，1：非字段） (char(1) NULL) */
	private String flag;

	/** 列描述(varchar(300) NULL) */
	private String columnDesc;

	/** 创建人(varchar(32) NULL) */
	private String creater;

	/** 创建时间(datetime NULL) */
	private Date createTime;

	/** 修改人(varchar(32) NULL) */
	private String modifier;

	/** 修改时间(datetime NULL) */
	private Date modifyTime;

	/** 排序(decimal(12,0) NULL) */
	private Long reorder;

	/** 备注(varchar(500) NULL) */
	private String remark;
	
	/** 是否存在子菜单,默认为false */
	private boolean child = false;
	
	/** 子菜列集合 */
	private List<CustomColumns> childColumns;

	public String getColumnCode() {
		return columnCode;
	}

	public void setColumnCode(String columnCode) {
		this.columnCode = columnCode;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getParentColumnCode() {
		return parentColumnCode;
	}

	public void setParentColumnCode(String parentColumnCode) {
		this.parentColumnCode = parentColumnCode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getColumnDesc() {
		return columnDesc;
	}

	public void setColumnDesc(String columnDesc) {
		this.columnDesc = columnDesc;
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

	public boolean isChild() {
		return child;
	}

	public void setChild(boolean child) {
		this.child = child;
	}

	public List<CustomColumns> getChildColumns() {
		return childColumns;
	}

	public void setChildColumns(List<CustomColumns> childColumns) {
		this.childColumns = childColumns;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

}

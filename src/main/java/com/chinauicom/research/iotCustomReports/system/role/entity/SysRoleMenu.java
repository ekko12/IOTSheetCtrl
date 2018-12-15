/**
 * com.tydic.dbs.system.role.mapper.SysRoleAuth.java
 */
package com.chinauicom.research.iotoperation.system.role.entity;

import com.chinauicom.research.commons.utils.BaseVO;

/**
 * 
 * @ClassName: SysRoleMenu 
 * @Description: TODO(菜单角色关系实体) 
 * @author huangChuQin
 * @date 2016-7-28 下午8:10:53 
 *
 */
public class SysRoleMenu extends BaseVO implements java.io.Serializable{

	private static final long serialVersionUID = -8178934349657286426L;
	private String roleMenuRelId;
	private String roleCode;
	private String menuCode;
	private String remark;
	private String operateCode;

	public SysRoleMenu(){
	}
	/** 
	 * @return roleMenuRelId 
	 */
	public String getRoleMenuRelId() {
		return roleMenuRelId;
	}
	/** 
	 * @param roleMenuRelId 要设置的 roleMenuRelId 
	 */
	public void setRoleMenuRelId(String roleMenuRelId) {
		this.roleMenuRelId = roleMenuRelId;
	}
	public String getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	public String getMenuCode() {
		return menuCode;
	}
	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/** 
	 * @return operateCode 
	 */
	public String getOperateCode() {
		return operateCode;
	}
	/** 
	 * @param operateCode 要设置的 operateCode 
	 */
	public void setOperateCode(String operateCode) {
		this.operateCode = operateCode;
	}
	/* (非 Javadoc) 
	 * <p>Title: toString</p> 
	 * <p>Description: </p> 
	 * @return 
	 * @see java.lang.Object#toString() 
	 */
	@Override
	public String toString() {
		return "SysRoleMenu [roleMenuRelId=" + roleMenuRelId + ", roleCode="
				+ roleCode + ", menuCode=" + menuCode + ", remark=" + remark
				+ ", operateCode=" + operateCode + "]";
	}
}

/**
 * com.tydic.dbs.system.role.mapper.SysRoleAuth.java
 */
package com.chinauicom.research.iotoperation.system.role.entity;

import com.chinauicom.research.commons.utils.BaseVO;

/**
 * @file  SysDataPermission.java
 * @author shuyongfu
 * @version 0.1
 * @SysDataPermission实体类
 * Copyright(C), 2013-2014
 *		 Guangzhou Sunrise Technology Co., Ltd.
 * History
 *   	1. Date: 2014-06-21 18:40:53
 *      	Author: shuyongfu
 *      	Modification: this file was created
 *   	2. ...
 */
public class SysDataPermission extends BaseVO implements java.io.Serializable{

	private static final long serialVersionUID = -8178934349657286426L;
	private Long dataPermissionId;	//数据权限ID
	private String roleCode;		//角色编码
	private String mallCode;		//商城编码
	private String regionCode;		//区域编码
	private String remark;			//权限描述

	public SysDataPermission(){
	}
	public String getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	public Long getDataPermissionId() {
		return dataPermissionId;
	}
	public void setDataPermissionId(Long dataPermissionId) {
		this.dataPermissionId = dataPermissionId;
	}
	public String getMallCode() {
		return mallCode;
	}
	public void setMallCode(String mallCode) {
		this.mallCode = mallCode;
	}
	public String getRegionCode() {
		return regionCode;
	}
	public void setRegionCode(String regionCode) {
		this.regionCode = regionCode;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}

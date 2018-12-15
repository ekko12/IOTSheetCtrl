/**
 * com.tydic.dbs.system.role.mapper.SysPermission.java
 */
package com.chinauicom.research.iotoperation.system.role.entity;

import java.util.Date;
import java.util.List;

import com.chinauicom.research.commons.utils.BaseVO;

/**
 * @file  SysPermission.java
 * @author caipeimin
 * @version 0.1
 * @SysPermission实体类
 * Copyright(C), 2013-2014
 *		 Guangzhou Sunrise Technology Co., Ltd.
 * History
 *   	1. Date: 2014-06-24 05:42:53
 *      	Author: caipeimin
 *      	Modification: this file was created
 *   	2. ...
 */
public class SysPermission extends BaseVO implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3254267111331979900L;
	
	private String operId;
	private String operName;
	private String operPwd;
	private String orgCode;
	private String mobile;
	private String operType;
	private Integer errorCount;
	private String status;
	private Date lastLoginTime;
	private String channelId;						//父渠道ID
	private List<String> roleCodeList;		//角色列表
	private List<String> groupCodeList;	//用户组列表
	private List<String> mallCodeList;		//数据权限商城维度-商城列表
	private List<String> regionCodeList;	//数据权限区域维度-地市列表
	private List<String> channelIdList;		//父渠道与子渠道ID
	private List<String> regionCodes;		//用户管辖的区域以及子区域
	
	public String getOperId() {
		return operId;
	}
	public void setOperId(String operId) {
		this.operId = operId;
	}
	public String getOperName() {
		return operName;
	}
	public void setOperName(String operName) {
		this.operName = operName;
	}
	public String getOperPwd() {
		return operPwd;
	}
	public void setOperPwd(String operPwd) {
		this.operPwd = operPwd;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getOperType() {
		return operType;
	}
	public void setOperType(String operType) {
		this.operType = operType;
	}
	public Integer getErrorCount() {
		return errorCount;
	}
	public void setErrorCount(Integer errorCount) {
		this.errorCount = errorCount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public java.util.Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(java.util.Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public List<String> getRoleCodeList() {
		return roleCodeList;
	}
	public void setRoleCodeList(List<String> roleCodeList) {
		this.roleCodeList = roleCodeList;
	}
	public List<String> getGroupCodeList() {
		return groupCodeList;
	}
	public void setGroupCodeList(List<String> groupCodeList) {
		this.groupCodeList = groupCodeList;
	}
	public List<String> getMallCodeList() {
		return mallCodeList;
	}
	public void setMallCodeList(List<String> mallCodeList) {
		this.mallCodeList = mallCodeList;
	}
	public List<String> getRegionCodeList() {
		return regionCodeList;
	}
	public void setRegionCodeList(List<String> regionCodeList) {
		this.regionCodeList = regionCodeList;
	}
	public String getChannelId() {
		return channelId;
	}
	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}
	public List<String> getChannelIdList() {
		return channelIdList;
	}
	public void setChannelIdList(List<String> channelIdList) {
		this.channelIdList = channelIdList;
	}
	public List<String> getRegionCodes() {
		return regionCodes;
	}
	public void setRegionCodes(List<String> regionCodes) {
		this.regionCodes = regionCodes;
	}
	
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("OperId:"+getOperId()).append("\n");
		sb.append("OperName:"+getOperName()).append("\n");
		sb.append("OperType:"+getOperType()).append("\n");
		sb.append("OrgCode:"+getOrgCode()).append("\n");
		sb.append("ChannelId:"+getChannelId()).append("\n");
		sb.append("roleCodeList:"+getRoleCodeList().toString()).append("\n");
		sb.append("groupCodeList:"+getGroupCodeList().toString()).append("\n");
		sb.append("mallCodeList:"+getMallCodeList().toString()).append("\n");
		sb.append("regionCodeList:"+getRegionCodeList()).append("\n");
		sb.append("channelIdList:"+getChannelIdList()).append("\n");
		sb.append("regionCodes:"+getRegionCodes());
		return sb.toString();
	}
}

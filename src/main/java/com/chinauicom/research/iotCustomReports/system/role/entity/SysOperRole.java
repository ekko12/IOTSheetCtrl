/**
 * com.sunrise.system.mapper.SysOperRole.java
 */
package com.chinauicom.research.iotoperation.system.role.entity;

import java.util.Date;

import com.chinauicom.research.commons.utils.BaseVO;


/**
 * 
 * @ClassName: SysOperRole 
 * @Description: TODO(实体) 
 * @author Zhongjialiang zhongjialiang@tydic.com 
 * @date 2016-7-11 下午5:47:02 
 *
 */
public class SysOperRole extends BaseVO implements java.io.Serializable{

    private Long operRoleRelId;

    private String operId;

    private String roleCode;

    private String creater;

    private Date createTime;

    private String remark;

	private String roleName;
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

	public SysOperRole(){
	}

	public SysOperRole(
		java.lang.Long operRoleRelId
	){
		this.operRoleRelId = operRoleRelId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public void setOperRoleRelId(java.lang.Long value) {
		this.operRoleRelId = value;
	}	
	public java.lang.Long getOperRoleRelId() {
		return this.operRoleRelId;
	}

	public void setOperId(java.lang.String value) {
		this.operId = value;
	}	
	public java.lang.String getOperId() {
		return this.operId;
	}

	public void setRoleCode(java.lang.String value) {
		this.roleCode = value;
	}	
	public java.lang.String getRoleCode() {
		return this.roleCode;
	}



	public void setRemark(java.lang.String value) {
		this.remark = value;
	}	
	public java.lang.String getRemark() {
		return this.remark;
	}


    public String toString() {
		  StringBuffer buffer = new StringBuffer();
		  buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [");	
			   buffer.append("OperRoleRelId").append("='").append(getOperRoleRelId()).append("' ");	
			   buffer.append("OperId").append("='").append(getOperId()).append("' ");	
			   buffer.append("RoleCode").append("='").append(getRoleCode()).append("' ");	
			   buffer.append("Creater").append("='").append(getCreater()).append("' ");	
			   buffer.append("CreateTime").append("='").append(getCreateTime()).append("' ");	
			   buffer.append("Remark").append("='").append(getRemark()).append("' ");	
		  buffer.append("]");
		  return buffer.toString();
	}		

	public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof SysOperRole) ) return false;
		 SysOperRole  castOther = ( SysOperRole) other;  
		 return 
					( (this.getOperRoleRelId()==castOther.getOperRoleRelId()) ||( this.getOperRoleRelId()!=null && castOther.getOperRoleRelId()!=null && this.getOperRoleRelId().equals(castOther.getOperRoleRelId()) ) )
					&&( (this.getOperId()==castOther.getOperId()) ||( this.getOperId()!=null && castOther.getOperId()!=null && this.getOperId().equals(castOther.getOperId()) ) )
					&&( (this.getRoleCode()==castOther.getRoleCode()) ||( this.getRoleCode()!=null && castOther.getRoleCode()!=null && this.getRoleCode().equals(castOther.getRoleCode()) ) )
					&&( (this.getCreater()==castOther.getCreater()) ||( this.getCreater()!=null && castOther.getCreater()!=null && this.getCreater().equals(castOther.getCreater()) ) )
					&&( (this.getCreateTime()==castOther.getCreateTime()) ||( this.getCreateTime()!=null && castOther.getCreateTime()!=null && this.getCreateTime().equals(castOther.getCreateTime()) ) )
					&&( (this.getRemark()==castOther.getRemark()) ||( this.getRemark()!=null && castOther.getRemark()!=null && this.getRemark().equals(castOther.getRemark()) ) )
			;
    }

	public int hashCode() {
         int result = 17;
				  result = 37 * result + (getOperRoleRelId() == null ? 0 : this.getOperRoleRelId().hashCode() );
				  result = 37 * result + (getOperId() == null ? 0 : this.getOperId().hashCode() );
				  result = 37 * result + (getRoleCode() == null ? 0 : this.getRoleCode().hashCode() );
				  result = 37 * result + (getCreater() == null ? 0 : this.getCreater().hashCode() );
				  result = 37 * result + (getCreateTime() == null ? 0 : this.getCreateTime().hashCode() );
				  result = 37 * result + (getRemark() == null ? 0 : this.getRemark().hashCode() );
         return result;
	} 
	
}


package com.chinauicom.research.iotoperation.system.role.entity;

import java.util.Date;

import com.chinauicom.research.commons.utils.BaseVO;

public class SysRole extends BaseVO implements java.io.Serializable{
	
	private static final long serialVersionUID = 2377326041120387473L;
	private String roleCode;

    private String roleName;

    private String status;

    private String roleType;

    private String roleDesc;

    private Date createTime;

    private String creater;

    private Date modifyTime;

    private String modifier;

    private String remark;

	public SysRole(){
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getModifier() {
		return modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	public SysRole(
		java.lang.String roleCode
	){
		this.roleCode = roleCode;
	}



	public void setRoleCode(java.lang.String value) {
		this.roleCode = value;
	}	
	public java.lang.String getRoleCode() {
		return this.roleCode;
	}

	public void setRoleName(java.lang.String value) {
		this.roleName = value;
	}	
	public java.lang.String getRoleName() {
		return this.roleName;
	}

	public void setStatus(java.lang.String value) {
		this.status = value;
	}	
	public java.lang.String getStatus() {
		return this.status;
	}

	public void setRoleType(java.lang.String value) {
		this.roleType = value;
	}	
	public java.lang.String getRoleType() {
		return this.roleType;
	}

	public void setRoleDesc(java.lang.String value) {
		this.roleDesc = value;
	}	
	public java.lang.String getRoleDesc() {
		return this.roleDesc;
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
			   buffer.append("RoleCode").append("='").append(getRoleCode()).append("' ");	
			   buffer.append("RoleName").append("='").append(getRoleName()).append("' ");	
			   buffer.append("Status").append("='").append(getStatus()).append("' ");	
			   buffer.append("RoleType").append("='").append(getRoleType()).append("' ");	
			   buffer.append("RoleDesc").append("='").append(getRoleDesc()).append("' ");	
			   buffer.append("CreateTime").append("='").append(getCreateTime()).append("' ");	
			   buffer.append("Creater").append("='").append(getCreater()).append("' ");	
			   buffer.append("ModifyTime").append("='").append(getModifyTime()).append("' ");	
			   buffer.append("Modifier").append("='").append(getModifier()).append("' ");	
			   buffer.append("Remark").append("='").append(getRemark()).append("' ");	
		  buffer.append("]");
		  return buffer.toString();
	}		

	public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof SysRole) ) return false;
		 SysRole  castOther = ( SysRole) other;  
		 return 
					( (this.getRoleCode()==castOther.getRoleCode()) ||( this.getRoleCode()!=null && castOther.getRoleCode()!=null && this.getRoleCode().equals(castOther.getRoleCode()) ) )
					&&( (this.getRoleName()==castOther.getRoleName()) ||( this.getRoleName()!=null && castOther.getRoleName()!=null && this.getRoleName().equals(castOther.getRoleName()) ) )
					&&( (this.getStatus()==castOther.getStatus()) ||( this.getStatus()!=null && castOther.getStatus()!=null && this.getStatus().equals(castOther.getStatus()) ) )
					&&( (this.getRoleType()==castOther.getRoleType()) ||( this.getRoleType()!=null && castOther.getRoleType()!=null && this.getRoleType().equals(castOther.getRoleType()) ) )
					&&( (this.getRoleDesc()==castOther.getRoleDesc()) ||( this.getRoleDesc()!=null && castOther.getRoleDesc()!=null && this.getRoleDesc().equals(castOther.getRoleDesc()) ) )
					&&( (this.getCreateTime()==castOther.getCreateTime()) ||( this.getCreateTime()!=null && castOther.getCreateTime()!=null && this.getCreateTime().equals(castOther.getCreateTime()) ) )
					&&( (this.getCreater()==castOther.getCreater()) ||( this.getCreater()!=null && castOther.getCreater()!=null && this.getCreater().equals(castOther.getCreater()) ) )
					&&( (this.getModifyTime()==castOther.getModifyTime()) ||( this.getModifyTime()!=null && castOther.getModifyTime()!=null && this.getModifyTime().equals(castOther.getModifyTime()) ) )
					&&( (this.getModifier()==castOther.getModifier()) ||( this.getModifier()!=null && castOther.getModifier()!=null && this.getModifier().equals(castOther.getModifier()) ) )
					&&( (this.getRemark()==castOther.getRemark()) ||( this.getRemark()!=null && castOther.getRemark()!=null && this.getRemark().equals(castOther.getRemark()) ) )
			;
    }

	public int hashCode() {
         int result = 17;
				  result = 37 * result + (getRoleCode() == null ? 0 : this.getRoleCode().hashCode() );
				  result = 37 * result + (getRoleName() == null ? 0 : this.getRoleName().hashCode() );
				  result = 37 * result + (getStatus() == null ? 0 : this.getStatus().hashCode() );
				  result = 37 * result + (getRoleType() == null ? 0 : this.getRoleType().hashCode() );
				  result = 37 * result + (getRoleDesc() == null ? 0 : this.getRoleDesc().hashCode() );
				  result = 37 * result + (getCreateTime() == null ? 0 : this.getCreateTime().hashCode() );
				  result = 37 * result + (getCreater() == null ? 0 : this.getCreater().hashCode() );
				  result = 37 * result + (getModifyTime() == null ? 0 : this.getModifyTime().hashCode() );
				  result = 37 * result + (getModifier() == null ? 0 : this.getModifier().hashCode() );
				  result = 37 * result + (getRemark() == null ? 0 : this.getRemark().hashCode() );
         return result;
	} 
	
}

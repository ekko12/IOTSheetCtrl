/**
 * com.sunrise.system.mapper.SysRoleOperate.java
 */
package com.chinauicom.research.iotoperation.system.role.entity;

import java.util.Date;

import com.chinauicom.research.commons.utils.BaseVO;

/**
 * 
 * @ClassName: SysRoleOperate 
 * @Description: TODO(实体) 
 * @author Zhongjialiang zhongjialiang@tydic.com 
 * @date 2016-7-11 下午5:58:40 
 *
 */
public class SysRoleOperate extends BaseVO implements java.io.Serializable{

	   private Long roleOpeRelId;

	    private String roleCode;

	    private String operateCode;

	    private String creater;

	    private Date createTime;

	    private String remark;
	    
	    
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

	public SysRoleOperate(){
	}

	public SysRoleOperate(
		java.lang.Long roleOpeRelId
	){
		this.roleOpeRelId = roleOpeRelId;
	}



	public void setRoleOpeRelId(java.lang.Long value) {
		this.roleOpeRelId = value;
	}	
	public java.lang.Long getRoleOpeRelId() {
		return this.roleOpeRelId;
	}

	public void setRoleCode(java.lang.String value) {
		this.roleCode = value;
	}	
	public java.lang.String getRoleCode() {
		return this.roleCode;
	}

	public void setOperateCode(java.lang.String value) {
		this.operateCode = value;
	}	
	public java.lang.String getOperateCode() {
		return this.operateCode;
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
			   buffer.append("RoleOpeRelId").append("='").append(getRoleOpeRelId()).append("' ");	
			   buffer.append("RoleCode").append("='").append(getRoleCode()).append("' ");	
			   buffer.append("OperateCode").append("='").append(getOperateCode()).append("' ");	
			   buffer.append("Creater").append("='").append(getCreater()).append("' ");	
			   buffer.append("CreateTime").append("='").append(getCreateTime()).append("' ");	
			   buffer.append("Remark").append("='").append(getRemark()).append("' ");	
		  buffer.append("]");
		  return buffer.toString();
	}		

	public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof SysRoleOperate) ) return false;
		 SysRoleOperate  castOther = ( SysRoleOperate) other;  
		 return 
					( (this.getRoleOpeRelId()==castOther.getRoleOpeRelId()) ||( this.getRoleOpeRelId()!=null && castOther.getRoleOpeRelId()!=null && this.getRoleOpeRelId().equals(castOther.getRoleOpeRelId()) ) )
					&&( (this.getRoleCode()==castOther.getRoleCode()) ||( this.getRoleCode()!=null && castOther.getRoleCode()!=null && this.getRoleCode().equals(castOther.getRoleCode()) ) )
					&&( (this.getOperateCode()==castOther.getOperateCode()) ||( this.getOperateCode()!=null && castOther.getOperateCode()!=null && this.getOperateCode().equals(castOther.getOperateCode()) ) )
					&&( (this.getCreater()==castOther.getCreater()) ||( this.getCreater()!=null && castOther.getCreater()!=null && this.getCreater().equals(castOther.getCreater()) ) )
					&&( (this.getCreateTime()==castOther.getCreateTime()) ||( this.getCreateTime()!=null && castOther.getCreateTime()!=null && this.getCreateTime().equals(castOther.getCreateTime()) ) )
					&&( (this.getRemark()==castOther.getRemark()) ||( this.getRemark()!=null && castOther.getRemark()!=null && this.getRemark().equals(castOther.getRemark()) ) )
			;
    }

	public int hashCode() {
         int result = 17;
				  result = 37 * result + (getRoleOpeRelId() == null ? 0 : this.getRoleOpeRelId().hashCode() );
				  result = 37 * result + (getRoleCode() == null ? 0 : this.getRoleCode().hashCode() );
				  result = 37 * result + (getOperateCode() == null ? 0 : this.getOperateCode().hashCode() );
				  result = 37 * result + (getCreater() == null ? 0 : this.getCreater().hashCode() );
				  result = 37 * result + (getCreateTime() == null ? 0 : this.getCreateTime().hashCode() );
				  result = 37 * result + (getRemark() == null ? 0 : this.getRemark().hashCode() );
         return result;
	} 
	
}

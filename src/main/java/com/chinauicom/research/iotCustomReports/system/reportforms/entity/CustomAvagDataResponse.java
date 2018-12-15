/**
 * com.chinauicom.research.iotoperation.system.reportforms.entity.DmCustom.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.entity;
 
import java.util.List;

import com.chinauicom.research.commons.utils.BaseVO;
import com.chinauicom.research.iotoperation.busAccSnap.entity.HomePgFourTbInfo;

/**
 * 自定义报表实体
 * @author zhaich5
 * @since 2018/1/22
 *
 */
public class CustomAvagDataResponse extends BaseVO implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8890248624264254865L;
 
	/**  数据日期到日yyyymmdd(varchar(8) null)  
	 * */
	private String code;

	private String msg;

	private List<CustomAvagData> datas;
	
	
	private String secondName;
	private double secondValue;
	private String thirdName;
	private double thirdValue;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public List<CustomAvagData> getDatas() {
		return datas;
	}
	public void setDatas(List<CustomAvagData> datas) {
		this.datas = datas;
	}
	public String getSecondName() {
		return secondName;
	}
	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}
	public double getSecondValue() {
		return secondValue;
	}
	public void setSecondValue(double secondValue) {
		this.secondValue = secondValue;
	}
	public String getThirdName() {
		return thirdName;
	}
	public void setThirdName(String thirdName) {
		this.thirdName = thirdName;
	}
	public double getThirdValue() {
		return thirdValue;
	}
	public void setThirdValue(double thirdValue) {
		this.thirdValue = thirdValue;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	 
}

/**
 * com.tydic.dbs.system.role.dao.SysPermissionDao.java
 */
package com.chinauicom.research.iotoperation.system.role.dao;

import org.springframework.stereotype.Repository;

import com.chinauicom.research.commons.dao.BaseDao;
import com.chinauicom.research.iotoperation.system.role.entity.SysPermission;

/**
 * @file  SysPermissionDao.java
 * @author caipeimin
 * @version 0.1
 * @SysPermissionDao数据操作类
 * Copyright(C), 2013-2014
 *		  Guangzhou Sunrise Technology Co., Ltd.
 * History
 *   	1. Date: 2014-06-24 19-19:53
 *      	Author: caipeimin
 *      	Modification: this file was created
 *   	2. ...
 */
@Repository
public class SysPermissionDao extends BaseDao {	
    /**
	 * 对数据库进行查询并返回VO对象
	 * @return type : SysPermission 返回查询操作符合条件的记录的VO对象，操作失败返回null
	 * @throws Exception
	 */
	public SysPermission selectPermissionByOperatorId(String operatorId) throws Exception {
		return (SysPermission) queryForObject("SYS_PERMISSION.selectPermissionByOperatorId", operatorId);
	}
}

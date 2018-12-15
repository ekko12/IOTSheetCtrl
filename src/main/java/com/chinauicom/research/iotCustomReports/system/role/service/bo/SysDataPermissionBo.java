/**
 * com.tydic.dbs.system.role.bo.SysDataPermissionBo.java
 */
package com.chinauicom.research.iotoperation.system.role.service.bo;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.role.dao.SysDataPermissionDao;
import com.chinauicom.research.iotoperation.system.role.entity.SysDataPermission;
import com.chinauicom.research.iotoperation.system.role.service.SysDataPermissionService;

/**
 * @file  SysDataPermissionBo.java
 * @author shuyongfu
 * @version 0.1
 * @SysDataPermission业务操作接口实现类
 * Copyright(C), 2013-2014
 *		 Guangzhou Sunrise Technology Co., Ltd.
 * History
 *   	1. Date: 2014-06-21 19:22:53
 *      	Author: shuyongfu
 *      	Modification: this file was created
 *   	2. ...
 */
@Service
public class SysDataPermissionBo implements SysDataPermissionService {
	@Autowired
	private SysDataPermissionDao SysDataPermissionDao;
	


	/**
	 * 查找所有数据库记录
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<SysDataPermission> getAll() throws Exception {
		return SysDataPermissionDao.selectAll();
	}
	
	/**
     * 查找符合条件的所有数据库记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     * @throws Exception
     */
    public List<SysDataPermission> get(SysDataPermission vo) throws Exception{
		if(vo == null)
			return null;
        return SysDataPermissionDao.selectByVo(vo);
	}
	
    /**
     * 分页查找
     * @param params 与数据库中记录对应的值对象
     * @return type : Page 返回满足条件的记录集，操作失败返回null
     * @throws Exception
     */
    public Page getPageByParamMap(@SuppressWarnings("rawtypes") Map params) throws Exception{
		if (params == null)
			return null;
		return SysDataPermissionDao.queryForPage(params);
	}
	
    /**
     * 根据复合主键查询角色权限关系信息
     * @param roleCode 角色编码
     * @param menuCode 菜单编码
     * @param operateCode 操作编码
     * @return type : 返回查询操作所有符合条件的记录的VO对象，操作失败返回null
     * @throws Exception
     */
	public SysDataPermission get(String roleCode, String menuCode, String operateCode) throws Exception{
		if(roleCode==null || menuCode==null || operateCode==null)
			return null;
     	return SysDataPermissionDao.selectByPk(roleCode, menuCode, operateCode);
	}
	
	/**
     * 角色授权函数
     * @param roleCode 角色编码
     * @param data 角色与操作权限关系集合
     * @return boolean true成功 false失败
     * @throws Exception
     */
    public boolean save(String roleCode, List<SysDataPermission> data) throws Exception{
    	if(StringUtils.isEmpty(roleCode) || CollectionUtils.isEmpty(data))
    		return false;
    	/**根据角色编码删除原数据*/
    	boolean bool = SysDataPermissionDao.deleteByRoleCode(roleCode);
    	if (!bool)
    		return false;
    	/**批量增加*/
    	return SysDataPermissionDao.batchInsertDataPermission(data);
    }
    
    /**
     * 角色权限保存
     * @throws Exception
     */
    public SysDataPermission save(SysDataPermission vo) throws Exception{
    	if(vo==null)
    		return null;
    	return SysDataPermissionDao.insertByVo(vo);
    }
    
    /**
     * 删除符合条件的所有数据库记录
     * @param roleCode 角色编码
     * @param menuCode 菜单编码
     * @param operateCode 操作编码
     * @return type : boolean 返回删除操做是否成功，操作失败返回false
     */
    public boolean delete(String roleCode, String menuCode, String operateCode) throws Exception{
    	if(roleCode == null || menuCode == null || operateCode == null)
    		return false;
    	return SysDataPermissionDao.deleteByPk(roleCode, menuCode, operateCode);
    }
    
    /**
     * 删除数据库中与传入的值对象对应的记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : boolean 返回删除操作是否成功
     * @throws Exception
     */
    public boolean delete(SysDataPermission vo) throws Exception{
    	if(vo == null)
    		return false;
     	return SysDataPermissionDao.deleteByVo(vo);
    }
    
    /**
     * 根据角色编码删除角色权限关系数据
     * @param roleCode 角色编码
     * @return
     * @throws Exception
     */
    public boolean deleteByRoleCode(String roleCode) throws Exception {
    	return SysDataPermissionDao.deleteByRoleCode(roleCode);
    }

    /**
     * 角色权限数据批量增加
     * @param modes 角色权限数据集合
     * @return
     * @throws Exception
     */
	public boolean batchInsertDataPermission(List<SysDataPermission> modes) throws Exception {
		if (CollectionUtils.isEmpty(modes))
			return false;
		return SysDataPermissionDao.batchInsertDataPermission(modes);
	}
	
	/**
     * 角色权限数据更新
     * @param vo 需要更新的对象
     * @return
     * @throws Exception
     */
    public boolean update(SysDataPermission vo) throws Exception {
    	if (null == vo)
    		return false;
    	SysDataPermissionDao.updateByVoNotNull(vo);
    	return true;
    }
    
    /**
     * 根据查询条件获取功能操作数据权限数据
     * @param params
     * @return
     * @throws Exception
     */
    public List<SysDataPermission> getDataFactorByParams(Map<String,Object> params) throws Exception {
    	if (null == params)
    		return null;
    	return SysDataPermissionDao.selectDataFactorByParams(params);
    }
	
}

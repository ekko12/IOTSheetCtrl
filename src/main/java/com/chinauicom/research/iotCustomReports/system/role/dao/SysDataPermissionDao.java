/**
 * com.tydic.dbs.system.role.dao.SysDataPermissionDao.java
 */
package com.chinauicom.research.iotoperation.system.role.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Repository;

import com.chinauicom.research.commons.dao.BaseDao;
import com.chinauicom.research.commons.utils.BaseVO;
import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.role.entity.SysDataPermission;

/**
 * @file  SysDataPermissionDao.java
 * @author liugaolin
 * @version 0.1
 * @SysDataPermissionDao数据操作类
 * Copyright(C), 2013-2014
 *		  Guangzhou Sunrise Technology Co., Ltd.
 * History
 *   	1. Date: 2014-19-19 19-19:53
 *      	Author: shuyongfu
 *      	Modification: this file was created
 *   	2. ...
 */
@Repository
public class SysDataPermissionDao extends BaseDao {
	
	public Page queryByParams(String sqlDef, @SuppressWarnings("rawtypes") Map params, int currPage,
			int pageSize) throws Exception {
		return this.queryForPage(sqlDef, params, currPage, pageSize);
	}
	
	public Page queryByParams(@SuppressWarnings("rawtypes") Map params, int currPage,
			int pageSize) throws Exception {
		return this.queryForPage("SYS_DATA_PERMISSION.selectByParams", params, currPage, pageSize);
	}
	
	public Page queryForPage(String sqlDef, @SuppressWarnings("rawtypes") Map params) throws Exception {
		return this.queryForPage(sqlDef, params, null);
	}
	
	public Page queryForPage(@SuppressWarnings("rawtypes") Map params) throws Exception {
		return this.queryForPage("SYS_DATA_PERMISSION.selectByParams", params, null);
	}
	
    /**
	 * 对数据库进行查询并返回一个VO数组
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<SysDataPermission> selectAll() throws Exception {
		return queryForList("SYS_DATA_PERMISSION.selectAll", null);
	}
	
	/**
     * 在本方法中组装出一个Map{[数据库列名:值],[数据库列名:值]}对象调用myBatis相关方法
	 * @param valueOne 需要进行查询的值。
	 * @param valueTwo 需要进行查询的值。
	 * @param valueThree 需要进行查询的值。
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	public List<SysDataPermission> selectByParamMap(@SuppressWarnings("rawtypes") Map paramMap) throws Exception {
	    return getSqlSession().selectList("SYS_DATA_PERMISSION.selectByParams", paramMap);
	}
	
	/**
	 * 搜索数据库中所有与对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<SysDataPermission> selectByVo(SysDataPermission vo) throws Exception {
	    if(vo == null) return null;
	    return queryForList("SYS_DATA_PERMISSION.selectByVO", vo);
	}
	
    /**
     * 实现翻页
     * @param condition condition{Vo:条件VO对象，curPage:当前页面数，pageSize:每页最大行数}
     * @return type : Page 返回一个分页的List，操作失败返回null
	 * @throws Exception
     */
    public Page selectForPage(@SuppressWarnings("rawtypes") Map condition) throws Exception {
        if(condition == null) return null;
        int pageIndex = ((Integer) condition.get("curPage")).intValue();
        int perPageSize = ((Integer) condition.get("pageSize")).intValue();
        String sqlStr = "";
        BaseVO vo = (BaseVO) condition.get("Vo");
        if(vo == null) {
        	sqlStr = "SYS_DATA_PERMISSION.selectAll";
        }else {
        	sqlStr = "SYS_DATA_PERMISSION.selectByVO";
        }
        return queryForPage(sqlStr , vo, pageIndex, perPageSize);
    }
    
     /**
     * 实现翻页
     * @param {Vo:条件VO对象，curPage:当前页面数，pageSize:每页最大行数}
     * @return type : Page 返回一个分页的List，操作失败返回null
	 * @throws Exception
     */
    public Page selectForPage(SysDataPermission vo, int pageIndex, int perPageSize) throws Exception {
        String sqlStr = "";
        if(vo == null) {
        	sqlStr = "SYS_DATA_PERMISSION.selectAll";
        }else {
        	sqlStr = "SYS_DATA_PERMISSION.selectByVO";
        }
        return queryForPage(sqlStr , vo, pageIndex, perPageSize);
    }
    
    /**
     * 根据复合主键查询角色权限关系信息
     * @param roleCode 角色编码
     * @param menuCode 菜单编码
     * @param operateCode 操作编码
     * @return type : 返回查询操作所有符合条件的记录的VO对象，操作失败返回null
     * @throws Exception
     */
    public SysDataPermission selectByPk(String roleCode, String menuCode, String operateCode) throws Exception {
    	if(roleCode==null || menuCode==null || operateCode==null)
			return null;
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("roleCode", roleCode);
    	map.put("menuCode", menuCode);
    	map.put("operateCode", operateCode);
    	return (SysDataPermission)getSqlSession().selectOne("SYS_DATA_PERMISSION.selectByPk", map);
    }
    
	/**
	 * 向数据库中插入一个VO对象
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : 
	 * @throws Exception
	 */
	public SysDataPermission insertByVo(SysDataPermission vo) throws Exception {
	    if(vo == null)
	    	return null;
	    return (SysDataPermission)insert("SYS_DATA_PERMISSION.insertByVo", vo);
    }
	
    /**
	 * 更新数据库中对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录记录
	 * @return type : 
	 * @throws Exception
	 */
	public SysDataPermission updateByVo(SysDataPermission vo) throws Exception {
		if(vo == null) return null;
		update("SYS_DATA_PERMISSION.updateByVO", vo);
		return vo;
	}
	
    /**
	 * 更新数据库中对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录记录
	 * @return type : 
	 * @throws Exception
	 */
	public SysDataPermission updateByVoNotNull(SysDataPermission vo) throws Exception {
		if(vo == null) return null;
		update("SYS_DATA_PERMISSION.updateByVoNotNull", vo);
		return vo;
	}
	   
	/**
	 * 删除数据库中所有记录
	 * @return type : boolean 返回删除操作是否成功
	 * @throws Exception
	 */
	public boolean deleteAll() throws Exception {
		return getSqlSession().delete("SYS_DATA_PERMISSION.deleteAll", null) > 0?true:false;
	}

	/**
	 * 删除数据库中与对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : boolean 返回删除操作是否成功
	 * @throws Exception
	 */
	public boolean deleteByVo(SysDataPermission vo) throws Exception {
		if(vo == null) return false;
		int i = delete("SYS_DATA_PERMISSION.deleteByVO", vo);
		return i==0?false:true;
	}
	
    /**
	 * 删除数据库中与传入的主键对应的一条记录
	 * @param pkid 与数据库主键对应
	 * @return type : boolean 返回删除操作是否成功,如果传入参数为空则返回false,如果操作失败则抛出Exception异常
	 * @throws Exception
	 */
    public boolean deleteByPk(String roleCode, String menuCode, String operateCode) throws Exception {
    	if(roleCode==null || menuCode==null || operateCode==null)
			return false;
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("roleCode", roleCode);
    	map.put("menuCode", menuCode);
    	map.put("operateCode", operateCode);
		getSqlSession().delete("SYS_DATA_PERMISSION.deleteByPk", map);
		return true;
	}
    
    /**
     * 根据角色编码删除角色权限关系数据
     * @param roleCode 角色编码
     * @return
     * @throws Exception
     */
    public boolean deleteByRoleCode(String roleCode) throws Exception {
    	if (null == roleCode || roleCode.trim().length() == 0)
    		return false;
    	getSqlSession().delete("SYS_DATA_PERMISSION.deleteByRoleCode", roleCode);
    	return true;
    }

    /**
     * 批量增加角色权限数据
     * @param data
     * @return
     * @throws Exception
     */
    public boolean batchInsertDataPermission(List<SysDataPermission> data) throws Exception {
    	if (CollectionUtils.isEmpty(data))
    		return false;
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("dataPermissionArray", data);
    	getSqlSession().insert("SYS_DATA_PERMISSION.batchInsertDataPermission", map);
    	return true;
    }
    
    /**
     * 根据查询条件获取用户数据权限信息
     * @param map
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<SysDataPermission> selectDataFactorByParams(Map<String, Object> map) throws Exception {
    	if (null == map)
    		return null;
    	return queryForList("SYS_DATA_PERMISSION.selectDataFactorByParams", map);
    }

}

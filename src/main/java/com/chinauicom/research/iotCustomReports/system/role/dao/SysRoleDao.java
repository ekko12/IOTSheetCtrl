/**
 * com.tydic.dbs.system.role.dao.SysRoleDao.java
 */
package com.chinauicom.research.iotoperation.system.role.dao;

import java.util.List;
import java.util.Map;

import com.chinauicom.research.commons.dao.BaseDao;
import com.chinauicom.research.commons.utils.BaseVO;
import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.role.entity.SysOperRole;
import com.chinauicom.research.iotoperation.system.role.entity.SysRole;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

/**
 * @file  SysRoleDao.java
 * @author liugaolin
 * @version 0.1
 * @SysRole数据操作类
 * Copyright(C), 2013-2014
 *		  Guangzhou Sunrise Technology Co., Ltd.
 * History
 *   	1. Date: 2014-02-27 05:42:53
 *      	Author: liugaolin
 *      	Modification: this file was created
 *   	2. ...
 */
@Repository
public class SysRoleDao extends BaseDao {
	
	public Page queryByParams(String sqlDef, @SuppressWarnings("rawtypes") Map params, int currPage, int pageSize) throws Exception {
		return queryForPage(sqlDef, params, currPage, pageSize);
	}
	
	public Page queryByParams(@SuppressWarnings("rawtypes") Map params, int currPage,	int pageSize) throws Exception {
		return queryForPage("SYS_ROLE.selectByParams", params, currPage, pageSize);
	}
	
	public Page queryForPage(String sqlDef, @SuppressWarnings("rawtypes") Map params) throws Exception {
		return queryForPage(sqlDef, params, null);
	}
	
	public Page queryForPage(@SuppressWarnings("rawtypes") Map params) throws Exception {
		return queryForPage("SYS_ROLE.selectByParams", params, null);
	}
	
    /**
	 * 对数据库进行查询并返回一个VO数组
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	public List selectAll() throws Exception {
		return queryForList("SYS_ROLE.selectAll", null);
	}
	
	/**
     * 在本方法中组装出一个Map{[数据库列名:值],[数据库列名:值]}对象调用myBatis相关方法
	 * @param valueOne 需要进行查询的值。
	 * @param valueTwo 需要进行查询的值。
	 * @param valueThree 需要进行查询的值。
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<SysRole> selectByParamMap(@SuppressWarnings("rawtypes") Map paramMap) throws Exception {
	    return queryForList("SYS_ROLE.selectByParams", paramMap);
	}
	
	/**
	 * 搜索数据库中所有与对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public List selectByVo(SysRole vo) throws Exception {
	    if(vo == null) return null;
	    return queryForList("SYS_ROLE.selectByVO", vo);
	}
	
    /**
     * 实现翻页
     * @param condition condition{Vo:条件VO对象，currPage:当前页面数，pageSize:每页最大行数}
     * @return type : Page 返回一个分页的List，操作失败返回null
	 * @throws Exception
     */
    public Page selectForPage(@SuppressWarnings("rawtypes") Map condition) throws Exception {
        if(condition == null) return null;
        int pageIndex = ((Integer) condition.get("currPage")).intValue();
        int perPageSize = ((Integer) condition.get("pageSize")).intValue();
        String sqlStr = "";
        BaseVO vo = (BaseVO) condition.get("Vo");
        if(vo == null) {
        	sqlStr = "SYS_ROLE.selectAll";
        }else {
        	sqlStr = "SYS_ROLE.selectByVO";
        }
        return queryForPage(sqlStr , vo, pageIndex, perPageSize);
    }
    
     /**
     * 实现翻页
     * @param {Vo:条件VO对象，currPage:当前页面数，pageSize:每页最大行数}
     * @return type : Page 返回一个分页的List，操作失败返回null
	 * @throws Exception
     */
    public Page selectForPage(SysRole vo, int pageIndex, int perPageSize) throws Exception {
        String sqlStr = "";
        if(vo == null) {
        	sqlStr = "SYS_ROLE.selectAll";
        }else {
        	sqlStr = "SYS_ROLE.selectByVO";
        }
        return queryForPage(sqlStr , vo, pageIndex, perPageSize);
    }
    
    /**
     * 搜索数据库中与传入的主键对应的记录
     * @param pkid 与数据库主键对应
     * @return type : 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
     */
    public SysRole selectByPk(String pkId) throws Exception {
    	if(pkId ==null) return null;
    	return (SysRole)queryForObject("SYS_ROLE.selectByPk", pkId);
    }
    
	/**
	 * 向数据库中插入一个VO对象
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : 
	 * @throws Exception
	 */
	public SysRole insertByVo(SysRole vo) throws Exception {
	    if(vo == null) return null;
	    return (SysRole)insert("SYS_ROLE.insertByVo", vo);
    }
	
    /**
	 * 更新数据库中对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录记录
	 * @return type : SysRole
	 * @throws Exception
	 */
	public SysRole updateByVo(SysRole vo) throws Exception {
		if(vo == null) return null;
		update("SYS_ROLE.updateByVO", vo);
		return vo;
	}
	
    /**
	 * 更新数据库中对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录记录
	 * @return type : 
	 * @throws Exception
	 */
	public SysRole updateByVoNotNull(SysRole vo) throws Exception {
		if(vo == null) return null;
		update("SYS_ROLE.updateByVoNotNull", vo);
		return vo;
	}
	
    /**
	 * 更新数据库中对象的状态
	 * @param map: <ids: Id列表>, <status: 状态>, <modifier: 修改者>
	 * @return type : boolean 返回操作是否成功
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
    public boolean updateStatus(Map params) throws Exception {
    	if(params == null) return false;
    	getSqlSession().update("SYS_ROLE.updateStatus", params);
    	return true;
    }
	   
	/**
	 * 删除数据库中所有记录
	 * @return type : boolean 返回删除操作是否成功
	 * @throws Exception
	 */
	public boolean deleteAll() throws Exception {
		return delete("SYS_ROLE.deleteAll", null) > 0?true:false;
	}
	

	/**
	 * 删除数据库中与对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : boolean 返回删除操作是否成功
	 * @throws Exception
	 */
	public boolean deleteByVo(SysRole vo) throws Exception {
		if(vo == null) return false;
		int i = delete("SYS_ROLE.deleteByVO", vo);
		return i==0?false:true;
	}
	
    /**
	 * 删除数据库中与传入的主键对应的一条记录
	 * @param pkid 与数据库主键对应
	 * @return type : boolean 返回删除操作是否成功,如果传入参数为空则返回false,如果操作失败则抛出Exception异常
	 * @throws Exception
	 */
    public boolean deleteByPk(String pkId) throws Exception {
		if(pkId == null) return false;
		delete("SYS_ROLE.deleteByPk", pkId);
		return true;
	}
    
    /**
	 * 根据操作员ID删除操作员与角色之间关系记录
	 * @param operId 操作员ID
	 * @return type : boolean 返回删除操作是否成功,如果传入参数为空则返回false,如果操作失败则抛出Exception异常
	 * @throws Exception
	 */
    public boolean deleteByOperId(String operId) throws Exception {
		if(operId == null)
			return false;
		getSqlSession().delete("SYS_ROLE.deleteByOperId", operId);
		return true;
	}
    
    /**
	 * 根据操作员ID添加操作员与角色之间关系记录
	 * @param sysRole 角色  使用roleDesc存放operId
	 * @throws Exception
	 */
	public void insertByVoOperId(SysRole sysRole) throws Exception {
	    if(sysRole == null) return;
		insert("SYS_ROLE.insertByVoOperId", sysRole);
	}

    
    /**
	 * 根据角色编码删除操作员与角色之间关系记录
	 * @param roleCode 角色编码
	 * @return type : boolean 返回删除操作是否成功,如果传入参数为空则返回false,如果操作失败则抛出Exception异常
	 * @throws Exception
	 */
    public boolean deleteByRoleCode(String roleCode) throws Exception {
		if(roleCode == null)
			return false;
		getSqlSession().delete("SYS_ROLE.deleteByRoleCode", roleCode);
		return true;
	}

	public List<SysOperRole> selectOperRole(String operId)throws Exception{
		if (StringUtils.isEmpty(operId)) return null;
		return queryForList("SYS_ROLE.selectOperRole",operId);
	}
}

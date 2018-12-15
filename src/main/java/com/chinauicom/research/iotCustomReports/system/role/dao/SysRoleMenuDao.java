/**
 * com.tydic.dbs.system.role.dao.SysRoleMenuDao.java
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
import com.chinauicom.research.iotoperation.system.role.entity.SysRoleMenu;

/**
 * 
 * @ClassName: SysRoleMenuDao 
 * @Description: TODO(菜单角色关系数据层) 
 * @author huangChuQin
 * @date 2016-7-28 下午7:49:27 
 *
 */
@Repository
public class SysRoleMenuDao extends BaseDao {
	
	public Page queryByParams(String sqlDef, @SuppressWarnings("rawtypes") Map params, int currPage,
			int pageSize) throws Exception {
		return this.queryForPage(sqlDef, params, currPage, pageSize);
	}
	
	public Page queryByParams(@SuppressWarnings("rawtypes") Map params, int currPage,
			int pageSize) throws Exception {
		return this.queryForPage("SYS_ROLE_MENU.selectByParams", params, currPage, pageSize);
	}
	
	public Page queryForPage(String sqlDef, @SuppressWarnings("rawtypes") Map params) throws Exception {
		return this.queryForPage(sqlDef, params, null);
	}
	
	public Page queryForPage(@SuppressWarnings("rawtypes") Map params) throws Exception {
		return this.queryForPage("SYS_ROLE_MENU.selectByParams", params, null);
	}
	
    /**
	 * 对数据库进行查询并返回一个VO数组
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<SysRoleMenu> selectAll() throws Exception {
		return queryForList("SYS_ROLE_MENU.selectAll", null);
	}
	
	/**
     * 在本方法中组装出一个Map{[数据库列名:值],[数据库列名:值]}对象调用myBatis相关方法
	 * @param valueOne 需要进行查询的值。
	 * @param valueTwo 需要进行查询的值。
	 * @param valueThree 需要进行查询的值。
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	public List<SysRoleMenu> selectByParamMap(@SuppressWarnings("rawtypes") Map paramMap) throws Exception {
	    return getSqlSession().selectList("SYS_ROLE_MENU.selectByParams", paramMap);
	}
	
	/**
	 * 搜索数据库中所有与对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<SysRoleMenu> selectByVo(SysRoleMenu vo) throws Exception {
	    if(vo == null) return null;
	    return queryForList("SYS_ROLE_MENU.selectByVO", vo);
	}
	/**
	 * 搜索数据库中所有与对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<SysRoleMenu> selectByVo2(SysRoleMenu vo) throws Exception {
	    if(vo == null) return null;
	    return queryForList("SYS_ROLE_MENU.selectByVO2", vo);
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
        	sqlStr = "SYS_ROLE_MENU.selectAll";
        }else {
        	sqlStr = "SYS_ROLE_MENU.selectByVO";
        }
        return queryForPage(sqlStr , vo, pageIndex, perPageSize);
    }
    
     /**
     * 实现翻页
     * @param {Vo:条件VO对象，curPage:当前页面数，pageSize:每页最大行数}
     * @return type : Page 返回一个分页的List，操作失败返回null
	 * @throws Exception
     */
    public Page selectForPage(SysRoleMenu vo, int pageIndex, int perPageSize) throws Exception {
        String sqlStr = "";
        if(vo == null) {
        	sqlStr = "SYS_ROLE_MENU.selectAll";
        }else {
        	sqlStr = "SYS_ROLE_MENU.selectByVO";
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
    public SysRoleMenu selectByPk(String roleCode, String menuCode, String operateCode) throws Exception {
    	if(roleCode==null || menuCode==null || operateCode==null)
			return null;
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("roleCode", roleCode);
    	map.put("menuCode", menuCode);
    	map.put("operateCode", operateCode);
    	return (SysRoleMenu)getSqlSession().selectOne("SYS_ROLE_MENU.selectByPk", map);
    }
    
	/**
	 * 向数据库中插入一个VO对象
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : 
	 * @throws Exception
	 */
	public SysRoleMenu insertByVo(SysRoleMenu vo) throws Exception {
	    if(vo == null)
	    	return null;
	    return (SysRoleMenu)insert("SYS_ROLE_MENU.insertByVo", vo);
    }
	
    /**
	 * 更新数据库中对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录记录
	 * @return type : 
	 * @throws Exception
	 */
	public SysRoleMenu updateByVo(SysRoleMenu vo) throws Exception {
		if(vo == null) return null;
		update("SYS_ROLE_MENU.updateByVO", vo);
		return vo;
	}
	
    /**
	 * 更新数据库中对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录记录
	 * @return type : 
	 * @throws Exception
	 */
	public SysRoleMenu updateByVoNotNull(SysRoleMenu vo) throws Exception {
		if(vo == null) return null;
		update("SYS_ROLE_MENU.updateByVoNotNull", vo);
		return vo;
	}
	   
	/**
	 * 删除数据库中所有记录
	 * @return type : boolean 返回删除操作是否成功
	 * @throws Exception
	 */
	public boolean deleteAll() throws Exception {
		return getSqlSession().delete("SYS_ROLE_MENU.deleteAll", null) > 0?true:false;
	}

	/**
	 * 删除数据库中与对象对应的记录
	 * @param vo 对象对应到数据库中的一条记录
	 * @return type : boolean 返回删除操作是否成功
	 * @throws Exception
	 */
	public boolean deleteByVo(SysRoleMenu vo) throws Exception {
		if(vo == null) return false;
		int i = delete("SYS_ROLE_MENU.deleteByVO", vo);
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
		getSqlSession().delete("SYS_ROLE_MENU.deleteByPk", map);
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
    	getSqlSession().delete("SYS_ROLE_MENU.deleteByRoleCode", roleCode);
    	return true;
    }

    /**
     * 批量增加角色权限数据
     * @param data
     * @return
     * @throws Exception
     */
    public boolean batchInsertRoleAuth(List<SysRoleMenu> data) throws Exception {
    	if (CollectionUtils.isEmpty(data))
    		return false;
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("roleAuthArray", data);
    	getSqlSession().insert("SYS_ROLE_MENU.batchInsertRoleAuth", map);
    	return true;
    }
    
    /**
     * 根据查询条件获取用户数据权限信息
     * @param map
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<SysRoleMenu> selectDataFactorByParams(Map<String, Object> map) throws Exception {
    	if (null == map)
    		return null;
    	return queryForList("SYS_ROLE_MENU.selectDataFactorByParams", map);
    }

}

/**
 * com.tydic.dbs.system.role.service.SysRoleMenuService.java
 */
package com.chinauicom.research.iotoperation.system.role.service;

import java.util.List;
import java.util.Map;

import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.role.entity.SysRoleMenu;

/**
 * 
 * @ClassName: SysRoleMenuService 
 * @Description: TODO(菜单角色关系接口) 
 * @author huangChuQin
 * @date 2016-7-28 下午7:48:32 
 *
 */
public interface SysRoleMenuService {

	/**
	 * 查找所有数据库记录
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
	public abstract List<SysRoleMenu> getAll() throws Exception;
	
	/**
     * 查找符合条件的所有数据库记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     * @throws Exception
     */
	public abstract List<SysRoleMenu> get(SysRoleMenu vo) throws Exception;

	/**
     * 查找符合条件的所有数据库记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     * @throws Exception
     */
	public abstract List<SysRoleMenu> getRoleOperat(SysRoleMenu vo) throws Exception;
	
    /**
     * 分页查找
     * @param params 与数据库中记录对应的值对象
     * @return type : Page 返回满足条件的记录集，操作失败返回null
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
	public abstract Page getPageByParamMap(Map params) throws Exception;
	
    /**
     * 根据复合主键查询角色权限关系信息
     * @param roleCode 角色编码
     * @param menuCode 菜单编码
     * @param operateCode 操作编码
     * @return type : 返回查询操作所有符合条件的记录的VO对象，操作失败返回null
     * @throws Exception
     */
	public abstract SysRoleMenu get(String roleCode, String menuCode, String operateCode) throws Exception;
	
	/**
     * 角色授权函数
     * @param roleCode 角色编码
     * @param data 角色与操作权限关系集合
     * @return boolean true成功 false失败
     * @throws Exception
     */
    public abstract boolean save(String roleCode, List<SysRoleMenu> data) throws Exception;
    
    /**
     * 角色全选数据保存，单笔
     * @param vo 需新增对象
     * @return
     * @throws Exception
     */
    public abstract SysRoleMenu save(SysRoleMenu vo) throws Exception;
    
    /**
     * 删除符合条件的所有数据库记录
     * @param roleCode 角色编码
     * @param menuCode 菜单编码
     * @param operateCode 操作编码
     * @return type : boolean 返回删除操做是否成功，操作失败返回false
     */
    public abstract boolean delete(String roleCode, String menuCode, String operateCode) throws Exception;
    
    /**
     * 删除数据库中与传入的值对象对应的记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : boolean 返回删除操作是否成功
     * @throws Exception
     */
    public abstract boolean delete(SysRoleMenu vo) throws Exception;
    
    /**
     * 根据角色编码删除角色权限关系数据
     * @param roleCode 角色编码
     * @return
     * @throws Exception
     */
    public abstract boolean deleteByRoleCode(String roleCode) throws Exception;
    
    /**
     * 角色权限数据批量增加
     * @param modes 角色权限数据集合
     * @return
     * @throws Exception
     */
    public abstract boolean batchInsertRoleAuth(List<SysRoleMenu> modes) throws Exception;
    
    /**
     * 角色权限数据更新
     * @param vo 需要更新的对象
     * @return
     * @throws Exception
     */
    public abstract boolean update(SysRoleMenu vo) throws Exception;
    
    /**
     * 根据查询条件获取功能操作数据权限数据
     * @param params
     * @return
     * @throws Exception
     */
    public abstract List<SysRoleMenu> getDataFactorByParams(Map<String,Object> params) throws Exception;

}

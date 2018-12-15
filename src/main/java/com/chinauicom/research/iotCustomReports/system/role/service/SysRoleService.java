/**
 * com.tydic.dbs.system.role.service.SysRoleService.java
 */
package com.chinauicom.research.iotoperation.system.role.service;

import java.util.List;
import java.util.Map;

import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.role.entity.SysOperRole;
import com.chinauicom.research.iotoperation.system.role.entity.SysRole;

/**
 * 
 * @ClassName: SysRoleService 
 * @Description: TODO(角色管理接口) 
 * @author huangChuQin
 * @date 2016-7-27 下午3:56:28 
 *
 */
public abstract interface SysRoleService {

	/**
	 * 查找所有数据库记录
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<SysRole> getAll() throws Exception;
	
    /**
     * 分页查找
     * @param params 与数据库中记录对应的值对象
     * @return type : Page 返回满足条件的记录集，操作失败返回null
     * @throws Exception
     */
    public Page getPageByParamMap(@SuppressWarnings("rawtypes") Map params) throws Exception;
	
    /**
     * 查找符合条件的所有数据库记录
     * @param pkId 与数据库中主键对应的值
     * @return type : 返回查询操作所有符合条件的记录的VO对象，操作失败返回null
     * @throws Exception
     */
	public SysRole get(String pkId) throws Exception;
	
	/**
     * 查找符合条件的所有数据库记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     * @throws Exception
     */
	public List<SysRole> get(SysRole vo) throws Exception;
	
	/**
     * 向数据库表中插入/修改一条角色记录
     * @param vo 与数据库中记录对应的值对象
     * @param flag 操作标识（0新增操作 1修改操作）
     * @return type : RpDir 返回插入操作是否成功
     * @throws Exception
     */
    public SysRole save(SysRole vo,String[] operateCode, int flag) throws Exception;

	/**
	 * 
	 * @Title: save 
	 * @Description: TODO(保存角色并授权) 
	 * @param @param vo
	 * @param @param menuParams
	 * @param @param operateCode
	 * @param @return
	 * @param @throws Exception    设定文件 
	 * @return SysRole    返回类型 
	 * @throws
	 */
    public SysRole save(SysRole vo,String[] menuParams, String[] operateCode, String type) throws Exception;
    
    /**
     * 删除符合条件的所有数据库记录
     * @param pkId 与数据库中主键对应的值
     * @return type : boolean 返回删除操做是否成功，操作失败返回false
     */
    public boolean delete(String pkId) throws Exception;
    
    /**
     * 根据ids逻辑删除数据权限数据信息（将数据状态置为无效）
     * @param ids 数据权限集合
     * @param status 数据有效状态（1有效 0无效）
     * @return
     * @throws Exception
     */
    public boolean deleteLogical(List<String> ids, String status) throws Exception;
    
    /**
     * 根据ids恢复数据权限数据信息（将数据状态置为有效）
     * @param ids 数据权限集合
     * @param status 数据有效状态（1有效 0无效）
     * @return
     * @throws Exception
     */
    public boolean recover(List<String> ids, String status) throws Exception;

	public List<SysOperRole> selectOperRole(String operId)throws Exception;
	
	 public SysRole save(SysRole vo,String[] menuParams, Map<String,String []> menuAndOperateCodeMap, String type) throws Exception;
    
}

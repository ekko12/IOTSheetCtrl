/**
 * com.tydic.dbs.system.role.bo.SysRoleMenuBo.java
 */
package com.chinauicom.research.iotoperation.system.role.service.bo;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.role.dao.SysRoleMenuDao;
import com.chinauicom.research.iotoperation.system.role.entity.SysRoleMenu;
import com.chinauicom.research.iotoperation.system.role.service.SysRoleMenuService;

/**
 * 
 * @ClassName: SysRoleMenuBo 
 * @Description: TODO(菜单角色关系实现类) 
 * @author huangChuQin
 * @date 2016-7-28 下午7:47:58 
 *
 */
@Service
public class SysRoleMenuBo implements SysRoleMenuService {
	@Autowired
	private SysRoleMenuDao SysRoleMenuDao;
	

	/**
	 * 查找所有数据库记录
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<SysRoleMenu> getAll() throws Exception {
		return SysRoleMenuDao.selectAll();
	}
	
	/**
     * 查找符合条件的所有数据库记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     * @throws Exception
     */
    public List<SysRoleMenu> get(SysRoleMenu vo) throws Exception{
		if(vo == null)
			return null;
        return SysRoleMenuDao.selectByVo(vo);
	}
    
    public List<SysRoleMenu> getRoleOperat(SysRoleMenu vo) throws Exception{
		if(vo == null)
			return null;
        return SysRoleMenuDao.selectByVo2(vo);
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
		return SysRoleMenuDao.queryForPage(params);
	}
	
    /**
     * 根据复合主键查询角色权限关系信息
     * @param roleCode 角色编码
     * @param menuCode 菜单编码
     * @param operateCode 操作编码
     * @return type : 返回查询操作所有符合条件的记录的VO对象，操作失败返回null
     * @throws Exception
     */
	public SysRoleMenu get(String roleCode, String menuCode, String operateCode) throws Exception{
		if(roleCode==null || menuCode==null || operateCode==null)
			return null;
     	return SysRoleMenuDao.selectByPk(roleCode, menuCode, operateCode);
	}
	
	/**
     * 角色授权函数
     * @param roleCode 角色编码
     * @param data 角色与操作权限关系集合
     * @return boolean true成功 false失败
     * @throws Exception
     */
    public boolean save(String roleCode, List<SysRoleMenu> data) throws Exception{
    	if(StringUtils.isEmpty(roleCode) || CollectionUtils.isEmpty(data))
    		return false;
    	/**根据角色编码删除原数据*/
    	boolean bool = SysRoleMenuDao.deleteByRoleCode(roleCode);
    	if (!bool)
    		return false;
    	/**批量增加*/
    	return SysRoleMenuDao.batchInsertRoleAuth(data);
    }
    
    /**
     * 角色权限保存
     * @throws Exception
     */
    public SysRoleMenu save(SysRoleMenu vo) throws Exception{
    	if(vo==null)
    		return null;
    	return SysRoleMenuDao.insertByVo(vo);
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
    	return SysRoleMenuDao.deleteByPk(roleCode, menuCode, operateCode);
    }
    
    /**
     * 删除数据库中与传入的值对象对应的记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : boolean 返回删除操作是否成功
     * @throws Exception
     */
    public boolean delete(SysRoleMenu vo) throws Exception{
    	if(vo == null)
    		return false;
     	return SysRoleMenuDao.deleteByVo(vo);
    }
    
    /**
     * 根据角色编码删除角色权限关系数据
     * @param roleCode 角色编码
     * @return
     * @throws Exception
     */
    public boolean deleteByRoleCode(String roleCode) throws Exception {
    	return SysRoleMenuDao.deleteByRoleCode(roleCode);
    }

    /**
     * 角色权限数据批量增加
     * @param modes 角色权限数据集合
     * @return
     * @throws Exception
     */
	public boolean batchInsertRoleAuth(List<SysRoleMenu> modes) throws Exception {
		if (CollectionUtils.isEmpty(modes))
			return false;
		return SysRoleMenuDao.batchInsertRoleAuth(modes);
	}
	
	/**
     * 角色权限数据更新
     * @param vo 需要更新的对象
     * @return
     * @throws Exception
     */
    public boolean update(SysRoleMenu vo) throws Exception {
    	if (null == vo)
    		return false;
    	SysRoleMenuDao.updateByVoNotNull(vo);
    	return true;
    }
    
    /**
     * 根据查询条件获取功能操作数据权限数据
     * @param params
     * @return
     * @throws Exception
     */
    public List<SysRoleMenu> getDataFactorByParams(Map<String,Object> params) throws Exception {
    	if (null == params)
    		return null;
    	return SysRoleMenuDao.selectDataFactorByParams(params);
    }
	
}

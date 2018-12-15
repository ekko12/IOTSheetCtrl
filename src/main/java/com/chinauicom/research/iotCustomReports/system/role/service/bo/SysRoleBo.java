/**
 * com.tydic.dbs.bo.SysRoleBo.java
 */
package com.chinauicom.research.iotoperation.system.role.service.bo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinauicom.research.commons.define.WcsDefinition;
import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.menu.dao.SysFunOperateDao;
import com.chinauicom.research.iotoperation.system.menu.entity.SysFunOperate;
import com.chinauicom.research.iotoperation.system.role.dao.SysRoleDao;
import com.chinauicom.research.iotoperation.system.role.dao.SysRoleMenuDao;
import com.chinauicom.research.iotoperation.system.role.entity.SysOperRole;
import com.chinauicom.research.iotoperation.system.role.entity.SysRole;
import com.chinauicom.research.iotoperation.system.role.entity.SysRoleMenu;
import com.chinauicom.research.iotoperation.system.role.entity.SysRoleOperate;
import com.chinauicom.research.iotoperation.system.role.service.SysRoleService;

/**
 * 
 * @ClassName: SysRoleBo 
 * @Description: TODO(角色管理实现类) 
 * @author huangChuQin
 * @date 2016-7-27 下午3:56:28 
 *
 */
@Service
public class SysRoleBo implements SysRoleService {
	@Autowired
	private SysRoleDao sysRoleDao;
	@Autowired
	private SysFunOperateDao sysFunOperateDao;
	@Autowired
	private SysRoleMenuDao sysRoleMenuDao;
	

	/**
	 * 查找所有数据库记录
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    @SuppressWarnings("unchecked")
	public List<SysRole> getAll() throws Exception {
		return sysRoleDao.selectAll();
	}
	
	/**
     * 查找符合条件的所有数据库记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public List<SysRole> get(SysRole vo) throws Exception{
		if(vo == null) return null;
        return sysRoleDao.selectByVo(vo);
	}
	
    /**
     * 分页查找
     * @param params 与数据库中记录对应的值对象
     * @return type : Page 返回满足条件的记录集，操作失败返回null
     * @throws Exception
     */
	@SuppressWarnings({ "rawtypes" })
    public Page getPageByParamMap(Map params) throws Exception{
		if (params == null) return null;
		return sysRoleDao.queryForPage(params);
	}
	
    /**
     * 查找符合条件的所有数据库记录
     * @param pkid 与数据库中主键对应的值
     * @return type : 返回查询操作所有符合条件的记录的VO对象，操作失败返回null
     * @throws Exception
     */
	public SysRole get(String pkId) throws Exception{
		if(pkId==null) return null;
     	return sysRoleDao.selectByPk(pkId);
	}
	
	/**
     * 向数据库表中插入/修改一条角色记录
     * @param vo 与数据库中记录对应的值对象
     * @param flag 操作标识（0新增操作 1修改操作）
     * @return type : RpDir 返回插入操作是否成功
     * @throws Exception
     */
    public SysRole save(SysRole vo, String[] operateCode, int flag) throws Exception{
    	if(vo == null) return null;		
		if(flag != 0) {
			if (operateCode!=null&&operateCode.length>0) {
				///
				sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
				///
				for (int i = 0; i < operateCode.length; i++) {
					SysFunOperate sysFunOperate = new SysFunOperate();
					sysFunOperate.setOperateDesc(vo.getRoleCode());
					sysFunOperate.setOperateCode(operateCode[i]);
					sysFunOperate.setCreater(vo.getCreater());
					sysFunOperate.setCreateTime(Calendar.getInstance().getTime());
					sysFunOperateDao.insertByVoRoleCode(sysFunOperate);
				}
			}else{
				sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
			}
			return sysRoleDao.updateByVoNotNull(vo);
		} else {
			if (null != vo.getRoleCode() && vo.getRoleCode().trim().length() > 0) {
				SysRole role = sysRoleDao.selectByPk(vo.getRoleCode().trim());
				if (null != role)
					throw new Exception("数据新增失败，角色编码已存在。");
				if (operateCode!=null&&operateCode.length>0) {
					///
					sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
					///
					for (int i = 0; i < operateCode.length; i++) {
						SysFunOperate sysFunOperate = new SysFunOperate();
						sysFunOperate.setOperateDesc(vo.getRoleCode());
						sysFunOperate.setOperateCode(operateCode[i]);
						sysFunOperate.setCreater(vo.getCreater());
						sysFunOperate.setCreateTime(Calendar.getInstance().getTime());
						sysFunOperateDao.insertByVoRoleCode(sysFunOperate);
					}
				}
				return sysRoleDao.insertByVo(vo);
			} else {
				throw new Exception("数据新增失败，角色编码为空。");
			}
		}
    }
    
    /**
     * 删除符合条件的所有数据库记录
     * @param pkid 与数据库中主键对应的值
     * @return type : boolean 返回删除操做是否成功，操作失败返回false
     */
    public boolean delete(String pkId) throws Exception{
    	if(pkId == null) return false;
    	if(!sysFunOperateDao.deleteByRoleCode(pkId))
    		return false;
    	if(!sysRoleMenuDao.deleteByRoleCode(pkId))
    		return false;
    	if(!sysRoleDao.deleteByRoleCode(pkId))
    		return false;
    	return sysRoleDao.deleteByPk(pkId);
    }
    
    /**
     * 删除数据库中与传入的值对象对应的记录
     * @param vo 与数据库中记录对应的值对象
     * @return type : boolean 返回删除操作是否成功
     * @throws Exception
     */
    public boolean delete(SysRole vo) throws Exception{
    	if(vo == null) return false;
    	sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
     	return sysRoleDao.deleteByVo(vo);
    }
    
    /**
	 * 逻辑删除数据库中的对象
	 * @param ids: Id列表, modifier: 修改者
	 * @return type : boolean 返回操作是否成功
	 * @throws Exception
	 */
    @SuppressWarnings({ "rawtypes", "unchecked", "static-access" })
	public boolean deleteLogical(List ids, String modifier) throws Exception{
    	Map params = new HashMap();
    	params.put("ids", ids);
    	params.put("status", WcsDefinition.WcsCommonStatus.WCS_INVALID);
    	params.put("modifier", modifier);
    	params.put("modifyTime", Calendar.getInstance().getTime());
    	return sysRoleDao.updateStatus(params);
	}
	
    /**
	 * 恢复已逻辑删除的数据库中的对象
	 * @param ids: Id列表, modifier: 修改者
	 * @return type : boolean 返回操作是否成功
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", "static-access" })
	public boolean recover(List ids, String modifier) throws Exception{
    	Map params = new HashMap();
    	params.put("ids", ids);
    	params.put("status", WcsDefinition.WcsCommonStatus.WCS_VALID);
    	params.put("modifier", modifier);
    	params.put("modifyTime", Calendar.getInstance().getTime());
    	return sysRoleDao.updateStatus(params);
	}
	
	public SysRole save(SysRole vo,String[] menuParams, String[] operateCode, String type) throws Exception{
		if(vo == null) return null;		
		if(type == "edit" || type.equals("edit")) {//编辑
			if (menuParams!=null&&menuParams.length>0) {
				///
				sysRoleMenuDao.deleteByRoleCode(vo.getRoleCode());
				///
				for (int i = 0; i < menuParams.length; i++) {
					SysRoleMenu sysRoleMenu = new SysRoleMenu();
					sysRoleMenu.setRoleCode(vo.getRoleCode());
					sysRoleMenu.setMenuCode(menuParams[i]);
					sysRoleMenu.setCreater(vo.getCreater());
					sysRoleMenu.setCreateTime(Calendar.getInstance().getTime());
					try {
						sysRoleMenuDao.insertByVo(sysRoleMenu);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}else{
				sysRoleMenuDao.deleteByRoleCode(vo.getRoleCode());
			}
			if (operateCode!=null&&operateCode.length>0) {
				///
				sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
				///
				for (int i = 0; i < operateCode.length; i++) {
					SysFunOperate sysFunOperate = new SysFunOperate();
					sysFunOperate.setOperateDesc(vo.getRoleCode());
					sysFunOperate.setOperateCode(operateCode[i]);
					sysFunOperate.setCreater(vo.getCreater());
					sysFunOperate.setCreateTime(Calendar.getInstance().getTime());
					try {
						sysFunOperateDao.insertByVoRoleCode(sysFunOperate);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}else{
				sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
			}
			return sysRoleDao.updateByVoNotNull(vo);
		} else {//新增
			if (null != vo.getRoleCode() && vo.getRoleCode().trim().length() > 0) {
				if (menuParams!=null&&menuParams.length>0) {
					///
					sysRoleMenuDao.deleteByRoleCode(vo.getRoleCode());
					///
					for (int i = 0; i < menuParams.length; i++) {
						SysRoleMenu sysRoleMenu = new SysRoleMenu();
						sysRoleMenu.setRoleCode(vo.getRoleCode());
						sysRoleMenu.setMenuCode(menuParams[i]);
						sysRoleMenu.setCreater(vo.getCreater());
						sysRoleMenu.setCreateTime(Calendar.getInstance().getTime());
						try {
							sysRoleMenuDao.insertByVo(sysRoleMenu);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				if (operateCode!=null&&operateCode.length>0) {
					///
					sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
					///
					for (int i = 0; i < operateCode.length; i++) {
						SysFunOperate sysFunOperate = new SysFunOperate();
						sysFunOperate.setOperateDesc(vo.getRoleCode());
						sysFunOperate.setOperateCode(operateCode[i]);
						sysFunOperate.setCreater(vo.getCreater());
						sysFunOperate.setCreateTime(Calendar.getInstance().getTime());
						try {
							sysFunOperateDao.insertByVoRoleCode(sysFunOperate);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				return sysRoleDao.insertByVo(vo);
			} else {
				throw new Exception("数据新增失败，角色编码为空。");
			}
		}
	}

	public List<SysOperRole> selectOperRole(String operId)throws  Exception{
		return sysRoleDao.selectOperRole(operId);
	}
	
	public SysRole save(SysRole vo,String[] menuParams, Map<String,String []> menuAndOperateCodeMap, String type) throws Exception{
		if(vo == null) return null;		
		if(type == "edit" || type.equals("edit")) {//编辑
			if (menuParams!=null&&menuParams.length>0) {
				///
				sysRoleMenuDao.deleteByRoleCode(vo.getRoleCode());
				///
				for (int i = 0; i < menuParams.length; i++) {
					SysRoleMenu sysRoleMenu = new SysRoleMenu();
					sysRoleMenu.setRoleCode(vo.getRoleCode());
					sysRoleMenu.setMenuCode(menuParams[i]);
					sysRoleMenu.setCreater(vo.getCreater());
					sysRoleMenu.setCreateTime(Calendar.getInstance().getTime());
					try {
						sysRoleMenuDao.insertByVo(sysRoleMenu);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}else{
				sysRoleMenuDao.deleteByRoleCode(vo.getRoleCode());
			}
			
			
			if (menuAndOperateCodeMap!=null) {
				List<String> operateCodeList = new ArrayList<String>();
				List<String> newOperateCodeList = new ArrayList<String>();
				for(String menuCode:menuAndOperateCodeMap.keySet()){
					//将需要保存的operateCode放入List
					String [] tmpCodes = menuAndOperateCodeMap.get(menuCode);
					Collections.addAll(newOperateCodeList, tmpCodes);
					
					//获取菜单对应的operateCode
					List<SysFunOperate> operateList = sysFunOperateDao.selectByMenuCode(menuCode);
					if(operateList != null){
						for(SysFunOperate oper:operateList){
							operateCodeList.add(oper.getOperateCode());
						}
					}
				}
				
				//删除sys_role_operater中menu_code对应的旧的数据
				Map<String,Object> param = new HashMap<>();
				param.put("roleCode",vo.getRoleCode());
				param.put("operateCodes", operateCodeList);
				sysFunOperateDao.delByRoleAndOperateCode(param);
				
				//批量保存新的数据
				List<SysRoleOperate> sysRoleOperateList = new ArrayList<>();
				for(String opCode: newOperateCodeList){
					SysRoleOperate sysRoleOperate = new SysRoleOperate();
					sysRoleOperate.setRoleCode(vo.getRoleCode());
					sysRoleOperate.setOperateCode(opCode);
					sysRoleOperate.setCreater(vo.getCreater());
					sysRoleOperate.setCreateTime(Calendar.getInstance().getTime());
					sysRoleOperateList.add(sysRoleOperate);
				}
				sysFunOperateDao.addSysRoleOperateBatch(sysRoleOperateList);
				
			}
				
			
				
				
				///
				//sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
				///
				/*
				for (int i = 0; i < operateCode.length; i++) {
					SysFunOperate sysFunOperate = new SysFunOperate();
					sysFunOperate.setOperateDesc(vo.getRoleCode());
					sysFunOperate.setOperateCode(operateCode[i]);
					sysFunOperate.setCreater(vo.getCreater());
					sysFunOperate.setCreateTime(Calendar.getInstance().getTime());
					try {
						sysFunOperateDao.insertByVoRoleCode(sysFunOperate);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}else{
				sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
			}*/
			return sysRoleDao.updateByVoNotNull(vo);
		} else {//新增
			if (null != vo.getRoleCode() && vo.getRoleCode().trim().length() > 0) {
				if (menuParams!=null&&menuParams.length>0) {
					///
					sysRoleMenuDao.deleteByRoleCode(vo.getRoleCode());
					///
					for (int i = 0; i < menuParams.length; i++) {
						SysRoleMenu sysRoleMenu = new SysRoleMenu();
						sysRoleMenu.setRoleCode(vo.getRoleCode());
						sysRoleMenu.setMenuCode(menuParams[i]);
						sysRoleMenu.setCreater(vo.getCreater());
						sysRoleMenu.setCreateTime(Calendar.getInstance().getTime());
						try {
							sysRoleMenuDao.insertByVo(sysRoleMenu);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				if (menuAndOperateCodeMap!=null) {
					List<String> operateCodeList = new ArrayList<String>();
					List<String> newOperateCodeList = new ArrayList<String>();
					for(String menuCode:menuAndOperateCodeMap.keySet()){
						//将需要保存的operateCode放入List
						String [] tmpCodes = menuAndOperateCodeMap.get(menuCode);
						Collections.addAll(newOperateCodeList, tmpCodes);
						
						//获取菜单对应的operateCode
						List<SysFunOperate> operateList = sysFunOperateDao.selectByMenuCode(menuCode);
						if(operateList != null){
							for(SysFunOperate oper:operateList){
								operateCodeList.add(oper.getOperateCode());
							}
						}
					}
					
					//删除sys_role_operater中menu_code对应的旧的数据
					Map<String,Object> param = new HashMap<>();
					param.put("roleCode",vo.getRoleCode());
					param.put("operateCodes", operateCodeList);
					sysFunOperateDao.delByRoleAndOperateCode(param);
					
					//批量保存新的数据
					List<SysRoleOperate> sysRoleOperateList = new ArrayList<>();
					for(String opCode: newOperateCodeList){
						SysRoleOperate sysRoleOperate = new SysRoleOperate();
						sysRoleOperate.setRoleCode(vo.getRoleCode());
						sysRoleOperate.setOperateCode(opCode);
						sysRoleOperate.setCreater(vo.getCreater());
						sysRoleOperate.setCreateTime(Calendar.getInstance().getTime());
						sysRoleOperateList.add(sysRoleOperate);
					}
					sysFunOperateDao.addSysRoleOperateBatch(sysRoleOperateList);
					
				}
				/*
				if (operateCode!=null&&operateCode.length>0) {
					///
					sysFunOperateDao.deleteByRoleCode(vo.getRoleCode());
					///
					for (int i = 0; i < operateCode.length; i++) {
						SysFunOperate sysFunOperate = new SysFunOperate();
						sysFunOperate.setOperateDesc(vo.getRoleCode());
						sysFunOperate.setOperateCode(operateCode[i]);
						sysFunOperate.setCreater(vo.getCreater());
						sysFunOperate.setCreateTime(Calendar.getInstance().getTime());
						try {
							sysFunOperateDao.insertByVoRoleCode(sysFunOperate);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}*/
				return sysRoleDao.insertByVo(vo);
			} else {
				throw new Exception("数据新增失败，角色编码为空。");
			}
		}
	}
}

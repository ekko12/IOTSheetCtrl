/**
 * com.chinauicom.research.iotoperation.system.reportforms.dao.CustomTemplatesDao.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chinauicom.research.commons.dao.BaseDao;
import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomColumns;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplates;

/**
 * 自定义模板DAO
 * @author zhaich5
 * @since 2018/1/15
 *
 */
@Repository
public class CustomTemplatesDao extends BaseDao {
	
	/**
	 * 根据用户ID查询自定义模板信息列表
	 * @param params 
	 * 			operId 必输
	 * @param currPage
	 * @param pageSize
	 * @return page 
	 * 			分页对象
	 * @throws Exception
	 */
	public Page selectByOperId(CustomTemplates params, 
			int currPage, int pageSize) throws Exception {
		return queryForPage("CUSTOM_TEMPLATES.selectByOperId", 
				params, currPage, pageSize);
	}
	
	/**
	 * 根据用户ID查询有效自定义模板信息列表
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<CustomTemplates> selectValidCustomTemplatesListByOperId(
			CustomTemplates params) throws Exception {
		return (List<CustomTemplates>) queryForList(
				"CUSTOM_TEMPLATES.selectValidCustomTemplatesListByOperId", params);
	}
	
	/**
	 * 根据模板编号查询用户有效自定义列信息列表</br>
	 * 注：这里只取非父节点列，而且只支持两层结构的非父节点
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<CustomColumns> selectUserValidCustomColumnsListByTemplateId(
			CustomTemplates params) throws Exception {
		return (List<CustomColumns>) queryForList(
				"CUSTOM_TEMPLATES.selectUserValidCustomColumnsListByTemplateId", params);
	}	
	
	/**
	 * 根据模板编号查询用户指定有效自定义模板的目标列信息列表</br>
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<CustomColumns> selectUserCustomTemplateTargetColumnListByTemplateId(
			CustomTemplates params) throws Exception {
		return (List<CustomColumns>) queryForList(
				"CUSTOM_TEMPLATES.selectUserCustomTemplateTargetColumnListByTemplateId", params);
	}	
	
	/**
	 * 根据主键查询一条自定义模板信息
	 * @param templateId
	 * 				模板ID
	 * @return
	 * @throws Exception
	 */
	public CustomTemplates selectByPk(String templateId) 
			throws Exception {
		return (CustomTemplates) queryForObject(
				"CUSTOM_TEMPLATES.selectByPk", templateId);
	}
	
	/**
	 * 插入一条自定义模板信息
	 * @param vo 对象对应到数据库中的一条记录
	 * @return 影响记录数 
	 * @throws Exception
	 */
	public int insertCustomTemplates(CustomTemplates vo) 
			throws Exception {
	    if (vo == null) { 
	    	return 0;
	    }
	    return save("CUSTOM_TEMPLATES.insertCustomTemplates", vo);
    }
	
	/**
	 * 修改一条用户自定义模板信息
	 * @param vo 对象对应到数据库中的一条记录
	 * @return 影响记录数 
	 * @throws Exception
	 */
	public int updateCustomTemplates(CustomTemplates vo) 
			throws Exception {
	    if (vo == null) { 
	    	return 0;
	    }
	    return modify("CUSTOM_TEMPLATES.updateCustomTemplates", vo);
    }
	
	/**
	 * 累加一条用户自定义模板使用次数
	 * @param vo 对象对应到数据库中的一条记录
	 * @return 影响记录数 
	 * @throws Exception
	 */
	public int addUpTemplateUseCount(CustomTemplates vo) 
			throws Exception {
	    if (vo == null) { 
	    	return 0;
	    }
	    return modify("CUSTOM_TEMPLATES.addUpTemplateUseCount", vo);
    }		
			
	/**
	 * 删除一条用户自定义模板信息
	 * @param vo 对象对应到数据库中的一条记录
	 * @return 影响记录数 
	 * @throws Exception
	 */
	public int deleteCustomTemplates(CustomTemplates vo) 
			throws Exception {
	    if (vo == null) { 
	    	return 0;
	    }
	    return delete("CUSTOM_TEMPLATES.deleteCustomTemplates", vo);
    }
	
}

/**
 * com.chinauicom.research.iotoperation.system.reportforms.dao.CustomTemplatesColumnsDao.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.dao;

import org.springframework.stereotype.Repository;

import com.chinauicom.research.commons.dao.BaseDao;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplatesColumns;

/**
 * 自定义模板列DAO
 * @author zhaich5
 * @since 2018/1/15
 *
 */
@Repository
public class CustomTemplatesColumnsDao extends BaseDao {

	/**
	 * 批量插入多个自定义模板列信息对象
	 * @param list 对象对应到数据库中的多或一条记录
	 * @return type : 
	 * @throws Exception
	 */
	/*@SuppressWarnings("unchecked")
	public List<CustomTemplatesColumns> insertBatchCustomTemplatesColumns(
			List<CustomTemplatesColumns> list) throws Exception {
	    if (list == null || list.size() <= 0) { 
	    	return null;
	    }
	    return (List<CustomTemplatesColumns>) insert(
	    			"CUSTOM_TEMPLATES_COLUMNS.insertBatchCustomTemplatesColumns", list);
    }*/
	
	/**
	 * 插入一个自定义模板列信息对象
	 * @param vo 对象对应到数据库中的一条记录
	 * @return 影响记录数 
	 * @throws Exception
	 */
	public int insertCustomTemplatesColumns (
			CustomTemplatesColumns vo) throws Exception {
	    if (vo == null) { 
	    	return 0;
	    }
	    return save("CUSTOM_TEMPLATES_COLUMNS"
	    		+ ".insertCustomTemplatesColumns", vo);
    }
	
	/**
	 * 根据自定义模板编号删除自定义模板与列关系信息
	 * @param templateId 模板编号
	 * @return 影响记录数 
	 * @throws Exception
	 */
	public int deleteCustomTemplatesColumnsByTemplateId (
			String templateId) throws Exception {
	    if (templateId == null) { 
	    	return 0;
	    }
	    return delete("CUSTOM_TEMPLATES_COLUMNS"
	    		+ ".deleteCustomTemplatesColumnsByTemplateId", templateId);
    }
}

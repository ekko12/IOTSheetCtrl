/**
 * com.chinauicom.research.iotoperation.system.reportforms.service.CustomColumnsService.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.service;

import java.util.List;

import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomColumns;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplates;
import com.chinauicom.research.iotoperation.system.reportforms.entity.DmCustom;

/**
 * 自定义报表服务接口
 * @author zhaich5
 * @since 2018/1/9
 *
 */
public interface CustomReportFormService {

	/**
	 * 查询全部自定义表信息列表
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<CustomColumns> queryCustomTableList() throws Exception;
    
	/**
	 * 查询指定自定义表自定义列信息列表
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<CustomColumns> queryCustomTableColumnList(String columnCode) 
    		throws Exception;
    
	/**
	 * 查询指定表字段信息列表
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<CustomColumns> queryTableColumnList(String columnCode) 
    		throws Exception;
	
	/**
	 * 查询全部自定义列信息列表，由于需求变更已弃用
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<CustomColumns> queryAllCustomColumnsList() throws Exception;
    
	/**
	 * 查询全部固定列和自定义列信息列表
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<CustomColumns> queryAllFixedAndCustomColumnList() 
    		throws Exception;
    
	/**
	 * 查询全部固定列信息列表，由于需求变更已弃用
     * @return type : List 返回查询操作所有符合条件的记录的VO对象集合，操作失败返回null
     */
    public List<CustomColumns> queryAllFixedColumnList() throws Exception;
    
    /**
     * 查询用户自定义模板信息列表（分页）
     * @param params
     * @param currPage
     * @param pageSize
     * @return 
     * @throws Exception
     */
    public Page queryUserCustomTemplatesList(
    		CustomTemplates params, int currPage, int pageSize) 
    				throws Exception;
    
    /**
     * 查询用户有效自定义模板信息列表
     * @param params
     * @return 
     * @throws Exception
     */
    public List<CustomTemplates> queryUserValidCustomTemplatesList(
    		CustomTemplates params) 
    				throws Exception;
    
    /**
     * 查询用户自定义模板有效自定义列信息列表
     * @param params
     * @return 
     * @throws Exception
     */
    public List<CustomColumns> queryUserCustomTemplateValidCustomColumnsList(
    		CustomTemplates params) 
    				throws Exception;
    /**
     * 查询用户指定有效自定义模板的目标列信息列表
     * @param params
     * @return 
     * @throws Exception
     */
    public List<CustomColumns> queryUserCustomTemplateTargetColumnList(
    		CustomTemplates params) 
    				throws Exception;
    
    /**
     * 查询自定义列编号信息列表
     * @param params
     * @return 
     * @throws Exception
     */
    public List<CustomColumns> queryCustomColumnsByColumnCodes(
    		List<CustomColumns> columnCodeList) 
    				throws Exception;
    
    /**
     * 查询自定义列的自定义报表信息列表（分页）
     * @param params
     * @param currPage
     * @param pageSize
     * @return 
     * @throws Exception
     */
    public Page queryDmCustomListForColumnsByParams(
    		DmCustom params, int currPage, int pageSize) 
    				throws Exception;
    
    /**
     * 查询自定义列的自定义报表信息列表
     * @param params
     * @return
     * @throws Exception
     */
    public List<DmCustom> queryDmCustomListForColumnsByParams(
    		DmCustom params) 
    				throws Exception;
    
    /**
     * 根据模板编号查询一条自定义模板信息
     * @param templateId
     * 				模板ID
     * @return
     * @throws Exception
     */
    public CustomTemplates queryCustomTemplatesByTemplateId(
    		String templateId) 
    				throws Exception;
    
    /**
     * 保存一条用户自定义模板信息
     * @param customTemplates
     * 				自定义模板信息对象
     * @return
     * @throws Exception
     */
    public int saveCustomTemplates(
    		CustomTemplates customTemplates) 
    				throws Exception;
    
    /**
     * 修改一条用户自定义模板信息
     * @param customTemplates
     * 				自定义模板信息对象
     * @return
     * @throws Exception
     */
    public int modifyCustomTemplates(
    		CustomTemplates customTemplates) 
    				throws Exception;
        
    /**
     * 删除一条用户自定义模板信息
     * @param customTemplates
     * 				自定义模板信息对象
     * @return 
     * @throws Exception
     */
    public int deleteCustomTemplates(
    		CustomTemplates customTemplates) 
    				throws Exception;
    
    /**
     * 累加一条用户自定义模板的使用次数
     * @param customTemplates
     * @return
     * @throws Exception
     */
    public int addUpTemplateUseCount(
    		CustomTemplates customTemplates) 
    		throws Exception;
    
}

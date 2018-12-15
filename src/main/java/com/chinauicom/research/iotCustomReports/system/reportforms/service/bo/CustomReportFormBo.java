/**
 * com.chinauicom.research.iotoperation.system.reportforms.service.bo.CustomColumnsBo.java
 */
package com.chinauicom.research.iotoperation.system.reportforms.service.bo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.reportforms.dao.CustomColumnsDao;
import com.chinauicom.research.iotoperation.system.reportforms.dao.CustomTemplatesColumnsDao;
import com.chinauicom.research.iotoperation.system.reportforms.dao.CustomTemplatesDao;
import com.chinauicom.research.iotoperation.system.reportforms.dao.DmCustomDao;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomColumns;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplates;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplatesColumns;
import com.chinauicom.research.iotoperation.system.reportforms.entity.DmCustom;
import com.chinauicom.research.iotoperation.system.reportforms.service.CustomReportFormService;

/**
 * 自定义报表服务
 * @author zhaich5
 * @since 2018/1/19
 *
 */
@Service
public class CustomReportFormBo implements CustomReportFormService {

	@Autowired
	private CustomColumnsDao customColumnsDao;
	
	@Autowired
	private CustomTemplatesDao customTemplatesDao;
	
	@Autowired
	private CustomTemplatesColumnsDao customTemplatesColumnsDao;
	
	@Autowired
	private DmCustomDao dmCustomDao;
	
	@Override
	public List<CustomColumns> queryAllCustomColumnsList() 
			throws Exception {
		return customColumnsDao.selectAllCustomColumnList();
	}
	
	@Override
	public List<CustomColumns> queryAllFixedAndCustomColumnList() 
			throws Exception {
		return customColumnsDao.selectAllFixedAndCustomColumnList();
	}
	
	@Override
	public Page queryUserCustomTemplatesList(
			CustomTemplates params, int currPage, int pageSize) 
					throws Exception {
		return customTemplatesDao.selectByOperId(params, currPage, pageSize);
	}

	@Override
	public Page queryDmCustomListForColumnsByParams(
			DmCustom params, int currPage, int pageSize) 
					throws Exception {
		return dmCustomDao.selectDmCustomListForColumnsByParams(
				params, currPage, pageSize);
	}
	
	@Override
	public List<DmCustom> queryDmCustomListForColumnsByParams(
			DmCustom params) throws Exception {
		return dmCustomDao.selectDmCustomListForColumnsByParams(params);
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public int saveCustomTemplates(CustomTemplates customTemplates) 
			throws Exception {
		int resultCount = customTemplatesDao.insertCustomTemplates(customTemplates);
		if (resultCount > 0) {
			//XXX 由于框架限制采用循环插入，但可考虑使用批量插入方式提高性能
			for (CustomTemplatesColumns customTemplatesColumns 
					: customTemplates.getCustomTemplatesColumnsList()) {
				customTemplatesColumnsDao.insertCustomTemplatesColumns(
						customTemplatesColumns);
			}
		}

		return resultCount;
	}

	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public int modifyCustomTemplates(CustomTemplates customTemplates) 
			throws Exception {
		int resultCount = customTemplatesDao.updateCustomTemplates(customTemplates);
		if (resultCount > 0) {
			customTemplatesColumnsDao.deleteCustomTemplatesColumnsByTemplateId(
					customTemplates.getTemplateId());
			//XXX 由于框架限制采用循环插入，但可考虑使用批量插入方式提高性能
			for (CustomTemplatesColumns customTemplatesColumns 
					: customTemplates.getCustomTemplatesColumnsList()) {
				customTemplatesColumnsDao.insertCustomTemplatesColumns(
						customTemplatesColumns);
			}
		}
		return resultCount;
	}
	
	@Override
	@Transactional(readOnly = false, propagation = Propagation.REQUIRED)
	public int deleteCustomTemplates(CustomTemplates customTemplates) 
			throws Exception {
		int resultCount = customTemplatesDao.deleteCustomTemplates(customTemplates);
		if (resultCount > 0) {
			customTemplatesColumnsDao.deleteCustomTemplatesColumnsByTemplateId(
					customTemplates.getTemplateId());
		}
		return resultCount;
	}


	@Override
	public CustomTemplates queryCustomTemplatesByTemplateId(String templateId) 
			throws Exception {
		
		CustomTemplates customTemplates = customTemplatesDao.selectByPk(templateId);
		
		if (customTemplates != null) {
			
			List<CustomColumns> customColumnsList = customColumnsDao
					.selectCustomColumnsByTemplateId(customTemplates.getTemplateId());
			
			List<CustomColumns> allCustomColumnsList = 
					customColumnsDao.selectChildrenCustomColumnListByColumnCode(
							customTemplates.getTableCode());
			if (allCustomColumnsList != null) {
				//初始化自定义列树
				List<Map<String, Object>> customColumnsTree = 
						new ArrayList<Map<String, Object>>();
				for (CustomColumns allCustomColumns : allCustomColumnsList) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("id", allCustomColumns.getColumnCode());
					map.put("name", allCustomColumns.getColumnName());
					map.put("pId", allCustomColumns.getParentColumnCode());
					//如果是已选自定义初省选中
					if (customColumnsList != null) {
						for (CustomColumns customColumns : customColumnsList) {
							if (allCustomColumns.getColumnCode()
									.equals(customColumns.getColumnCode())) {
								map.put("checked", Boolean.TRUE); //选中
							}
						}
					}
					map.put("open", Boolean.TRUE); //菜单展开
					customColumnsTree.add(map);
				}
				customTemplates.setCustomColumnsTree(customColumnsTree);
			}
			
		}
		
		return customTemplates;
	}

	@Override
	public List<CustomTemplates> queryUserValidCustomTemplatesList(
			CustomTemplates params) throws Exception {
		return customTemplatesDao.selectValidCustomTemplatesListByOperId(params);
	}

	@Override
	public List<CustomColumns> queryUserCustomTemplateValidCustomColumnsList(
			CustomTemplates params) throws Exception {
		return customTemplatesDao.selectUserValidCustomColumnsListByTemplateId(params);
	}

	@Override
	public List<CustomColumns> queryCustomColumnsByColumnCodes(
			List<CustomColumns> columnCodeList) 
					throws Exception {
		return customColumnsDao.selectCustomColumnsByColumnCodes(columnCodeList);
	}

	@Override
	public List<CustomColumns> queryAllFixedColumnList() 
			throws Exception {
		return customColumnsDao.selectAllFixedColumnList();
	}

	@Override
	public int addUpTemplateUseCount(CustomTemplates customTemplates) 
			throws Exception {
		return customTemplatesDao.addUpTemplateUseCount(customTemplates);
	}

	@Override
	public List<CustomColumns> queryCustomTableList() throws Exception {
		return customColumnsDao.selectLevelOneCustomColumnList();
	}

	@Override
	public List<CustomColumns> queryCustomTableColumnList(String columnCode)
			throws Exception {
		return customColumnsDao
				.selectChildrenCustomColumnListByColumnCode(columnCode);
	}

	@Override
	public List<CustomColumns> queryTableColumnList(String columnCode) 
			throws Exception {
		return customColumnsDao
				.selectChildrenColumnListByColumnCode(columnCode);
	}

	@Override
	public List<CustomColumns> queryUserCustomTemplateTargetColumnList(
			CustomTemplates params) throws Exception {
		return customTemplatesDao
				.selectUserCustomTemplateTargetColumnListByTemplateId(params);
	}

}

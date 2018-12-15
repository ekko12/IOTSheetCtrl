package com.chinauicom.research.iotoperation.system.reportforms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.chinauicom.research.commons.dao.BaseDao;
import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomSql;

/**
 * 自定义SQL DAO
 * @author zhaich5
 * @since 2018/5/23
 *
 */
@Repository
public class CustomSqlDao extends BaseDao {

	/**
	 * 根据自定义SQL查询（分页）</br>
	 * @param currPage 
	 * 			当前页码
	 * @param pageSize
	 * 			当前页记录数
	 * @return page 
	 * 			当前页对象
	 * @throws Exception
	 */
	public Page selectByCustomSql(CustomSql params, 
			int currPage, int pageSize) throws Exception {
		return queryForPage("CUSTOM_SQL.selectByCustomSql", 
				params, 
				currPage, 
				pageSize);
	}
	
	/**
	 * 根据自定义SQL查询</br>
	 * @return list 
	 * 			
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectByCustomSql(CustomSql params) 
			throws Exception {
		return (List<Map<String, Object>>) queryForList(
				"CUSTOM_SQL.selectByCustomSql", params);
	}
	
}

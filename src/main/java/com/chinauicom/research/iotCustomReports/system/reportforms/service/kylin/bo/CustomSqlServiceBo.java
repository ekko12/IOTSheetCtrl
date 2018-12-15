/**
 * 
 */
package com.chinauicom.research.iotoperation.system.reportforms.service.kylin.bo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.reportforms.dao.CustomSqlDao;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomSql;
import com.chinauicom.research.iotoperation.system.reportforms.service.kylin.CustomSqlService;

/**
 * 自定义SQL服务接口实现
 * @author zhaich5
 * @since 2018/5/23
 *
 */
@Service
public class CustomSqlServiceBo implements CustomSqlService {
	
	@Autowired
	private CustomSqlDao customSqlDao;
	
	@Override
	public Page queryCustomSql(CustomSql sql, int currPage, int pageSize) 
			throws Exception {
		return customSqlDao.selectByCustomSql(sql, currPage, pageSize);
	}

	@Override
	public List<Map<String, Object>> queryCustomSql(CustomSql sql) 
			throws Exception {
		return customSqlDao.selectByCustomSql(sql);
	}

}

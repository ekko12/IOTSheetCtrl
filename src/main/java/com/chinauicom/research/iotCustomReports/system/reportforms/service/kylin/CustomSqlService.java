/**
 * 
 */
package com.chinauicom.research.iotoperation.system.reportforms.service.kylin;

import java.util.List;
import java.util.Map;

import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomSql;

/**
 * 自定义SQL服务接口
 * @author zhaich5
 * @since 2018/5/23
 *
 */
public interface CustomSqlService {

    /**
     * 查询自定义SQL（分页）
     * @param sql
     * 			自定义sql对象
     * @param currPage
     * 			当前页
     * @param pageSize
     * 			每页记录数
     * @return page
     * 			分页对象
     * @throws Exception
     */
    public Page queryCustomSql(CustomSql sql, int currPage, int pageSize) 
    				throws Exception;
    
    /**
     * 查询自定义SQL
     * @param sql
     * 			自定义sql对象
     * @return list
     * 			
     * @throws Exception
     */
    public List<Map<String, Object>> queryCustomSql(CustomSql sql) 
    		throws Exception;
    
}

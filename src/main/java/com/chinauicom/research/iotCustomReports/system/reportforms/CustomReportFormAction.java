/**
 * CustomReportFormAction.java
 */
package com.chinauicom.research.iotoperation.system.reportforms;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinauicom.research.commons.Constants;
import com.chinauicom.research.commons.Message;
import com.chinauicom.research.commons.constant.WcsSessionConstant;
import com.chinauicom.research.commons.exception.BizException;
import com.chinauicom.research.commons.utils.DateUtil;
import com.chinauicom.research.commons.utils.IDUtils;
import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.commons.utils.Utils;
import com.chinauicom.research.iotoperation.system.operator.entity.SysOperator;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomColumns;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplates;
import com.chinauicom.research.iotoperation.system.reportforms.entity.CustomTemplatesColumns;
import com.chinauicom.research.iotoperation.system.reportforms.entity.DmCustom;
import com.chinauicom.research.iotoperation.system.reportforms.entity.QueryCustomReportFormInVo;
import com.chinauicom.research.iotoperation.system.reportforms.entity.TargetColumnExpression;
import com.chinauicom.research.iotoperation.system.reportforms.service.CustomReportFormService;
import com.chinauicom.research.iotoperation.system.reportforms.service.kylin.CustomSqlService;
import com.chinauicom.research.iotoperation.system.reportforms.utils.ExcelUtils;

/**
 * 自定义报表Controller
 * 
 * @author zhaich5
 * @since 2018/1/5
 * @version 1.0
 * 
 */
@Controller
@RequestMapping("/customReportForm")
public class CustomReportFormAction {
	
	/**
	 * 日志
	 */
	private final Logger LOG = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CustomReportFormService customColumnsService;
	
	@Autowired
	private CustomSqlService customSqlService;
	
	@Value("${reportform.filepath}")
	private String filePath;
	
    /**
     * 访问自定义报表
     * @param request
     * @return 
     * @throws Exception
     */
    @RequestMapping("/list.do")
    public String list(HttpServletRequest request) 
    		throws Exception {
    	
    	LOG.info("开始访问自定义报表列表");
    	LOG.info("访问自定义报表列表结束");
    	
        return "system/reportForms/customReportFormList";
    }
    
    /**
     * 访问自定义模板列表
     * @param request
     * @return 
     * @throws Exception
     */
    @RequestMapping("/templatesList.do")
    public String templatesList(HttpServletRequest request) 
    		throws Exception {
    	
    	LOG.info("开始访问自定义模板列表");
    	LOG.info("访问自定义模板列表结束");
    	
        return "system/reportForms/customTemplateList";
    }
    
    /**
     * 查询自定义报表
     * @param request
     * @return map</br>
     * 			map.msg：操作结果信息</br>
     * 			map.page：分页对象</br>
     * 			map.customColumnsList：自定义列列表</br>
     * @throws ParseException 
     * @throws Exception
     */
    @RequestMapping("/queryCustomReportForm.do")
    public @ResponseBody Map<String, Object> queryCustomReportForm(
    		@RequestBody QueryCustomReportFormInVo inVo, 
    		HttpServletRequest request) 
    		throws BizException, ParseException {
    	
    	LOG.info("开始查询自定义报表");
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		
		//定义返回对象
		Map<String, Object> map = new HashMap<String, Object>();
		Message msg = new Message(); //定义返回操作结果信息对象
		
		String operId = operator.getOperId(); //获取操作用户ID
		
		if (StringUtils.isEmpty(inVo.getCustomSql().getTableName())) {
			msg.setFlag(false);
			msg.setMsg("表名不能为空");
			map.put("msg", msg);
			return map;
		}
		
		//日期处理开始
		if (StringUtils.isEmpty(inVo.getQueryDate())) {
			msg.setFlag(false);
			msg.setMsg("日期不能为空");
			map.put("msg", msg);
			return map;
		}
		
		if (!isTrueInterval(inVo.getQueryDate())) {
			msg.setFlag(false);
			msg.setMsg("查询数据日期需大于5年前日期，小于等于当前日期");
			map.put("msg", msg);
			return map;
		}
		
		//计算日期，将字符串格式的日期yyyyMMdd转为yyyy，用于分表表名后缀
		String tableNamePostfix = null; //表名后缀
		try {
			tableNamePostfix = DateUtil.DateToString(
					DateUtil.StringTODate(inVo.getQueryDate(), DateUtil.DATEFORMAT2), 
					DateUtil.YEARFORMAT);
		}catch (Exception e) {
			LOG.error("计算表名后缀异常", e);
			msg.setFlag(false);
			msg.setMsg("请输入正确的查询日期格式");
			map.put("msg", msg);
			return map;
		}
		
		inVo.getCustomSql().setTableName(
				inVo.getCustomSql().getTableName() + "_" + tableNamePostfix);//根据年份重置查询表
		//日期处理结束
		
		//分页参数
		String pageNo = inVo.getPageNo(); //获取当前页码
		if (pageNo == null || "".equals(pageNo)) {
			pageNo = Constants.PAGE_NO;
		}
		int currPage = Integer.parseInt(pageNo); //当前页码
		int pageSize = Page.DEFAULT_PAGE_SIZE; //当前页记录数
		

		List<CustomColumns> customColumnsList = null; //目标列对象集合
		//当查询类型是自定义时执行
		if ("0".equals(inVo.getMode())) {
			
			List<CustomColumns> params = new ArrayList<CustomColumns>();
			for (TargetColumnExpression targetColumnExpression : inVo.getCustomSql().getTargetColumnExpressionList()) {
				if (StringUtils.isNotEmpty(targetColumnExpression.getColumnExpression())) {
					CustomColumns customColumns = new CustomColumns();
					customColumns.setColumnCode(targetColumnExpression.getColumnExpression());
					params.add(customColumns);
				}
			}
			try {
				customColumnsList = customColumnsService
						.queryCustomColumnsByColumnCodes(params);
			} catch (Exception e) {
				LOG.error("查询自定义列编号信息列表异常", e);
				throw new BizException(BizException.FAILURE, "查询自定义列编号信息列表异常");
			}
			
			List<TargetColumnExpression> targetColumnExpressionList = 
					new ArrayList<TargetColumnExpression>();
			if (customColumnsList != null) {
				for (CustomColumns customColumns : customColumnsList) {
					TargetColumnExpression targetColumnExpression = 
							new TargetColumnExpression();
					targetColumnExpression.setColumnExpression(customColumns.getColumnCode());
					targetColumnExpressionList.add(targetColumnExpression);
				}
			}
			inVo.getCustomSql().setTargetColumnExpressionList(targetColumnExpressionList);
			
		} else if ("1".equals(inVo.getMode())) {//当查询类型是模板时执行
			
			String templateId = inVo.getTemplateId();
			CustomTemplates params = new CustomTemplates();
			params.setTemplateId(templateId);
			params.setOperId(operId);
			try {
				customColumnsList = customColumnsService
						.queryUserCustomTemplateTargetColumnList(params);
			} catch (Exception e) {
				LOG.error("查询用户自定义模板有效自定义列信息列表异常", e);
				throw new BizException(BizException.FAILURE, "查询用户自定义模板有效自定义列信息列表异常");
			}
			List<TargetColumnExpression> targetColumnExpressionList = 
					new ArrayList<TargetColumnExpression>();
			if (customColumnsList != null) {
				for (CustomColumns customColumns : customColumnsList) {
					TargetColumnExpression targetColumnExpression = 
							new TargetColumnExpression();
					targetColumnExpression.setColumnExpression(customColumns.getColumnCode());
					targetColumnExpressionList.add(targetColumnExpression);
				}
			}
			inVo.getCustomSql().setTargetColumnExpressionList(targetColumnExpressionList);
			
		} else {
			msg.setFlag(false);
			msg.setMsg("查询类型不能为空");
			map.put("msg", msg);
			return map;
		}
		
		Page page = null;
		try {
			page = customSqlService.queryCustomSql(
					inVo.getCustomSql(), currPage, pageSize);
		} catch (Exception e) {
			LOG.error("查询自定义Sql错误", e);
			msg.setFlag(false);
			msg.setMsg("查询自定义Sql错误:" + e.getMessage());
			map.put("msg", msg);
			return map;
		}
		
		msg.setFlag(true);
		msg.setMsg("查询自定义报表成功");
		map.put("msg", msg);
		map.put("page", page);
		map.put("titleList", customColumnsList);
		
		LOG.info("查询自定义报表结束");
		
		return map;
		
    }
    
    /**
     * 导出自定义报表
     * @param request
     * @return map</br>
     * 			map.msg：操作结果信息</br>
     * 			map.url：文件路径</br>
     * @throws ParseException 
     * @throws Exception
     */
    @RequestMapping("/exportCustomReportForm.do")
    public @ResponseBody Map<String, Object> exportCustomReportForm(
    		@RequestBody QueryCustomReportFormInVo inVo, 
    		HttpServletRequest request) 
    		throws BizException, ParseException {
    	
    	LOG.info("开始导出自定义报表");
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		
		//定义返回对象
		Map<String, Object> map = new HashMap<String, Object>();
		Message msg = new Message(); //定义返回操作结果信息对象
		
		String operId = operator.getOperId(); //获取操作用户ID
		
		if (StringUtils.isEmpty(inVo.getCustomSql().getTableName())) {
			msg.setFlag(false);
			msg.setMsg("表名不能为空");
			map.put("msg", msg);
			return map;
		}
		
		//日期处理开始
		if (StringUtils.isEmpty(inVo.getQueryDate())) {
			msg.setFlag(false);
			msg.setMsg("日期不能为空");
			map.put("msg", msg);
			return map;
		}
		
		if (!isTrueInterval(inVo.getQueryDate())) {
			msg.setFlag(false);
			msg.setMsg("查询数据日期需大于5年前日期，小于等于当前日期");
			map.put("msg", msg);
			return map;
		}
		
		//计算日期，将字符串格式的日期yyyyMMdd转为yyyy，用于分表表名后缀
		String tableNamePostfix = null; //表名后缀
		try {
			tableNamePostfix = DateUtil.DateToString(
					DateUtil.StringTODate(inVo.getQueryDate(), DateUtil.DATEFORMAT2), 
					DateUtil.YEARFORMAT);
		}catch (Exception e) {
			LOG.error("计算表名后缀异常", e);
			msg.setFlag(false);
			msg.setMsg("请输入正确的查询日期格式");
			map.put("msg", msg);
			return map;
		}
		
		inVo.getCustomSql().setTableName(
				inVo.getCustomSql().getTableName() + "_" + tableNamePostfix);//根据年份重置查询表
		//日期处理结束
		
		List<CustomColumns> customColumnsList = null; //目标列对象集合
		//当查询类型是自定义时执行
		if ("0".equals(inVo.getMode())) {
			
			List<CustomColumns> params = new ArrayList<CustomColumns>();
			for (TargetColumnExpression targetColumnExpression : inVo.getCustomSql().getTargetColumnExpressionList()) {
				if (StringUtils.isNotEmpty(targetColumnExpression.getColumnExpression())) {
					CustomColumns customColumns = new CustomColumns();
					customColumns.setColumnCode(targetColumnExpression.getColumnExpression());
					params.add(customColumns);
				}
			}
			try {
				customColumnsList = customColumnsService
						.queryCustomColumnsByColumnCodes(params);
			} catch (Exception e) {
				LOG.error("查询自定义列编号信息列表异常", e);
				throw new BizException(BizException.FAILURE, "查询自定义列编号信息列表异常");
			}
			
			List<TargetColumnExpression> targetColumnExpressionList = 
					new ArrayList<TargetColumnExpression>();
			if (customColumnsList != null) {
				for (CustomColumns customColumns : customColumnsList) {
					TargetColumnExpression targetColumnExpression = 
							new TargetColumnExpression();
					targetColumnExpression.setColumnExpression(customColumns.getColumnCode());
					targetColumnExpressionList.add(targetColumnExpression);
				}
			}
			inVo.getCustomSql().setTargetColumnExpressionList(targetColumnExpressionList);
			
		} else if ("1".equals(inVo.getMode())) {//当查询类型是模板时执行
			
			String templateId = inVo.getTemplateId();
			CustomTemplates params = new CustomTemplates();
			params.setTemplateId(templateId);
			params.setOperId(operId);
			try {
				customColumnsList = customColumnsService
						.queryUserCustomTemplateTargetColumnList(params);
			} catch (Exception e) {
				LOG.error("查询用户自定义模板有效自定义列信息列表异常", e);
				throw new BizException(BizException.FAILURE, "查询用户自定义模板有效自定义列信息列表异常");
			}
			List<TargetColumnExpression> targetColumnExpressionList = 
					new ArrayList<TargetColumnExpression>();
			if (customColumnsList != null) {
				for (CustomColumns customColumns : customColumnsList) {
					TargetColumnExpression targetColumnExpression = 
							new TargetColumnExpression();
					targetColumnExpression.setColumnExpression(customColumns.getColumnCode());
					targetColumnExpressionList.add(targetColumnExpression);
				}
			}
			inVo.getCustomSql().setTargetColumnExpressionList(targetColumnExpressionList);
			
		} else {
			msg.setFlag(false);
			msg.setMsg("查询类型不能为空");
			map.put("msg", msg);
			return map;
		}
		
		List<Map<String, Object>> bodyList = null;
		try {
			bodyList = customSqlService.queryCustomSql(inVo.getCustomSql());
		} catch (Exception e) {
			LOG.error("查询自定义Sql错误", e);
			msg.setFlag(false);
			msg.setMsg("查询自定义Sql错误:" + e.getMessage());
			map.put("msg", msg);
			return map;
		}
		
		//初始化Excel表头信息,注意顺序，字段编码与名称顺序必须对应。
		List<String> headInfoList = new ArrayList<String>();
		List<String> titleList = new ArrayList<String>();
		if (customColumnsList != null) {
			for (CustomColumns customColumns : customColumnsList) {
				headInfoList.add(customColumns.getColumnCode());
				titleList.add(customColumns.getColumnName());
			}
		}
		
		String fileName = IDUtils.getFileName() + ".xls";
		String reportFormFilePath = filePath + fileName;
		
		LOG.info("生成自定义报表文件："+ reportFormFilePath);
		
		try {
			ExcelUtils.exportExcel2FilePath("自定义报表", reportFormFilePath, 
					headInfoList, titleList, bodyList);
		} catch (IOException e) {
			LOG.error("生成自定义报表文件异常", e);
			throw new BizException(BizException.FAILURE, "生成自定义报表文件异常");
		}
		
		msg.setFlag(true);
		msg.setMsg("导出自定义报表成功");
		map.put("msg", msg);
		map.put("fileName", fileName);
		
		LOG.info("导出自定义报表结束");
		
		return map;
		
    }
    
    /**
     * 下载文件
     * @param fileName
     * @param request
     * @param response
     * @throws BizException
     */
    @RequestMapping("/downLoadFile")
    public @ResponseBody void downLoadFile(String fileName, 
    		HttpServletRequest request, 
    		HttpServletResponse response) 
    				throws BizException {
        
        LOG.info("待下载文件的名称："+fileName);
        BufferedInputStream bis = null;  
        BufferedOutputStream bos = null;  
        try {

        	LOG.info("创建输入流读取文件...");
            
            //获取输入流
            bis = new BufferedInputStream(new FileInputStream(new File(filePath + fileName)));  
            //获取输出流
            
            LOG.info("创建输出流下载文件...");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/octet-stream");  
            response.setHeader("Content-disposition", "attachment; filename="+ new String(fileName.getBytes("utf-8"), "ISO8859-1"));
            bos = new BufferedOutputStream(response.getOutputStream()); 

            //定义缓冲池大小，开始读写
            byte[] buff = new byte[2048];  
            int bytesRead;  
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {  
              bos.write(buff, 0, bytesRead);  
            }

            //刷新缓冲，写出
            bos.flush();
            LOG.info("文件下载成功。");
        } catch(Exception e){
        	LOG.error("文件下载失败"+e.getMessage());
        	throw new BizException(BizException.FAILURE, "文件下载失败");
        } finally{
            //关闭流
            if(bis != null){
                try {
                    bis.close();
                } catch (IOException e) {
                	LOG.error("关闭输入流失败，"+e.getMessage());
                    e.printStackTrace();
                }  
            }
            if(bis != null){
                try {
                    bos.close();
                } catch (IOException e) {
                	LOG.error("关闭输出流失败，"+e.getMessage());
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * 获取自定义报表列表
     * @param request
     * @return map</br>
     * 			map.msg：操作结果信息</br>
     * 			map.page：分页对象</br>
     * 			map.customColumnsList：自定义列列表</br>
     * 			map.fixedColumnsList：固定列列表</br>
     * @throws ParseException 
     * @throws Exception
     */
    @RequestMapping("/getDmCustomList.do")
    public @ResponseBody Map<String, Object> getDmCustomList(HttpServletRequest request) 
    		throws BizException, ParseException {
    	
    	LOG.info("开始获取自定义报表列表");
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		
		//定义返回对象
		Map<String, Object> map = new HashMap<String, Object>();
		Message msg = new Message(); //定义返回操作结果信息对象
		
		String operId = operator.getOperId(); //获取操作用户ID
		String acctCycle = request.getParameter("acctCycle"); //数据日期
		if (StringUtils.isEmpty(acctCycle)) {
			msg.setFlag(false);
			msg.setMsg("查询数据日期不能为空");
			map.put("msg", msg);
			return map;
		}
		
		if (!isTrueInterval(acctCycle)) {
			msg.setFlag(false);
			msg.setMsg("查询数据日期需大于5年前日期，小于等于当前日期");
			map.put("msg", msg);
			return map;
		}
		
		//计算日期，将字符串格式的日期yyyyMMdd转为yyyy，用于分表表名后缀
		String tableNamePostfix = null; //表名后缀
		try {
			tableNamePostfix = DateUtil.DateToString(
					DateUtil.StringTODate(acctCycle, DateUtil.DATEFORMAT2), 
					DateUtil.YEARFORMAT);
		}catch (Exception e) {
			LOG.error("计算表名后缀异常", e);
			msg.setFlag(false);
			msg.setMsg("请输入正确的查询日期格式");
			map.put("msg", msg);
			return map;
		}
		
		String province = request.getParameter("province"); //商机-用户归属省
		
		//XXX 此判断是由于city表中的省编号长度错误，临时采用截取方式，当省编号调整正确后需取消该判断截取
		if (province.length() == 3) {
			province = province.substring(1, 3);
		}
		
		String city = request.getParameter("city"); //商机-用户归属市
		String principleIndustry = request.getParameter("principleIndustry"); //商机-主要行业
		String industryDetailProduct = request.getParameter("industryDetailProduct"); //商机-行业细分产品
		String mode = request.getParameter("mode"); //查询方式 0-按自定义列；1-按自定义模板
		
		//分页参数
		String pageNo = request.getParameter("pageNo"); //获取当前页码
		if (pageNo == null || "".equals(pageNo)) {
			pageNo = Constants.PAGE_NO;
		}
		int currPage = Integer.parseInt(pageNo); //当前页码
		int pageSize = Page.DEFAULT_PAGE_SIZE; //当前页记录数
		
		List<CustomColumns> customColumnsList = null; //自定义列对象集合
		//当为0时获取自定义列构建查询参数，当为1时根据模板编号获取该模板自定义列
		if ("0".equals(mode)) {
			String columnCodes = request.getParameter("menuParams"); //已","分隔的列编码字符串
			String[] columnCodeArray = columnCodes.split(","); //列编码数组
			List<CustomColumns> params = new ArrayList<CustomColumns>();
			for (String columnCode : columnCodeArray) {
				if (StringUtils.isNotEmpty(columnCode)) {
					CustomColumns customColumns = new CustomColumns();
					customColumns.setColumnCode(columnCode);
					params.add(customColumns);
				}
			}
			try {
				customColumnsList = customColumnsService
						.queryCustomColumnsByColumnCodes(params);
			} catch (Exception e) {
				LOG.error("查询自定义列编号信息列表异常", e);
				throw new BizException(BizException.FAILURE, "查询自定义列编号信息列表异常");
			}
		} else if ("1".equals(mode)) {
			String templateId = request.getParameter("templateId"); //模板编号
			CustomTemplates params = new CustomTemplates();
			params.setTemplateId(templateId);
			params.setOperId(operId);
			try {
				customColumnsList = customColumnsService
						.queryUserCustomTemplateValidCustomColumnsList(params);
			} catch (Exception e) {
				LOG.error("查询用户自定义模板有效自定义列信息列表异常", e);
				throw new BizException(BizException.FAILURE, "查询用户自定义模板有效自定义列信息列表异常");
			}
			//仅当页码为1时执行 
			//XXX 目前只有当前页面为1时才累计使用次数，如果有更好的方需要优化
			if (currPage == 1) {
				try {
					customColumnsService.addUpTemplateUseCount(params);
				} catch (Exception e) {
					LOG.error("累加模板的使用次数异常", e);
					throw new BizException(BizException.FAILURE, "累加一条模板的使用次数异常");
				}
			}
		} else {
			msg.setFlag(false);
			msg.setMsg("请选择正确的查询方式");
			map.put("msg", msg);
			return map;
		}
		
		//开始初始化查询参数
		DmCustom dmCustom = new DmCustom(); //定义查询参数对象
		dmCustom.setAcctCycle(acctCycle);
		dmCustom.setProvince(province);
		dmCustom.setCity(city);
		dmCustom.setPrincipleIndustry(principleIndustry);
		dmCustom.setIndustryDetailProduct(industryDetailProduct);
		dmCustom.setCustomColumnsList(customColumnsList);
		dmCustom.setTableName("dm_custom" + "_" + tableNamePostfix); //被查询分表表名，例如：dm_custom_2018
		
		Page resultPage = null; //定义返回分页查询结果集对象
		try {
			resultPage = customColumnsService
					.queryDmCustomListForColumnsByParams(dmCustom, currPage, pageSize);
		} catch (Exception e) {
			LOG.error("获取自定义报表列表异常", e);
			throw new BizException(BizException.FAILURE, "获取自定义报表列表异常");
		}
		
		List<?> resultList = resultPage.getObjects();
		//格式化查询结果集，输出List<Map<K, V>>，K-列编码，V-属性值
		List<Map<String, Object>> bodyList = new ArrayList<Map<String, Object>>();
		if (resultList != null) {
			for (Object result : resultList) {
				Map<String, Object> bodyMap = new HashMap<String, Object>();
				for (CustomColumns customColumns : customColumnsList) {
					String columnCode = customColumns.getColumnCode(); //列编码
					String propertyName = Utils.underline2Camel(customColumns.getColumnCode(), true); //属性名
					Object propertyValue = null; //属性值
					try {
						propertyValue = this.getProperty((DmCustom) result, propertyName);
					} catch (IllegalArgumentException | IllegalAccessException 
							| NoSuchFieldException | SecurityException e) {
						LOG.error("获取对象指定属性的值异常", e);
						throw new BizException(BizException.FAILURE, "获取对象指定属性的值异常");
					}
					bodyMap.put(columnCode, propertyValue);
				}
				bodyList.add(bodyMap);
			}
		}
		resultPage.setObjects(bodyList);
		
		msg.setFlag(true);
		msg.setMsg("获取自定义报表列表成功");
		map.put("msg", msg);
		map.put("page", resultPage);
		map.put("titleList", customColumnsList);
		
    	LOG.info("获取自定义报表列表结束");
    	
        return map;
    }
    
    /**
     * 导出自定义报表列表
     * @param request
     * @return
     * @throws BizException
     * @throws ParseException 
     */
    @RequestMapping("/exportDmCustomToExcel.do")
    public @ResponseBody Message exportDmCustomToExcel(
    		HttpServletRequest request, HttpServletResponse response) 
    				throws BizException, ParseException {
    	
    	LOG.info("开始导出自定义报表列表");
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		
		Message msg = new Message(); //定义返回操作结果信息对象
		String operId = operator.getOperId(); //获取操作用户ID
		String acctCycle = request.getParameter("acctCycle"); //数据日期
		if (StringUtils.isEmpty(acctCycle)) {
			msg.setFlag(false);
			msg.setMsg("查询数据日期不能为空");
			return msg;
		}
		
		if (!isTrueInterval(acctCycle)) {
			msg.setFlag(false);
			msg.setMsg("查询数据日期需大于5年前日期，小于等于当前日期");
			return msg;
		}
		
		//计算日期，将字符串格式的日期yyyyMMdd转为yyyy，用于分表表名后缀
		String tableNamePostfix = null; //表名后缀
		try {
			tableNamePostfix = DateUtil.DateToString(
					DateUtil.StringTODate(acctCycle, DateUtil.DATEFORMAT2), 
					DateUtil.YEARFORMAT);
		}catch (Exception e) {
			LOG.error("计算表名后缀异常", e);
			msg.setFlag(false);
			msg.setMsg("请输入正确的查询日期格式");
			return msg;
		}
		
		String province = request.getParameter("province"); //商机-用户归属省
		String city = request.getParameter("city"); //商机-用户归属市
		String principleIndustry = request.getParameter("principleIndustry"); //商机-主要行业
		String industryDetailProduct = request.getParameter("industryDetailProduct"); //商机-行业细分产品
		String mode = request.getParameter("mode"); //查询方式 0-按自定义列；1-按自定义模板
		List<CustomColumns> customColumnsList = null; //自定义列对象集合
		//当为0时获取自定义列构建查询参数，当为1时根据模板编号获取该模板自定义列
		if ("0".equals(mode)) {
			String columnCodes = request.getParameter("menuParams"); //已","分隔的列编码字符串
			String[] columnCodeArray = columnCodes.split(","); //列编码数组
			List<CustomColumns> params = new ArrayList<CustomColumns>();
			for (String columnCode : columnCodeArray) {
				if (StringUtils.isNotEmpty(columnCode)) {
					CustomColumns customColumns = new CustomColumns();
					customColumns.setColumnCode(columnCode);
					params.add(customColumns);
				}
			}
			try {
				customColumnsList = customColumnsService
						.queryCustomColumnsByColumnCodes(params);
			} catch (Exception e) {
				LOG.error("查询自定义列编号信息列表异常", e);
				throw new BizException(BizException.FAILURE, "查询自定义列编号信息列表异常");
			}
		} else if ("1".equals(mode)) {
			
			String templateId = request.getParameter("templateId"); //模板编号
			CustomTemplates params = new CustomTemplates();
			params.setTemplateId(templateId);
			params.setOperId(operId);
			
			try {
				customColumnsList = customColumnsService
						.queryUserCustomTemplateValidCustomColumnsList(params);
			} catch (Exception e) {
				LOG.error("查询用户自定义模板有效自定义列信息列表异常", e);
				throw new BizException(BizException.FAILURE, "查询用户自定义模板有效自定义列信息列表异常");
			}
			
			try {
				customColumnsService.addUpTemplateUseCount(params);
			} catch (Exception e) {
				LOG.error("累加模板的使用次数异常", e);
				throw new BizException(BizException.FAILURE, "累加一条模板的使用次数异常");
			}
			
		} else {
			msg.setFlag(false);
			msg.setMsg("请选择正确的查询方式");
			return msg;
		}
		
		//初始化查询参数
		DmCustom dmCustom = new DmCustom(); //定义查询参数对象
		dmCustom.setAcctCycle(acctCycle);
		dmCustom.setProvince(province);
		dmCustom.setCity(city);
		dmCustom.setPrincipleIndustry(principleIndustry);
		dmCustom.setIndustryDetailProduct(industryDetailProduct);
		dmCustom.setCustomColumnsList(customColumnsList);
		dmCustom.setTableName("dm_custom" + "_" + tableNamePostfix); //被查询分表表名，例如：dm_custom_201801
		
		List<DmCustom> resultList = null; //查询结果集
		try {
			resultList = customColumnsService.queryDmCustomListForColumnsByParams(dmCustom);
		} catch (Exception e) {
			LOG.error("查询导出自定义列的自定义报表信息列表异常", e);
			throw new BizException(BizException.FAILURE, "查询导出自定义列的自定义报表信息列表异常");
		}
		
		//初始化Excel表头信息,注意顺序，字段编码与名称顺序必须对应。
		List<String> headInfoList = new ArrayList<String>();
		List<String> titleList = new ArrayList<String>();
		if (customColumnsList != null) {
			for (CustomColumns customColumns : customColumnsList) {
				headInfoList.add(customColumns.getColumnCode());
				titleList.add(customColumns.getColumnName());
			}
		}
		
		//初始化Excel表体信息列表，格式化查询结果集，输出List<Map<K, V>>，K-列编码，V-属性值
		List<Map<String, Object>> bodyList = new ArrayList<Map<String, Object>>();
		if (resultList != null) {
			for (DmCustom result : resultList) {
				Map<String, Object> bodyMap = new HashMap<String, Object>();
				for (CustomColumns customColumns : customColumnsList) {
					String columnCode = customColumns.getColumnCode(); //列编码
					String propertyName = Utils.underline2Camel(customColumns.getColumnCode(), true); //属性名
					Object propertyValue = null; //属性值
					try {
						propertyValue = this.getProperty(result, propertyName);
					} catch (IllegalArgumentException | IllegalAccessException 
							| NoSuchFieldException | SecurityException e) {
						LOG.error("获取对象指定属性的值异常", e);
						throw new BizException(BizException.FAILURE, "获取对象指定属性的值异常");
					}
					bodyMap.put(columnCode, propertyValue);
				}
				bodyList.add(bodyMap);
			}
		}
		
		try {
			ExcelUtils.exportExcel2FilePath("自定义报表", "自定义报表.xls", 
					headInfoList, titleList, bodyList, response);
		} catch (IOException e) {
			LOG.error("导出自定义报表异常", e);
			throw new BizException(BizException.FAILURE, "导出自定义报表异常");
		}
		
		//测试打印
		/*for (Map<String, Object> bodyMap : bodyList) {
			for (CustomColumns customColumns : titleList) {
				System.out.println(
						"编码：" + customColumns.getColumnCode() 
						+ ",名称：" + customColumns.getColumnName() 
						+ ",属性值：" + bodyMap.get(customColumns.getColumnCode()));
			}
			System.out.println("===============================");
		}*/
		
		msg.setFlag(true);
		msg.setMsg("导出自定义报表列表成功");
		
    	LOG.info("导出自定义报表列表结束");
    	return msg;
    }
    
    /**
     * 获取用户自定义模板信息列表
     * @param request
     * @return
     * @throws BizException 
     * @throws Exception
     */
    @RequestMapping("/getUserTemplatesList.do")
    public @ResponseBody Page getUserTemplatesList(HttpServletRequest request) 
    		throws BizException {
    	
    	LOG.info("开始获取用户自定义模板信息列表");
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		String operId = operator.getOperId(); //获取操作用户ID
		String pageNo = request.getParameter("pageNo"); //获取当前页码
		String keywordTemplateName = request.getParameter("keywordTemplateName"); //模板名称关键字
		String keywordTableCode = request.getParameter("keywordTableCode"); //表名关键字
		String keywordStatus = request.getParameter("keywordStatus"); //模板状态关键字
		if (pageNo == null || "".equals(pageNo)) {
			pageNo = Constants.PAGE_NO;
		}
		int currPage = Integer.parseInt(pageNo); //当前页码
		int pageSize = Page.DEFAULT_PAGE_SIZE; //当前页记录数
		//查询参数对象
		CustomTemplates customTemplates = new CustomTemplates();
		customTemplates.setOperId(operId);
		customTemplates.setKeywordTemplateName(keywordTemplateName);
		customTemplates.setKeywordTableCode(keywordTableCode);
		customTemplates.setKeywordStatus(keywordStatus);
		Page resultPage = null;
		try {
			resultPage = customColumnsService
					.queryUserCustomTemplatesList(customTemplates, currPage, pageSize);
		} catch (Exception e) {
			LOG.error("获取用户自定义模板信息列表异常", e);
			throw new BizException(BizException.FAILURE, "获取用户自定义模板信息列表异常");
		}
		
    	LOG.info("获取用户自定义模板信息列表结束");
    	
        return resultPage;
    }
    
    /**
     * 保存用户自定义模板信息
     * @param request
     * @return
     */
    @RequestMapping("/saveUserTemplate.do")
    public @ResponseBody Message saveUserTemplate(HttpServletRequest request) 
    		throws BizException {
		
    	LOG.info("开始保存用户自定义模板信息");
    	Message msg = new Message(); //定义返回信息
    	
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		String operId = operator.getOperId(); //获取操作用户ID
		String tableCode = request.getParameter("tableCode"); //表编码
		if (StringUtils.isEmpty(tableCode)) {
	    	msg.setFlag(false);
	    	msg.setMsg("报表类型不能为空");
	    	return msg;
		}
		String templateName = request.getParameter("templateName"); //模板名称
		if (StringUtils.isEmpty(templateName)) {
	    	msg.setFlag(false);
	    	msg.setMsg("模板名称不能为空");
	    	return msg;
		}
		String status = request.getParameter("status"); //状态
		String templateDesc = request.getParameter("templateDesc"); //描述
		String columnCodes = request.getParameter("menuParams"); //已","分隔的列编码字符串
		String[] columnCodeArray = columnCodes.split(","); //列编码数组
		String templateId = IDUtils.getTemplateId(); //模板ID
		
		//初始化新增自定义模板信息对象
		CustomTemplates customTemplates = new CustomTemplates();
		customTemplates.setTemplateId(templateId);
		customTemplates.setTableCode(tableCode);
		customTemplates.setOperId(operId); //用户使用操作用户
		customTemplates.setCreater(operId);  //创建人使用操作用户
		customTemplates.setTemplateName(templateName);
		customTemplates.setStatus(status);
		customTemplates.setTemplateDesc(templateDesc);
		
		//初始化自定义模板列参数
		List<CustomTemplatesColumns> list = new ArrayList<CustomTemplatesColumns>();
		for (String columnCode : columnCodeArray) {
			if (StringUtils.isNotEmpty(columnCode)) {
				CustomTemplatesColumns customTemplatesColumns = 
						new CustomTemplatesColumns();
				customTemplatesColumns.setCreater(operId);
				customTemplatesColumns.setTemplateId(templateId);
				customTemplatesColumns.setTableCode(tableCode);
				customTemplatesColumns.setColumnCode(columnCode);
				list.add(customTemplatesColumns);
			}
		}
		customTemplates.setCustomTemplatesColumnsList(list);
		
		try {
			customColumnsService.saveCustomTemplates(customTemplates);
		} catch (Exception e) {
			LOG.error("保存用户自定义模板信息异常", e);
			throw new BizException(BizException.FAILURE, "保存用户自定义模板信息异常");
		} 	
    	msg.setFlag(true);
    	msg.setMsg("保存用户自定义模板信息成功");
    	
    	LOG.info("保存用户自定义模板信息结束");
		return msg;
    }
    
    /**
     * 修改用户自定义模板信息
     * @param request
     * @return
     */
    @RequestMapping("/modifyUserTemplate.do")
    public @ResponseBody Message modifyUserTemplate(HttpServletRequest request) 
    		throws BizException {
		
    	LOG.info("开始修改用户自定义模板信息");
    	Message msg = new Message(); //定义返回信息
    	
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		String operId = operator.getOperId(); //获取操作用户ID
		String tableCode = request.getParameter("tableCode"); //表编码
		if (StringUtils.isEmpty(tableCode)) {
	    	msg.setFlag(false);
	    	msg.setMsg("报表类型不能为空");
	    	return msg;
		}
		String templateName = request.getParameter("templateName"); //模板名称
		if (StringUtils.isEmpty(templateName)) {
	    	msg.setFlag(false);
	    	msg.setMsg("模板名称不能为空");
	    	return msg;
		}
		String templateId = request.getParameter("templateId");; //模板ID
		if (StringUtils.isEmpty(templateId)) {
	    	msg.setFlag(false);
	    	msg.setMsg("模板编号不能为空");
	    	return msg;
		}
		String status = request.getParameter("status"); //状态
		String templateDesc = request.getParameter("templateDesc"); //描述
		String columnCodes = request.getParameter("menuParams"); //已","分隔的列编码字符串
		String[] columnCodeArray = columnCodes.split(","); //列编码数组
		
		//初始化修改自定义模板信息对象
		CustomTemplates customTemplates = new CustomTemplates();
		customTemplates.setTemplateId(templateId);
		customTemplates.setOperId(operId); //用户使用操作用户
		customTemplates.setCreater(operId);  //创建人使用操作用户
		customTemplates.setTemplateName(templateName);
		customTemplates.setStatus(status);
		customTemplates.setTemplateDesc(templateDesc);
		
		//初始化自定义模板列参数
		List<CustomTemplatesColumns> list = new ArrayList<CustomTemplatesColumns>();
		for (String columnCode : columnCodeArray) {
			if (StringUtils.isNotEmpty(columnCode)) {
				CustomTemplatesColumns customTemplatesColumns = 
						new CustomTemplatesColumns();
				customTemplatesColumns.setCreater(operId);
				customTemplatesColumns.setTemplateId(templateId);
				customTemplatesColumns.setTableCode(tableCode);
				customTemplatesColumns.setColumnCode(columnCode);
				list.add(customTemplatesColumns);
			}
		}
		customTemplates.setCustomTemplatesColumnsList(list);
		
		try {
			customColumnsService.modifyCustomTemplates(customTemplates);
		} catch (Exception e) {
			LOG.error("修改用户自定义模板信息异常", e);
			throw new BizException(BizException.FAILURE, "修改用户自定义模板信息异常");
		} 	
    	msg.setFlag(true);
    	msg.setMsg("修改用户自定义模板信息成功");
    	
    	LOG.info("修改用户自定义模板信息结束");
		return msg;
    } 
    
    /**
     * 删除用户自定义模板信息
     * @param request
     * @return
     */
    @RequestMapping("/deleteUserTemplate.do")
    public @ResponseBody Message deleteUserTemplate(HttpServletRequest request) 
    		throws BizException {
		
    	LOG.info("开始删除用户自定义模板信息");
    	Message msg = new Message(); //定义返回信息
    	
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		String operId = operator.getOperId(); //获取操作用户ID
		String templateId = request.getParameter("templateId");; //模板ID
		if (StringUtils.isEmpty(templateId)) {
	    	msg.setFlag(false);
	    	msg.setMsg("模板编号不能为空");
	    	return msg;
		}
		
		//初始化删除自定义模板信息对象
		CustomTemplates customTemplates = new CustomTemplates();
		customTemplates.setTemplateId(templateId);
		customTemplates.setOperId(operId); //用户使用操作用户
		
		try {
			customColumnsService.deleteCustomTemplates(customTemplates);
		} catch (Exception e) {
			LOG.error("删除用户自定义模板信息异常", e);
			throw new BizException(BizException.FAILURE, "删除用户自定义模板信息异常");
		} 	
    	msg.setFlag(true);
    	msg.setMsg("删除用户自定义模板信息成功");
    	
    	LOG.info("删除用户自定义模板信息结束");
		return msg;
    } 
    
    /**
     * 获取用户自定义模板信息
     * @param request
     * @return
     */
    @RequestMapping("/getTemplate.do")
    public @ResponseBody CustomTemplates getTemplate(HttpServletRequest request) 
    		throws BizException {
		
    	LOG.info("开始获取自定义模板信息");
    	CustomTemplates customTemplates = null; //定义返回自定义模板信息
    	
		String templateId = request.getParameter("templateId"); //模板编号
		if (StringUtils.isEmpty(templateId)) {
			LOG.error("模板编号为空");
	    	return customTemplates;
		}
		
		try {
			customTemplates = customColumnsService.queryCustomTemplatesByTemplateId(templateId);
		} catch (Exception e) {
			LOG.error("获取自定义模板信息异常", e);
			throw new BizException(BizException.FAILURE, "获取自定义模板信息异常");
		}
    	
    	LOG.info("获取自定义模板信息结束");
		return customTemplates;
    }
    
    /**
     * 获取用户有效自定义模板信息列表
     * @param request
     * @return
     * @throws BizException
     */
	@RequestMapping("/getUserValidCustomTemplatesList.do")
	public @ResponseBody List<CustomTemplates> getUserValidCustomTemplatesList(
			HttpServletRequest request) throws BizException {
		LOG.info("开始获取用户有效自定义模板信息列表");
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		String operId = operator.getOperId(); //获取操作用户ID
		String tableCode = request.getParameter("tableCode");
		
		CustomTemplates customTemplates = new CustomTemplates();
		customTemplates.setOperId(operId);
		customTemplates.setTableCode(tableCode);
		
		List<CustomTemplates> list = null;
		
		try {
			list = customColumnsService
					.queryUserValidCustomTemplatesList(customTemplates);
		} catch (Exception e) {
			LOG.error("获取用户有效自定义模板信息列表异常", e);
			throw new BizException(BizException.FAILURE, "获取用户有效自定义模板信息列表异常");
		}
		
		LOG.info("获取用户有效自定义模板信息列表结束");
		return list;
	}
    
	/**
	 * 获取全部自定义列信息列表树
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getColumnTree.do")
	public @ResponseBody List<Map<String, Object>> getColumnTree(HttpServletRequest request) 
			throws Exception {
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
			
		final String showFlag = request.getParameter("showFlag");// 菜单是否展开标志(true是;false否)
		
		List<CustomColumns> customColumnsList = 
				customColumnsService.queryAllFixedAndCustomColumnList();
		List<Map<String, Object>> responseList = new ArrayList<Map<String, Object>>();
		if (CollectionUtils.isNotEmpty(customColumnsList)) {
			final boolean bool = 
					(StringUtils.isNotEmpty(showFlag) && showFlag.equals("true")) 
					? Boolean.TRUE
					: Boolean.FALSE;
			Map<String, Object> map = null;
			for (CustomColumns customColumns : customColumnsList) {
				map = new HashMap<String, Object>();
				map.put("id", customColumns.getColumnCode());
				map.put("name", customColumns.getColumnName());
				map.put("pId", customColumns.getParentColumnCode());
				//固定列默认选中
				if ("1".equals(customColumns.getStatus())) {
					map.put("checked", Boolean.TRUE); //选中
				}
				map.put("open", bool);
				responseList.add(map);
			}
		}
		return responseList;
	}
	
	/**
	 * 获取表的自定义列信息列表树
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getTableColumnTree.do")
	public @ResponseBody List<Map<String, Object>> getTableColumnTree(HttpServletRequest request) 
			throws Exception {
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
			
		final String showFlag = request.getParameter("showFlag");// 菜单是否展开标志(true是;false否)
		String tableCode = request.getParameter("tableCode");// 表编码
		
		List<CustomColumns> customColumnsList = 
				customColumnsService.queryCustomTableColumnList(tableCode);
		List<Map<String, Object>> responseList = new ArrayList<Map<String, Object>>();
		if (CollectionUtils.isNotEmpty(customColumnsList)) {
			final boolean bool = 
					(StringUtils.isNotEmpty(showFlag) && showFlag.equals("true")) 
					? Boolean.TRUE
					: Boolean.FALSE;
			Map<String, Object> map = null;
			for (CustomColumns customColumns : customColumnsList) {
				map = new HashMap<String, Object>();
				map.put("id", customColumns.getColumnCode());
				map.put("name", customColumns.getColumnName());
				map.put("pId", customColumns.getParentColumnCode());
				//固定列默认选中
				if ("1".equals(customColumns.getStatus())) {
					map.put("checked", Boolean.TRUE); //选中
				}
				map.put("open", bool);
				responseList.add(map);
			}
		}
		return responseList;
	}
	
	/**
	 * 获取表的字段信息列表
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getTableColumn.do")
	public @ResponseBody List<CustomColumns> getTableColumn(HttpServletRequest request) 
			throws Exception {
		
		LOG.info("开始获取表的字段信息列表");
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		
		String tableCode = request.getParameter("tableCode");// 表编码
		
		List<CustomColumns> list = null;
			
		try {
			list = customColumnsService.queryTableColumnList(tableCode);
		} catch (Exception e) {
			LOG.error("获取表的字段信息列表异常", e);
			throw new BizException(BizException.FAILURE, "获取表的字段信息列表异常");
		}
		
		LOG.info("获取表的字段信息列表结束");
		
		return list;
		
	}
    
    /**
     * 获取对象指定成员变量的值
     * @param obj
     * 			对象
     * @param PropertyName
     * 			成员变量名称
     * @return Object 
     * 			成员变量值
     * @throws IllegalArgumentException
     * @throws IllegalAccessException
     * @throws NoSuchFieldException
     * @throws SecurityException
     */
    private Object getProperty(Object obj, String PropertyName) 
    		throws IllegalArgumentException, IllegalAccessException, 
    		NoSuchFieldException, SecurityException {
    	if (obj == null) {
    		return null;
    	}
    	Class<? extends Object> c = obj.getClass();
    	Field f = c.getDeclaredField(PropertyName);
		//取消语言访问检查
		f.setAccessible(true);
    	return f.get(obj);
    }
    
    /**
     * 设置对象指定成员变量的值
     * @param obj
     * 			对象
     * @param PropertyName
     * 			成员变量名称
     * @param value
     * 			成员变量值
     * @throws NoSuchFieldException
     * @throws SecurityException
     * @throws IllegalArgumentException
     * @throws IllegalAccessException
     */
    @SuppressWarnings("unused")
	private void setProperty(Object obj, String PropertyName, Object value) 
			throws NoSuchFieldException, SecurityException, 
			IllegalArgumentException, IllegalAccessException {
		// 获取obj类的字节文件对象
		Class<? extends Object> c = obj.getClass();
		// 获取该类的成员变量
		Field f = c.getDeclaredField(PropertyName);
		// 取消语言访问检查
		f.setAccessible(true);
		// 给变量赋值
		f.set(obj, value);
	}
    
    /**
     * 判断查询日期是否在正确的区间</br>
     * 正确日期小于等于当前日期并且大于五年前日期
     * @param acctCycle
     * 				查询日期
     * @return true：正确</br>false：错误
     * @throws ParseException
     */
	private boolean isTrueInterval(String acctCycle) 
			throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat(DateUtil.DATEFORMAT2);
		Date date = sdf.parse(acctCycle); //查询日期
	    Calendar calendar = Calendar.getInstance(); //日历  
	    Date nowDate = new Date();
	    calendar.setTime(nowDate);
	    Date endDate = calendar.getTime(); 
	    calendar.add(Calendar.YEAR, -5);
	    Date beginDate = calendar.getTime();
	    if (sdf.parse(sdf.format(beginDate)).getTime() 
	    		< sdf.parse(sdf.format(date)).getTime() 
	    		&& 
	    		sdf.parse(sdf.format(date)).getTime() 
	    		<= sdf.parse(sdf.format(endDate)).getTime()) {
	    	return true;
	    }else {
	    	return false;
	    }
	}
	
    /**
     * 获取自定义表信息列表
     * @param request
     * @return
     * @throws BizException
     */
	@RequestMapping("/getCustomTableList.do")
	public @ResponseBody List<CustomColumns> getCustomTableList(
			HttpServletRequest request) throws BizException {
		LOG.info("开始获取自定义表信息列表");
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session
				.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == operator || StringUtils.isEmpty(operator.getOperId())) {
			return null;
		}
		//String operId = operator.getOperId(); //获取操作用户ID
		
		List<CustomColumns> list = null;
		
		try {
			list = customColumnsService.queryCustomTableList();
		} catch (Exception e) {
			LOG.error("获取自定义表信息列表异常", e);
			throw new BizException(BizException.FAILURE, "获取自定义表信息列表异常");
		}
		
		LOG.info("获取自定义表信息列表结束");
		return list;
	}
    
}

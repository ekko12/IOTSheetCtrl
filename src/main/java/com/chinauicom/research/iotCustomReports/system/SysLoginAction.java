package com.chinauicom.research.iotoperation.system;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.chinauicom.research.commons.Message;
import com.chinauicom.research.commons.constant.WcsSessionConstant;
import com.chinauicom.research.commons.define.WcsDefinition;
import com.chinauicom.research.iotoperation.system.log.entity.SysLoginLog;
import com.chinauicom.research.iotoperation.system.log.service.SysLoginLogService;
import com.chinauicom.research.iotoperation.system.operator.entity.SysOperator;
import com.chinauicom.research.iotoperation.system.operator.service.SysOperatorService;


//import com.tydic.dbs.order.web.action.OrderAction;

/**
 * 
 * @ClassName: SysLoginAction 
 * @Description: TODO(后台用户登录控制) 
 * @author huangChuQin
 * @date 2016-7-18 上午10:27:17 
 *
 */
@Controller
@RequestMapping("/sysLogin")
public class SysLoginAction {

	@Autowired
	private SysOperatorService sysOperatorService;
	@Autowired
	private SysLoginLogService sysLoginLogService;

	protected final  Logger log = LoggerFactory.getLogger(this.getClass());
	/**
	 * 跳转到系统登录页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toLogin.do")
	public String toLogin(HttpServletRequest request) throws Exception{
		return "system/login/login";
	}
	
	/**
	 * 后台用户登录
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	@RequestMapping("/checkSysLogin.do")
	public @ResponseBody
	Message checkSysLogin(HttpServletRequest request, HttpServletResponse response,
			SysOperator operator) throws Exception {
		Message msg = new Message();
		//页面传过来的用户信息为空，直接返回
		if (null == operator) {
			msg.setFlag(false);
			msg.setMsg("登录失败，请联系管理员。");
			return msg;
		}
		HttpSession session = request.getSession();
		/**用户信息验证*/
		final String ipAddr = getIpAddr(request);
		log.debug("----------ipAddr:"+ipAddr);   
//		final String macAddr = getMacAddress(ipAddr);
		Map<String, Object> hash = sysOperatorService.validateOperLogin(operator.getOperAccount(), operator.getOperPwd(), ipAddr, "");
		//数据库没有查询到对应的用户数据，直接返回
		if (null == hash || hash.isEmpty()) {
			msg.setFlag(false);
			msg.setMsg("登录失败，请联系管理员。");
			return msg;
		}
		final String state = (String) hash.get("state");
		if (!StringUtils.isNotEmpty(state) || !state.equals(WcsDefinition.wcsOperatorStatus.NORMAL)) {
			msg.setFlag(false);
			msg.setMsg((String) hash.get("message"));
			return msg;
		}
		msg.setFlag(true);
		/**操作员数据*/
		operator = (SysOperator) hash.get(WcsSessionConstant.SESSION_OPERATOR);
		/**设置登录日志ID到session中*/
		session.setAttribute(WcsSessionConstant.SESSION_LOGIN_LOG_ID, hash.get(WcsSessionConstant.SESSION_LOGIN_LOG_ID));
		/**设置用户信息到session中*/
		session.setAttribute(WcsSessionConstant.SESSION_OPERATOR, operator);
		/**END*/
		return msg;
	}
	
	/**
	 * 获取客户端ip地址
	 * @param request
	 * @return
	 */
	private static String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
	     }  
         //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割  
        if(ip!=null && ip.length()>15){ 
             if(ip.indexOf(",")>0){  
            	 ip = ip.substring(0,ip.indexOf(","));  
               }  

		}
		return ip;
	}
	
	/**
	 * 根据ip地址获取mac地址
	 * @param remotePcIP
	 * @return
	 */
	private static String getMacAddress(String remotePcIP){
		String str="";
		String macAddress="";
		try {
			Process pp= Runtime.getRuntime().exec ("nbtstat -A " + remotePcIP);
			InputStreamReader ir = new InputStreamReader(pp.getInputStream());
			LineNumberReader input = new LineNumberReader (ir);
			for (int i = 1; i <100; i++) {
				str=input.readLine();
				if (str!=null) {
					if(str.indexOf("MAC Address")>1){ 
						macAddress=str.substring(str.indexOf("MAC Address")+14,str.length());
						break;
					}
				}
			}
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return macAddress;
	}
	
	/**
	 * 注销系统
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/cancellation.do")
	public void cancellation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		final String context = request.getContextPath();
		if (null == session)
			response.sendRedirect(context+"/sysLogin/toLogin.do");
			
		final String logId = (String) session.getAttribute(WcsSessionConstant.SESSION_LOGIN_LOG_ID);
		//日志记录
		SysLoginLog log = sysLoginLogService.get(Long.valueOf(logId));
		log.setLogoutTime(Calendar.getInstance().getTime());
		sysLoginLogService.save(log, 1);
		
		session.invalidate();//清空session
		response.sendRedirect(context+"/sysLogin/toLogin.do");
	}
	
}

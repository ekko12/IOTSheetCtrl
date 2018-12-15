package com.chinauicom.research.iotoperation.system.role;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.chinauicom.research.commons.Message;
import com.chinauicom.research.commons.constant.WcsSessionConstant;
import com.chinauicom.research.commons.define.WcsDefinition;
import com.chinauicom.research.commons.utils.Page;
import com.chinauicom.research.iotoperation.system.menu.entity.SysFunOperate;
import com.chinauicom.research.iotoperation.system.menu.service.SysFunOperateService;
import com.chinauicom.research.iotoperation.system.operator.entity.SysOperator;
import com.chinauicom.research.iotoperation.system.role.entity.SysRole;
import com.chinauicom.research.iotoperation.system.role.service.SysRoleService;


/**
 * 
 * @ClassName: SysRoleAction 
 * @Description: TODO(角色管理控制类) 
 * @author huangChuQin
 * @date 2016-7-26 下午7:46:40 
 *
 */
@Controller
@RequestMapping("/sysRole")
public class SysRoleAction  {
	
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private SysFunOperateService sysFunOperateService;
	/**
	 * 跳转到角色列表页面
	 */
	@SuppressWarnings("static-access")
	@RequestMapping("/toRoleList.do")
	public String toRoleList(HttpServletRequest request) throws Exception {
		Map<String, String> statusHash = WcsDefinition.WcsCommonStatus.WCS_COMMON_STATUS_MAP;
		HttpSession session = request.getSession();
		SysOperator operator = (SysOperator) session.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		List<SysFunOperate> funOperateList = sysFunOperateService.getHasAuthFunOperateByMenuCodeAndOperId("SYS_USER_ROLE", operator.getOperId());
		request.setAttribute("statusHash", statusHash);
		request.setAttribute("funOperateList", funOperateList);
		return "system/role/roleList";
	}
	
	/**
	 * 角色列表页数据查询函数
	 * @param request
	 * @param response
	 * @param page
	 * @param rows
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/getRoleList.do")
	public @ResponseBody Map<String, Object> getRoleList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		String roleName1 = request.getParameter("roleName");
		if (StringUtils.isNotEmpty(roleName1)){
			roleName1 = roleName1.replaceAll("%", "\\\\%");
			roleName1 = roleName1.replaceAll("_", "\\\\_");
		}
		String roleCode1 = request.getParameter("roleCode");
		if (StringUtils.isNotEmpty(roleCode1)){
			roleCode1 = roleCode1.replaceAll("%", "\\\\%");
			roleCode1 = roleCode1.replaceAll("_", "\\\\_");
		}
		final String roleName = roleName1;
		final String roleCode = roleCode1;
		final String status = request.getParameter("status");
		final String page = request.getParameter("page");
		params.put(Page.CURR_PAGE, Integer.parseInt(page));
		params.put(Page.PAGE_SIZE, Page.DEFAULT_PAGE_SIZE);
		if (StringUtils.isNotEmpty(roleName))
			params.put("roleNameLike", roleName);
		if (StringUtils.isNotEmpty(roleCode))
			params.put("roleCode", roleCode);
		if (StringUtils.isNotEmpty(status))
			params.put("status", status);
		List<Map<String, Object>> orderBy = new ArrayList<Map<String, Object>>();
    	Map<String, Object> hash = new HashMap<String, Object>();
    	hash.put("createTime", "desc");
    	orderBy.add(hash);
    	params.put("orderBy", orderBy);

		Page sysRolePage = sysRoleService.getPageByParamMap(params);
		List<SysRole> sysRoleList = sysRolePage.getList();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalNumber", sysRolePage.getTotalNumber());
		map.put("totalPage", sysRolePage.getTotalPage());
		map.put("rows", sysRoleList);
		return map;
	}
	
	@RequestMapping("/toDetail.do")
	public @ResponseBody SysRole toDetail(HttpServletRequest request, String roleCode)throws Exception {
		SysRole role = new SysRole();
		try {
			role = sysRoleService.get(roleCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return role;
	}
	
	/**
	 * 角色新增、编辑、详情查询页面跳转
	 * @param request
	 * @throws Exception
	 */
	@SuppressWarnings({ "static-access" })
	@RequestMapping("/toPage.do")
	public String toPage(HttpServletRequest request, String operType, 
			String roleCode, String page) throws Exception {
		Map<String, String> statusHash = WcsDefinition.WcsCommonStatus.WCS_COMMON_STATUS_MAP;
		request.setAttribute("statusHash", statusHash);
		
		/*角色类型*/
		Map<String , String> roleTypeMap = WcsDefinition.WcsRoleType.WCS_ROLE_TYPE_MAP;
		Map<String , String> newRoleTypeMap = new HashMap<String , String>();
		for(String key : roleTypeMap.keySet()){
			if(!key.equals(WcsDefinition.WcsRoleType.WCS_ROLE_TYPE_SYSTEM)){
				newRoleTypeMap.put(key, roleTypeMap.get(key));
			}
		}
		
		if (StringUtils.isNotEmpty(operType) && operType.equals("add")) {
			request.setAttribute("roleTypeMap", newRoleTypeMap);
			//角色新增
			return "system/role/roleAdd";
		} else if (StringUtils.isNotEmpty(operType) && operType.equals("edit")) {
			//角色编辑
			SysRole role = sysRoleService.get(roleCode);
			request.setAttribute("role", role);
			
			//如果当前角色的类型为系统管理员,则map中只有一个系统管理员的元素 
			if(WcsDefinition.WcsRoleType.WCS_ROLE_TYPE_SYSTEM.equals(role.getRoleType())){
				newRoleTypeMap = new HashMap<String , String>();
				newRoleTypeMap.put(WcsDefinition.WcsRoleType.WCS_ROLE_TYPE_SYSTEM, 
						roleTypeMap.get(WcsDefinition.WcsRoleType.WCS_ROLE_TYPE_SYSTEM));
			}
			request.setAttribute("roleTypeMap", newRoleTypeMap);
			return "system/role/roleEdit";
		} else {
			//角色查询
			SysRole role = sysRoleService.get(roleCode);
			request.setAttribute("role", role);
			return "system/role/roleDetail";
		}
	}
	
	/**
	 * 角色信息新增、修改
	 * @throws Exception
	 */
	@RequestMapping("/roleSaveOrUpdate.do")
	public @ResponseBody
	Message roleSaveOrUpdate(HttpServletRequest request, SysRole role, String type) throws Exception {
		Message msg = new Message();
		try {
			HttpSession session = request.getSession();
			SysOperator operator = (SysOperator) session.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
			String menuParams1 = request.getParameter("menuParams");
			String btnParams1 = request.getParameter("btnParams");
			String[] menuParams = {};
			String[] operateCode = {};
			Map<String,String[]> menuAndOperateCodeMap = null;
			
			if (menuParams1!=""&&!"".equals(menuParams1)) {
				menuParams = menuParams1.split(" ");
			}
			if (btnParams1!=""&&!"".equals(btnParams1)) {
				//params["btnParams"]=btnParams;
				Gson gson = new Gson();
				menuAndOperateCodeMap = gson.fromJson(btnParams1, new TypeToken<Map<String,String[]>>() {
				}.getType());
			}
			
			if (StringUtils.isNotEmpty(type) && type.equals("add")) {
				//新增角色
				role.setCreater(operator.getOperId());
				role.setCreateTime(Calendar.getInstance().getTime());
				
				SysRole sysRole = sysRoleService.get(role.getRoleCode());
				if(sysRole != null){
					msg.setFlag(false);
					msg.setMsg("角色编码 "+ role.getRoleCode() +" 已经被使用！");
					return msg;
				}
				sysRoleService.save(role, menuParams, menuAndOperateCodeMap, type);
//				sysRoleService.save(role, menuParams, operateCode, type);
				msg.setFlag(true);
				msg.setMsg("新增角色信息成功");
			} else {
				//修改角色
				role.setModifier(operator.getOperId());
				role.setModifyTime(Calendar.getInstance().getTime());
				sysRoleService.save(role, menuParams, menuAndOperateCodeMap, type);
				msg.setFlag(true);
				msg.setMsg("修改角色信息成功");
			}
		} catch (Exception e) {
			msg.setFlag(false);
			msg.setMsg("操作异常");
		}
		return msg;
	}
	
	/**
	 * 
	 * @Title: delRole 
	 * @Description: TODO(删除一条角色信息) 
	 * @param @param request
	 * @param @param response
	 * @param @return    设定文件 
	 * @return Message    返回类型 
	 * @throws
	 */
	@RequestMapping("/delRole.do")
	public @ResponseBody Message delRole(HttpServletRequest request, HttpServletResponse response){
		Message msg = new Message();
		HttpSession session = request.getSession();
		SysOperator user = (SysOperator) session.getAttribute(WcsSessionConstant.SESSION_OPERATOR);
		if (null == user) {
			msg.setFlag(false);
			msg.setMsg("删除角色信息失败！");
			return msg;
		}
		final String roleCode = request.getParameter("roleCode");
		if (null == roleCode||"".equals(roleCode)) {
			msg.setFlag(false);
			msg.setMsg("删除角色信息失败！");
			return msg;
		}
		try {
			boolean falg = sysRoleService.delete(roleCode);
			if (falg) {
				msg.setFlag(true);
				msg.setMsg("成功删除角色信息！");
				return msg;
			}else{
				msg.setFlag(false);
				msg.setMsg("删除角色信息失败！");
				return msg;
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg.setFlag(false);
			msg.setMsg("系统异常，操作失败！");
			return msg;
		}
	}
}

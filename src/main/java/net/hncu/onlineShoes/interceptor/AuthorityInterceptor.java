package net.hncu.onlineShoes.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.util.BitUtil;

public class AuthorityInterceptor implements HandlerInterceptor{
	private static Logger logger = Logger.getLogger(AuthorityInterceptor.class);
	private static Map<String, Integer> uriMapping;
	static {
		uriMapping = new HashMap<>();
		uriMapping.put("product", User.Flag.PRODUCT_MANAGER);
		uriMapping.put("member", User.Flag.MEMBER_MANAGER);
		uriMapping.put("order", User.Flag.ORDER_MANAGER);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		String uri = request.getRequestURI();
		String referer = request.getHeader("Referer");
		
		boolean canIn = true;
		
		if(user == null && !canInNoLogin(uri)) { //用户未登录进行控制
			canIn = false;
		}
		if(uri.indexOf("/adm") >= 0 && !canInAdm(user, uri)) { //进行adm路径权限认证
			canIn = false;
		}
		if(!canIn) {
			logger.info(request.getRemoteAddr()+" 访问: "+uri);
			if(referer != null && !referer.isEmpty() && !referer.endsWith(uri)) {
				response.sendRedirect(referer);
			}else {
				response.sendRedirect(request.getContextPath()+"/");
			}
		}
		return canIn;
	}
	/**
	 * 未登录禁止进入的uri
	 */
	private static String[] noLoginBanUri;
	static {
		noLoginBanUri = new String[] {
			"/basket",
			"/buy",
			"/adm",
			"/order",
		};
	}
	private boolean canInNoLogin(String uri) {
		if(uri == null) 
			return false;
		for (String str: noLoginBanUri) {
			if(uri.indexOf(str) >= 0) {
				return false;
			}
		}
		return true;
	}

	private boolean canInAdm(User user, String uri) {
		if(user == null || uri == null) 
			return false;
		Integer flag = user.getFlag();
		if(BitUtil.hasBit(flag, User.Flag.SUPER_MANAGER)) 
			return true;
		
		String[] strs = uri.split("/");
		if(strs != null && strs.length > 2) {
			String key = strs[2];
			Integer _flag = uriMapping.get(key);
			return BitUtil.hasBit(flag, _flag);
		} else {
			 return true;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}

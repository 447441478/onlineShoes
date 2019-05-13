package net.hncu.onlineShoes.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import net.hncu.onlineShoes.domain.User;

public class AuthorityInterceptor implements HandlerInterceptor{
	private static Logger logger = Logger.getLogger(AuthorityInterceptor.class);
	private static int[] admFlags;
	static {
		admFlags = new int[] {
			User.Flag.PRODUCT_MANAGER,
			User.Flag.MEMBER_MANAGER,
			User.Flag.ORDER_MANAGER,
			User.Flag.SUPER_MANAGER
		};
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
		
		if(uri.indexOf("/adm") > 0 && !canInAdm(user)) { //进行adm路径权限认证
			canIn = false;
		}
		if(!canIn) {
			logger.info(request.getRemoteAddr()+" 访问: "+uri);
			if(referer != null && !referer.isEmpty() && !referer.endsWith(uri)) {
				response.sendRedirect(referer);
			}else {
				response.sendRedirect(request.getContextPath());
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
			if(uri.indexOf(str) > 0) {
				return false;
			}
		}
		return true;
	}

	private boolean canInAdm(User user) {
		if(user == null) 
			return false;
		Integer flag = user.getFlag();
		if(flag == null) {
			return false;
		}
		for (int i : admFlags) {
			if((flag & i) == i) {
				return true;
			}
		}
		return false;
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

package net.hncu.onlineShoes.util;

import javax.servlet.http.HttpServletRequest;

import com.mchange.util.AssertException;

/**
 * 该工具需要配合 tomcat/conf/Servlet.xml 文件<br/>
 * 在项目主机即<host>标签内配置一个虚拟路径，用来存放上传的文件，如 ：<br/>
 * &ltContext docBase="product" path="/onlineShoes/product" reloadable="true"/&gt
 * @author 宋进宇
 */
public class FileUtil {
	public static final String PRODUCT_PATH = "/product";
	public static final String[] imgSuffixs = {".jpg",".jpeg",".png",".pic",".bmp"};
	 
	private FileUtil() {
		throw new AssertException();
	}
	public static String getProductRootRealPath(HttpServletRequest req) {
		String webPath = req.getServletContext().getRealPath("");
		return webPath.substring(0, webPath.lastIndexOf("\\")) + PRODUCT_PATH;
	}
	public static String getImgSuffix(String imgName) {
		String imgSuffix = null;
		for (String suffix : imgSuffixs) {
			if(imgName.endsWith(suffix)) {
				imgSuffix = suffix;
				break;
			}
		}
		return imgSuffix;
	}
}

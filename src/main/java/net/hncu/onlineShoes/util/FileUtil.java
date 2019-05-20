package net.hncu.onlineShoes.util;

import java.io.FileOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.mchange.util.AssertException;

/**
 * 该工具需要配合 tomcat/conf/Servlet.xml 文件<br/>
 * 在项目主机即<host>标签内配置一个虚拟路径，用来存放上传的文件，如 ：<br/>
 * &ltContext docBase="product" path="/product" reloadable="true"/&gt
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
	/**
	 * 生成 Execel  .xlsx  格式
	 * @param sheetNames  页   不能重复
	 * @param titles  标题
	 * @param values  具体值
	 * @return
	 */
	public static XSSFWorkbook generatorXlsx(String[] sheetNames, String[] titles, String[][] values) {
		if(sheetNames == null || titles == null || values == null) {
			return null;
		}
		XSSFWorkbook workBook = new XSSFWorkbook();
		//表头单元格风格: 文本居中 + 字体加粗
		XSSFCellStyle titleCellStyle = workBook.createCellStyle();
		//文本居中
		titleCellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		XSSFFont titleCellFont = workBook.createFont();
		titleCellFont.setBold(true);
		titleCellStyle.setFont(titleCellFont);
		
		for (String sheetName : sheetNames) {
			XSSFSheet sheet = workBook.createSheet(sheetName);
			//生成表头行
			XSSFRow titleRow = sheet.createRow(0);
			for (int i = 0; i < titles.length; i++) {
				XSSFCell cell = titleRow.createCell(i);
				cell.setCellStyle(titleCellStyle);
				cell.setCellValue(titles[i]);
			}
			//生成内容
			for (int i = 0; i < values.length; i++) {
				XSSFRow row = sheet.createRow(i+1);
				if(values[i] == null) {
					continue;
				}
				for (int j = 0; j < values[i].length; j++) {
					XSSFCell cell = row.createCell(j);
					cell.setCellValue(values[i][j]);
				}
			}
			
		}
		return workBook;
	}
	
	public static void main(String[] args) throws Exception {
		String[] sheetNames = {"sheet1", "sheet2"};
		String[] titles = {"name", "age"};
		String[][] values = {{"杰克","22"},{"rose","18"}};
		XSSFWorkbook workBook = generatorXlsx(sheetNames, titles, values);
		workBook.write(new FileOutputStream("d:/a/t.xlsx"));
		
	}
	
}

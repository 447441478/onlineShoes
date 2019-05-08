package net.hncu.onlineShoes.util;
 
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;
 
import javax.imageio.ImageIO;
 
public class CheckCodeGenerator {
	private static final Random random = new Random( System.currentTimeMillis() );
	private static final String[] codes = {"0","1","2","3","4","5",
									 "6","7","8","9","A","B",
									 "C","D","E","F","G","H",
									 "I","J","K","L","M","N",
									 "O","P","Q","R","S","T",
									 "U","V","W","X","Y","Z" };
	/**
	 * 产生一个图片验证码，并且返回以字符串表示的验证码
	 * @param height 图片的高度
	 * @param out 把验证码图片通过out对象输出
	 * @return 字符串的验证码
	 * @throws IOException
	 */
	public static String CheckCodeOfImgCanRotate( int height,OutputStream out) throws IOException {
		//用来校验的验证码
		String checkCode = "";
		//计算宽度
		int width = 3*height;
		
		//1. 先创建一个BufferedImage对象
		BufferedImage bufImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		//2. 获取Graphics对象
		Graphics g = bufImg.getGraphics();
		//3. 把Graphics对象强转成Graphics2D,用到旋转与缩放
		Graphics2D g2d = (Graphics2D) g;
		
		//设置验证码字体
		int size = height>>1; //字体大小位高度的1/2	
		Font font = new Font("微软雅黑", Font.BOLD, size);
		g2d.setFont(font);
		
		int offset = size; //第一个字符的偏移量
		
		//以白色填充背景
		g2d.setColor( Color.WHITE );
		g2d.fillRect(0, 0, width, height);
		
		//生成4位验证码
		for(int i = 0; i < 4; i++ ) {
			String str = codes[random.nextInt( codes.length )];
			checkCode += str;
			//产生随机颜色
			Color c = new Color( random.nextInt(200),random.nextInt(200), random.nextInt(200) );
			g2d.setColor(c);
			//创建变换对象
			AffineTransform aff = new AffineTransform();
			//设置好变化规则
			aff.rotate(Math.random()*Math.PI, offset+ (i+0.5)*size, height/2);
			g2d.setTransform( aff );
			
			g2d.drawString(str, offset + i*size, height );
		}
		//清空变化
		g2d.setTransform( new AffineTransform() );
		//产生干扰线
		for (int i = 0; i < 3; i++) {
			//产生随机颜色
			Color c = new Color( random.nextInt(200),random.nextInt(200), random.nextInt(200) );
			g2d.setColor(c);
			//画干扰线
			g2d.drawLine(random.nextInt(height), random.nextInt(height),(height<<1) + random.nextInt(height),random.nextInt(height));
		}
		
		g2d.dispose();
		
		ImageIO.write(bufImg, "JPEG", out);
		
		return checkCode;
	}
	/**
	 * 通过 height 生成一张验证码图片，验证码具有上下浮动特性，最后通过out输出
	 * @param height 图片高度
	 * @param out 字节输出流
	 * @return 验证码的码值
	 * @throws IOException
	 */
	public static String CheckCodeOfImgCanFolat( int height,OutputStream out) throws IOException {
		//用来校验的验证码
		String checkCode = "";
		//计算宽度
		int width = height<<1; //宽度为高度的2倍
		
		int offset = height>>2; //第一个字符的偏移量
		
		//1. 先创建一个BufferedImage对象
		BufferedImage bufImg = new BufferedImage(width+offset, height, BufferedImage.TYPE_INT_RGB);
		
		//2. 获取Graphics对象
		Graphics g = bufImg.getGraphics();
		
		//设置验证码字体
		int size = height>>1;	
		Font font = new Font("微软雅黑", Font.BOLD, size);
		g.setFont(font);
		
		//以白色填充背景
		g.setColor(new Color(247, 246, 246));
		g.fillRect(0, 0, width+offset, height);
		
		//生成4位验证码
		for(int i = 0; i < 4; i++ ) {
			String str = codes[random.nextInt( codes.length )];
			checkCode += str;
			//产生随机颜色
			Color c = new Color( random.nextInt(200),random.nextInt(200), random.nextInt(200) );
			g.setColor(c);
			
			g.drawString(str, offset + i*size, size+random.nextInt(size) );
		}
		//产生干扰线
		for (int i = 0; i < 3; i++) {
			//产生随机颜色
			Color c = new Color( random.nextInt(200),random.nextInt(200), random.nextInt(200) );
			g.setColor(c);
			//画干扰线
			g.drawLine(random.nextInt(height), random.nextInt(height),(height<<1) + random.nextInt(height),random.nextInt(height));
		}
		
		g.dispose(); //销毁g对象，该方法内部会调用把内存中的数据全部刷到bufImg对象中
		
		ImageIO.write(bufImg, "JPEG", out);
		
		return checkCode;
	}
	/**
	 * 产生一个高度为32px的验证码图片（默认选取上下浮动类型），并且通过out流输出
	 * @param out 字节输出流
	 * @return 验证码的码值
	 * @throws IOException
	 */
	public static String CheckCodeOfImg(OutputStream out) throws IOException {
		return CheckCodeOfImgCanFolat(32, out);
	}
}

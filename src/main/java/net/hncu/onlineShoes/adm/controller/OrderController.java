package net.hncu.onlineShoes.adm.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import net.hncu.onlineShoes.domain.OrderDetail;
import net.hncu.onlineShoes.domain.OrderDetailExample;
import net.hncu.onlineShoes.domain.OrderDetailExample.Criteria;
import net.hncu.onlineShoes.domain.OrderDetailMapper;
import net.hncu.onlineShoes.domain.ShoesMapper;
import net.hncu.onlineShoes.domain.User;
import net.hncu.onlineShoes.user.controller.UserController;
import net.hncu.onlineShoes.util.BitUtil;
import net.hncu.onlineShoes.util.DateUtil;
import net.hncu.onlineShoes.util.FileUtil;
import net.hncu.onlineShoes.util.Msg;

@RequestMapping("/adm/order")
@Controller
public class OrderController {
	private static final String ROOT = "adm/order/";
	private static final Logger LOG = Logger.getLogger(OrderController.class);
	
	@Autowired
	OrderDetailMapper orderDetailMapper;
	@Autowired
	ShoesMapper shoesMapper;
	
	@RequestMapping(path="/manageOrder",method=RequestMethod.GET)
	public String index(HttpSession session,Model model) throws JsonProcessingException {
		User user = UserController.getUser(session);
		LOG.info("userId:" + user.getUserId());
		List<OrderDetail> orderDetails = orderDetailMapper.selectByExampleWithShoes(new OrderDetailExample());
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("orderDetails", om.writeValueAsString(orderDetails));
		return ROOT + "/manageOrder";
	}
	@RequestMapping(path="/get",method=RequestMethod.GET)
	@ResponseBody
	public Msg get(@RequestParam(name="currentPage", defaultValue="1") Integer currentPage, 
			@RequestParam(name="pageSize", defaultValue="10") Integer pageSize, 
			@RequestParam(name="payMethod", defaultValue="-1") Integer payMethod, 
			@RequestParam(name="keyWord", defaultValue="") String keyWord,
			@RequestParam(name="startTime", defaultValue="0") Long startTime,
			@RequestParam(name="endTime", defaultValue="0") Long endTime,
			@RequestParam(name="flag", defaultValue="-1") Integer flag,
			HttpSession session) {
		User user = UserController.getUser(session);
		if(user == null) {
			return Msg.fail();
		}
		PageHelper.startPage(currentPage,pageSize);
		if(!DateUtil.isBefore(startTime, endTime)) {
			return Msg.fail(); 
		}
		String st = null;
		String et = null;
		try {
			st = DateUtil.getDayFirstSeconds(startTime);
			et = DateUtil.getDayLastSeconds(endTime);
		} catch (Exception e) {
			e.printStackTrace();
			return Msg.fail();
		}
		
		OrderDetailExample orderDetailExample = new OrderDetailExample();
		Criteria criteria = orderDetailExample.createCriteria();
		criteria.andShoesNameLike(keyWord);
		if (payMethod != -1) {
			if(payMethod == OrderDetail.Paymethod.ONLINE_PAY) {
				criteria.andPaymethodBitAnd(OrderDetail.Paymethod.ONLINE_PAY);
			}else {
				criteria.andPaymethodEqualTo(OrderDetail.Paymethod.DEFAULT);
			}
		}
		if(flag != -1) {
			criteria.andFlagEqualTo(flag);
		}
		criteria.andCreateTimeBetween(DateUtil.stringConversionDateTime(st), DateUtil.stringConversionDateTime(et));
		List<OrderDetail> orderDetails = orderDetailMapper.selectByExampleWithShoes(orderDetailExample);
		PageInfo<OrderDetail> pageInfo = new PageInfo<OrderDetail>(orderDetails);
		return Msg
				.success()
				.add("orderDetails", pageInfo.getList())
				.add("total", pageInfo.getTotal())
				.add("keyWord", keyWord)
				.add("payMethod",payMethod)
				.add("startTime", startTime)
				.add("endTime", endTime)
				;
	}
	
	@RequestMapping(path="/sendGoods",method=RequestMethod.GET)
	public String sendGoods() {
		return ROOT + "sendGoods";
	}
	@RequestMapping(path="/sendGoods",method=RequestMethod.POST)
	public Msg sendGoodsUpdate(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId,
			@RequestParam(name="logisticsId",required=true) String logisticsId) {
		OrderDetailExample example = new OrderDetailExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrderDetailIdEqualTo(orderDetailId);
		criteria.andFlagEqualTo(OrderDetail.Flag.INIT);
		OrderDetail record = new OrderDetail();
		record.setLogisticsId(logisticsId);
		record.setFlag(OrderDetail.Flag.DELIVERED);
		orderDetailMapper.updateByExampleSelective(record, example);
		return Msg.success();
	}
	
	@RequestMapping(path="/updateOrder",method=RequestMethod.GET)
	public String updateOrder(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId,
			Model model) throws JsonProcessingException {
		OrderDetail orderDetail = orderDetailMapper.selectByPrimaryKeyWithShoes(orderDetailId);
		ObjectMapper om = new ObjectMapper();
		model.addAttribute("orderDetail", om.writeValueAsString(orderDetail));
		return ROOT + "updateOrder";
	}
	@RequestMapping(path="/updateOrder",method=RequestMethod.POST)
	public Msg updateOrder(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId,
			@RequestParam(name="name",required=true) String name,
			@RequestParam(name="tel",required=true) String tel,
			@RequestParam(name="addr",required=true) String addr) {
		OrderDetailExample example = new OrderDetailExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrderDetailIdEqualTo(orderDetailId);
		criteria.andFlagEqualTo(OrderDetail.Flag.INIT);
		OrderDetail record = new OrderDetail();
		record.setName(name);
		record.setTel(tel);
		record.setAddr(addr);
		orderDetailMapper.updateByExampleSelective(record, example);
		return Msg.success();
	}
	
	@RequestMapping(path="/changeOrderState",method=RequestMethod.POST)
	@ResponseBody
	public Msg changeOrderState(@RequestParam(name="orderDetailId",required=true) Integer orderDetailId,
			@RequestParam(name="flag",required=true)Integer flag,
			@RequestParam(name="newFlag",required=true)Integer newFlag) {
		if(orderDetailId == null || flag == null || newFlag == null) {
			return Msg.fail();
		}
		OrderDetailExample example = new OrderDetailExample();
		Criteria criteria = example.createCriteria();
		criteria.andOrderDetailIdEqualTo(orderDetailId);
		criteria.andFlagEqualTo(flag);
		OrderDetail record = new OrderDetail();
		switch (flag) {
			case OrderDetail.Flag.APPLY_REFUND:
				if( newFlag != OrderDetail.Flag.COMPLETE_REFUND ) {
					newFlag = null;
				}
				break;
			case OrderDetail.Flag.ACCEPTED:
				if( newFlag != OrderDetail.Flag.COMPLETE_TRANSACTION ) {
					newFlag = null;
				}
				break;
			default:
				newFlag = null;
		}
		if(newFlag != null) {
			record.setFlag(newFlag);
			orderDetailMapper.updateByExampleSelective(record, example);
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}
	
	@RequestMapping(path="/download", method=RequestMethod.GET)
	public void download(@RequestParam(name = "orderDetailIds[]", required=false) Integer[] orderDetailIds,
			HttpServletResponse response) throws IOException {
		LOG.info("导出Execel");
		String dateStr = DateUtil.dateConversionString(new Date());
		String filename = "订单-"+dateStr+".xlsx";
		response.setHeader("Content-Type", "application/force-download");
		response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(filename, "utf-8"));
		List<OrderDetail> orderDetails = null;
		if (orderDetailIds != null && orderDetailIds.length > 0) {
			OrderDetailExample example = new OrderDetailExample();
			example.createCriteria().andOrderDetailIdIn(Arrays.asList(orderDetailIds));
			orderDetails = orderDetailMapper.selectByExampleWithShoes(example);
		}else {
			orderDetails = orderDetailMapper.selectByExampleWithShoes(null);
		}
		String[] sheetNames = {"订单明细"};
		String[] titles = {
				"订单编号",
				"下单时间",
				"产品名称",
				"尺码",
				"单价",
				"数量",
				"小计",
				"姓名",
				"手机",
				"地址",
				"支付方式",
				"物流单号",
				"订单状态",
			};
		String[][] values = getValues(titles, orderDetails);
		XSSFWorkbook workbook = FileUtil.generatorXlsx(sheetNames, titles, values);
		workbook.write(response.getOutputStream());
		response.getOutputStream().flush();
	}
	private String[][] getValues(String[] titles, List<OrderDetail> orderDetails) {
		String[][] values = new String[orderDetails.size()][titles.length];
		for (int i = 0; i < orderDetails.size(); i++) {
			OrderDetail orderDetail = orderDetails.get(i);
			values[i] = new String[titles.length];
			values[i][0] = ""+orderDetail.getOrderDetailId();
			values[i][1] = ""+DateUtil.dateTimeConversionString(orderDetail.getCreateTime());
			values[i][2] = ""+orderDetail.getShoes().getName();
			values[i][3] = ""+orderDetail.getShoesSize();
			values[i][4] = ""+orderDetail.getPrice();
			values[i][5] = ""+orderDetail.getAmount();
			values[i][6] = ""+(orderDetail.getAmount() * orderDetail.getPrice().doubleValue());
			values[i][7] = ""+orderDetail.getName();
			values[i][8] = ""+orderDetail.getTel();
			values[i][9] = ""+orderDetail.getAddr();
			Integer paymethod = orderDetail.getPaymethod();
			if(paymethod == OrderDetail.Paymethod.DEFAULT) {
				values[i][10] = "货到付款";
			} else {
				values[i][10] = "在线支付/";
				if(BitUtil.hasBit(paymethod, OrderDetail.Paymethod.AL_PAY)) {
					values[i][10] += "支付宝";
				}
				if(BitUtil.hasBit(paymethod, OrderDetail.Paymethod.WX_PAY)) {
					values[i][10] += "微信";
				}
			}
			values[i][11] = orderDetail.getLogisticsId() == null ? "" : ""+orderDetail.getLogisticsId();
			Integer flag = orderDetail.getFlag();
			switch (flag) {
				case OrderDetail.Flag.INIT:
					values[i][12] = "待发货";
					break;
				case OrderDetail.Flag.DELIVERED:
					values[i][12] = "已发货";
					break;
				case OrderDetail.Flag.ACCEPTED:
					values[i][12] = "已签收";
					break;
				case OrderDetail.Flag.APPLY_REFUND:
					values[i][12] = "申请退款";
					break;
				case OrderDetail.Flag.COMPLETE_REFUND:
					values[i][12] = "退款成功";
					break;
				case OrderDetail.Flag.COMPLETE_TRANSACTION:
					values[i][12] = "交易完成";
					break;
				case OrderDetail.Flag.EVALUATED:
					values[i][12] = "已评价";
					break;
				default:
					values[i][12] = "";
					break;
			}
			
		}
		return values;
	}
}

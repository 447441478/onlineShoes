<%@page import="net.hncu.onlineShoes.domain.Shoes"%>
<%@page import="net.hncu.onlineShoes.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加产品</title>
<%@ include file="/inc/admCommon_js_css.jsp.inc" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adm/addProduct.css">
</head>
<body style="overflow-x:hidden;overflow-y:auto;">
	<div class="top_bar">
		<div class="top_bar_title">${shoes == null ? "添加产品":"修改产品"}</div>
	</div>
	<form id="addProduct" style="font-size: 0;" onsubmit="return false;" method="post" enctype="multipart/form-data">
		<div class="clear" style="height:10px;"></div>
		<div class="product">
			<div class="item">
				<div class="leftItem">名称</div>
				<div class="rightItem">
					<input id="name" name="name" v-model="name" maxlength="30">
				</div>
			</div>
			<div class="item">
				<div class="leftItem">品牌</div>
				<div class="rightItem">
					<select name="brand" id="brand" v-model="selected">
						<option v-for="brand in brands" :value="brand.id">{{brand.name}}</option>
					</select>
				</div>
			</div>
			<div class="item">
				<div class="leftItem">进价</div>
				<div class="rightItem">
					<input id="inPrice" name="inPrice" v-model="inPrice">
					<span>{{inPriceTip}}</span>	
				</div>
			</div>
			<div class="item">
				<div class="leftItem">售价</div>
				<div class="rightItem">
					<input id="outPrice" name="outPrice" v-model="outPrice">
				</div>
			</div>
			<div class="item">
				<div class="leftItem">折扣</div>
				<div class="rightItem">
					<input id="ratio" name="ratio"  v-model="ratio">
					<span class="fc-g">98.00表示打98折</span>
				</div>
			</div>
			<div class="item">
				<div class="leftItem">立即上架</div>
				<div class="rightItem">
					<label for="stock_out_no">是<input id="stock_out_no"  type="radio" name="stock_out" v-model="stock_out" :value="stock_out_no"/></label>
					<label for="stock_out_yes">否<input id="stock_out_yes" type="radio" name="stock_out" v-model="stock_out" :value="stock_out_yes"/></label>
				</div>
			</div>
			<div v-if="imgUrl != ''" style="clear:both;height: 100px;line-height: 100px;font-size: 12px;">
				<div style="text-align: right;float:left;width: 30%;margin-right:15px;display: inline-block;">产品图片</div>
				<img style="float:left;height: 100px;" v-if="imgUrl != ''" alt="" :src="imgUrl"/>
			</div>
			<div  class="item">
				<div class="leftItem"><span v-if="imgUrl == ''">产品图片</span></div>
				<div class="rightItem">
					<input class="easyui-filebox" :buttonText="imgUrl == '' ? '选择图片':'替换图片'" name="img" style="width:60%" :accept="imgSuffixs.join(',')">
				</div>
				<div class="leftItem"></div>
				<span class="fc-g">合法后缀：{{imgSuffixs.join("，")}}</span>
			</div>
			
		</div>
		<div class="sizeAndAmount">
			<table id="sizeAndAmountTable">
				<thead>
					<tr>
						<th>尺码</th>
						<th>库存量</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="item,index in sizeAndAmounts">
						<td><input name="sizes" v-model="item.size"/></td>
						<td><input name="amounts" v-model="item.amount"/></td>
						<td>
							<input name="shoesSizeId" v-model="item.shoesSizeId" type="hidden"/>
							<div v-if="index != 0 || item.shoesSizeId!=''" class="delBtn" @click="delsizeAndAmountDom(index)">删除</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="addBtn" @click="addsizeAndAmountDom">+添加</div>
		</div>
		<div class="clear bottomBtn">
			<button class="save" @click="save">保存</button>
		</div>
	</form>
</body>
<script type="text/javascript">
	new Vue({
		el:"#addProduct",
		data:function(){
			return {
				name:"${shoes.name}",
				selected:"${shoes.brandId == null ? 1 : shoes.brandId}",
				brands:[
					{
						id:1,
						name:"Nike",
					},
					{
						id:2,
						name:"Adidas",
					},
					{
						id:3,
						name:"NewBlance",
					},
					{
						id:4,
						name:"Vans",
					},
				],
				inPrice:"${shoes.inPrice}",
				inPriceTip:"",
				outPrice:"${shoes.outPrice}",
				ratio:"${shoes.ratio == null ? "98.00" : shoes.ratio}",
				stock_out:"${shoes.stockOut == null ? 1 : shoes.stockOut}",
				imgUuid:"${shoes.imgUuid}",
				imgSuffix:"${shoes.imgSuffix}",
				stock_out_yes:"1",
				stock_out_no:"0",
				sizeAndAmounts:${sizeAndAmounts == null ? "[{size:39,amount:'',shoesSizeId:''}]" : sizeAndAmounts},
				imgSuffixs:[".jpg",".jpeg",".png",".pic",".bmp"],
			}
		},
		computed:{
			imgUrl:function(){
				if(this.imgUuid != "" && this.imgSuffix != ""){
					return "${productImgRoot}/"+this.imgUuid+this.imgSuffix;
				}else{
					return "";
				}
			},
			watchsizeAndAmounts:function(){
				var that = this;
				var arr = [];
				for(index in that.sizeAndAmounts){
					var obj = {};
					Object.keys(that.sizeAndAmounts[index]).forEach(function(key){
						obj[key] = that.sizeAndAmounts[index][key];
					});
					arr.push(obj);
				}
				return arr;
			}
			
		},
		watch:{
			inPrice:function(newVal,oldVal){
				if(!this.checkPrice(newVal)){
					this.inPrice = oldVal;
				}
			},
			outPrice:function(newVal,oldVal){
				if(!this.checkPrice(newVal)){
					this.outPrice = oldVal;
				}
			},
			ratio:function(newVal,oldVal){
				var reg = /^(((([1-9]\d{0,1}|0)(\.\d{0,2})?)|(100(\.0{0,2})?))?)$/;
				if(!reg.test(String(newVal))){
					this.ratio = oldVal;
				}
			},
			watchsizeAndAmounts:{
				handler:function(newArr,oldArr){
					var reg = /^([1-9]\d?(\.5?)?)?$/;
					var reg2 = /^([1-9]\d{0,10}|0)?$/;
					for(var i = 0; i < newArr.length; i++){
						if(!reg.test(String(newArr[i].size))){
							this.sizeAndAmounts[i].size = oldArr[i].size;
						}
						if(!reg2.test(String(newArr[i].amount))){
							this.sizeAndAmounts[i].amount = oldArr[i].amount;
						}
					}
                },
                deep: true
			}
		},
		methods:{
			checkPrice:function(num){
				var reg = /^(([1-9]\d{0,4}|0)(\.\d{0,2})?)?$/;
				return reg.test(String(num));
			},
			delsizeAndAmountDom:function(index){
				this.sizeAndAmounts.splice(index,1);
				$(".sizeAndAmount .addBtn").css("display","block");
			},
			addsizeAndAmountDom:function(){
				var size = this.sizeAndAmounts[this.sizeAndAmounts.length-1].size+0.5;
				this.sizeAndAmounts.push({size:size,amount:"",shoesSizeId:""});
				if(this.sizeAndAmounts.length >= 10){
					$(".sizeAndAmount .addBtn").css("display","none");
					return;
				}
			},
			replaceImg:function(){
				$("#img").css("display","display");
				$("#img").click();
			},
			save:function(){
				var that = this;
				var oForm = $("#addProduct")[0];
				with(that){
					if(!name){
						alert("产品名称不能为空");
						oForm.name.focus();
						return;
					}
					if(name.length>30){
						alert("产品名称长度不能超过30个字");
						oForm.name.focus();
						return;
					}
					if(!inPrice){
						alert("进价不能为空");
						oForm.inPrice.focus();
						return;
					}
					if(inPrice.length == inPrice.indexOf(".")+1){
						alert("进价格式非法");
						oForm.inPrice.focus();
						return;
					}
					if(!outPrice){
						alert("售价不能为空");
						oForm.outPrice.focus();
						return;
					}
					if(outPrice.length == outPrice.indexOf(".")+1){
						alert("售价格式非法");
						oForm.outPrice.focus();
						return;
					}
					if(this.imgUrl == ""){
						var file = oForm.img.files[0];
						if(!file){
							alert("请选择产品图片");
							return;
						}
						var isImg = false;
						for(var i=0; i<imgSuffixs.length;i++){
							if(file.name.toLocaleLowerCase().endsWith(imgSuffixs[i])){
								isImg = true;
								break;
							}
						}
						if(!isImg){
							alert("请选择后缀为："+imgSuffixs.join("，")+" 的图片");
							return;
						}
					}
					
					for(var i=0;i<this.sizeAndAmounts.length;i++){
						if(!sizeAndAmounts[i].size){
							alert("尺码不能为空");
							oForm.sizes[i].focus();
							return;
						}
						if(!sizeAndAmounts[i].amount){
							alert("库存量不能为空");
							oForm.amounts[i].focus();
							return;
						}
					}
				}
				if(${!empty shoes}){
					oForm.action = "${APP_DIR}/adm/product/update?shoesId=${shoes.shoesId}";
				}
				$(oForm).ajaxSubmit({
					success:function(data){
						if(data.code == <%=Msg.Code.SUCCESS%>){
							location.reload();
						}
						alert(data.info);
					}
				});
			}
		}
	});
</script>
</html>
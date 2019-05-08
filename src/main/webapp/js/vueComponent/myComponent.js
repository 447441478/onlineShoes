/**
 * vue 自定义组件
 */
Vue.component("products-component",{
	props:{'products':Array},
	template:'<div class="products">'+
				'<div v-for="(product,index) in products">'+
					'<div v-if="index%4==0" class="row"></div>'+
					'<div class="col-md-3 product" >'+
						'<a :href="product.jumpUrl" class="thumbnail">'+
							'<img alt="产品" class="productImg" :src="product.imgUrl">'+
						'</a>'+
						'<div class="name" @click="jumpToProductDetail(product.jumpUrl)">{{product.name}}</div>'+
						'<p class="price"><span :class="product.priceStyle">￥{{Number(product.price).toFixed(2)}}</span>&emsp;<span v-if="product.useDiscount" >￥{{product.discountPrice}}</span></p>'+
					'</div>'+
				'</div>'+
			 '</div>'
	,
	methods:{
		jumpToProductDetail:function(url){
			location.href = url;
		},
	},
});

Vue.component("products-pagination",{
	props:['pageInfo'],
	template:'<div style="text-align:center" v-show="totalPage > 1">'+
				 '<ul class="pagination">'+
					'<li @click="pageClick(1)" v-if="pageInfo.currentPage != 1"><a href="javascript:;">首页</a></li>'+
					'<li @click="preClick()" v-if="!preDisabled"><a href="javascript:;" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>'+
					'<li @click="pageClick(page)" v-for="page in pages" :class="{active:pageInfo.currentPage==page}"><a href="javascript:;">{{page}}</a></li>'+
					'<li @click="nextClick()" v-if="!nextDisabled"><a href="javascript:;" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>'+
					'<li @click="pageClick(totalPage)" v-if="pageInfo.currentPage != totalPage"><a href="javascript:;">末页</a></li>'+
				 '</ul>'+
				 '<div style="float:right;margin-right:20px;margin-top:10px;">共:{{pageInfo.total}}条</div>'+
			'</div>'
	,
	computed:{
		preDisabled:function(){
			return this.pageInfo.currentPage == 1;
		},
		nextDisabled:function(){
			return this.pageInfo.currentPage == this.totalPage;
		},
		totalPage:function(){
			return parseInt((this.pageInfo.total-1+this.pageInfo.pageSize)/this.pageInfo.pageSize);
		},
		pages:function(){
			var showSize = this.pageInfo.showSize || 10;
			var totalPage = parseInt((this.pageInfo.total-1+this.pageInfo.pageSize)/this.pageInfo.pageSize);
			var pages=[];
			if(showSize>=totalPage){
				for(var i = 0; i < totalPage; ){
					pages[i] = ++i;
				}
			}else{
				var start = this.pageInfo.currentPage-(showSize+1>>1);
				start = start >= 0 ? start : 0;
				if(start + showSize > totalPage){
					start = totalPage - showSize;
				}
				start ++;
				for(var i = 0; i < showSize; i++){
					pages[i] = start + i;
				}
			}
			return pages;
		}
	},
	methods:{
		preClick:function(){
			if(!this.preDisabled){
				this.pageInfo.currentPage--;
			}
		},
		pageClick:function(page){
			this.pageInfo.currentPage = page;
		},
		nextClick:function(){
			if(!this.nextDisabled){
				this.pageInfo.currentPage++;
			}
		},
	}
});	
		
	
	
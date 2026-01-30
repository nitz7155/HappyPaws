<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	*{box-sizing: border-box;}
	#orderWishCart{
		position: fixed; 
/* 		padding: 10px 20px; */
		border-radius : 5px;
		z-index : 20;
		color : #fff;
		display: none;
	}
	#orderWishCart a.control-button{
		display : flex;
		width : 40px;
		height : 40px;
 		background-color: #fff; 
 		border: 2px solid #fcd11e; 
		border-radius : 50%;
		align-items : center;
		justify-content : center;
		padding : 5px;
		margin-bottom: 5px;
	}
	
	#orderWishCart img.odwsct{
		width : 80%;
		height : 80%;
	}
	
	#orderWishCart .top-controls {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    
	 @media screen and (min-width: 768px) {
        #orderWishCart .top-controls {
            flex-direction: row;
            justify-content: center;
            gap: 10px; /* Add spacing between buttons */
        }

        #orderWishCart a.control-button {
            margin-bottom: 0; /* Remove vertical margin */
        }
        
    }
    
	@media screen and (min-width : 768px){
/* 		#orderWishCart{ */
/* 			top: 120px;  */
/* 		} */
		
	}
	
	@media screen and (max-width : 768px){
/* 		#orderWishCart{ */
/* 			bottom: 30px !important;  */
/* 		}		 */
	}
	</style>
	<script>
	window.onload=function(){
		rightResize();
		window.addEventListener('resize', function(){
			rightResize();
		});
	};
	
	
	function rightResize(){
		if(document.body.clientWidth > 768){
			let divTag = document.querySelector("div.header-login-div");
			let rightVal =  divTag.getClientRects()[0].right -5;
			document.getElementById("orderWishCart").style.left = rightVal+"px";
			document.getElementById("orderWishCart").style.top = "120px";
			document.getElementById("orderWishCart").style.display = "block";
		}else{
			document.getElementById("orderWishCart").style.left = "";
			document.getElementById("orderWishCart").style.top = "";
			document.getElementById("orderWishCart").style.right = "10px";
			document.getElementById("orderWishCart").style.bottom = "20px";
			document.getElementById("orderWishCart").style.display = "block";
		}
	}
	</script>
    <section id="orderWishCart">
		<div class="top">
		    <div class="top-controls">
<!-- 		        <a href="/product/pr_order_list" class="control-button">주문내역/위시리스트</a> -->
<!-- 		        <a href="/product/pr_cart" class="control-button">장바구니</a> -->
		        <a href="/product/pr_order_list" class="control-button"><img src="<%=request.getContextPath()%>/resources/images/Wishlist.png"  alt="위시리스트" class="odwsct"></a>
		        <a href="/product/pr_cart" class="control-button"><img src="<%=request.getContextPath()%>/resources/images/shopping-cart.svg" alt="장바구니" class="odwsct"></a>
		    </div>
		</div>
    </section>
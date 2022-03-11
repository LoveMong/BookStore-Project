<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome! SJBook Store!</title>
<link rel="stylesheet" href="resources/css/search.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
<script src="resources/js/search.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="resources/css/slick.css"/>
<link rel="stylesheet" type="text/css" href="resources/css/slick-theme.css"/>
<style>
	.starR1{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR2{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR1.on{background-position:0 0;}
.starR2.on{background-position:-15px 0;}

.starR1 {
   
    margin-top: -6px;
}

.starR2 {
	 margin-top: -6px;

}


</style>
</head>
<body>

				
<jsp:include page="include/header.jsp"></jsp:include>

<div id="main_contents">
	
	<div id="main_section" class="mt-3">
		<div id="main_container_">
			
			<section class="categories-section mt-5">
				
		

				<div id="main2_1" class="container">
				<!-- 테스트 -->
					<c:if test="${listCnt==0}">
						<br/>
						<br/>
							<div style="text-align:center;">
								<h1>검색된 결과가 없습니다.</h1>
							</div>
						<br/>
						<br/>
					</c:if>
					 	
					 <table>
							<c:forEach items="${bookList}" var="book" varStatus="i">
								
								<tr>
									<td class="table_image" >
										<img src="${book.bk_thumbUrl}" style="width: 130px;height: 195px;">
									</td>
									
									<td id="table_info">
										<div class="title">
											<a href="detail?num=${book.bk_num}">
												<%-- <span class="category">[${book.bk_category}]</span> --%>
												<strong class="mr-1">[<span class="main2_1_box_con_cate" id="cate${i.getIndex() }"></span>]</strong>
												<input type="hidden" id="catenum${i.getIndex() }" value="${book.bk_category }">
												<strong> ${book.bk_name} </strong>
											</a>
										</div>
										<script>
											$(document).ready(function(){ 
												var cateCodeNum = $('#catenum${i.getIndex() }').val();
												var cateNum = parseInt(cateCodeNum);
												var category = cateSwitch(cateNum);
												$('#cate${i.getIndex() }').text(category);
											});
										</script>
										<div class="author">
											<a>${book.bk_writer}</a> 지음 
											<span class="line">|</span>
											<a> ${book.bk_pblsher}</a>
											<span class="line">|</span>
											${bk_pdate}
										
										</div>
										<div class="likeStar">
											<c:if test="${book.bk_rank == 0}">
												<span> 평점 없음</span>
											</c:if>
											<c:if test="${book.bk_rank != 0}">
												<strong style="font-size:22px;"> 평점 : </strong>
												<div class="starRev d-inline-block" id="starRev${i.getIndex() }" >
													<span class="starR1" id="star0" value="0.5">별1_왼쪽</span>
													<span class="starR2" id="star1" value="1">별1_오른쪽</span>
													<span class="starR1" id="star2" value="1.5">별2_왼쪽</span>
													<span class="starR2" id="star3" value="2">별2_오른쪽</span>
													<span class="starR1" id="star4" value="2.5">별3_왼쪽</span>
													<span class="starR2" id="star5" value="3">별3_오른쪽</span>
													<span class="starR1" id="star6" value="3.5">별4_왼쪽</span>
													<span class="starR2" id="star7" value="4">별4_오른쪽</span>
													<span class="starR1" id="star8" value="4.5">별5_왼쪽</span>
													<span class="starR2" id="star9" value="5">별5_오른쪽</span>
													
													<input type="hidden" id="star_rank" value="${book.bk_rank}">
													<span style="font-size: 22px;  margin-top: -11px; display: inline-block;">&nbsp;(${book.bk_rank})</span>
												</div>
											</c:if>
										</div>
									</td>
									<td id="table_price">
									
										<div class="org_price">
											<strong style="color:red; font-size:20px;">
											 	<fmt:formatNumber value="${book.bk_price}" pattern="#,###"/> 원
											 </strong>
										</div>
									</td>
									<td id="table_info3">
										<form id="buy_form${i}" method="post">
											<div class="check">
												<span class="btn_count">
													<label><strong>수량</strong>  
														<input type="text" value="0" maxlength="3" id="cartStock${i.getIndex()}" class="input_style02" name="cartStock" readonly="readonly">
													</label>
													<a class="btn_plus" id="btn_plus${i.getIndex()}">수량 더하기</a>
													<a class="btn_minus" id="btn_minus${i.getIndex()}">수량 빼기</a>
												</span>
											</div>
											<div class="button">
												<input type = "hidden" name = "user_id" id = "user_id${i.getIndex()}" value = "${login.user_id }">
												<input type = "hidden" name = "bnum" id = "bnum${i.getIndex()}" value = "${book.bk_num}">
												<input type = "hidden" name = "cartStock" id="odcount${i.getIndex()}"value="cartStock${i.getIndex()}">
												<input type = "button" id = "cart_btn${i.getIndex()}" class="btn btn-block btn-dark" value = "장바구니">
												
											</div>
										</form>
									</td>
								</tr>
								<script>
									$(function(){
										$("#cart_btn${i.getIndex()}").click(function(e){
										const odcount=$('#odcount${i.getIndex()}').val();
										const bknum=$('#bnum${i.getIndex()}').val();
										const userid=$('#user_id${i.getIndex()}').val();
										console.log("odcount : "+odcount);
										console.log("bknum : "+bknum);
										console.log("userid : "+userid);
											if(userid!=null&&userid!=""&&userid!=0){
											if(odcount > 0){
												console.log("carInfo");
												$.ajax({
													type:"POST",
													url:"/addcart",
													data: {
														od_num : odcount,
														bk_num : bknum,
														user_id : userid
													},
													dataType:"text",
													success:function(result){
														const resultSet = $.trim(result);
														if(result==="success"){
															var msg='장바구니에 담겼습니다.'
															alert(msg);
															location.reload();
														}
														else if(result==="fail"){
															var msg='실패했습니다.'
																alert(msg);
														}
														
													}
												});
											}
											else{
												alert('수량을 선택해주세요');
											}
											}
											else{
												alert('로그인 해주세요')
											}
										});
									});
									</script>
									<script>
										$(document).ready(function(){
											//alert("연결");
											// 이미지 불러오기
											
												$("#btn_plus${i.getIndex()}").click(function(e){
													var value = parseInt($('#cartStock${i.getIndex()}').val());
													value = value + 1;
													$('#cartStock${i.getIndex()}').val(value);
													$('#odcount${i.getIndex()}').val(value);
												});
											//수량 감소
												$("#btn_minus${i.getIndex()}").click(function(e){
													var value = parseInt($('#cartStock${i.getIndex()}').val());
													if(value <= 0){
														return;
													}
													value = value - 1;
													$('#cartStock${i.getIndex()}').val(value);
													$('#odcount${i.getIndex()}').val(value);
												});
										});
										</script>
										
							</c:forEach>
					</table> 
					
					
					
					
					
					
					
						<div id="paginationBox" class="mt-3 mb-5">
							<ul class="pagination justify-content-center" style="list-style:none; text-align:center;">
								<c:if test="${pagination.prev}">
									<li class="page-item"><a class="page-link" href="#" 
										onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.searchType}', '${pagination.keyword}')">Previous</a></li>
								</c:if>
								
								<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
									<li style="display: inline-block;" class="page-item 
										<c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
										<a class="page-link" href="#" 
										onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.searchType}', '${pagination.keyword}')"> ${idx} </a>
									</li>
								</c:forEach>
								<c:if test="${pagination.next}">
									<li class="page-item"><a class="page-link" href="#" 
										onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.searchType}', '${pagination.keyword}')" >Next</a></li>
								</c:if>
							</ul>
						</div>	
				</div>
			</section>
			
			
			
		</div>
	</div>
	
	<jsp:include page="include/footerBox.jsp"></jsp:include>
	
</div>
<script>
	function fn_prev(page, range, rangeSize, searchType, keyword) {
		var cateCode = ${code};
		var newbook = ${newbook};
		var best = ${best};
		console.log('cateCode');
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "/search";
		url = url + "?cateCode=" + cateCode;
 		url = url + "&newbook=" + newbook;
		url = url + "&best=" + best;
		url = url + "&page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + searchType;
		url = url + "&keyword=" + keyword;
		location.href = url;
	}
	
	function fn_pagination(page, range, rangeSize, searchType, keyword) {
		var cateCode = ${code};
		var newbook = ${newbook};
		var best = ${best};
		console.log('cateCode');
		console.log('newbook');
		console.log('best');
		var url = "/search";
		url = url + "?cateCode=" + cateCode;
 		url = url + "&newbook=" + newbook;
		url = url + "&best=" + best; 
		url = url + "&page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + searchType;
		url = url + "&keyword=" + keyword;
		
		location.href = url;
	}
	function fn_next(page, range, rangeSize, searchType, keyword) {
		var cateCode = ${code};
		var newbook=${newbook};
		var best=${best}; 
		console.log('cateCode');
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "/search";
		url = url + "?cateCode=" + cateCode;
  		url = url + "&newbook=" + newbook;
		url = url + "&best=" + best;
		url = url + "&page=" + page;
		url = url + "&range=" + range;
		url = url + "&searchType=" + searchType;
		url = url + "&keyword=" + keyword;
		location.href = url;
	}
	$(document).on('click', '#btn_Search', function(e){
		e.preventDefault();
		var url = "/search";
		url = url + "?searchType=" + $('#searchType').val();
		url = url + "&keyword=" + $('#keyword').val();
		location.href = url;
	});
</script>
<script>
	function cateSwitch(val) {
		var result = "";
		switch(val){
			case 1:
				result = "소설";
				break;
			case 2:
				result = "시/에세이";
				break;
			case 3:
				result = "경제/경영";
				break;
			case 4: 
				result = "자기계발";
				break;
			case 5: 
				result = "인문";
				break;
			case 6: 
				result = "역사/문화";
				break;
			case 7: 
				result = "종교";
				break;
			case 8: 
				result = "정치/사회";
				break;
			case 9: 
				result = "예술/대중문화";
				break;
			case 10: 
				result = "과학";
				break;
			case 11: 
				result = "기술/공학";
				break;
			case 12: 
				result = "컴퓨터/IT";
				break;
		}
		return result;
	}
</script>
<script>
	$(document).ready(function(){
		for(var i =0; i <10; i++){
			var idx = $("#starRev"+i).find("input").val() ; 
			idx = ( idx - 0.5 )*2
			idx = Math.floor(idx);
			$('#starRev'+i).find('#star'+idx).addClass(' on').prevAll('span').addClass(' on');	
		}
	});
</script>

</body>
</html>
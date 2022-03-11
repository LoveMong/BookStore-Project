<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bs_Store</title>
<link rel="stylesheet" href="resources/css/detail.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous">
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
</head>
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
</style>
<style>
	.tab-button-outer {
		display: none;
	    font-size: 30px;
	    text-align: center;
		
	}
	@media screen and (min-width: 640px) {
		.tab-button-outer {
			display: block;
		}
		.tab-select-outer {
			display: none;
		}
	}
	table.type02 {
	  border-collapse: separate;
	  border-spacing: 0;
	  text-align: center;
	  line-height: 1.5;
	  border-top: 1px solid #ccc;
	  border-left: 1px solid #ccc;
	  margin: 20px 60px;
	  font-size:20px;
	}
	table.type02 th {
	  width: 370px;
	  padding: 10px;
	  font-weight: bold;
	  vertical-align: top;
	  border-right: 1px solid #ccc;
	  border-bottom: 1px solid #ccc;
	  border-top: 1px solid #fff;
	  border-left: 1px solid #fff;
	  background: #eee;
	}
	table.type02 td {
	  width: 700px;
	  padding: 10px;
	  vertical-align: top;
	  border-right: 1px solid #ccc;
	  border-bottom: 1px solid #ccc;
	}
	td, th {
	    padding-right: 100px;
	    font-size: 20px;
	}
	#tab-area {
		width:1200px;
		margin:0 auto;
	}
</style>
<style>
	.reply-list {margin-bottom:30px; list-style:none; border-bottom:1px solid #e9e9e9}
	.reply-list li {padding:20px 0; border-top:1px solid #e9e9e9}
	.reply-list li:after {display:block; clear:both; content:''}
	.reply-list li .thumb {float:left; width:10%; text-align:center}
	.reply-list li .thumb img {border-radius: 50%;}
	.reply-list li .reply-content {float:right; width:90%}
	.reply-list li .reply-content:after {display:block; clear:both; content:''}
	.reply-list li .reply-content ul {}
	.reply-list li .reply-content ul li {border:0; padding:0}
	.reply-list li .reply-content .info {float:left;}
	.reply-list li .reply-content .info li {display:inline-block}
	.reply-list li .reply-content .info li.date {font-size:0.75em; color:#bbb} 
	.reply-list li .reply-content .control {float:right}
	.reply-list li .reply-content .control li {display:inline-block; margin-right:10px}
	.reply-list li .reply-content .control li a {color:#ff8149; font:normal 0.75em 'NanumBarunGothic', 'Noto Sans', sans-serif;}
	.reply-list li .reply-content .control li a .fa {color:#ff8149;}
	.reply-list li .reply-content .control li a.reply-url, .reply-list li .reply-content .control li a.reply-url .fa {color:#999;}
	.reply-list li .reply-content .control li a.reply-modify, .reply-list li .reply-content .control li a.reply-modify .fa {color:#ed145b}
	.reply-list li .reply-content .text {clear:both; padding:10px 0 0; color:#777; font:normal 0.875em 'NanumBarunGothic', 'Noto Sans', sans-serif; line-height:1.5em}
	/* @ 비밀글 */ .reply-list li.rp_secret .reply-content .text {color:#999}
	/* @ 일반 */   .reply-list li.rp_general {}
	/* @ 관리자 */ .reply-list li.rp_admin .reply-content .nickname a {color:#ff8149}

</style>
<body>
	<div id="wrap">

		<jsp:include page="include/header.jsp"></jsp:include>


		<div id="detail_middle" class="categories-section mt-3">
			<div class="container">
				<div id="detail_middle_container" class="clearfix">

					<div id="cover">
						<div id="image">
							<img class="img_size" src="${book.bk_thumbUrl}">
						</div>
					</div>
					<div id="title">

						<strong><input type="hidden" id="catenum"
							value="${book.bk_category }"></strong>
						<table>
							<tbody class="detail_intro2">
								<tr>
									<th scope="row">카테고리</th>
									<td id="cate"></td>
								</tr>
								<tr>
									<th scope="row">책제목</th>
									<td>${book.bk_name}</td>
								</tr>
								<tr>
									<th scope="row">작가</th>
									<td>${book.bk_writer}</td>
								</tr>
								<tr>
									<th scope="row">출판사</th>
									<td>${book.bk_pblsher}</td>
								</tr>
								<tr>
									<th scope="row">출간일</th>
									<td>${book.bk_pdate}</td>
								</tr>
								<tr>
									<th scope="row">판매가</th>
									<td style="color: red; font-size: 20px;"><fmt:formatNumber
											value="${book.bk_price}" pattern="#,###" /> 원</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div id="purchase">
						<br> <span style="font-size: 25px; margin-left: 40px;">${book.bk_name}</span>
						<span id="purchase_money1" style="margin-right: 20px"> <fmt:formatNumber
								value="${book.bk_price}" pattern="#,###" /> 원
						</span>
						<div class="btn_count">
							<label><strong>수량</strong> <input type="text" value="0"
								maxlength="3" id="cartStock" class="input_style02"
								name="cartStock" readonly="readonly"> </label> <a
								class="btn_plus" id="btn_plus">수량 더하기</a> <a class="btn_minus"
								id="btn_minus">수량 빼기</a>
						</div>
						<br>

						<div id="purchase_btn">
							<br /> <br /> <br />
							<form method="post" action="/pay/payment" id="payfrm">
								<input type="hidden" name="Orderlist[0].chkBox" value="on">
								<input type="hidden" name="Orderlist[0].bk_price" id="bk_price"
									value="${book.bk_price }"> <input type="hidden"
									name="Orderlist[0].bk_num" id="bnum" value="${book.bk_num}">
								<input type="hidden" name="Orderlist[0].bk_ordercnt"
									id="odcount" value="cartStock"> <input type="hidden"
									name="Orderlist[0].bk_totalprice" id="bk_totalprice" value="">
								<span id="purchase_money3">합계금액&nbsp; <span
									style="color: red;" id="allprice"> 0</span>원 <%-- <fmt:formatNumber var="allprice2" value="0" pattern="#,###"/> --%>
								</span>
								<div style="float: right;" class="detail_btn">
									<input class="btn btn-success" type="button" id="cart_btn"
										value="장바구니"> <input class="btn btn-success"
										type="button" id="buy_btn" value="바로구매">
								</div>
							</form>
						</div>
					</div>
				</div>
				<script>
					$(document).ready(function() {
						var cateCodeNum = $('#catenum').val();
						var cateNum = parseInt(cateCodeNum);
						var category = cateSwitch(cateNum);
						$('#cate').text(category);
					});
					$(document).ready(function() {
						var cateCodeNum = $('#catenum').val();
						var cateNum = parseInt(cateCodeNum);
						var category = cateSwitch(cateNum);
						$('#cate2').text(category);
					});
				</script>
				<div class="tabs mt-3 mb-5" id="tab-area">
					
					
						<div id="tab01" class="tab-pane active">
							<div id="detail_main">
								<div id="detail_main_container">
									<div id="book_intro_wrapper">
										<div id="book_intro_subject">
											<span>책소개</span>
										</div>
										<table class="type02">
											<tbody class="detail_intro">
												<tr>
													<th scope="row">카테고리</th>
													<td id="cate2"></td>
												</tr>
												<tr>
													<th scope="row">책제목</th>
													<td>${book.bk_name}</td>
												</tr>
												<tr>
													<th scope="row">작가</th>
													<td>${book.bk_writer}</td>
												</tr>
												<tr>
													<th scope="row">출판사</th>
													<td>${book.bk_pblsher}</td>
												</tr>
												<tr>
													<th scope="row">출간일</th>
													<td>${book.bk_pdate}</td>
												</tr>
											</tbody>
										</table>
										<div id="book_intro_con">
											<h2>
												<strong>INTRO</strong>
											</h2>

										</div>
										<div id="book_intro_con2">${book.bk_intro}</div>
									</div>


								</div>
							</div>
						</div>


						<div id="tab02" class="tab-pane">
							<div id="detail_reply">
								<div id="detail_reply_container">
									<div id="detail_reply_container_subject">
										<span>평점/리뷰</span>
									</div>
									<br />
									<c:if test="${rank==0 }">
										<div style="text-align: center;">
											<h2>
												<strong>등록된 평점이 없습니다.</strong>
											</h2>
										</div>
									</c:if>

									<c:if test="${rank !=0 }">
										<div style="text-align: center;">
											<h2 style="display: inline-block; margin: 20px;">
												<strong>책 평점</strong>
											</h2>
											<div class="starRev" id="revStar"
												style="display: inline-block;">
												<span class="starR1" id="star0" value="0.5">별1_왼쪽</span> <span
													class="starR2" id="star1" value="1">별1_오른쪽</span> <span
													class="starR1" id="star2" value="1.5">별2_왼쪽</span> <span
													class="starR2" id="star3" value="2">별2_오른쪽</span> <span
													class="starR1" id="star4" value="2.5">별3_왼쪽</span> <span
													class="starR2" id="star5" value="3">별3_오른쪽</span> <span
													class="starR1" id="star6" value="3.5">별4_왼쪽</span> <span
													class="starR2" id="star7" value="4">별4_오른쪽</span> <span
													class="starR1" id="star8" value="4.5">별5_왼쪽</span> <span
													class="starR2" id="star9" value="5">별5_오른쪽</span> <input
													type="hidden" id="star_rank" value="${rank}">
											</div>
											<h2 style="display: inline-block; margin: 20px;">(${rank })</h2>
										</div>
									</c:if>
									<br />
									<hr>
									<br />
									<c:forEach items="${comment }" var="com" varStatus="i">
										<c:if test="${com.rev_rank == 0.0}">
											<p>등록된 리뷰가 없습니다.</p>
										</c:if>
										<c:if test="${com.rev_num!=null }">
											<s_rp_container>
											<ul class="reply-list">
												<s_rp_rep>
												<div id="book_reply" class="comment_reply">
													<li id="[##_rp_rep_id_##]" class="[##_rp_rep_class_##]">
														<div class="reply-content" style="font-size: 20px;">
															<ul class="info">
																<li>
																	<div class="starRev" id="starRev${i.getIndex() }">
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
																		<span>(${com.rev_rank})</span> <input type="hidden"
																			id="star_rank" value="${com.rev_rank}">
																	</div>
																</li>
																<li class="nickname">${com.user_id }</li>
																<li class="date">[${ com.rev_date}]</li>
															</ul>
															<p class="text">${com.rev_comment}</p>
															<input type="hidden" id="comment${i.getIndex()}"
																value="${com.rev_comment }"> <input
																type="hidden" id="comrank${i.getIndex() }"
																value="${com.rev_rank }"> <input type="hidden"
																id="commentnum${i.getIndex()}" value="${com.rev_num }">
															<ul class="control">
																<c:set var="louserid" value="${login.user_id}" />
																<c:set var="couserid" value="${com.user_id}" />
																<c:if test="${louserid==couserid }">
																	<button type="button"
																		id="comment_delete${i.getIndex()}"
																		value="${com.rev_num}" class="btn btn-success">삭제</button>
																	<button type="button" data-toggle="modal" data-target="#myModal" id="comment_update${i.getIndex()}"
																		value="${com.rev_num}" class="btn btn-danger">수정</button>
																</c:if>
															</ul>
														</div>
													</li>
												</div>
												</s_rp_rep>
											</ul>
											</s_rp_container>
										</c:if>
										<%--  <c:forEach items="${comment }" var="com" varStatus="i"> --%>
										<script>
               $("#comment_delete${i.getIndex()}").click(function(){
                  const revnum=$('#comment_delete${i.getIndex()}').val();
                  const userid="${login.user_id}";
                  console.log("comment_revnum${i.getIndex()} : "+revnum);
                  if(userid!=null&&userid!=""&&userid!=0){
                     $.ajax({
                        type:"GET",
                        url:"/commentDelete",
                        data: {
                           rev_num : revnum
                        },
                        success:function(result){
                           console.log("result")
                           alert('댓글이 삭제되었습니다.');
                           location.reload();
                        }
                     })
                  }
                  else{
                     alert('로그인을 해주세요')
                  }
               });
               $(document).ready(function() {
                  $('#myModal').on('show.bs.modal', function(event) {
                     var idx = $("#rankStar").find("input").val() ; 
                     idx = ( idx - 0.5 )*2
                     idx = Math.floor(idx);
                     $('#rankStar').find('#star'+idx).addClass(' on').prevAll('a').addClass(' on');
                        $('#commentUpdate').click(function(e){
                           const revRank=$('#revRank').val();
                           const revnum=$('#comnum').val();
                           const revcomment=$('#revcom').val();
                           console.log("revnum : "+revnum);
                           console.log("revRank : "+revRank);
                           console.log("revcomment : "+revcomment);
                              $.ajax({
                                 type:"POST",
                                 url:"/commentUpdate",
                                 data: {
                                    rev_rank : revRank,
                                    rev_num : revnum,
                                    rev_comment : revcomment
                                 },
                                 dataType: "text",
                                 success:function(result){
                                    location.reload();
                                 }
                              });
                        });
                     
                  });
               });
            </script>
			<script>
               $('#comment_update${i.getIndex()}').click(function(e){
                  const valuenum = $('#comment_update${i.getIndex()}').val();
                  const valuecom = $('#comment${i.getIndex()}').val();
                  const valuerank = $('#comrank${i.getIndex() }').val();
         
					$('#comnum').val(valuenum);
					$('#revcom').text(valuecom);
					$('#revRank').val(valuerank);
				});
				</script>

									</c:forEach>
									<div id="paginationBox">
										<ul class="pagination justify-content-center">
											<c:if test="${pagination.prev}">
												<li class="page-item"><a class="page-link" href="#"
													onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Previous</a>
												</li>
											</c:if>
											<c:forEach begin="${pagination.startPage}"
												end="${pagination.endPage}" var="idx">
												<li
													class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
													<a class="page-link" href="#"
													onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')">
														${idx} </a>
												</li>
											</c:forEach>
											<c:if test="${pagination.next}">
												<li class="page-item"><a class="page-link" href="#"
													onClick="fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')">Next</a>
												</li>
											</c:if>
										</ul>
									</div>

									<c:if test="${login== null}">
										<div id="replyWarning">
											<div id="replyWarning_subject">평점/리뷰 등록</div>
											<div id="replyWarning_content">로그인후 리뷰 등록 가능합니다.</div>
										</div>

									</c:if>

									<c:if test="${login != null}">
										<div id="replyRegist">
											<div id="replyRegist_content">
												<div id="replyRegist_content_likeStar">
													평점 :
													<div class="starRev">
														<a class="starR1 on" value="0.5">별1_왼쪽</a> <a
															class="starR2" value="1">별1_오른쪽</a> <a class="starR1"
															value="1.5">별2_왼쪽</a> <a class="starR2" value="2">별2_오른쪽</a>
														<a class="starR1" value="2.5">별3_왼쪽</a> <a class="starR2"
															value="3">별3_오른쪽</a> <a class="starR1" value="3.5">별4_왼쪽</a>
														<a class="starR2" value="4">별4_오른쪽</a> <a class="starR1"
															value="4.5">별5_왼쪽</a> <a class="starR2" value="5">별5_오른쪽</a>
													</div>
													<br /> <span>리뷰 : </span> <br> <span
														style="float: left; width: 660px;"> <textarea
															rows="3px" cols="140px" name="repCon" id="revdate"></textarea>
														<input type="hidden" name="user_id" id="userid"
														value="${login.user_id }"> <input type="hidden"
														name="bknum" id="bknum" value="${book.bk_num }"> <input
														type="button" id="reply_btn" value="등록"
														class="btn btn-success">
													</span>
												</div>
											</div>
										</div>
									</c:if>
								</div>
							</div>
						</div>
					
				</div>
			</div>
		</div>
	</div>

	<script>
/* $(document).ready(function() {
    var $tabButtonItem = $('#tab-button li'),
        $tabSelect = $('#tab-select'),
        $tabContents = $('.tab-contents'),
        activeClass = 'is-active';

  $tabButtonItem.first().addClass(activeClass);
  $tabContents.not(':first').hide();

  // button
  $tabButtonItem.find('a').on('click', function(e) {
    var target = $(this).attr('href');

    $tabButtonItem.removeClass(activeClass);
    $(this).parent().addClass(activeClass);
    $tabSelect.val(target);
    $tabContents.hide();
    $(target).show();
    e.preventDefault();
  });

  // select
  $tabSelect.on('change', function() {
    var target = $(this).val(),
        targetSelectNum = $(this).prop('selectedIndex');

    $tabButtonItem.removeClass(activeClass);
    $tabButtonItem.eq(targetSelectNum).addClass(activeClass);
    $tabContents.hide();
    $(target).show();
  });
}); */
</script>

<script>
function fn_prev(page, range, rangeSize) {
   var page = ((range - 2) * rangeSize) + 1;
   var range = range - 1;
   var url = "/detail";
   url = url + "?num=" + ${bk_num};
   url = url + "&page=" + page;
   url = url + "&range=" + range;
   location.href = url;
}


function fn_pagination(page, range, rangeSize) {
   var url = "/detail";
   url = url + "?num=" + ${bk_num};
   url = url + "&page=" + page;
   url = url + "&range=" + range;
   
   location.href = url;
}
function fn_next(page, range, rangeSize) {
   var page = parseInt((range * rangeSize)) + 1;
   var range = parseInt(range) + 1;
   var url = "/detail";
   url = url + "?num=" + ${bk_num};
   url = url + "&page=" + page;
   url = url + "&range=" + range;
   location.href = url;
}
</script>

      <jsp:include page="include/footerBox.jsp"></jsp:include>
<script>
   $(function(){
      $("#cart_btn").click(function(e){
      const odcount=$('#odcount').val();
      const bknum=$('#bnum').val();
      const userid="${login.user_id}";
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
                        location.reload();
                        alert(msg);
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
   $(document).ready(function(){
      //alert("연결");
      // 이미지 불러오기
      $("#btn_plus").click(function(e){
         var value = parseInt($('#cartStock').val());
         var bkprice=${book.bk_price };
         value = value + 1;
         $('#cartStock').val(value);
         $('#odcount').val(value);
         var allprice = value*bkprice;
         $('#allprice').text(comma(allprice));
      });
   //수량 감소
      $("#btn_minus").click(function(e){
         var value = parseInt($('#cartStock').val());
         var bkprice=${book.bk_price };
         if(value <= 0){
            return;
         }
         value = value - 1;
         $('#cartStock').val(value);
         $('#odcount').val(value);
         var allprice = value*bkprice;
         $('#allprice').text(comma(allprice));
      });
   });
</script>
<script>
   $('#buy_btn').click(function(){
      var user = "${login.user_id}"
      console.log(user);
      if(user===null){
         alert('로그인해주세요');
      }
      else{
         var bkprice = parseInt($('#bk_price').val());
         var odcount = parseInt($('#odcount').val());
         var bk_totalprice = (bkprice*odcount);
         $('bk_totalprice').val(bk_totalprice);
         if(odcount>0){
            $('#payfrm').submit();
         }
         else{
            alert('수량을 입력하세요')
         }
         
      }
   });
</script>

<script>
$(function(){
   $("#reply_btn").click(function(e){
   const userid=$('#userid').val();
   const bknum=$('#bknum').val();
   const revcomment=$('#revdate').val();
   const revRank=$('#revRank').val();
   
   console.log("userid : "+userid);
   console.log("bknum : "+bknum);
   console.log("revcomment : "+revcomment);
   console.log("revRank : "+revRank);
      if(userid!=null&&userid!=""&&userid!=0){
         if(revcomment!=null&&revcomment!=""){
            $.ajax({
               type:"POST",
               url:"/comment",
               data: {
                  rev_rank : revRank,
                  user_id : userid,
                  bk_num : bknum,
                  rev_comment : revcomment
               },
               dataType: "text",
               success:function(result){
                  const resultSet = $.trim(result);
                  
                  if(resultSet==="notorder"){
                     alert('구매 후 리뷰 작성이 가능합니다.')
                     location.reload();
                  }
                  else if(resultSet==="order"){
                     console.log('성공');
                     location.reload();
                  }
                  
               }
            });
         }
         else{
            alert('댓글을 입력해주세요');
         }
      }
      else{
         alert('로그인 해주세요')
      }
   });
   
   $('.starRev a').click(function(){ 
      $(this).parent().children("a").removeClass("on"); 
      $(this).addClass("on").prevAll("a").addClass("on"); 
      value=$(this).attr("value");
      $('#revRank').val(value);
      console.log($(this).attr("value")); 
   });
   
});
</script>
<div class="modal fade" id="myModal" role="dialog">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title">리뷰 수정</h4>
            <button type="button" class="close" data-dismiss="modal">×</button>
         </div>
            <div class="modal-body">
               <div class="starRev" id="rankStar">
                  <a class="starR1" id="star0" value="0.5">별1_왼쪽</a>
                  <a class="starR2" id="star1" value="1">별1_오른쪽</a>
                  <a class="starR1" id="star2" value="1.5">별2_왼쪽</a>
                  <a class="starR2" id="star3" value="2">별2_오른쪽</a>
                  <a class="starR1" id="star4" value="2.5">별3_왼쪽</a>
                  <a class="starR2" id="star5" value="3">별3_오른쪽</a>
                  <a class="starR1" id="star6" value="3.5">별4_왼쪽</a>
                  <a class="starR2" id="star7" value="4">별4_오른쪽</a>
                  <a class="starR1" id="star8" value="4.5">별5_왼쪽</a>
                  <a class="starR2" id="star9" value="5">별5_오른쪽</a>
                  
                  <input type="hidden" id="revRank" value="">
               </div>
               <br/><br/>
            <textarea rows="4px" cols="55px" id="revcom"></textarea>
            
            <input type="hidden" id="comnum" value="">
         </div>
            <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal" id="commentUpdate">수정</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
         </div>
      </div>
   </div>
</div>
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
<script>
   $(document).ready(function(){
      var idx = $("#revStar").find("input").val() ; 
      idx = ( idx - 0.5 )*2
      idx = Math.floor(idx);
      $('#revStar').find('#star'+idx).addClass(' on').prevAll('span').addClass(' on');
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
		function comma(num){
	    var len, point, str;  
	       
	    num = num + "";  
	    point = num.length % 3 ;
	    len = num.length;  
	   
	    str = num.substring(0, point);  
	    while (point < len) {  
	        if (str != "") str += ",";  
	        str += num.substring(point, point + 3);  
	        point += 3;  
	    }  
	     
	    return str;
	 
		}
</script>

</body>
</html>
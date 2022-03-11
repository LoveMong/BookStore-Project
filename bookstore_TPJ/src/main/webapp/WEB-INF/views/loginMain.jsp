<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!--  CSS Link -->
<link rel="stylesheet" href="resources/css/loginMain.css">
<!-- Bootstrap CSS Link -->
<link rel="stylesheet" href="resources/bootstraps/css/bootstrap.css">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="770076919086-eq6fgbjuq59078luff512ol07ifc52h8.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js"></script>
<!-- Bootstrap CSS CDN -->

</head>
<body>
	<div id="main">
		<div class="main_title" style="margin-top: 80px">
		    <!-- 북로고 -->
			<div class="book_logo mt-5 mb-2" style="width: 280px"> 
	               <a href="/main"> <img src="/resources/img/bk_store2.png"></a>
	        </div>
			<!-- 로그인 -->
			<form class="login__input" action="/login" method="post"
				id="loginFrm" name="loginFrm">
				<div class="form-group">
					<label class="form-label mt-4">로그인</label>
					<div id="main_id" class="form-floating mb-3" style="width: 350px">
						<input type="text" name="memberId" class="form-control"
							id="login_id" placeholder="ID"> <label
							for="floatingInput">아이디</label>
					</div>
					<div id="main_pw" class="form-floating" style="width: 350px">
						<input type="password" name="memberPw" class="form-control"
							id="login_pw" placeholder="PW"> <label
							for="floatingPassword">비밀번호</label>
					</div>
					  <a href="https://kauth.kakao.com/oauth/authorize?client_id=22968e372ff6eb359a4c50fa6ac2ad49&redirect_uri=http://localhost:8080/kakaoLogin&response_type=code">
           				 <img src="resources/img/kakao_login_medium_narrow.png" style="width: 170px; margin-top: 35px; float: left;">
     			      </a>
     			      <div id="button" class="g-signin2" data-onsuccess="onSignIn" style="float: left; margin-left: 10px; width: 170px; margin-top: 35px; height: 40px"></div>
     			    <br>
					<c:if test="${not empty cookie.user_check}">
						<c:set value="checked" var="checked" />
					</c:if>

					<fieldset style=	"clear: left;">
						<br />
						<div class="form-check form-switch">
							<input class="form-check-input" type="checkbox"
								id="flexSwitchCheckDefault"> <label
								class="form-check-label" for="idSaveCheck">자동로그인</label>
						</div>
					</fieldset>
				</div>
			</form>
			<a href="/idsearch"> <span class="badge bg-success" style="margin-top: 10px; width: 170px; height: 25px; line-height: 15px; float: left; margin-top: 35px">아이디찾기</span></a>
			<a href="/passearch"> <span class="badge bg-success" style="margin-top: 10px; width: 170px; margin-left: 10px; line-height: 15px; height: 25px; margin-top: 35px">비밀번호찾기</span></a>
			<div style="margin-top: 20px; margin-left: 40px">
					<button type="button" class="btn btn-warning" onclick="location.href='/join'" style="width: 130px; margin-top: 35px">회원가입</button>
					<button type="button" id="loginBtn" class="btn btn-warning" style="width: 130px; margin-top: 35px">로그인</button>
				<br /> <br />
			</div>
		</div>
	</div>
		
	<!-- 구글 로그인 스크립트 -->
	<script>	
	
	  function onSignIn(googleUser) {
		
	    var profile = googleUser.getBasicProfile();
        var profile;
	    var email;
	    var userName;
	    
	    email =  profile.getEmail();
	    userName = profile.getName();

	    console.log("email: " + email);
	    console.log('userName: ' + userName);
	    
		    $.ajax({			
				url: "googleLogin",
				type: "POST",
				data:{
					"email" : email,						      
					"userName" : userName    
														
			},
			success: function(data) {
				console.log("data: " + data);
				
				if(data === "suc") {		
				alert("로그인 성공.");
				
				location.href="main";
				
				}
			}
		    
		 });
      }
	  
	</script>

	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>

	<!-- Bootstrap JS Script -->
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<!-- Bootstrap jQuery Script -->
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</body>

<script>
	$(document).ready(function() {

		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
		var key = getCookie("key");
		$("#login_id").val(key);

		if ($("#login_id").val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
			$("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
		}

		$("#idSaveCheck").change(function() { // 체크박스에 변화가 있다면,
			if ($("#idSaveCheck").is(":checked")) { // ID 저장하기 체크했을 때,
				setCookie("key", $("#login_id").val(), 7); // 7일 동안 쿠키 보관
			} else { // ID 저장하기 체크 해제 시,
				deleteCookie("key");
			}
		});

		// ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
		$("#login_id").keyup(function() { // ID 입력 칸에 ID를 입력할 때,
			if ($("#idSaveCheck").is(":checked")) { // ID 저장하기를 체크한 상태라면,
				setCookie("key", $("#login_id").val(), 7); // 7일 동안 쿠키 보관
			}
		});

	});

	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}

	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) {
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1)
				end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
</script>

<script>
	$(function() {

		let chk1 = false;
		let chk2 = false;
		$('#login_id').on('keyup', function() {
			if ($('#login_id').val() === "") {
				chk1 = false;
			} else {
				chk1 = true;
			}
		});
		$('#login_pw').on('keyup', function() {
			if ($('#login_pw').val() === "") {
				chk2 = false;
			} else {
				chk2 = true;
			}
		});

		$('#loginBtn').click(function(e) {

			console.log("check 통과 - true");

			if (chk1 && chk2) {

				console.log("if 진입");

				const user_id = $('#login_id').val();
				const user_pw = $('#login_pw').val();

				//json객체에 담기
				const userInfo = {
					user_id : user_id,
					user_pw : user_pw
				};

				$.ajax({
					type : "POST",
					url : "/loginCheck",
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					data : JSON.stringify(userInfo),
					dataType : "text",
					success : function(result) {
						console.log(result);
						const resultSet = $.trim(result);
						console.log("resultSet:" + resultSet);

						if (resultSet === "idFail") {
							$('#login_id').focus();
							alert('아이디/패스워드가 틀렸습니다.')

						} else if (resultSet === "loginSuccess") {
							$('#loginFrm').submit();
						}
					}

				});

			} else {
				alert('입력 정보를 다시 확인하세요');
			}
		});
	});
</script>
</html>
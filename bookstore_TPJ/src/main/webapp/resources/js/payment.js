

var addr;
var phone;
var name;


// 배송 정보 [기본/입력] 설정 
$('.tab-link').click(function () {
var tab_id = $(this).attr('data-tab');
					 
   $('.tab-link').removeClass('current');
   $('.tab-content').removeClass('current');
					 
   $(this).addClass('current');
   $("#" + tab_id).addClass('current');
					
});



// daum_주소 검색 api
function execution_daum_address(){
	 
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 주소변수 문자열과 참고항목 문자열 합치기
                addr += extraAddr;
            
            } else {
            	addr += ' ';
            }

            $(".address_input_1").val(data.zonecode);
            //$("[name=memberAddr1]").val(data.zonecode);    // 대체가능
            $(".address_input_2").val(addr);
            //$("[name=memberAddr2]").val(addr);            // 대체가능
            // 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
            $(".address_input_3").attr("readonly",false);
             $(".address_input_3").focus();
 
        }
    }).open();    
 
};



// 배송지 등록
$(document).ready(function(e){
	
	$("#addAddr").click(function(){
		
		const userID = $('#user_id').val();
		const name = $('#orderRec').val();
		const phone = $('#orderPhone').val();
		const addr = $('#memberAddr1').val() + $('#memberAddr2').val()
		
	 
			console.log("userID : "+userID);									      
			console.log("name : "+name);									      
			console.log("phone : "+phone);									      
			console.log("addr : "+addr);									      
	
        $.ajax({			
				url: "regiaddr",
				type: "POST",
				data:{
					"userID" : userID,						      
					"name" : name,									      
					"phone" : phone,									      
					"addr" : addr		      
																		
			},
			success: function(data) {
				alert("배송지가 등록되었습니다.");
				location.reload();
				
			}
		});
	});
	
});



// 배송지 선택
$('.liston').click(function(){

		phone = $(this).parent().find('.phoneValue').val();
		name = $(this).parent().find('.nameValue').val();
		addr = $(this).parent().find('.addrValue').val();	
	
	
		console.log("name : "+name);									      
		console.log("phone : "+phone);									      
		console.log("addr : "+addr);
	
});	


//배송비 관련
$(document).ready(function(e){
	
	var shipPrice = $('#shipPrice').val();
	
	$("#lastPayment").click(function(){		
		
		var userPoint = $('#userPoint').val();
		var totalPrice = Math.floor($('#finalTotalPrice').val());
		
		userPoint = userPoint - totalPrice;
		console.log("shipPrice : "+shipPrice);
		
		
		$.ajax({			
			url: "LastPayment",
			type: "GET",
			data:{
				"shipPrice" : shipPrice,
				"user_point" : userPoint
													
		},
		success: function(data) {								
				
			
		}

			});											      
		});
});



							



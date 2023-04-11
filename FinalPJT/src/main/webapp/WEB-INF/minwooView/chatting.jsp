<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 
<style>
	.input-group-text{width:100%;background-color:linen;
		color:black;font-weight:bolder;}
	.input-group-prepend{width:20%;}
	#chatArea{
		width:80%;height:200px;overflow-y:auto;text-align:left;
		border:1px solid green;
	}
</style>

<script src="${path }/resources/a00_com/jquery.min.js"></script>
<script src="${path}/resources/a00_com/popper.min.js"></script>
<script src="${path}/resources/a00_com/bootstrap.min.js"></script>
<script src="${path}/resources/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<link rel="icon" type="image/x-icon" href="${path }/resources/sneat-1.0.0/assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="${path }/resources/sneat-1.0.0/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->

    <!-- Helpers -->
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="${path }/resources/sneat-1.0.0/assets/js/config.js"></script>
<script type="text/javascript">
	window.addEventListener("resize", function() {
		//console.log("크기 변경")
		//console.log("#chatArea 크기 변경:"+$("#chatArea").width())
		//console.log("#chatMessageArea크기 변경:"+$("#chatMessageArea>div").width())
		$("#chatMessageArea>div").width($("#chatArea").width()-20)
	});	
	// 전역변수 설정 : 핸들러나 다른 기능메서드를 넘어 사용해야 되기에
	var wsocket;
	var members=[];
	$(document).ready(function(){
		$("#menu-item-chatting").addClass('active open');
		// 화면 로딩시, ajax로 접속된 아이디 출력..
		conUsers()
		$("#id").focus()
		// 이벤트 핸들러 익명 함수 호출
		// 1. 접속시1(버튼)
		$("#enterBtn").click(function(){
			console.log("접속1")
			cKId()
		})
		// 2. 접속시2(enter키) 
		$("#id").keyup(function(){
			if(event.keyCode==13){
				console.log("접속2")
				cKId()
			}
		})
		// 3. 메시지보내기1(버튼)
		$("#sendBtn").click(function(){
			console.log("메시지1")
			// 보내는사람아이디:메시지:받는사람아이디
			// 보내는사람아이디:메시지:그룹
			sendMsg()	
			
		})
		// 4. 메시지보내기2(enter키) 
		$("#msg").keyup(function(){
			if(event.keyCode==13){
				sendMsg()			
			}
		})	
		// 5. 종료 버튼
		$("#exitBtn").click(function(){
			console.log("종료")
			if($("#id").val()!="")
			if(confirm("접속을 종료하시겠습니까?")){
				// wsocket.send( $("#id").val()+":연결을 종료하였습니다." )
				// 핸들러 클래스의 afterConnectionClosed 메서드 호출
				wsocket.close()
				conUsers()
				$("#chatMessageArea").text("")
				$("#msg").attr("readOnly","readOnly")
			}
			
		})
		// 6. 전송해보는 메시지 처리(socket 객체를 통해서 처리)
	});
	// 아이디에 대한 유효성(공백, 접속된 아이디 제외), 처리 후, 접속..
	function cKId(){
		console.log(members)
		var idVal = $("#id").val()
		if($("#id").val()==""){
			alert("아이디를 입력하셔야 접속가능합니다.")
		}else{
			var isNotValid=false;
			$(members).each(function(idx, mem){
				if(idVal==mem){
					isNotValid=true;
				}
			})
			if(isNotValid){
				alert("접속한 동일한 아이디가 있습니다.")
			}else{
				conn()
				$("#id").attr("readOnly","readOnly")
				$("#msg").removeAttr("readOnly")
				$("#msg").focus()
			}
		}		
		
	}
	
	// 소캩 통신 관련 공통메서드 처리
	function conn(){
		// 스프링 컨테이너 안에 선언된 서버 핸들러 호출 객체 호출과 함께 소켓 서버 접속
		wsocket = new WebSocket("ws:49.238.187.241:7080/${path}/chat-ws.do")
	//	wsocket = new WebSocket("ws:localhost:7080/${path}/chat-ws.do")
		//   고정아이피 기준으로 원격서버 주소를 localhost로 처리하여야
		//   1:다 관계 채팅이 가능하다.
		// 이벤트 핸들러 메서드 선언
		// 1. 접속될 때.. 서버상 afterConnectionEstablished() 메서드와 연동
		wsocket.onopen=function(evt){
			// 메시지 전송 메서드 호출 서버상 handleMessage() 메서드 연동
			wsocket.send($("#id").val()+
					":연결 접속했습니다.")
		}
		// 연결을 종료하였습니다.
		// 연결 접속했습니다.
		// 2. 메시지를 받을 때, 처리 내용.
		//    서버 핸들러에 ws.sendMessage(message);에 의해 push방식으로 메시지
		//    전달 받음..
		wsocket.onmessage=function(evt){
			var revMsg = evt.data
			revMsgFun(revMsg)
		}
	}
	function sendMsg(){
		if($("#msg").val().length>0){
			wsocket.send( $("#id").val()+":"+
					$("#msg").val() )
			$("#msg").val("").focus()					
		}else{
			alert("메시지를 입력하세요!!")
		}
		
	}	
	function revMsgFun(msg){
		// 보내는사람아이디:메시지:받는사람아이디
		// 보내는사람아이디:메시지:그룹
		// 1:1
		// 그룹채팅
		// msgArr[2] : 해당 내용이면 메시지를 받게 처리..
		
		var alignOpt = "left"
		// 모든 메시지 내용 ex)  김길동:연결 접속했습니다.
		// 배열 = 문자열.split("구분자")
		//   	해당 구분자로 배열을 만든다.
		// msg[0] : 김길동
		// msg[1] : 연결 접속했습니다.
		var msgArr= msg.split(":");
		console.log("# 메시지 배열 #")
		console.log(msgArr)
		var sndId = msgArr[0]
		// 현재 접속한 아이디와 서버에서 전송하는 아이디 비교
		// 같으면 내가 보낸 메시지 이므로 오른쪽 정렬
		// 다르면 다른 사람의 메시지이므로 왼쪽 정렬
		if($("#id").val()==sndId){
			alignOpt="right"
		}
		// width를 설정해서 정렬 처리
		//console.log("넓이:"+$("#chatArea").width());	
		// $("요소객체").text("메시지내용")
		// .attr("align","정렬속성")
		// .css("width","넓이 속성")
		var msgObj =$("<div></div>").text(msg
				).attr("align",alignOpt).css("width",
						$("#chatArea").width()-20)
		$("#chatMessageArea").append(msgObj)
		
		
		
	
		
		// 스크롤링 처리
		// 1. 전체 해당 데이터의 높이를 구한다.
		// 2. 포함하고 있는 부모 객체(#chatArea)에서
		//    스크롤 기능메서드로 스크롤되겡 처리한다.
		//    scrollTop()
		var height = 
			parseInt($("#chatMessageArea").height())
		//console.log("chatMessageArea 높이:"+height)
		mx+=height+20
		console.log("chatArea 높이:"+$("#chatArea").height())	
		$("#chatArea").scrollTop(mx)	
		conUsers()
	}
	var mx = 0
	// 등록된 사용자 리스트 ajax로 가져와서, 버튼으로 리스트 처리
	function conUsers(){
		$.ajax({
			url:"${path}/chGroup.do",
			dataType:"json",
			success:function(data){
				members = data.group
				var add=""
				$(data.group).each(function(idx,group ){
					add+="<button class='btn btn-outline-primary'  class='btn btn-success' >"+group+"</button>"
				})
				$(".group").html(add)
				//$("#group").val(data.group);
				// <button class="group"  class="btn btn-success" ></button>
			}
		})		
	}
</script>
</head>

<body style="overflow-x: hidden">
   <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->
	<jsp:include page="/mainMenubar.jsp"></jsp:include>
        <!-- / Menu -->
        <!-- Layout container -->
        <div class="layout-page">
        <jsp:include page="/mainTop.jsp"></jsp:include>


          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->
			
            <div class="container-xxl flex-grow-1 container-p-y">
		           	<h4 class="fw-bold py-3 mb-4">채팅</h4>
		           <div class="card">
	           			<div class="container">
							<div class="input-group mb-3">	
								<div class="input-group-prepend">
									<span class="input-group-text  justify-content-center">접속아이디</span>
								</div>
								<input id="id" name="id" class="form-control" value="${emp.id }" readonly/>
								<input id="enterBtn" type="button" class="btn btn-success" value="채팅입장"/>
								<input id="exitBtn" type="button" class="btn btn-danger" value="나가기"/>			
							</div>	
							<div class="input-group mb-3">	
								<div class="input-group-prepend">
									<span class="input-group-text  justify-content-center">접속자들</span>
								</div>
								<div class="input-group-append group">
								</div>
							</div>	
							<div class="input-group mb-3">	
								<div class="input-group-prepend">
									<span class="input-group-text  justify-content-center">내용</span>
								</div>
								<div id="chatArea" class="input-group-append">
									<div id="chatMessageArea"></div>
								</div>
							</div>
							<div class="input-group mb-3">	
								<div class="input-group-prepend">
									<span class="input-group-text  justify-content-center">메시지</span>
								</div>
								<input id="msg" class="form-control" value="" placeholder="보낼 메시지 입력" readOnly/>
								<input id="sendBtn" type="button" class="btn btn-info" value="메시지전송"/>		
							</div>		
						</div>
               </div>
         	  <!-- /card -->
            </div>
            <!-- / Content -->

	

           
          </div>
          <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
      </div>
      </div>

      <!-- Overlay -->
      <div class="layout-overlay layout-menu-toggle"></div>
   
 

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/libs/popper/popper.js"></script>
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/js/bootstrap.js"></script>
    <script src="${path }/resources/sneat-1.0.0/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="${path }/resources/sneat-1.0.0/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="${path }/resources/sneat-1.0.0/assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</body>
</html>
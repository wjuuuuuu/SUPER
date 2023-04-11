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
.card.mb-4{
	padding-left: 3rem !important;
	padding-right: 3rem !important;
}
.demo-inline-spacing{
	display: flex;
    justify-content: flex-end; 
}
</style>
<script src="${path }/resources/a00_com/jquery.min.js"></script>
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
	$(document).ready(function(){
		$("#download").click(function(){
			if(confirm($(this).val()+"을 다운로드 하시겠습니까?")){
				location.href="${path}/downloadMail.do?fname="+$(this).val()
			}
		})
		
		$("#replyBtn").click(function(){
			var mailno = $("[name=mailno]").val()
			location.href="${path}/replyMail.do?mailno="+mailno
		})
		
		
	})
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
 
           <h4 class="fw-bold py-3 mb-4">받은 메일함 > <small class="text-muted">받은 메일함 상세</small></h4>
           
           <div class="card mb-4 pb-3">
	           <div class="demo-inline-spacing">
	            
	            <button id="replyBtn" type="button" class="btn rounded-pill btn-primary">답장</button>
	            <!-- 
	         	<button id="delBtn" type="button" class="btn rounded-pill btn-danger">삭제</button>
	         	 -->
	         	</div>
	         	<input type="hidden" name="mailno" value="${receiveDetail.mailno }"/>
	         	<br><br>
	           <h3 class="mb-0">${receiveDetail.title}</h3>
	           <br>
	           <div style="display: flex;
    				justify-content: flex-start;
   					align-items: center;">
                <h5 class="mb-0">보낸 사람</h5>&nbsp;&nbsp;
                <h4 class="mb-0" style="background:#a6e3f6; border-radius:10px;"> ${receiveDetail.sender}</h4>
               </div>
               <br>
               <div style="display: flex;
    				justify-content: flex-start;
   					align-items: center;">
                <h5 class="mb-0">받는 사람</h5>&nbsp;&nbsp;
                <h4 class="mb-0" style="background:#a6e3f6; border-radius:10px;"> ${receiveDetail.receiver }</h4> 
                </div>
                <br>
               <h6 class="mb-0"><fmt:formatDate pattern='yyyy-MM-dd' value="${receiveDetail.receiveDte}"/></h6>  
               <br>  <br>  
                <div class="input-group">
                <c:if test="${receiveDetail.fname!=null}">
                   <input type="text" class="form-control" value="${receiveDetail.fname}" readOnly/>
                   <button class="btn btn-outline-primary" 
                   type="button" id="download" value="${receiveDetail.fname}">다운로드</button>
                </c:if>
                </div>
              <div style="margin-top:80px;">
               <h5 style="white-space:pre-wrap; line-height:30px;">${receiveDetail.content }</h5>		
         	  </div>
                      
                </div>
         	</div>
         	  <!-- /card -->
            </div>
            <!-- / Content -->
			  <!-- Modal -->
			   <h2 data-bs-toggle="modal"
                          data-bs-target="#modalCenter"></h2>
                        <div class="modal fade" id="modalCenter" tabindex="-1" aria-hidden="true">
                          <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="modalTitle">Modal title</h5>
                                <button
                                  type="button"
                                  class="btn-close"
                                  data-bs-dismiss="modal"
                                  aria-label="Close"
                                ></button>
                              </div>
                               <form class="form">
                              <div class="modal-body">
                              <input type="hidden" value="" name="tno" id="tno">
                                <div class="row">
                                  <div class="col mb-3">
                                    <label for="todoWithTitle" class="form-label">할 일</label>
                                    <input	type="text" name="todo" id="todo" class="form-control" />
                                  </div>
                                </div>
                                <div class="row g-2">
                                  <div class="col mb-0">
                                   
                                    <input type="hidden"  name="id" id="id" class="form-control" value="${emp.id }"/>
                                  </div>
                                </div>
                              </div>
                              </form>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                  닫기
                                </button>
                                <button id="regBtn" type="button" class="btn btn-primary">등록</button>
                                <button id="mUptBtn" type="button" class="btn btn-primary">수정</button>
                              </div>
                            </div>
                          </div>
                        </div>
	

           
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
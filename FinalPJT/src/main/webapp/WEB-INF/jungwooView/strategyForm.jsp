<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
.nav-item.nav-link{
	padding-right: 1rem !important;
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
		
		
		$("#goBack").click(function(){
			location.href="${path}/project_riskDetail.do?riskno="+${param.riskno}+"&prjno="+${param.prjno}	
		});
		
	});
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
           <div class="card mb-4 pb-3">
           <jsp:include page="/projectTop.jsp"></jsp:include>
			<hr class="mx-0">
           		<div class="card-body">
           			<div class="input-form col-md-12 mx-auto">
				        <h4 class="text-primary">대응전략 등록</h4>
				        
				        <form method="get" class="validation-form" novalidate> 
						  <input type="hidden" class="form-control  ckValid" 
						  id="riskno" name="riskno" value="${param.riskno }">
						  <input type="hidden" class="form-control  ckValid" 
						  id="prjno" name="prjno" value="${param.prjno }">
				          <div class="row">      
					          <div class="col-md-6 mb-3">
					            <input class="form-check-input form-control ckValid" 
					            type="radio" value="AVOIDANCE" name="risk_strategy" id="AVOIDANCE" >
								  <label class="form-check-label" for="AVOIDANCE">
								    AVOIDANCE
								  </label>
					          </div> 
					          <div class="col-md-6 mb-3">
					            <input class="form-check-input form-control ckValid" type="radio" value="TRANSFERENCE" name="risk_strategy" id="TRANSFERENCE">
								  <label class="form-check-label" for="TRANSFERENCE">
								    TRANSFERENCE
								  </label>
					          </div> 	          
				          </div>     
				          <div class="row">      
					          <div class="col-md-6 mb-3">
					            <input class="form-check-input form-control ckValid" type="radio" value="MITIGATION" name="risk_strategy" id="MITIGATION">
								  <label class="form-check-label" for="MITIGATION">
								    MITIGATION
								  </label>
					          </div> 
					          <div class="col-md-6 mb-3">
					            <input class="form-check-input form-control ckValid" type="radio" value="ACCEPTANCE" name="risk_strategy" id="ACCEPTANCE">
								  <label class="form-check-label" for="ACCEPTANCE">
								    ACCEPTANCE
								  </label>
					          </div> 	          
				          </div>     
				          <div class="row">      
					          <div class="col-md-6 mb-3">
					            <input class="form-check-input form-control ckValid" type="radio" value="EXPLOIT" name="risk_strategy" id="EXPLOIT">
								  <label class="form-check-label" for="EXPLOIT">
								    EXPLOIT
								  </label>
					          </div> 
					          <div class="col-md-6 mb-3">
					            <input class="form-check-input form-control ckValid" type="radio" value="SHARE" name="risk_strategy" id="SHARE">
								  <label class="form-check-label" for="SHARE">
								    SHARE
								  </label>
					          </div> 	          
				          </div>     
				          <div class="row">      
					          <div class="col-md-6 mb-3">
					            <input class="form-check-input form-control ckValid" type="radio" value="ENHANCE" name="risk_strategy" id="ENHANCE">
								  <label class="form-check-label" for="ENHANCE">
								    ENHANCE
								  </label>
					          </div> 
					          <div class="col-md-6 mb-3">
					            <input class="form-check-input form-control ckValid" type="radio" value="ACCEPT" name="risk_strategy" id="ACCEPT">
								  <label class="form-check-label" for="ACCEPT">
								    ACCEPT
								  </label>
					          </div> 	          
				          </div>     
				          <div class="mb-4"></div>
				          <button id="insertBtn" class="btn btn-warning btn-lg btn-block" type="button">등록</button>
				          <button id="goBack" class="btn btn-info   btn-lg btn-block" type="button">이전</button>
				        </form>
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
    <script type="text/javascript">
    $("#insertBtn").click(function(){			
		if(confirm("등록하시겠습니까?")){
			$("form").attr("action","${path}/insertStrategy.do");
			$("form").submit();
		}
	})
    </script>
  </body>
</body>
</html>
</html>
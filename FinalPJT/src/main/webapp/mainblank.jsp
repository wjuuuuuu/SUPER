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
	td{text-align:center;}
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
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var options = {
				  chart: {
				    type: 'donut'
				  },
				  colors:['#696cff', '#8592a3', '#71dd37','#03c3ec','#007bff','#e83e8c','#696cff','#71dd37'],
				  series: [44, 55, 41, 17],
				  labels: ['개발', '영업', '마케팅', '디자인'],
				  legend: {
					    position: 'bottom'
					}
				}
		var chart = new ApexCharts(document.querySelector("#chart"), options);
		chart.render();	
		/*
		--bs-blue: #007bff;
    --bs-indigo: #6610f2;
    --bs-purple: #696cff;
    --bs-pink: #e83e8c;
    --bs-red: #ff3e1d;
    --bs-orange: #fd7e14;
    --bs-yellow: #ffab00;
    --bs-green: #71dd37;
    --bs-teal: #20c997;
    --bs-cyan: #03c3ec;
		--bs-primary: #696cff;
	    --bs-secondary: #8592a3;
	    --bs-success: #71dd37;
	    --bs-info: #03c3ec;
	    --bs-warning: #ffab00;
	    --bs-danger: #ff3e1d;
	    --bs-light: #fcfdfd;
	    --bs-dark: #233446;	
		*/
		
		var options2 = {
		          series: [{
		          data: [40, 43, 44.8, 47.0, 54.0, 58.0, 69.0, 100, 12, 13.8]
		        }],
		          chart: {
		          type: 'bar',
		          height: 500
		        },
		        plotOptions: {
		          bar: {
		            borderRadius: 4,
		            horizontal: true,
		          }
		        },
		        dataLabels: {
		          enabled: false
		        },
		        fill:{
		        	colors:['#696cff']
		        },
		        xaxis: {
		          categories: ['South Korea', 'Canada', 'United Kingdom', 'Netherlands', 'Italy', 'France', 'Japan',
		            'United States', 'China', 'Germany'
		          ],
		        },
		        yaxis: {
		            max: 100, //100%가 최대값이도록 설정
		        },
		        tooltip: {
		        	 y: {
		                 formatter: undefined,
		                 title: {
		                     formatter: (seriesName) => "진행률", 
		                 },
		             }
		          }
		  };
		var chart2 = new ApexCharts(document.querySelector("#chart2"), options2);
		chart2.render();		
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
 			<div class="row">
 			<div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
	           <div class="card">
	           	<div class="row row-bordered g-0">
	         	  <div id="chart2" style="width: 100%;height: 100%;"></div>

	           </div>
	           </div>
          	 </div>
          	 
          	 <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2">
	          	  <div class="card">
	           		<div id="chart" style="width: 100%;height: 100%;"></div>
	         	 </div>
         	</div>
         	  <!-- /card -->
         	 
         	 
         	 </div>
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
</html>
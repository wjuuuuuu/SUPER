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
<script type="text/javascript">
	function goMyPage(id){
		location.href="${path}/myPage.do?id="+id
	}
	
	$(document).ready(function(){
		$("#readAll").click(function(){
		 	 $("input[name=chk]").prop("checked", true)
		 	 var chkArray = new Array()
			    $("input[name=chk]:checked").each(function() { 
			      var alertnoVal = $(this).val(); 
			      chkArray.push(alertnoVal);
			    });
				if(confirm("모두 읽음 처리하시겠습니까?")){
					alert("모든 알림이 읽음처리되었습니다.")
					$.ajax({
						type:"post",
						url:"${path}/alertState.do?no="+chkArray,
						success:function(){
							location.reload()
						},
						error:function(err){
							console.log(err)
						}
					})
					
				}
		   })
		   
		   
	 });
	function alertState(no){
	      location.href="${path}/alertState.do?no="+no
	      location.reload()
	   }
    function alertDelete(no){
	   location.href="${path}/alertDelete.do?no="+no
	   location.reload()   
  }
</script>
</head>

<body style="overflow-x: hidden">
  <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
              <ul class="navbar-nav flex-row align-items-center ms-auto mx-5">
               <!-- alert -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown mx-1">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                 <i class="bx bx-bell bx-md"></i>
                 <c:if test="${alertList[0].cnt>0 }">
                <span class="badge badge-center rounded-pill bg-danger"
                   style="margin-left: -17px;">${alertList[0].cnt }</span>
                   </c:if>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                     <li>
                        <button style="margin-left: 300px; border:none;
                         background:white; color:#848484;" id="readAll">모두 읽음</button>
                     </li>
                     <li>
                      <div class="dropdown-divider"></div>
                    </li>  
                     <li>
                     <span class="dropdown-item" >  
                       <span class="align-middle">알림</span>
                     </span>
                     </li>
                     
                    <li>s
                     <div class="card-body" >
                     <c:if test="${empty alertList}">
                     	<span style="display:flex; justify-content:center; width:330px;">알림 없음</span>
                     </c:if>
                        <c:forEach var="alert" items="${alertList }"> 
                       <div class="bs-toast toast fade show bg-${alert.style }" 
                       role="alert" aria-live="assertive" aria-atomic="true" style="margin-top:30px; margin-left:17x;">
                           <div class="toast-header">
                           <input type="checkbox" name="chk" style="display:none;" value="${alert.no }">
                             <i class="bx bx-bell me-2"></i>
                             <div class="me-auto fw-semibold">${alert.title }</div>
                           
                             <c:if test="${alert.state=='0' }">
                              <small>읽지 않음</small>
                             </c:if>
           
                             <button type="button" onclick="alertDelete('${alert.no }')" 
                                class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                           </div>
                           
                           <div class="toast-body">
                             <a class="dropdown-item" href="${path }/${alert.url}">
                                <span style="color:white;" onclick="alertState('${alert.no }')">${alert.content }</span>
                             </a>
                           </div>
                       </div>
                      </c:forEach>
                       </div>
                    </li>
                   
                    
                  </ul>
                </li>
               <!-- /alert -->
                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown mx-1"> 
                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                <span style="position:absolute; top:20px;left:4px; z-index: 3;font-size: 0.6rem;color:white;">${emp.ename }</span>
                  
                   <div class="avatar avatar-online">
                      <svg viewBox="0 0 40 40">
                 <circle cx="20" cy="20" r="20" fill="#0054a6" />
               </svg>
                   </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="javascript:goMyPage('${emp.id }');">
                        <i class="bx bx-user me-2"></i>
                        <span class="align-middle">My Profile</span>
                      </a>
                    </li>
                    <!-- 
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                     -->
                    <li>
                      <a class="dropdown-item" href="${path }/PMSLogin.do">
                        <i class="bx bx-power-off me-2"></i>
                        <span class="align-middle">Log Out</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
         
  </body>
</body>
</html>
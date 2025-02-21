<%@page import="com.dakshabhi.pms.users.dtos.CUserLoginDTO"%>
<%
CUserLoginDTO cUserLoginDTO = (CUserLoginDTO)session.getAttribute("userLogin");
if(cUserLoginDTO == null){
	response.sendRedirect("signin.jsp");
}
 
%>
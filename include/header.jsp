<!--
=========================================================
* Material Dashboard 2 PRO - v3.0.6
=========================================================

* Product Page: https://www.creative-tim.com/product/material-dashboard-pro
* Copyright 2022 Creative Tim (https://www.creative-tim.com)
* Coded by Creative Tim
=========================================================
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->

<%@page import="com.dakshabhi.common.constants.ConfigConstants"%>
<%@page import="com.dakshabhi.pms.companies.daos.CCompanyDAO"%>
<%@page import="com.dakshabhi.pms.companies.dtos.CCompanyDTO"%>
<%
String url = request.getServerName().toString(); 
String companyID = session.getAttribute("companyID")==null?"":(String)session.getAttribute("companyID");
String companyName = session.getAttribute("companyName")==null?"":(String)session.getAttribute("companyName");

if(companyID.equals("")){
	companyID = CCompanyDAO.getCompanyIDByURL(url);
	if(!companyID.equals("")){
		session.setAttribute("companyID",companyID); 
		
		/* Get company name using company id  */
		CCompanyDTO cCompanyDTO = CCompanyDAO.getCompanyName(companyID);
		companyName = cCompanyDTO.getCompany_name();
		session.setAttribute("companyName", companyName); 
		
	}
} 
%>
 
<html lang="en">
<head>
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-JHSVBGMGMP"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-JHSVBGMGMP');
</script>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<%@ include file="sessionexpire.jsp" %>
 
<link rel="icon" type="image/png" href="./assets/img/favicon.ico">

<title>DAKSHABHI-Project Management System</title> 
<!--     Fonts and icons     -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />

<!-- Nucleo Icons -->
<link href="./assets/css/nucleo-icons.css" rel="stylesheet" />
<link href="./assets/css/nucleo-svg.css" rel="stylesheet" />

<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js"
	crossorigin="anonymous"></script> 
<!-- Material Icons -->
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet">

<!-- CSS Files --> 
<link id="pagestyle" href="./assets/css/material-dashboard.css?v=3.0.7"
	rel="stylesheet" /> 
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"
	type="text/javascript"></script>
</head>
<%@page import="com.dakshabhi.pms.Security.dto.CAllowAccessDTO"%>
<%@page import="com.dakshabhi.common.constants.ConfigConstants"%>
<aside
	class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl fixed-start bg-gradient-dark"
	id="sidenav-main">

	<div class="bg-white">
		<i
			class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0  d-lg-none"
			aria-hidden="true" id="iconSidenav"></i> <a class="navbar-brand m-0"
			href="#"> <img src="./assets/img/taskistic-logo.png"
			class="navbar-brand-img h-100" alt="main_logo"> <span
			class="ms-1 font-weight-bold h4 vertical-middle">TASKISTIC</span>
		</a>
	</div>
	<hr class="horizontal light mt-0 mb-2">

	<div class="collapse navbar-collapse  w-auto h-auto"
		id="sidenav-collapse-main">
		<ul class="navbar-nav">
			<%
			CAllowAccessDTO allowAccessDTO = (CAllowAccessDTO) session.getAttribute("allowAccess");
			if (allowAccessDTO != null) {
			%>
			<li class="nav-item"><a href="workspace.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">cases</i>
					<span class="nav-link-text ms-2 ps-1">My Workspace</span>
			</a></li>
			<hr class="horizontal light mt-0" />
			<%
			if (allowAccessDTO.isCustomerSectionAllowed()) {
			%>

			<li class="nav-item"><a href="companies.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">store</i>
					<span class="nav-link-text ms-2 ps-1">Company</span>
			</a></li>

			<hr class="horizontal light mt-0" />
			<li class="nav-item"><a href="customer.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">co_present</i>
					<span class="nav-link-text ms-2 ps-1">Customers</span>
			</a></li>
			<hr class="horizontal light mt-0" />
			<%
			}
			%>
			<%
			if (allowAccessDTO.isEmployeeSectionAllowed()) {
			%>
			<li class="nav-item"><a href="employee.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">group</i>
					<span class="nav-link-text ms-2 ps-1">Employees</span>
			</a></li>
			<hr class="horizontal light mt-0">
			<%
			}
			%>

			<%
			if (allowAccessDTO.isProjectSectionAllowed()) {
			%>
			<li class="nav-item"><a href="projects.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">domain_add</i>
					<span class="nav-link-text ms-2 ps-1">Projects</span>
			</a></li>
			<hr class="horizontal light mt-0">

			<li class="nav-item"><a href="masters.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">settings</i>
					<span class="nav-link-text ms-2 ps-1">Masters</span>
			</a></li>
			<hr class="horizontal light mt-0">
			
			<li class="nav-item"><a href="taskanalysisreport.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">report</i>
					<span class="nav-link-text ms-2 ps-1">Task Analysis Report</span>
			</a></li>
			<li class="nav-item"><a href="employeeperformance.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">report</i>
					<span class="nav-link-text ms-2 ps-1">Employee Performace</span>
			</a></li>
			<%
			}
			%>
			<li class="nav-item"><a href="userprofile.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">manage_accounts</i>
					<span class="nav-link-text ms-2 ps-1">Profile</span>
			</a></li>
			<li class="nav-item"><a href="tickets.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">local_activity</i>
					<span class="nav-link-text ms-2 ps-1">Tickets</span>
			</a></li>
			
			<li class="nav-item"><a href="Help.jsp"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">help</i>
					<span class="nav-link-text ms-2 ps-1">Help</span>
			</a></li>
			<li class="nav-item"><a href="userlogout"
				class="nav-link text-white " aria-controls="pagesExamples"
				role="button" aria-expanded="false"> <i
					class="material-icons-round {% if page.brand == 'RTL' %}ms-2{% else %} me-2{% endif %}">logout</i>
					<span class="nav-link-text ms-2 ps-1">Logout</span>
			</a></li>
			<%
			}
			%>

		</ul>
	</div>

</aside>
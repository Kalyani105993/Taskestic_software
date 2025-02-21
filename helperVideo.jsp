<%@page import="java.util.ArrayList"%>
<%@ include file="/include/header.jsp"%>
<%@ page isELIgnored="false"%>


<style>
.helper-video-card {
	width: 45%;
	margin: auto;
}
</style>

<body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden">
	<%@ include file="/include/leftnav.jsp"%>
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg position-sticky mt-4 top-1 px-0 shadow-none border-radius-xl z-index-sticky"
			id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3"
				style="display: block !important">
				<nav aria-label="breadcrumb">
					<div class="row">
						<div class="col-6">
							<h6 class="font-weight-bolder mb-0">Help</h6>
							<div class="sidenav-toggler sidenav-toggler-inner">
								<a href="javascript:;" class="nav-link text-body p-0">
									<div class="sidenav-toggler-inner">
										<i class="sidenav-toggler-line"></i> <i
											class="sidenav-toggler-line"></i> <i
											class="sidenav-toggler-line"></i>
									</div>
								</a>
							</div>
						</div>
						<div class="col-6" id="addbtbn"></div>
					</div>
				</nav>
			</div>
		</nav>



		<div class="card card-body p-2 pt-2 helper-video-card">
			<video controls autoplay>
				<source src="Login.mp4" type="video/mp4">
			</video>
		</div>
	</main>


</body>
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.min.js?v=3.0.6"></script>

<%@ include file="/include/footer.jsp"%>

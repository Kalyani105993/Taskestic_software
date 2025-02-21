<%@ include file="/include/header.jsp"%>
<!--  media query css -->
<link rel="stylesheet" media="screen and (max-width: 600px)"
	href="smallscreen.css">
<style>
.savecancelbtn {
	display: inline-block;
}
.usercss1 {
	border: none;
	border-bottom: 1px solid lightgrey;
}

.usercss {
	border: none;
	background-color: white;
}

.msgError {
	font-size: 0.875rem;
	display: none;
	color: red;
}
@media screen and (max-device-width: 574px) {
 select#timezoneSelect {
	       font-size: 9px;
	}
}
</style>
<body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden">
	<%@ include file="/include/leftnav.jsp"%>
	<!-- Main -->
	<main
		class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
		<!-- Navbar -->
		<nav
			class="navbar navbar-main navbar-expand-lg position-sticky px-0 shadow-none border-radius-xl z-index-sticky"
			id="navbarBlur" data-scroll="true">
			<div class="container-fluid py-1 px-3">
				<nav aria-label="breadcrumb">
					<div class="row">
						<div class="col-12">
							  <ol class="breadcrumb active">
						    <li class="breadcrumb-item"><a i class="material-icons fixed-plugin-button-nav cursor-pointer " href='workspace.jsp'> home </i></a></li>
						     <h6 class="font-weight-bolder mb-0 breadcrumb-item active" >Company Profile</h6>
						  </ol>
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
		</nav>
		<!--End Navbar -->

		<div class="container-fluid ">
			<div class="row">
				<div class="col-lg-12 col-12 mx-auto position-relative">
					<div class="card mt-4" id="basic-info"">
						<div class="card-header p-2 mb-0">
							<h5>Company Details</h5>
						</div>
						<div class="card-body pt-0">
							<form id="formId">
								<input type="hidden" id="companyId">
								<div class="row">
									<div class="col-12">
										<div class="input-group input-group-static">
											<label>Company Name </label><input type="text"
												id="companyName" class="form-control"
												onfocus="focused(this)" onfocusout="defocused(this)"><br>
											<span class="msgError" id="msgError_companyName"></span>
										</div>
									</div>
								</div>
								<div class="row mt-4">
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
											<label>Company Email</label><input type="email" 
												placeholder="example@email.com" onfocus="focused(this)"
												onfocusout="defocused(this)" id="companyEmail" name= "company_email"
												class="form-control" onchange="is_alreadyexits(this.value,this.name)"><br> <span
												class="msgError" id="msgError_companyEmail"></span>
										</div>
									</div>
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
											<label>Company Phone No.</label><input type="text" placeholder="xxxxxxxxxx"  onfocus="focused(this)"
												onfocusout="defocused(this)" id="companyPhone" name= "company_phone"
												class="form-control" onchange="is_alreadyexits(this.value,this.name)" maxlength="10"><br> <span
												class="msgError" id="msgError_companyPhone"></span>
										</div>
									</div>
								</div>
								<div class="row mt-4">
									<div class="col-12">
										<div class="input-group input-group-static">
											<label>Company Address</label><input type="text"
												id="companyAddress" class="required form-control"
												onfocus="focused(this)" onfocusout="defocused(this)"><br>
											<span class="msgError" id="msgError_companyAddress"></span>
										</div>
									</div>
								</div>
								<div class="row mt-4">
									<div class="input-group input-group-static">
								        <label for="timezone">Select Timezone:</label>
									        <select id="timezoneSelect" class="form-control" name="timezone">
										            <option value="Asia/Kolkata" selected>(GMT+05:30) Chennai,Kolkata,Mumbai,New Delhi,West Bengal </option>
								        	</select>
								        </div>
								</div>			
								<div class="row mt-4">
									<div class="col-md-2 col-sm-12">
										<label>Login Time Restriction </label>
									</div>
									<div class="col-md-1 col-sm-12">
											<div class="form-check form-switch">
												<input class="form-check-input" type="checkbox" id="toggelSwitchId">
											</div>
									</div>
								</div>
								<div class="row mt-4">
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
										<label>Start Time :</label>
											<input type="text" class="form-control time-pickable" id="from_LoginRestrictionId" value="09:00 am"  disabled="disabled" >
										</div>
									</div>
									<div class="col-md-6 col-sm-12">
										<div class="input-group input-group-static">
										<label>End Time :</label>
											<input type="text" class="form-control time-pickable" id="to_LoginRestrictionId" value="07:00 pm"  disabled="disabled">
										</div>
									</div>
								</div>
								<div class="row mt-4">
									<div class="col-md-12 text-end" id="updateDetails">
										<button type="button" class="btn btn-icon btn-1 btn-dark mb-0"
											onclick="return saveCompanyDetails();"
											id="updateProfileDetails">Save</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>	
	</main>
</body>
<!--   Core JS Files   -->
<script src="assets/js/core/popper.min.js"></script>
<script src="assets/js/core/bootstrap.min.js"></script>
<script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="assets/js/plugins/datatables.js"></script> 
<script src="assets/js/plugins/dragula/dragula.min.js"></script>
<script src="assets/js/plugins/jkanban/jkanban.js"></script>
<script src="assets/js/material-dashboard.min.js?v=3.0.6"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
<!--     Include Moment.js CDN -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment.min.js"></script>  
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"> </script>
 <!--    Include Bootstrap DateTimePicker CDN -->
<link  href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<script>
	$(document).ready(function() {
		checkSession();
		companiesList();
		activate();
		populateTimezoneSelect();
	})
	function checkSession(){
		jQuery.ajax({
			type : "POST",
			url : "checksession",
			data : { 
			},
			async : true,
			success : function(data) { 
				if(data == 'Failure'){
					window.location = 'signin.jsp';
				}
				 
			},
			error : function(data) {
				window.location = 'signin.jsp';
			}
		});
	}

	function companiesList() {
		$.ajax({
			url : "company",
			type : "post",
			data : {
				action_type : "getCompanyData"
			},
			success : function(resp) {
				console.log(resp);
				$("#companyName").val(resp.company_name);
				$("#companyEmail").val(resp.company_email);
				$("#companyPhone").val(resp.company_phone);
				$("#companyAddress").val(resp.company_address);
				$("#companyId").val(resp.company_id);
				$("#from_LoginRestrictionId").val(resp.from_login);
				$("#to_LoginRestrictionId").val(resp.to_login); 
				if(resp.isToggelSwitchOn =='yes')
					$("#toggelSwitchId").prop('checked', true);
				
			}
		})
	}
	function editProfileDetails() {
		$("#editDetails").prop("hidden", true);
		$("#updateDetails").prop("hidden", false);
		$("#cancel").prop("hidden", false);

		$("#companyName").prop("disabled", false);
		$("#companyEmail").prop("disabled", false);
		$("#companyPhone").prop("disabled", false);
		$("#companyAddress").prop("disabled", false);

		$("#companyName").removeClass("usercss");
		$("#companyEmail").removeClass("usercss");
		$("#companyPhone").removeClass("usercss");
		$("#companyAddress").removeClass("usercss");

		$("#companyName").addClass("usercss1");
		$("#companyEmail").addClass("usercss1");
		$("#companyPhone").addClass("usercss1");
		$("#companyAddress").addClass("usercss1");

	}

	$("#cancel").click(function() {
		$("#editDetails").prop("hidden", false);
		$("#updateDetails").prop("hidden", true);
		$("#cancel").prop("hidden", true);

		$("#companyName").prop("disabled", true);
		$("#companyEmail").prop("disabled", true);
		$("#companyPhone").prop("disabled", true);
		$("#companyAddress").prop("disabled", true);

		$("#companyName").removeClass("usercss1");
		$("#companyEmail").removeClass("usercss1");
		$("#companyPhone").removeClass("usercss1");
		$("#companyAddress").removeClass("usercss1");

		$("#companyName").addClass("usercss");
		$("#companyEmail").addClass("usercss");
		$("#companyPhone").addClass("usercss");
		$("#companyAddress").addClass("usercss");
	})
	
	 var istoggelSwitchON = "";
	 async function saveCompanyDetails() {
		console.log($("#companyId").val());
		console.log($("#companyName").val());
		console.log($("#companyAddress").val());
		console.log($("#companyPhone").val());
		console.log($("#companyEmail").val());
		console.log($("#from_LoginRestrictionId").val());
		console.log($("#to_LoginRestrictionId").val());
		console.log($("#toggelSwitchId").val());
		
		if(istoggelSwitchON == ""){
			istoggelSwitchON = "no";
		}
		const selectedTimezone = document.querySelector('#timezoneSelect').value;

		if(validateServiceDetails('formId')){
				var is_emailExist = await is_alreadyexits($("#companyEmail").val(),$("#companyEmail").attr("name"));
		if(!is_emailExist){
				var is_phoneExist = await is_alreadyexits($("#companyPhone").val(),$("#companyPhone").attr("name"));
				if(!is_phoneExist){
					$.ajax({
						url : "company",
						type : "POST",
						data : {
							action_type : "updateCompanyDetails",
							companyid : $("#companyId").val(),
							companyname : $("#companyName").val(),
							companyaddress : $("#companyAddress").val(),
							companyphone : $("#companyPhone").val(),
							companyemail : $("#companyEmail").val(),
							from_login :$("#from_LoginRestrictionId").val(),
							to_login : $("#to_LoginRestrictionId").val(),
							time_zone : selectedTimezone,
							toggel_switch : istoggelSwitchON
						},
						success : function(data) {
							console.log(data);
							$("#updateDetails").prop("hidden", true);
							companiesList();
						}
					})
				}
			}
		}
	};

	function validateServiceDetails(form_id) {
		var formObj = $('#' + form_id);
		for (var i = 0; i <= formObj.get(0).length - 1; i++) {
			inputObj = formObj.get(0)[i];
			if (inputObj.type == 'select-one'
					&& inputObj.className === 'required form-control'
					&& inputObj.value == '0') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text(
						'Please select at least one option.');
				return false;
			} else if (inputObj.type === 'text'
					&& inputObj.className === 'form-control'
					&& inputObj.value.trim() === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'textarea'
					&& inputObj.className === 'required usercss1'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'email'
					&& inputObj.className === 'form-control'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			} else if (inputObj.type === 'date'
					&& inputObj.className === 'required usercss1'
					&& inputObj.value === '') {
				$("#msgError_" + inputObj.id).show();
				$("#msgError_" + inputObj.id).text("Please fill this field.");
				return false;
			}
			if (inputObj.className === 'form-control') {
				$("#msgError_" + inputObj.id).hide();
			}
		}
		return true;
	}
	// Check email and phone is already exists for company
	async function is_alreadyexits(isexistvalue,checkfor){
		return $.ajax({
			url : "company",
			method : "POST",
			data : {
				action_type : "checkalreadyexists",
				isexistvalue : isexistvalue,
				checkfor : checkfor
			},
			async : true,
			success : await function(data){
				if(checkfor == 'company_email'){
					if(data != false){
						$('#msgError_companyEmail').text("Email already exists.");
						$('#msgError_companyEmail').show();
						$('#companyEmail').focus();
					}else{
						$('#msgError_companyEmail').hide();
						return true;
					}
				}else if(checkfor == 'company_phone'){
					if(data != false){
						$('#msgError_companyPhone').text("Phone already exists.");
						$('#msgError_companyPhone').show();
						$('#companyPhone').focus();
					}else{
						$('#msgError_companyPhone').hide();
						return true;
					}
				}
			},
			error : function(error){
				alert(error);
			}
			
		});
	}
	
	$("#toggelSwitchId").change(function(){
	    if($(this).prop("checked") == true){
	    	
	    	 istoggelSwitchON = 'yes';
	    	 $("#from_LoginRestrictionId").prop('disabled', false);
	    	 $("#to_LoginRestrictionId").prop('disabled', false); 
	    	 $("#from_LoginRestrictionId").removeAttr('disabled', false); 
	    	 $("#to_LoginRestrictionId").removeAttr('disabled', false); 
	    	 
	    }else{
	    	
	    	 istoggelSwitchON = 'no';	
	    	 $("#from_LoginRestrictionId").prop('disabled', true);
	    	 $("#to_LoginRestrictionId").prop('disabled', true);
	 		 $("#from_LoginRestrictionId").addAttr("disabled",true);
	 		 $("#to_LoginRestrictionId").addAttr("disabled",true);
	    	 $("#from_LoginRestrictionId").val("09:00 am");
	    	 $("#to_LoginRestrictionId").val("07:00 pm"); 
		}
	});
	
	function activate() {
			document.head.insertAdjacentHTML("beforeend", `
				<style>
					.time-picker {
						position: absolute;
						display: inline-block;
						padding: 20px;
						background: #eeeeee;
						border-radius: 6px;
					}

					.time-picker__select {
						-webkit-appearance: none;
						-moz-appearance: none;
						appearance: none;
						outline: none;
						text-align: center;
						border: 1px solid #dddddd;
						border-radius: 6px;
						padding: 6px 10px;
						background: #ffffff;
						cursor: pointer;
						font-family: 'Heebo', sans-serif;
					}
				</style>
			`);
			document.querySelectorAll(".time-pickable").forEach(timePickable => {
				let activePicker = null;

				timePickable.addEventListener("focus", () => {
					if (activePicker) return;

					activePicker = show(timePickable);

					const onClickAway = ({ target }) => {
						if (
							target === activePicker|| target === timePickable|| activePicker.contains(target)
						) {
							return;
						}
						document.removeEventListener("mousedown", onClickAway);
						document.body.removeChild(activePicker);
						activePicker = null;
					};

					document.addEventListener("mousedown", onClickAway);
				});
			});
		}

		function show(timePickable) {
			const picker = buildPicker(timePickable);
			const { bottom: top, left } = timePickable.getBoundingClientRect();	

			picker.style.top = `${top}px`;
			picker.style.left = `${left}px`;

			document.body.appendChild(picker);
			return picker;
		}
			
		function buildPicker(timePickable) {
			const picker = document.createElement("div");
			const hourOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map(numberToOption);
			const minuteOptions = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55].map(numberToOption);

			picker.classList.add("time-picker");
			picker.innerHTML = `
				<select class="time-picker__select">
					${hourOptions.join("")}
				</select>
				:
				<select class="time-picker__select">
					${minuteOptions.join("")}
				</select>
				<select class="time-picker__select text-primary">
					<option  value="am">AM</option>
					<option  value="pm">PM</option>
				</select>`;

			const selects = getSelectsFromPicker(picker);

			selects.hour.addEventListener("change", () => timePickable.value = getTimeStringFromPicker(picker));
			selects.minute.addEventListener("change", () => timePickable.value = getTimeStringFromPicker(picker));
			selects.meridiem.addEventListener("change", () => timePickable.value = getTimeStringFromPicker(picker));

			if (timePickable.value) {
				const { hour, minute, meridiem } = getTimePartsFromPickable(timePickable);

				selects.hour.value = hour;
				selects.minute.value = minute;
				selects.meridiem.value = meridiem;
			}

			return picker;
		}

		function getTimePartsFromPickable(timePickable) {
			const pattern = /^(\d+):(\d+) (am|pm)$/;
			const [hour, minute, meridiem] = Array.from(timePickable.value.match(pattern)).splice(1);

			return {
				hour,
				minute,
				meridiem
			};
		}

		function getSelectsFromPicker(timePicker) {
			const [hour, minute, meridiem] = timePicker.querySelectorAll(".time-picker__select");
			return {
				hour,
				minute,
				meridiem
			};
		}

		function getTimeStringFromPicker(timePicker) {
			const selects = getSelectsFromPicker(timePicker);

			return `${selects.hour.value}:${selects.minute.value} ${selects.meridiem.value}`;
		}

		function numberToOption(number) {
			const padded = number.toString().padStart(2, "0");

			return `<option value="${padded}">${padded}</option>`;
		}
		 
	  function populateTimezoneSelect() { 
	            const timezoneOptions = [
	                { value: "Pacific/Midway", text: "(GMT-11:00) Midway Island, Samoa" },
	                { value: "Asia/Tbilisi", text: "(GMT+03:00) Tbilisi" },
	                { value: "Asia/Tehran", text: "(GMT+03:30) Tehran" },
	                { value: "Europe/Sofia", text: "(UTC+03:00) Bulgaria" },
	                { value: "Asia/Muscat", text: "(GMT+04:00) Abu Dhabi, Muscat" },
	                { value: "Asia/Baku", text: "(GMT+04:00) Baku" },
	                { value: "Asia/Yerevan", text: "(GMT+04:00) Yerevan" },
	                { value: "Asia/Kabul", text: "(GMT+04:30) Kabul" },
	                { value: "Asia/Yekaterinburg" ,text: "(GMT+05:00) Yekaterinburg"},
	                { value: "Asia/Karachi" ,text: " (GMT+05:00) Islamabad, Karachi, Tashkent" },
	                { value: "Asia/Calcutta" ,text: "(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi" },
	                { value: "Asia/Calcutta" ,text: "(GMT+05:30) Sri Jayawardenapura" },
	                { value: "Asia/Katmandu" ,text: "(GMT+05:45) Kathmandu" },
	                { value: "Asia/Almaty" ,text: "(GMT+06:00) Almaty, Novosibirsk" },
	                { value: "Asia/Dhaka" ,text: "(GMT+06:00) Astana, Dhaka" },
	                { value: "Asia/Rangoon" , text: "(GMT+06:30) Yangon (Rangoon)" },
	    			{ value: "Asia/Bangkok" , text: "(GMT+07:00) Bangkok, Hanoi, Jakarta" },
	    			{ value: "Asia/Krasnoyarsk" , text: "(GMT+07:00) Krasnoyarsk" },
	    			{ value: "Asia/Hong_Kong" , text: "(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi" },
	    			{ value: "Asia/Kuala_Lumpur" , text: "(GMT+08:00) Kuala Lumpur, Singapore" },
	    			{ value: "Asia/Irkutsk" , text: "(GMT+08:00) Irkutsk, Ulaan Bataar" },
	    			{ value: "Asia/Taipei" , text: "(GMT+08:00) Taipei" },
	    			{ value: "Asia/Tokyo" , text: "(GMT+09:00) Osaka, Sapporo, Tokyo" },
	    			{ value: "Asia/Seoul" , text: "(GMT+09:00) Seoul" },
	    			{ value: "Asia/Kuwait" , text: "(GMT+03:00) Kuwait, Riyadh, Baghdad" },
	    			{ value: "Asia/Yakutsk" , text: "(GMT+09:00) Yakutsk" },
	    			{ value: "Asia/Jerusalem", text: "(GMT+02:00) Jerusalem" },
	    			{ value: "Asia/Beirut" , text: "(GMT+02:00) Beirut" },
	    			{ value: "Asia/Thimphu" , text: "(UTC +06:00) Bhutan" },
	    			{ value: "Asia/Rangoon", text:"(GMT+06:30) Yangon (Rangoon)" },
	    			{ value: "Asia/Bangkok" , text: "(GMT+07:00) Bangkok, Hanoi, Jakarta" },
	    			{ value: "Asia/Krasnoyarsk" , text: "(GMT+07:00) Krasnoyarsk" },
	    			{ value: "Asia/Hong_Kong" , text: "(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi" },
	    			{ value: "Asia/Kuala_Lumpur" , text: "(GMT+08:00) Kuala Lumpur, Singapore" },
	    			{ value: "Asia/Irkutsk" , text: "(GMT+08:00) Irkutsk, Ulaan Bataar" },
	    			{ value: "Asia/Taipei" , text: "(GMT+08:00) Taipei" },
	    			{ value: "Asia/Tokyo" , text: "(GMT+09:00) Osaka, Sapporo, Tokyo" },
	    			{ value: "Asia/Seoul" , text: "(GMT+09:00) Seoul" },
	    			{ value: "Asia/Kuwait" , text: "(GMT+03:00) Kuwait, Riyadh, Baghdad" },
	    			{ value: "Asia/Yakutsk" , text: "(GMT+09:00) Yakutsk" },
	    			{ value: "Asia/Jerusalem" , text: "(GMT+02:00) Jerusalem" },
	    			{ value: "Asia/Beirut" , text: "(GMT+02:00) Beirut" },
	    			{ value: "Asia/Thimphu" , text: "(UTC +06:00) Bhutan" },
	    			{ value: "Etc/GMT+12" , text: "(GMT-12:00) International Date Line West" },
	    			{ value: "Etc/UTC" , text: "(UTC +0000)Coordinated Universal Time (UTC)" },
	    			{ value: "Pacific/Midway" , text: "(GMT-11:00) Midway Island, Samoa" },
	    			{ value: "Pacific/Honolulu", text: "(GMT-10:00) Hawaii" },
	    			{ value: "US/Alaska", text: "(GMT-09:00) Alaska" },
	    			{ value: "America/Los_Angeles", text: "(GMT-08:00) Pacific Time (US & Canada)" },
	    			{ value: "America/Tijuana", text: "(GMT-08:00) Tijuana, Baja California" },
	    			{ value: "US/Arizona", text: "(GMT-07:00) Arizona" },
	    			{ value: "America/Chihuahua" , text: "(GMT-07:00) Chihuahua, La Paz, Mazatlan" },
	    			{ value: "US/Mountain", text: "(GMT-07:00) Mountain Time (US & Canada)" },
	    			{ value: "America/Managua", text: "(GMT-06:00) Central America" },
	    			{ value: "US/Central", text: "(GMT-06:00) Central Time (US & Canada)" },
	    			{ value: "America/Mexico_City", text: "(GMT-06:00) Guadalajara, Mexico City, Monterrey" },
	    			{ value: "Canada/Saskatchewan", text: "(GMT-06:00) Saskatchewan" },
	    			{ value: "America/Bogota", text: "(GMT-05:00) Bogota, Lima, Quito, Rio Branco" },
	    			{ value: "US/Eastern", text: "(GMT-05:00) Eastern Time (US & Canada)" },
	    			{ value: "US/East-Indiana", text: "(GMT-05:00) Indiana (East)" },
	    			{ value: "Canada/Atlantic", text: "(GMT-04:00) Atlantic Time (Canada)" },
	    			{ value: "America/Caracas", text: "(GMT-04:00) Caracas, La Paz" },
	    			{ value: "America/Manaus", text: "(GMT-04:00) Manaus" },
	    			{ value: "America/Santiago", text: "(GMT-04:00) Santiago" },
	    			{ value: "Canada/Newfoundland" , text: "(GMT-03:30) Newfoundland" },
	    			{ value: "America/Sao_Paulo" , text: "(GMT-03:00) Brasilia" },
	    			{ value: "America/Argentina/Buenos_Aires" , text: "(GMT-03:00) Buenos Aires, Georgetown" },
	    			{ value: "America/Godthab" , text: "(GMT-03:00) Greenland" },
	    			{ value: "America/Montevideo" , text: "(GMT-03:00) Montevideo" },
	    			{ value: "America/Noronha" , text: "(GMT-02:00) Mid-Atlantic" },
	    			{ value: "Atlantic/Cape_Verde" , text: "(GMT-01:00) Cape Verde Is." },
	    			{ value: "Atlantic/Azores" , text: "(GMT-01:00) Azores" },
	    			{ value: "Africa/Casablanca", text: "(GMT+00:00) Casablanca, Monrovia, Reykjavik" },
	    			{ value: "Etc/Greenwich", text: "(GMT+00:00) Greenwich Mean Time : Dublin, Edinburgh, Lisbon, London" },
	    			{ value: "Europe/Amsterdam", text: "(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna" },
	    			{ value: "Europe/Belgrade", text: "(GMT+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague" },
	    			{ value: "Europe/Brussels", text: "(GMT+01:00) Brussels, Copenhagen, Madrid, Paris" },
	    			{ value: "Europe/Sarajevo", text: "(GMT+01:00) Sarajevo, Skopje, Warsaw, Zagreb" },
	    			{ value: "Africa/Lagos", text: "(GMT+01:00) West Central Africa" },
	    			{ value: "Asia/Amman", text: "(GMT+02:00) Amman" },
	    			{ value: "Europe/Athens", text: "(GMT+02:00) Athens, Bucharest, Istanbul" },
	    			{ value: "Africa/Cairo", text: "(GMT+02:00) Cairo" },
	    			{ value: "Africa/Johannesburg", text: "(UTC +02:00) South Africa" },
	    			{ value: "Africa/Harare", text: "(GMT+02:00) Harare, Pretoria" },
	    			{ value: "Europe/Helsinki", text: "(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius" },
	    			{ value: "Europe/Dublin", text: "(UTC +01:00) Ireland" },
	    			{ value: "Europe/Minsk", text: "(GMT+02:00) Minsk" },
	    			{ value: "Africa/Windhoek", text: "(GMT+02:00) Windhoek" },
	    			{ value: "Europe/Moscow", text: "(GMT+03:00) Moscow, St. Petersburg, Volgograd" },
	    			{ value: "Africa/Nairobi", text: "(GMT+03:00) Nairobi" },
	    			{ value: "Australia/Perth", text: "(GMT+08:00) Perth" },
	    			{ value: "Australia/sydney", text: "(GMT+10) Time in Sydney NSW, Australia" },
	    			{ value: "Australia/Adelaide", text: "(GMT+09:30) Adelaide" },
	    			{ value: "Australia/Darwin", text: "(GMT+09:30) Darwin" },
	    			{ value: "Australia/Brisbane", text: "(GMT+10:00) Brisbane" },
	    			{ value: "Australia/Canberra", text: "(GMT+10:00) Canberra, Melbourne, Sydney" },
	    			{ value: "Australia/Hobart", text: "(GMT+10:00) Hobart" },
	    			{ value: "Pacific/Guam", text: "(GMT+10:00) Guam, Port Moresby" },
	    			{ value: "Asia/Vladivostok", text: "(GMT+10:00) Vladivostok" },
	    			{ value: "Asia/Magadan", text: "(GMT+11:00) Magadan, Solomon Is., New Caledonia" },
	    			{ value: "Pacific/Auckland", text: "(GMT+12:00) Auckland, Wellington,New Zealand" },
	    			{ value: "Pacific/Fiji", text: "(GMT+12:00) Fiji, Kamchatka, Marshall Is." },
	    			{ value: "Pacific/Tongatapu", text: "(GMT+13:00) Nuku'alofa" }
	    	
	            ];
	            
	            const select = document.getElementById("timezoneSelect");
	            // Loop through the timezone options and create option elements
	            timezoneOptions.forEach(option => {
	                const optionElement = document.createElement("option");
	                optionElement.value = option.value;
	                optionElement.textContent = option.text;
	                select.appendChild(optionElement);
	            });
	        }
	      
        </script>

<%@ include file="/include/footer.jsp"%>


<%@ include file="/include/header.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kanban Board</title>
        <style>
            .kanban-container {
                position: relative;
                box-sizing: border-box;
                width: auto;
                overflow: auto;
            }

            .active-pink .fa,
            .active-pink-2 .fa {
                color: #f48fb1;
            }
            .dark-version .kanban-item {
                background: transparent!important;
                border: 1px solid;
            }
            .dark-mode {
            	   
            	    background-color:#aebac4!important;
            	}
            .navbar-main {
                transition: box-shadow 0.25s ease-in, background-color 0.25s ease-in;
               
            }
           
            .kanban-container {
                display: flex;
                overflow-x: auto;
            }
            .text-sm {
                font-size: 0.700rem !important;
            }
            .mb-2 {
                margin-bottom: 0.2rem !important;
            }

            .gu-transit {
                box-shadow: inset 0 0 2px #fefefed1;
                -webkit-backdrop-filter: saturate(200%) blur(30px);
                backdrop-filter: saturate(200%) blur(30px);
                background-color: hsla(0, 0%, 100%, .8) !important;
                box-shadow: inset 0 0 1px 1px hsla(0, 0%, 100%, .9), 0 20px 27px 0 rgba(0, 0, 0, .05) !important
            }
            i.fas.fa-adjust.fa-lg {
                margin: 0px;
                padding: 15px;
                border-radius: 50%;
                border: 2px solid var(--ds-text-inverse, #FFFFFF);
                background-color: var(--ds-background-neutral, #F4F5F7);
                transition: background-color 0.1s ease-out 0s;
                cursor: pointer;
            }


            .searchButton {
                width: 40px;
                height: 36px;
                border: 1px solid #0062b4;
                background: #005eb4;
                text-align: center;
                color: #fff;
                border-radius: 0 5px 5px 0;
                cursor: pointer;
                font-size: 20px;
            }

            .searchTerm {

                border: 2px solid #0062b4;
                border-right: none;
                padding: 2px;
                // height: 20px;
                border-radius: 5px 0 0 5px;
                outline: none;
                color: #9DBFAF;
            }

            .search {
                padding-top: 10px;
                width: 100%;
                position: relative;
                display: flex;
            }

            i.fa-solid.fa-user-plus {
                margin: 0px;
                padding: 8px;
                border-radius: 50%;
                border: 2px solid var(--ds-text-inverse, #FFFFFF);
                background-color: var(--ds-background-neutral, #F4F5F7);
                transition: background-color 0.1s ease-out 0s;
                cursor: pointer;
            }


            .gu-mirror {
                opacity: .8;
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=80)";
                filter: alpha(opacity=80)
            }

            .gu-transit {
                opacity: .2;
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=20)";
                filter: alpha(opacity=20)
            }

            .kanban-board.is-moving.gu-mirror .kanban-drag {
                overflow: hidden;
                padding-right: 50px
            }

            .kanban-item {
                box-shadow: 3px 4px 5px 0px rgb(19 30 135 / 45%);
                border-radius: 17px;
               margin: 5px 0;
                cursor: grab;
            }
            .kanban-item {
                background: #fff;
                padding: 12px;
                margin-bottom: 20px;
                transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
            }

            .modal {
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1050;
                display: none;
                width: 100%;
                height: 100%;
                overflow-x: hidden;
                overflow-y: auto;
                outline: 0;
            }

            .kanban-board {
                position: relative;
                float: left;
                background: #d8dee7;
                transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
                border-radius: 0.5rem;
            }
            .kanban-item:hover {
                border: 1.5px solid #988ee9;
               
            }
            .kanban-item {
                box-shadow: 3px 4px 5px 0px rgb(19 30 135 / 45%);
                border-radius: 17px;
                 margin: 5px 0;
                cursor: grab;
            }

            h6.mb-2.text-sm {
                font-size: 0.875rem !important;
                font-weight: 400;
            }

            .kanban-board.is-moving.gu-mirror {
                transform: rotate(3deg)
            }

            .kanban-board.is-moving.gu-mirror .kanban-drag {
                overflow: hidden;
                padding-right: 50px
            }

            .kanban-item.is-moving.gu-mirror {
                transform: rotate(3deg);
                height: auto !important
            }

            .modal-content {
                opacity 1 !important;
            }

            .modal-backdrop.show {
                opacity: .5;
            }

            div#moreloadId {
                text-align: center;
            }

            .assignnameId {
                text-align: end;
            }

            p.split.left {
                text-align: end;
            }

            a.cursor-pointer {
                float: left;
            }

            .btn.btn-link.text-info.mb-0.border-0 {
                float: right;
                padding: 2px;
            }

            .progress {
                border: 0.5px solid #d9d0d0;
            }
        </style>
    </head>

    <iframe id="_hjSafeContext_670329" title="_hjSafeContext" tabindex="-1" aria-hidden="true" src="about:blank"
        style="display: none !important; width: 1px !important; height: 1px !important; opacity: 0 !important; pointer-events: none !important;"></iframe>

    <body class="g-sidenav-show  bg-gray-100 g-sidenav-hidden">
        <%@ include file="/include/leftnav.jsp" %>


        <!-- Main -->
    	<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
    	  
                <!-- Navbar -->
        		<nav class="navbar navbar-main navbar-expand-lg position-sticky top-0 px-0 shadow-none border-radius-xl z-index-sticky" id="navbarBlur" data-scroll="true">
        			<div class="container-fluid py-1 px-3" style="display: block !important">
        				<nav aria-label="breadcrumb">

        					<div class="row">
        						<div class="col-lg-2 col-md-3 col-sm-12 col-xs-12">
        							<h6 class="font-weight-bolder mb-0">
        								<span> Kanban</span>
        							</h6>
        							<div class="sidenav-toggler sidenav-toggler-inner">
        								<a href="javascript:;" class="nav-link text-body p-0">
        									<div class="sidenav-toggler-inner">
        										<i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i>
        									</div>
        								</a>
        							</div>
        						</div>
        						<div class="col-lg-2 col-md-3 col-sm-12 col-xs-12">



        							<div class="input-group input-group-static mb-2">
        								<select class="required form-control p-2" id="projectfiler_id" name="projectfilter" onchange="loadkanbanstatusList();">
        									<option value="">All Projects</option>
        								</select>
        							</div>
        						</div>

        						<div class="col-lg-2 col-md-3 col-sm-12 col-xs-12">
        							<div class="input-group input-group-static mb-2">
        								<select class="required form-control p-2" name="" id="searchbyId" onchange="loadkanbanstatusList();">
        									<!-- 	<option value="">Search_By</option> -->
        									<option value="last_3_months" <%=(equals("last_3_months") ? "selected='selected'" : "")%>>Last 3 Months</option>
        									<option value="this_month" <%=(equals("this_month") ? "selected='selected'" : "")%>>This Month</option>
        									<option value="this_week" <%=(equals("this_week") ? "selected='selected'" : "")%>>This Week</option>
        									<option value="yesterday" <%=(equals("yesterday") ? "selected='selected'" : "")%>>Yesterday</option>
        									<option value="today" <%=(equals("today") ? "selected='selected'" : "")%>>Today</option>
        									<option value="custom_dates" <%=(equals("custom_dates") ? "selected='selected'" : "")%>>Custom Dates</option>

        								</select>

        							</div>
        						</div>


        						<span id="errormessageforsearch_By" style="display: none; color: red">Please select to search !</span>

        						<div class="col-md-2" id="activitystartDateColid">
        							<div class="input-group input-group-dynamic">
        								<input class="multisteps-form__input form-control" type="date" placeholder="" name="filterStartDate" id="activityFilterStartDateid" />
        							</div>
        						<span id="errormessageforfromdateId" class="err-msg" style="display: none; color: red;">Please select a date..!</span> 
        						<span id="errMsgDateCompare" class="err-msg" style="display: none; color: red">From date is greater than to date..! </span>
        					   <span id="errormessagefordiffDaysId" class="err-msg" style="display: none; color: red">Date difference should be in 90 days..! </span>
        					
        						</div>

        						
        						<div class="col-md-2" id="activityendDateColid">
        							<div class="input-group input-group-dynamic">
        								<input class="multisteps-form__input form-control" type="date" placeholder="" name="filterEndDate" id="activityFilterEndDateid" />
        							</div>
        							<span id="errormessagefortodateId" class="err-msg" style="display: none; color: red">Please select a date..!</span>
        						</div>
        						<div class="col-md-1 rightalign">
        							<button class="btn btn-icon btn-2 btn-dark" id="searchId" type="button" onclick="loadkanbanstatusList();">
        								<span class="btn-inner--icon"><i class="material-icons">search</i></span>
        							</button>
        						</div>

        						<div class="col-md-0 col-lg-1 col-sm-12  rightalign">
        					

        						<i class="fa-duotone fa-chart-kanban"></i>		
        						</a>
        					
        						<a href="alllog.jsp" class=" rightalign col-sm-6 col-md-6 col-lg-6">
        						<i class="material-icons fixed-plugin-button-nav cursor-pointer text-info" data-bs-toggle="tooltip"  data-bs-placement="bottom" data-bs-original-title="Messages" > forum </i>
        									</a>
        						
        						<a href="activity.jsp" class=" rightalign col-sm-6 col-md-6 col-lg-6">
        						<i class="material-icons position-relative text-lg pe-2 text-info" data-bs-toggle="tooltip"  data-bs-placement="bottom" data-bs-original-title="Activities">splitscreen</i>
        						</a>
        					</div>
        				</div>
        			</nav>
        		</div>
        	</nav>


        		<!--End Navbar -->
                
        		 <div class="search">
                 <input type="text" class="searchTerm" id="kanbanSearchId" placeholder="Search this board">
                 <button type="submit" class="searchButton" onclick="loadEmployeeList();">
                     <i class="fa fa-search"></i>
                 </button>
                 
             </div>

                
                
                
                
                
                </nav>

                <!--End Navbar -->

                <tbody id="mysummarybodyId">

                <tbody id="mysummarybyprioritybodyId">
                </tbody>

                <!-- kanban start -->

                <div class="mt-3 kanban-container" id="kanbancontainerId">
                    <div class="py-2 min-vh-100 d-inline-flex" style="overflow-x: auto">
                        <div id="myKanban">
                            <div class="kanban-container" style="width: 100%;">
                                <div class="py-2 min-vh-100 d-inline-flex" ondrop="drop(event)"
                                    ondragover="allowDrop(event)" style="overflow-x: auto">

                                    <!--NEW MASTER    -->

                                    <div data-id="_new" data-order="2" class="kanban-board" draggable="true"
                                        style="width: 305px; margin-left: 10px; margin-right: 10px"
                                        ondragstart="dragStart(event)" ondragend="dragEnd(event)">
                                        <header class="kanban-board-header">
                                            <div class="kanban-title-board">NEW<span id="newCount"></span></div>
                                            <div data-bs-toggle="modal" data-bs-target="#newTask"
                                                onclick="showNewTaskModel()"
                                                class="btn btn-link text-info  mb-0 border-0" data-bs-toggle="tooltip"
                                                data-bs-placement="bottom" data-bs-original-title="New Task">
                                                <i class="material-icons text-lg">add_box</i> Task
                                            </div>


                                        </header>
                                        <main class="kanban-drag" id="tasknewbodyId">
                                            <!-- Your task items go here -->
                                        </main>
                                        <div class="text-center">
                                            <a id="loadmorenewId" href="#"
                                                onclick="moreloadTaskList(4)"><strong>Load More...</strong></a>
                                        </div>

                                    </div>


                                    <!--NEW MASTER END   -->

                                    <!--IN-PROGRESS MASTER   -->
                                    <div data-id="_progress" data-order="2" class="kanban-board"
                                        style="width:305px; margin-left: 10px; margin-right: 10px" draggable="true"
                                        ondragstart="dragStart(event)" ondragend="dragEnd(event)">
                                        <header class="kanban-board-header">
                                            <div class="kanban-title-board">IN-PROGRESS <span
                                                    id="inProgressCount"></span></div>
                                        </header>
                                        <main class="kanban-drag" id="tasktgridinprogressbodyId">
                                            <!-- Your task items go here -->
                                        </main>
                                        <div class="text-center">
                                            <a id="loadmoreinprogressId" href="#"
                                                onclick="moreloadTaskList(3)"><strong>Load More...</strong></a>
                                        </div>

                                    </div>
                                    <!--IN-PROGRESS MASTER END   -->

                                    <!-- RE- OPEN  MASTER   -->

                                    <div data-id="_reopen" data-order="3" class="kanban-board" draggable="true"
                                        style="width: 305px; margin-left: 10px; margin-right: 10px" draggable="true"
                                        ondragstart="dragStart(event)" ondragend="dragEnd(event)">
                                        <header class="kanban-board-header">
                                            <div class="kanban-title-board">RE-OPEN<span id="reopenCount"></span>
                                            </div>

                                        </header>
                                        <main class="kanban-drag" id="mytaskreopenbodyId">
                                            <!-- Your task items go here -->
                                        </main>
                                        <div class="text-center">
                                            <a id="moreloadre-openid" href="#"
                                                onclick="moreloadTaskList(2)"><strong>Load More...</strong></a>
                                        </div>

                                    </div>

                                    <!-- RE- OPEN  MASTER END   -->


                                    <!-- OVERDUE  MASTER  -->

                                    <div data-id="_overdueId" data-order="4" class="kanban-board" draggable="true"
                                        style="width: 305px; margin-left: 10px; margin-right: 10px;" draggable="true"
                                        ondragstart="dragStart(event)" ondragend="dragEnd(event)">

                                        <header class="kanban-board-header">
                                            <div class="kanban-title-board">OVERDUE<span id="overdueCount"></span>
                                            </div>
                                            <a href="#" class="text-md font-weight-bold"
                                                onclick="loadtasklistbystatus()"></a>

                                        </header>

                                        <main class="kanban-drag" id="mytaskoverdueidbodyId">


                                        </main>
                                        <div class="text-center">
                                            <a id="moreloadoverdueid" href="#" onclick="moreloadTaskList(1)">
                                                <strong>Load More...</strong></a>
                                        </div>
                                    </div>

                                    <!-- OVERDUE  MASTER END   -->

                                    <!--FEEDBACK MASTER    -->

                                    <div data-id="_feedback" data-order="5" class="kanban-board"
                                        style="width: 305px; margin-left: 10px; margin-right: 10px" draggable="true"
                                        ondragstart="dragStart(event)" ondragend="dragEnd(event)">
                                        <header class="kanban-board-header">
                                            <div class="kanban-title-board">FEEDBACK <span id="feedbackCount"></span>
                                            </div>

                                        </header>
                                        <main class="kanban-drag" id="taskfeedbackbodyId">



                                        </main>
                                        <div class="text-center">
                                            <a id="loadmorefeedbackId" href="#"
                                                onclick="moreloadTaskList(5)"><strong>Load More...</strong></a>
                                        </div>

                                    </div>

                                    <!--FEEDBACK MASTER END   -->

                                    <!--RESOLVED    MASTER    -->

                                    <div data-id="_resolved" data-order="6" class="kanban-board"
                                        style="width: 305px; margin-left: 10px; margin-right: 10px" draggable="true"
                                        ondragstart="dragStart(event)" ondragend="dragEnd(event)">
                                        <header class="kanban-board-header">
                                            <div class="kanban-title-board">RESOLVED <span id="resolvedCount"></span>
                                            </div>

                                        </header>
                                        <main class="kanban-drag" id="taskresolvedbodyId">



                                        </main>
                                        <div class="text-center">
                                            <div class="text-center">
                                                <a id="loadmoreresolvedId" href="#" onclick="moreloadTaskList(6)">
                                                    <strong>Load More...</strong></a>
                                            </div>
                                        </div>
                                    </div>

                                    <!--RESOLVED MASTER END   -->


                                    <!--CLOSED MASTER -->

                                    <div data-id="_closed" data-order="7" class="kanban-board"
                                        style="width: 305px; margin-left: 10px; margin-right: 10px" draggable="true"
                                        ondragstart="dragStart(event)" ondragend="dragEnd(event)">
                                        <header class="kanban-board-header">
                                            <div class="kanban-title-board">CLOSED<span id="closedCount"></span>
                                            </div>
                                        </header>
                                        <main class="kanban-drag" id="taskclosedbodyId">
                                        </main>
                                        <div class="text-center">
                                            <div class="text-center">
                                                <a id="loadmorecloseId" href="#" onclick="moreloadTaskList(7)">
                                                    <strong>Load More...</strong></a>
                                            </div>
                                        </div>

                                    </div>

                                    <!--CLOSED MASTER END   -->

                                    <div class="modal fade" id="new-board-modal" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content" id="openModel">
                                                <div class="modal-header">
                                                    <h5 class="h5 modal-title">Choose your new Board Name</h5>
                                                    <button type="button" class="btn close pe-1" data-dismiss="modal"
                                                        data-target="#new-board-modal" aria-label="Close">
                                                        <span aria-hidden="true">x</span>
                                                    </button>
                                                </div>
                                                <div class="pt-4 modal-body">
                                                    <div class="mb-4 input-group">
                                                        <span class="input-group-text">
                                                            <i class="far fa-edit" aria-hidden="true"></i>
                                                        </span>
                                                        <input class="form-control" placeholder="Board Name" type="text"
                                                            id="jkanban-new-board-name" onfocus="focused(this)"
                                                            onfocusout="defocused(this)">
                                                    </div>
                                                    <div class="text-end">
                                                        <button class="m-1 btn btn-primary" id="jkanban-add-new-board"
                                                            data-toggle="modal" data-target="#new-board-modal">
                                                            Save changes
                                                        </button>
                                                        <button class="m-1 btn btn-secondary" data-dismiss="modal"
                                                            data-target="#new-board-modal">
                                                            Close
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="hidden opacity-50 fixed inset-0 z-40 bg-black"
                                        id="new-board-modal-backdrop"></div>

            </main>
            </div>
            </div>
            </div>
            </div>
            </div>

            <!-- new create task -->

            <div class="modal fade" id="newTask" tabindex="-1" role="dialog" aria-labelledby="newTaskLabel"
                aria-hidden="true">
                <div class="modal-dialog  modal-xl modal-dialog-centered" role="document">
                    <div class="modal-content model-content-css">
                        <!--Header-->
                        <div class="modal-header p-2">
                            <h5 class="modal-title" id="newTaskLabel">New Task</h5>
                            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal"
                                aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <!--Body-->
                        <div class="modal-body p-0">
                            <div class="container-fluid">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-lg-12 col-md-12">
                                                <form name="taskform" method="post" id="taskformId" onsubmit="">
                                                    <input type="hidden" name="actionType" id="action_type_id"
                                                        value="createtask" />
                                                    <input type="hidden" name="taskid" id="taskid_id" value="" />
                                                    <div class="row">
                                                        <div class="col-md-6 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Project <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <select class="required form-control p-2"
                                                                    id="project_id" name="project"
                                                                    onchange="loadAssignee(this.value)">
                                                                    <option value="">Select Project</option>
                                                                </select> <span class="msgError"
                                                                    id="msgError_project_id"></span>
                                                            </div>
                                                        </div>


                                                        <div class="col-md-6 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Task Name <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <input type="text" class="required form-control"
                                                                    name="task_name" id="task_name_id">
                                                                <span class="msgError"
                                                                    id="msgError_task_name_id"></span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Task Description </label>
                                                                <textarea class=" form-control" rows="2"
                                                                    placeholder="This is how others will learn about the task, so make it good!"
                                                                    spellcheck="false" name="task_description"
                                                                    id="task_description_id"></textarea>
                                                                <span class="msgError"
                                                                    id="msgError_task_description_id"></span>

                                                            </div>
                                                        </div>


                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-3 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Type <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <select class="required form-control p-2"
                                                                    id="taskType_id" name="taskType">
                                                                </select> <span class="msgError"
                                                                    id="msgError_taskType_id"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Priority <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <select class="required form-control p-2"
                                                                    id="taskPriority_id" name="taskPriority">
                                                                </select> <span class="msgError"
                                                                    id="msgError_taskPriority_id"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Status <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <select class="required form-control p-2"
                                                                    id="taskStatus_id" name="taskStatus">
                                                                </select> <span class="msgError"
                                                                    id="msgError_taskStatus_id"></span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Assignee<sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <select class="required form-control p-2"
                                                                    id="assignee_id" name="assignee">
                                                                    <option value="">Select Assignee</option>
                                                                </select> <span class="msgError"
                                                                    id="msgError_assignee_id"></span>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-3 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Start Date</label> <input type="date"
                                                                    class="form-control" name="start_date"
                                                                    id="start_date_id" required="required">
                                                            </div>
                                                        </div>

                                                        <div class="col-md-3 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Due Date</label> <input type="datetime-local"
                                                                    class="form-control" name="due_date"
                                                                    id="due_date_id">
                                                            </div>
                                                        </div>

                                                        <div class="col-md-3 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Estimated time (Hours)</label> <input
                                                                    type="number" class="form-control"
                                                                    id="estimeted_time_id" name="estimeted_time">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3 col-sm-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>% Done</label> <select class="form-control p-2"
                                                                    id="done_value_id" name="done_value"
                                                                    required="required">
                                                                    <option value="0">0%</option>
                                                                    <option value="10">10%</option>
                                                                    <option value="20">20%</option>
                                                                    <option value="30">30%</option>
                                                                    <option value="40">40%</option>
                                                                    <option value="50">50%</option>
                                                                    <option value="60">60%</option>
                                                                    <option value="70">70%</option>
                                                                    <option value="80">80%</option>
                                                                    <option value="90">90%</option>
                                                                    <option value="100">100%</option>
                                                                </select>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div class="row">
                                                                <div class=" col-md-3 col-sm-12">
                                                                    <label class="form-check px-2 py-1 is-filled">Add
                                                                        Followers
                                                                    </label>
                                                                </div>
                                                                <div class=" col-md-6 col-sm-12">
                                                                    <div class="form-check lx-4 py-1">
                                                                        <input class="form-check-input" type="checkbox"
                                                                            name="chkaddAllfollowers" value="1"
                                                                            id="addAllcheckboxId"> <label
                                                                            class="mb-0 position-relative text-sm">Add
                                                                            All</label>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-3 col-md-3 col-sm-12 ">
                                                                    <div class="input-group input-group-static mb-4">
                                                                        <select class="form-control p-2"
                                                                            id="searchdepartment_id"
                                                                            name="departmentfilter"
                                                                            onchange="loadFollowers($('#project_id').val(),this.value);">
                                                                            <option value="0">All Department</option>
                                                                        </select> <span class="msgError"
                                                                            id="msgError_searchdepartment_id"></span>
                                                                    </div>
                                                                </div>

                                                                <div class=" mb-4">
                                                                    <div class="row" id="followerlistid"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row justify-content-md-end mt-4">
                                                        <div class="col-md-auto text-end px-1 d-none d-lg-block">
                                                            <button type="button" class="btn bg-gradient-info"
                                                                id="save&createid" onclick="cearenewtask();"
                                                                onblur="showNewTaskModalAgain();">Save
                                                                &amp Create</button>
                                                        </div>
                                                        <div class="col-md-auto text-end px-1">
                                                            <button type="button" class="btn bg-gradient-info"
                                                                id="taskactionid"
                                                                onclick="cearenewtask();">Save</button>
                                                            <button type="button" class="btn btn-link ml-auto"
                                                                data-bs-dismiss="modal">Close</button>
                                                        </div>
                                                    </div>
                                                    <div id="sandcdivid" class="col-md-auto text-end d-block d-lg-none">
                                                        <button type="button" class="btn bg-gradient-info"
                                                            id="save&createid" onclick="cearenewtask();"
                                                            onblur="showNewTaskModalAgain();">Save &amp
                                                            Create</button>

                                                    </div>

                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- new create task end -->

            <!-- Modal For Add Time Log -->

            <div class="modal fade" id="taskTimeLog" tabindex="-1" role="dialog" aria-labelledby="taskTimeLogLabel"
                aria-hidden="true">
                <div class="modal-dialog  modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content model-content-css">
                        <!--Header-->
                        <div class="modal-header ">
                            <h6 class="modal-title">Add Time</h6>
                            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal"
                                aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <!--Body-->
                        <div class="modal-body">
                            <div class="container-fluid">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-lg-12 col-md-12">
                                                <form name="taskform" id="tasklogformId">
                                                    <input type="hidden" name="taskId" id="taskid_id" value="" /> <input
                                                        type="hidden" name="actionType" id="actionType" value="" />
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Date <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <input type="date" class="form-control"
                                                                    name="task_log_date" id="task_log_date_id"
                                                                    required="required"> <span class="msgError"
                                                                    id="msgError_task_log_date_id"></span>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Hours <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <input type="number" class="form-control"
                                                                    id="task_log_hours_id" name="task_log_hours"
                                                                    required="required"> <span class="msgError"
                                                                    id="msgError_task_log_hours_id"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Comments <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <textarea class="required form-control" rows="2"
                                                                    placeholder="Add details about task related activity.."
                                                                    spellcheck="false" name="task_comments"
                                                                    id="task_comments_id"></textarea>
                                                                <span class="msgError"
                                                                    id="msgError_task_comments_id"></span>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="input-group input-group-static mb-4">
                                                                <label>Activity <sup><i
                                                                            class="fa fa-asterisk"></i></sup></label>
                                                                <select class="required form-control p-2"
                                                                    id="taskActivity_id" name="taskActivity">

                                                                </select> <span class="msgError"
                                                                    id="msgError_taskActivity_id"></span>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </form>
                                                <form enctype="multipart/form-data" method="post"
                                                    id="updateAttachForm_Id"
                                                    onsubmit="return validateServiceDetails('updateAttachForm_Id');">
                                                    <input type="hidden" name="task_id" id="taskidforfile_id"
                                                        value="" />
                                                    <div class="row" id="attachFormId">
                                                        <div class="col-12 position-relative">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <div class="row">
                                                                        <div class="row" id="uploadbtn_div">
                                                                            <div class="col-md-2">
                                                                                <label>Upload File</label>
                                                                            </div>
                                                                            <div class="col-md-2" id="btnFile">
                                                                                <input type="button" id="uploadbtn_Id"
                                                                                    class="btn bg-gradient-info mt-2"
                                                                                    value="Upload File"
                                                                                    onclick="showFileInput();">
                                                                            </div>
                                                                        </div>
                                                                        <div class="row my-2" id="logfilerow_id" hidden>

                                                                            <div class="col-md-6">
                                                                                <input type="file"
                                                                                    class="form-control form-control-sm"
                                                                                    id="updateAttachment_id"
                                                                                    name="updateAttachment"
                                                                                    accept=".csv, application/vnd.ms-excel,text/plain, application/pdf, image/*">
                                                                                <span id="logfile_msgErrorId"
                                                                                    class="msgError">File
                                                                                    too
                                                                                    Big,
                                                                                    please select a file less
                                                                                    than 10 Mb</span>
                                                                            </div>
                                                                            <div class="col-md-2">
                                                                                <input type="button" id="cancelbtn_id"
                                                                                    class="btn btn-link ml-auto"
                                                                                    value="Cancel"
                                                                                    onclick="removeFileInput();">
                                                                            </div>
                                                                            <div class="p-3 pt-2" id="logfileTableData"
                                                                                hidden>
                                                                                <div class="mx-2">
                                                                                    <table
                                                                                        class="table table-flush text-sm">
                                                                                        <thead>
                                                                                            <tr>
                                                                                                <th>Document
                                                                                                </th>
                                                                                                <th></th>
                                                                                            </tr>
                                                                                        </thead>
                                                                                        <tbody id="logFileTbodyid">
                                                                                            <tr class="row">
                                                                                                <td class="col-md-6 ">
                                                                                                    <input type="text"
                                                                                                        id="logFilechossedid"
                                                                                                        class="form-control">
                                                                                                </td>
                                                                                                <td class="col-md-6 ">
                                                                                                    <textarea
                                                                                                        type="textarea"
                                                                                                        id="logFileDescriptionid"
                                                                                                        class="required form-control"
                                                                                                        rows="2"
                                                                                                        cols="50"
                                                                                                        name="descriptionforfile"
                                                                                                        onfocus="focused(this)"
                                                                                                        placeholder="Description"
                                                                                                        onfocusout="defocused(this)"></textarea><span
                                                                                                        class="msgError"
                                                                                                        id="msgError_logFileDescriptionid"></span>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                                <div>
                                                                                    <input type="button"
                                                                                        class="btn bg-gradient-dark btn-sm float-end mt-2 mx-3 rounded-1 mb-0"
                                                                                        id="logFileSavebtn_id"
                                                                                        value="save">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row" id="logFilesListId" hidden>
                                                                            <div class="table-responsive">
                                                                                <table
                                                                                    class="table table-flush text-sm">
                                                                                    <thead class="thead-light">
                                                                                        <tr>
                                                                                            <th>Actions</th>
                                                                                            <th>Document Name
                                                                                            </th>
                                                                                            <th>Description</th>
                                                                                            <th>Uploaded Date
                                                                                            </th>
                                                                                        </tr>
                                                                                    </thead>
                                                                                    <tbody id="logFiletBody">
                                                                                    </tbody>
                                                                                </table>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                                <div class="row justify-content-md-end mt-4 text-end">
                                                    <div class="justify-content-end px-1">
                                                        <button type="button" class="btn bg-gradient-info"
                                                            onclick=" savetasklog();" id="tasklogid">Save</button>

                                                        <button type="button" class="btn btn-link  ml-auto"
                                                            data-bs-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Modal For Add Time Log -->

          

            <!-- PAGE NO DETAILS -->

            <input type="hidden" id="oPageNo1" value="1" />
            <input type="hidden" id="rPageNo2" value="1" />
            <input type="hidden" id="iPageNo3" value="1" />
            <input type="hidden" id="nPageNo4" value="1" />
            <input type="hidden" id="fPageNo5" value="1" />
            <input type="hidden" id="rPageNo6" value="1" />
            <input type="hidden" id="cPageNo7" value="1" />

            </div>
            </main>
    </body>


    <!--   Core JS Files   -->
    <script src="assets/js/core/popper.min.js"></script>
    <script src="assets/js/core/bootstrap.min.js"></script>
    <script src="assets/js/plugins/perfect-scrollbar.min.js"></script>
    <script src="assets/js/plugins/smooth-scrollbar.min.js"></script>
    <script src="assets/js/plugins/datatables.js"></script>
    <script src="assets/js/plugins/choices.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Kanban scripts -->
    <script src="assets/js/plugins/dragula/dragula.min.js"></script>
    <script src="assets/js/plugins/jkanban/jkanban.js"></script>
    <script src="assets/js/material-dashboard.min.js?v=3.0.6"></script>


    <script>
        function allowDrop(event) {             // kanban board  allow drop and drand drop function  and event pravent defalut function 
            event.preventDefault();
        }

        function drag(event) {
            event.dataTransfer.setData("text", event.target.innerText);
        }

        function drop(event) {
            event.preventDefault();
            const data = event.dataTransfer.getData("text");
            const newItem = document.createElement("div");
            newItem.className = "kanban-item ";
            newItem.draggable = true;
            newItem.innerText = data;
            newItem.ondragstart = drag;
            event.target.appendChild(newItem);
        }

        let draggedElement = null;

        function allowDrop(event) {
            event.preventDefault();
        }

        function drag(event) {
            draggedElement = event.target;
        }




        function drop(event) {              // kanban dragged and drop function 

            var tasknoid;
            event.preventDefault();
            const container = event.target;
            //  container.appendChild(draggedElement);

            if (container && draggedElement) {
                tasknoid = draggedElement.id;
                // Append the dragged element to the new container
                //  container.appendChild(draggedElement);
            } else {
                console.log("Container or dragged element not found.");
            }

            draggedElement = null;
            var StatusName = container.closest(".kanban-board").querySelector(".kanban-title-board").textContent;
            StatusName = StatusName.split(" ")[0];
            console.log(StatusName);
            if (StatusName == "IN-PROGRESS") {
                StatusName = "IN PROGRESS";
            }
            kanbangroupupdateStatus(tasknoid, StatusName);

        }
 //  checking and other functionlly 

        function closemodel() {
            $("#jkanban-info-modal").hide();
            var targetElement = document.querySelector('.g-sidenav-hidden .navbar-vertical.fixed-start+.main-content');


        }

        function openModel() {
            $("#jkanban-info-modal").show();
            var targetElement = document.querySelector('.g-sidenav-hidden .navbar-vertical.fixed-start+.main-content');


        }


        function dragStart(event) {
            event.dataTransfer.setData("text/plain", event.target.id);
        }

        function dragEnd(event) {

            event.preventDefault(); // Prevent the default behavior

            var data = event.dataTransfer.getData("text/plain");

            // For example, you can log the ID of the dragged element
            console.log("Dropped element ID: " + data);
        }

    </script>

    <script>
                                                    // Function to open the modal
        function openModal() {
            var modal = document.getElementById("jkanban-info-modal");
            modal.style.display = "block"; // Show the modal
            modal.classList.add("show"); // Add the 'show' class
        }

        // Function to close the modal
        function closeModal() {
            var modal = document.getElementById("jkanban-info-modal");
            modal.style.display = "none"; // Hide the modal
            modal.classList.remove("show"); // Remove the 'show' class
        }
    </script>

    <script type="text/javascript">
        var totalListCount = 0;
        var prevRows;
        var array = [];


        $("#activityFilterStartDateid").hide();
        $("#activityFilterEndDateid").hide();
          $("#searchId").hide();

        function showFileInput() {                     // function update button , cancel button , 
            $("#uploadbtn_div").prop("hidden", true);
            $("#logfilerow_id").prop("hidden", false);
            $("#cancelbtn_id").prop("hidden", false);
            $("#updateAttachment_id").prop("hidden", false);
        }

       
        
        
        
        

        $(function () {                 // kanban function frist is data apends 
            //  updateStatusCounts();
              loadSummaryOnReady();
            loadkanbanstatusList();
             loadTaskStatusList();
            loadtasklistbystatus();
            loadTaskStatusList();
            loadTaskPriorityList();
            loadTaskTypeList();
            loadTaskActivityList();
            loadEmployeeList();
            loadProjectList();
            loadDepartmentList();
          
            
            
            $($('#taskStatuschartId').children().children().children()[3]).attr('display', 'none');

        });

    </script>
    <script>
        document.addEventListener("drop", function (event) {       // kanban board drang drop and is moveinng function 


            event.preventDefault();
            const data = event.dataTransfer.getData("text/plain");
            const target = event.target;

            if (target.classList.contains("kanban-board")) {
                // Create a new row (a new container)
                const newRow = document.createElement("div");
                newRow.classList.add("kanban-row"); // You can add appropriate classes

                // Add the "is-moving" class to the new row (if needed)
                newRow.classList.add("is-moving");

                // Get the dragged element
                const draggedElement = document.getElementById(data);

                // Append the dragged element to the new row
                newRow.appendChild(draggedElement);

                // Append the new row to the kanban board
                target.appendChild(newRow);
            }
        });
    </script>




    <script>
        /***** function use for default filter *****/
        function loadMyTaskListByDate(search) {
        	debugger;
            $('#errormessageforfromdateId').hide();
            $('#errormessagefortodateId').hide();
            $('#errMsgDateCompare').hide();
            $('#errormessagefordiffDaysId').hide();

            if (search != undefined) {
                var from_date = $("#activityFilterStartDateid").val();
                var to_date = $("#activityFilterEndDateid").val();


                var startdate = new Date(from_date);
                var endDate = new Date(to_date);
                var diffTime = Math.abs(endDate - startdate);
                var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

                if (from_date == "") {
                    $('#errormessageforfromdateId').show();
                }
                else if (to_date == "") {
                    $('#errormessageforfromdateId').hide();
                    $('#errormessagefortodateId').show();
                }
                else if (from_date > to_date) {
                    $('#errormessageforfromdateId').hide();
                    $('#errormessagefortodateId').hide();

                    $('#errMsgDateCompare').show();
                }
                else if (diffDays > 90) {
                    $('#errormessageforfromdateId').hide();
                    $('#errormessagefortodateId').hide();
                    $('#errMsgDateCompare').hide();

                    $('#errormessagefordiffDaysId').show();
                    return;
                }
                else {
                    $('#errormessageforfromdateId').hide();
                    $('#errormessagefortodateId').hide();
                    $('#errMsgDateCompare').hide();
                    $('#errormessagefordiffDaysId').hide();
                }
            }

            if ($('#searchbyId').val() != 'custom_dates') {

                $("#activityFilterStartDateid").val("");
                $("#activityFilterEndDateid").val("");

                $("#activityFilterStartDateid").hide();
                $("#activityFilterEndDateid").hide();
                $("#searchId").hide();
            }

            $('#cPageNo').val(1);
            if ($('#projectfiler_id').val() == "") {
                loadSummaryOnReady();
                loadSummaryByPriorityOnReady();
            } else {
                loadSummary();
                loadSummaryByPriority();
            }

            $("#showMsgId").hide();
            $('#mytasktbodyId').empty();
            $('#mytasktgridbodyId').empty();
            $('#mytaskcount').empty();

            if ($("#activityFilterStartDateid").val() == '') {
                if ($('#searchbyId').val() == "custom_dates") {
                    $("#activityFilterStartDateid").show();
                    $("#activityFilterEndDateid").show();
                    $("#searchId").show();
                    $("#loadmoreid").hide();
                    return;
                }
                else {
                    $("#activityFilterStartDateid").val("");
                    $("#activityFilterEndDateid").val("");
                    $("#activityFilterStartDateid").hide();
                    $("#activityFilterEndDateid").hide();
                    $("#searchId").hide();
                }
            }
            else {
                $("#loadmoreid").show();
            }
            
            jQuery.ajax({
                type: "POST",
                url: "kanban",
                data: {
                    actionType: 'kanbantasklist',
                    statusid: $('#filtertaskstatusid').val(),
                    priorityid: $('#filtertaskpriorityid').val(),
                    projectid: $('#projectfiler_id').val(),
                    searchBy: $('#searchbyId').val(),
                    from_date: from_date,
                    to_date: to_date,
                    startIndex: 0,
                    endIndex: 5
                },
                async: true,
                success: function (data) {
                    $('#loadmoreid').show();
                    if (data == "" || data == null) {
                        $('#mysummarybodyId').empty();
                        $('#mysummarybyprioritybodyId').empty();
                     
                    }
                    console.log("list", data);
                    var jsonData = eval(data);
                    if (jsonData.length > 0) {
                        totalListCount = jsonData[0].count;
                        for (var i = 0; i < jsonData.length; i++) {
                            var rowdata = jsonData[i];
                            var newtaskrow = createtaskrow(rowdata);
                            //    $('#mytasktbodyId').append(newtaskrow);

                            var newtaskgridrow = createtaskgridrow(rowdata);
                          //  $('#mytasktgridbodyId').append(newtaskgridrow);
                        }
                    }
                    if (totalListCount <= 10) {
                        $('#loadmoreid').hide();
                    }
                    prevRows = 5;
                },
                error: function (data) {
                    alert("Error in process. Please try again.");
                }
            });
        }

        /*** function use for loadmore tasklist ***/

        function loadMoreTaskList() {
        	debugger;
            if ($('#projectfiler_id').val() == "") {
                loadSummaryOnReady();
                loadSummaryByPriorityOnReady();
            } else {
                loadSummary();
                loadSummaryByPriority();
            }

            if ($('#cPageNo').val() != '') {
                var cpage = parseInt($('#cPageNo').val()) + 1;
                $('#cPageNo').val(cpage)
                jQuery.ajax({
                    type: "POST",
                    url: "kanban",
                    data: {
                        actionType: 'kanbantasklist',
                        statusid: $('#filtertaskstatusid').val(),
                        priorityid: $('#filtertaskpriorityid').val(),
                        projectid: $('#projectfiler_id').val(),
                        searchBy: $('#searchbyId').val(),
                        from_date: $("#activityFilterStartDateid").val(),
                        to_date: $("#activityFilterEndDateid").val(),
                        startIndex: 0,
                        endIndex: 5,
                        pageNo: cpage
                    },
                    async: true,
                    success: function (data) {
                    	 $('#mytasktbodyId').empty();
                         $('#mytasktgridbodyId').empty();

                        console.log("loadmorelist", data)
                        var jsonData = eval(data);

                        if (jsonData.length > 0) {
                            prevRows = prevRows + jsonData.length;
                            for (var i = 0; i < jsonData.length; i++) {
                                var rowdata = jsonData[i];
                                var newtaskrow = createtaskrow(rowdata);
                                $('#mytasktbodyId').append(newtaskrow);

                                var newtaskgridrow = createtaskgridrow(rowdata);
                                $('#mytasktgridbodyId').append(newtaskgridrow);
                            }
                        }
                        if (totalListCount == prevRows) {
                            $('#loadmoreid').hide();
                        }

                    },
                    error: function (data) {
                        alert("Error in process. Please try again.");
                    }
                });
            }
        }

        function loadSummary() {          // function load summary  project id ,start date and end date 
            $('#mysummarybodyId').empty();
            jQuery.ajax({
                type: "POST",
                url: "kanban",
                data: {
                    actionType: 'kanbantasksummary',
                    projectfiler_id: $('#projectfiler_id').val(),
                    search_by: $('#searchbyId').val(),
                    projectID: $('#projectfiler_id').val(),
                    from_date: $("#activityFilterStartDateid").val(),
                    to_date: $("#activityFilterEndDateid").val()

                },
                async: true,
                success: function (data) {
                    var jsonData = eval(data);
                    var taskassociate = 0;
                    array = [];
                    if (jsonData.length > 0) {
                        for (var i = 0; i < jsonData.length; i++) {
                            var rowdata = jsonData[i];
                            taskassociate += rowdata.taskCount
                            var newsummaryrow = createsummaryrow(rowdata);
                            $('#mysummarybodyId').append(newsummaryrow);

                            var StatusColours = createStatusElementColors(rowdata.taskStatus, rowdata.taskStatusType);

                            array.push({ value: rowdata.taskCount, label: rowdata.taskStatus, color: StatusColours },);
                        }
                    }
                    $('#mytaskcount').empty();
                    $('#mytaskcount').append(taskassociate);
                    loadPiechartSummary('taskStatuschartId');
                },
                error: function (data) {
                    alert("Error in process. Please try again.");
                }
            });
        }

        function loadSummary() {           // kanban task summary function and prooject filer  , start date , end date
            $('#mysummarybodyId').empty();
            jQuery.ajax({
                type: "POST",
                url: "kanban",
                data: {
                    actionType: 'kanbantasksummary',
                    projectfiler_id: $('#projectfiler_id').val(),
                      search_by: $('#searchbyId').val(),
                    projectID: $('#projectfiler_id').val(),
                    from_date: $("#activityFilterStartDateid").val(),
                    to_date: $("#activityFilterEndDateid").val()

                },
                async: true,
                success: function (data) {
                    var jsonData = eval(data);
                    var taskassociate = 0;
                    array = [];
                    if (jsonData.length > 0) {
                        for (var i = 0; i < jsonData.length; i++) {
                            var rowdata = jsonData[i];
                            taskassociate += rowdata.taskCount
                            var newsummaryrow = createsummaryrow(rowdata);
                            $('#mysummarybodyId').append(newsummaryrow);

                            var StatusColours = createStatusElementColors(rowdata.taskStatus, rowdata.taskStatusType);

                            array.push({ value: rowdata.taskCount, label: rowdata.taskStatus, color: StatusColours },);
                        }
                    }
                    $('#mytaskcount').empty();
                    $('#mytaskcount').append(taskassociate);

                },
                error: function (data) {
                    alert("Error in process. Please try again.");
                }
            });
        }

        /**** This Function Use for Pie-chart colors ***/
        function createStatusElementColors(status, type) {
            switch (type) {
                case 1:
                    return '#f44335';
                    break;
                case 2:
                    return '#03a9f4';
                    break;
                case 3:
                    return '#03a9f4';
                    break;
                case 4:
                    return '#7b809a';
                    break;
                case 5:
                    return '#4caf50';
                    break;
                case 6:
                    return '#e91e63';
                    break;
                case 7:
                    return '#fb8c00';
                    break;
                default:
                    return '#7b809a';
            }
        }



        function loadSummaryByPriority() {              // kanban load summary By Priority function 
            $('#mysummarybyprioritybodyId').empty();
            jQuery.ajax({
                type: "POST",
                url: "kanban",
                data: {
                    actionType: 'tasksummarybypriority',
                    projectfiler_id: $('#projectfiler_id').val(),
                     search_by: $('#searchbyId').val(),
                    projectID: $('#projectfiler_id').val(),
                    from_date: $("#activityFilterStartDateid").val(),
                    to_date: $("#activityFilterEndDateid").val()
                },
                async: true,
                success: function (data) {
                    var jsonData = eval(data);
                    if (jsonData.length > 0) {
                        array = [];
                        for (var i = 0; i < jsonData.length; i++) {
                            var rowdata = jsonData[i];
                            var newsummaryrow = createprioritysummaryrow(rowdata);
                            //  $('#mysummarybyprioritybodyId').append(newsummaryrow);

                            var StatusColours = createPriorityElementColors(rowdata.taskPriority, rowdata.taskPriorityType);

                            array.push({ value: rowdata.taskCount, label: rowdata.taskPriority, color: StatusColours },);
                        }
                    }

                },
                error: function (data) {
                    alert("Error in process. Please try again.");
                }
            });
        }


        function loadSummaryByPriorityOnReady() {     // kanban summary By Priority On redy function 

            $('#mysummarybyprioritybodyId').empty();
            jQuery.ajax({
                type: "POST",
                url: "kanban",
                data: {
                    actionType: 'tasksummarybypriorityonready',
                    projectfiler_id: $('#projectfiler_id').val(),
                    search_by: $('#searchbyId').val(),
                    from_date: $("#activityFilterStartDateid").val(),
                    to_date: $("#activityFilterEndDateid").val()
                },
                async: true,
                success: function (data) {
                    var jsonData = eval(data);
                    array = [];

                    if (jsonData.length > 0) {
                        for (var i = 0; i < jsonData.length; i++) {
                            var rowdata = jsonData[i];
                            var newsummaryrow = createprioritysummaryrow(rowdata);
                            $('#mysummarybyprioritybodyId').append(newsummaryrow);

                            var StatusColours = createPriorityElementColors(rowdata.taskPriority, rowdata.taskPriorityType);

                            array.push({ value: rowdata.taskCount, label: rowdata.taskPriority, color: StatusColours },);
                        }
                    }
                    loadPiechartSummary('taskPrioritychartId');
                },
                error: function (data) {
                    alert("Error in process. Please try again.");
                }
            });
        }




        /**** This Function Use for Pie-chart colors ***/
        function createPriorityElementColors(status, type) {
            switch (type) {
                case 1:
                    return '#7b809a';
                    break;
                case 2:
                    return '#03a9f4';
                    break;
                case 3:
                    return '#fb8c00';
                    break;
                case 4:
                    return '#e91e63';
                    break;
                case 5:
                    return '#f44335';
                    break;
                case 6:
                    return '#EF5350 ';
                    break;
                default:
                    return '#7b809a';
            }
        }

        function loadCreatedTaskList() {      // kanban  load create task list  
            $('#createdtasktbodyId').empty();
            jQuery.ajax({
                type: "POST",
                url: "kanban",
                data: {
                    actionType: 'createdtasklist'
                },
                async: true,
                success: function (data) {
                    var jsonData = eval(data);
                    $('#createdtaskcount').text(jsonData.length);
                    if (jsonData.length > 0) {
                        for (var i = 0; i < jsonData.length; i++) {
                            var rowdata = jsonData[i];
                            var newtaskrow = createtaskrow(rowdata);
                            $('#createdtasktbodyId').append(newtaskrow);
                        }
                    }
                },
                error: function (data) {
                    alert("Error in process. Please try again.");
                }
            });
        }

        function createsummaryrow(data) {      // kanban  create summary row 

            var rowData = "<tr class='text-sm'>";
            rowData += "<td>"
                + createStatusElement(parseInt(data.taskStatusID),
                    data.taskStatus, data.taskStatusType) + "</td>";
            rowData += "<td> <a href='#' class='text-md font-weight-bold' onclick='loadtasklistbystatus("
                + data.taskStatusID + ")'>" + data.taskCount + "</a></td>";

            rowData += "<tr/>";
            return rowData;
        }

        function createprioritysummaryrow(data) {
            var rowData = "<tr class='text-sm'>";
            rowData += "<td>"
                + createPriorityElement(parseInt(data.taskPriorityId),
                    data.taskPriority, data.taskPriorityType) + "</td>";
            rowData += "<td> <a href='#' class='text-md font-weight-bold' onclick='loadtasklistbypriority("
                + data.taskPriorityId + ")'>" + data.taskCount + "</a></td>";

            rowData += "<tr/>";
            return rowData;
        }
        
        function loadtasklistbystatus(statusid) {
            $('#filtertaskstatusid').val(statusid);
            $('#filtertaskpriorityid').val('');
            //		loadMyTaskList();
            loadMyTaskListByDate();
        }

        function loadtasklistbypriority(priorityid) {
            $('#filtertaskstatusid').val('');
            $('#filtertaskpriorityid').val(priorityid);
            //		loadMyTaskList();
            loadMyTaskListByDate();
        }

        function createtaskrow(data) {        // create task row data  task status and task priority  
            var rowData = "<tr class='text-sm'>";
            rowData += "<td>" + getMenuItem(data.taskId) + "</td>";
            rowData += "<td>#" + data.taskId + ": " + data.taskName + "</td>";
            rowData += "<td>" + data.assigneeName + "</td>";
            rowData += "<td>" + data.projectName + "</td>";
            rowData += "<td>" + data.startDate + "</td>";
            rowData += "<td>" + data.dueDate + "</td>";
            rowData += "<td>" + data.taskCompletionValue + "</td>";

            rowData += "<td>"
                + createStatusElement(data.taskStatusId, data.taskStatus,
                    data.taskStatusType) + "</td>";
            rowData += "<td>"
                + createPriorityElement(data.taskPriorityId, data.taskPriority,
                    data.taskPriorityType) + "</td>";

            rowData += "<tr/>";
            return rowData;
        }


        function createtaskgridrow(data) {           //  create task  grid row and completion percentage  colors  
            var taskId = data.taskId; // Get the taskId
            var rowId = taskId; // Construct the id

            // Define different colors based on the completion percentage
            var progressBarColor; // Default color is primary

            if (data.taskCompletionValue <= 0) {
                progressBarColor = 'bg-danger'; // Red for completion = 0%
            } else if (data.taskCompletionValue < 25) {
                progressBarColor = 'bg-danger'; // Red for completion < 25%
            } else if (data.taskCompletionValue <= 50) {
                progressBarColor = 'bg-warning'; // Orange for completion <= 50%
            } else if (data.taskCompletionValue <= 75) {
                progressBarColor = 'bg-primary'; // Blue for completion <= 75%
            } else if (data.taskCompletionValue <= 100) {
                progressBarColor = 'bg-success'; // Green for completion <= 100%
            }

            var rowData = '<div class="Card kanban-item border-radius-md is-moving" draggable="true" ondragstart="drag(event)" id="' + rowId + '" onclick="kanbangroupupdateStatus(' + taskId + ')" > ' +
                '<p class="split left">' +
                getMenuItem(taskId) +
                createPriorityElement(data.taskPriorityId, data.taskPriority, data.taskPriorityType) +
                '<h6 class="mb-2 text-sm"> ' +
                '<div class="mb-2 text"> <i class="fas fa-user" style="color: #005eb4;"></i> &nbsp ' + taskId + ' : ' + data.taskName +
                '<br> ' + data.projectName + '<br> ' + data.dueDate + '</br>' +
                '<div class="assignnameId"> ' + data.assigneeName + '</div>' +
                //  'progressbar % : ' + data.taskCompletionValue + // Add taskEstimatedTime here
                '</div>' +
                '<div class="progress-wrapper">' +
                '<div class="progress-info">' +
                '<div class="progress-percentage">' +
                '<span class="text-sm font-weight-normal">' + data.taskCompletionValue + '%</span>' +
                '</div>' +
                '</div>' +
                '<div class="progress" role="progressbar" aria-label="Animated striped example" aria-valuenow="' + data.taskCompletionValue + '" aria-valuemin="0" aria-valuemax="100">' +
                '<div class="progress-bar ' + progressBarColor + ' progress-bar-striped progress-bar-animated" style="width: ' + data.taskCompletionValue + '%"></div>' +
                '</div>' +
                '</div>' +
               
                '<tbody id="mysummarybodyId"></tbody>' +
                '</div>';
            return rowData;
        }


        function createStatusElement(id, status, type) {   // kanban colur and id and status type 
            switch (type) {
                case 1:
                    return '<span class="badge badge-danger">' + status + '</span>';
                    break;
                case 2:
                    return '<span class="badge badge-info">' + status + '</span>';
                    break;
                case 3:
                    return '<span class="badge badge-info">' + status + '</span>';
                    break;
                case 4:
                    return '<span class="badge badge-secondary">' + status + '</span>';
                    break;
                case 5:
                    return '<span class="badge badge-success">' + status + '</span>';
                    break;
                case 6:
                    return '<span class="badge badge-primary">' + status + '</span>';
                    break;
                case 7:
                    return '<span class="badge badge-warning">' + status + '</span>';
                    break;
                default:
                    return '<span class="badge badge-secondary">' + status + '</span>';
            }
        }

        function createPriorityElement(id, prioirty, type) {     // creates priority Element  id and prioirty or type
            switch (type) {
                case 1:
                    return '<span class="badge bg-gradient-secondary">' + prioirty
                        + '</span>';
                    break;
                case 2:
                    return '<span class="badge bg-gradient-info">' + prioirty
                        + '</span>';
                    break;
                case 3:
                    return '<span class="badge bg-gradient-warning">' + prioirty
                        + '</span>';
                    break;
                case 4:
                    return '<span class="badge bg-gradient-primary">' + prioirty
                        + '</span>';
                    break;
                case 5:
                    return '<span class="badge bg-gradient-danger">' + prioirty
                        + '</span>';
                    break;
                case 6:
                    return '<span class="badge bg-gradient-danger">' + prioirty
                        + '</span>';
                    break;
                default:
                    return '<span class="badge bg-gradient-secondary">' + prioirty
                        + '</span>';
            }
        }
        function getMenuItem(taskid, taskname) {  // get menu iteam  task id and task name
            var rowData = '<a href="#" class="cursor-pointer btn-link  text-color-primary"  onclick="viewTask('
                + taskid + ');">';
            rowData += '<i class="material-icons text-xl me-2" >display_settings</i></a>';

            rowData += '<a href="#" class="cursor-pointer btn-link text-color-primary"  onclick="addTimeLog('
                + taskid + ');">';
            rowData += '<i class="material-icons text-xl me-2">more_time</i></a>';
            return rowData;
        }

        function viewProject(projectid, projectname) {
            sessionStorage.removeItem("projectid");
            sessionStorage.removeItem("projectname");
            sessionStorage.setItem("projectid", projectid);
            sessionStorage.setItem("projectname", projectname);
            window.location = 'projectview.jsp';
        }

        function viewTask(taskid) {      // function view task list
            sessionStorage.removeItem("taskid");
            sessionStorage.setItem("taskid", taskid);
            window.location = 'taskview.jsp';
        }
        function addTimeLog(taskid) {   // kanban add time log 
            $('#taskid_id').val(taskid);
            $('#taskidforfile_id').val(taskid);
            $('#task_log_date_id').val(today());
            $('#task_log_hours_id').val('');
            $('#taskActivity_id').val('');
            $('#task_comments_id').val('');
            $("#msgError_task_log_date_id").css("display", "none");
            $("#msgError_log_hours_id").css("display", "none");
            $("#msgError_taskActivity_id").css("display", "none");
            $("#msgError_task_comments_id").css("display", "none");
            $("#logfilerow_id").prop("hidden", true);
            $("#updateAttachment_id").prop("hidden", true);
            $("#updateAttachment_id").val("");
            $("#uploadbtn_div").prop("hidden", false);
            $("#cancelbtn_id").prop("hidden", true);
            $("#logfileTableData").prop("hidden", true);
            $("#logFileDescriptionid").val("");
            $("#logfile_msgErrorId").css("display", "none");
            $("#msgError_logFileDescriptionid").css("display", "none");
            $("#uploadbtn_Id").prop("disabled", false);
            $("#logFilesListId").prop("hidden", true);
            $("#logFiletBody").empty();
            $('#taskTimeLog').modal("show");
        }

        function savetasklog() {    // the kanban function save log functionlly 
            if (validateServiceDetails('tasklogformId')) {
                jQuery.ajax({
                    type: "POST",
                    url: "kanban",
                    data: {
                        actionType: 'savetasklog',
                        taskId: $('#taskid_id').val(),
                        logDate: $('#task_log_date_id').val(),
                        logHours: $('#task_log_hours_id').val(),
                        taskActivityId: $('#taskActivity_id').val(),
                        taskComment: $('#task_comments_id').val()
                    },
                    async: true,
                    success: function (data) {
                        $('#taskTimeLog').modal("hide");
                        loadTaskList();

                    },
                    error: function (data) {

                    }
                });
            }
        }
        function validateServiceDetails(form_id) {
            var formObj = $('#' + form_id);
            var inputObj;

            for (var i = 0; i <= formObj.get(0).length - 1; i++) {
                inputObj = formObj.get(0)[i];
                if (inputObj.type == 'select-one'
                    && inputObj.className === 'required form-control p-2'
                    && inputObj.value == '') {
                    $("#msgError_" + inputObj.id).show();
                    $("#msgError_" + inputObj.id).text(
                        'Please select at least one option.');
                    return false;
                } else if (inputObj.type === 'text'
                    && inputObj.className === 'required form-control'
                    && inputObj.value === '') {
                    $("#msgError_" + inputObj.id).show();
                    $("#msgError_" + inputObj.id).text("Please fill this field.");
                    return false;
                } else if (inputObj.type === 'textarea'
                    && inputObj.className === 'required form-control'
                    && inputObj.value === '') {
                    $("#msgError_" + inputObj.id).show();
                    $("#msgError_" + inputObj.id).text("Please fill this field.");
                    return false;
                }
                if (inputObj.className === 'required form-control') {
                    $("#msgError_" + inputObj.id).hide();
                } else if (inputObj.className === 'required form-control p-2') {
                    $("#msgError_" + inputObj.id).hide();
                }
            }
            return true;
        }

        function showNewTaskModel() {    // kanban function show task model 
            $("#newTaskLabel").text("Create Task");
            $('#action_type_id').val('createtask');
            $("#taskactionid").html("Save");
            $("#taskactionid").attr("onclick", "cearenewtask()");
            $('#task_name_id').val('');
            $('#task_description_id').val('');
            $('#taskStatus_id').val('');
            $('#taskType_id').val('');
            $('#taskPriority_id').val('');
            $('#assignee_id').val('');
            $('#start_date_id').val(today());
            $('#due_date_id').val(currdateTime());
            $('#estimeted_time_id').val('');
            $('#project_id').val('');
            $('#done_value_id').val('0');
            $('#searchdepartment_id').val('0');
            $('#followerlistid').empty();
            $('#msgError_project_id').hide();
            $('#msgError_assignee_id').hide();
            $('#msgError_task_name_id').hide();
            $('#msgError_task_description_id').hide();
            $('#addAllcheckboxId').prop('checked', false);

        }

        // When Add All checkbox is clicked
        $("#addAllcheckboxId").click(function () {
            $(".followers").prop("checked", this.checked);
        });
        // When any followers checkbox is clicked
        function checkfollowers() {
            if ($('.followers:checked').length == $('.followers').length) {
                $('#addAllcheckboxId').prop('checked', true);
            } else {
                $('#addAllcheckboxId').prop('checked', false);
            }
        }



        function showNewTaskModalAgain() {
            $("#newTaskLabel").text("Create Task");
            $('#action_type_id').val('createtask');
            $("#taskactionid").html("Save");
            $("#taskactionid").attr("onclick", "cearenewtask()");
            $('#project_id').val('');
            $('#task_name_id').val('');
            $('#task_description_id').val('');
            $('#taskStatus_id').val('');
            $('#taskType_id').val('');
            $('#taskPriority_id').val('');
            $('#assignee_id').val('');
            $('#start_date_id').val(today());
            $('#due_date_id').val(currdateTime());
            $('#estimeted_time_id').val('');
            $('#done_value_id').val('0');
            $('#searchdepartment_id').val('0');
            $('#followerlistid').empty();
            $('#addAllcheckboxId').prop('checked', false);
            $('.follower').prop("checked", false);
            $('#msgError_project_id').hide();
            $('#msgError_task_name_id').hide();
            $('#msgError_task_description_id').hide();
            $("#newTask").modal('show');
        }

        function loadProjectList() {    // kanban load project list
            $.ajax({
                url: "projects",
                type: "post",
                async: false,
                data: {
                    action_type: "searchData"
                },
                success: function (resp) {
                    if (resp[1] > 0 && resp[0] != null) {
                        for (var i = 0; i < resp[0].length; i++) {
                            var htmlData = '<option value="'
                                + (resp[0])[i].project_id + '">'
                                + (resp[0])[i].project_name + '</option>'
                            $("#project_id").append(htmlData);
                            $("#projectfiler_id").append(htmlData);

                        }
                    }
                }
            })
        }
        function loadAssignee(projectid) {     // kanban loadAssignee project Id 
            $('#assignee_id').empty();
            $('#followerlistid').empty();
            $('#searchdepartment_id').val("0");
            $('#msgError_project_id').hide();
            jQuery
                .ajax({
                    type: "POST",
                    url: "projectsemployee",
                    data: {
                        actionType: 'getprojectmembers',
                        projectid: projectid,
                    },
                    async: true,
                    success: function (data) {
                        var jsonData = eval(data);
                        if (jsonData.length > 0) {
                            var htmlData = '<option value="">Select Assignee</option>';
                            $('#assignee_id').append(htmlData);

                            for (var i = 0; i < jsonData.length; i++) {
                                var rowdata = jsonData[i];
                                // Check if isactive is not "0" before creating an option
                                if (rowdata.is_active !== "0") {
                                    var htmlData = '<option value="' + rowdata.employee_id + '">' + rowdata.employee_name + '</option>';
                                    $('#assignee_id').append(htmlData);
                                }
                            }
                            loadFollowers(projectid, $('#searchdepartment_id').val());
                        }
                    },
                    error: function (data) {

                    }
                });
        }

        function cearenewtask() {      // kanban board  create new task list 


            if (validateServiceDetails('taskformId')) {
                var taskfollowers = [];
                $("#followerlistid input[type=checkbox]:checked").each(function () {
                    taskfollowers.push($(this).val());
                });
                jQuery.ajax({
                    type: "POST",
                    url: "tasks",
                    data: {
                        actionType: $('#action_type_id').val(),
                        projectId: $('#project_id').val(),
                        taskName: $('#task_name_id').val(),
                        taskDescription: $('#task_description_id').val(),
                        taskStatusId: $('#taskStatus_id').val(),
                        taskTypeId: $('#taskType_id').val(),
                        taskPriorityId: $('#taskPriority_id').val(),
                        assigneeId: $('#assignee_id').val(),
                        startDate: $('#start_date_id').val(),
                        dueDateTime: $('#due_date_id').val(),
                        taskEstimatedTime: $('#estimeted_time_id').val(),
                        taskCompletionValue: $('#done_value_id').val(),
                        taskfollowers: taskfollowers.join(',')
                    },
                    async: true,
                    success: function (data) {
                        $('#newTask').modal("hide");
                        //				loadMyTaskList();
                        loadMyTaskListByDate();
                        loadSummary();
                        loadkanbanstatusList();
                    },
                    error: function (data) {
                        alert(data);
                    }
                });
            }

        }

        function loadTaskActivityList() {     // kanban task load activitylist
            $
                .ajax({
                    url: "masterDetails",
                    type: 'post',
                    data: {
                        actionType: 'taskActivityList',
                        company_id: "1"
                    },
                    success: function (data) {
                        if (data != null) {
                            for (let i = 0; i < data.length; i++) {
                                var htmlData = '<option value="' + data[i].taskActivityId + '">'
                                    + data[i].taskActivity + '</option>'
                                $('#taskActivity_id').append(htmlData);
                            }
                        }
                    },
                    error: function (error) {
                        alert(data);
                    }
                });
        }

        function loadTaskStatusList() {    // kanban status list and tast status Id 
            $.ajax({
                url: "masterDetails",
                type: 'post',
                data: {
                    actionType: 'taskStatusList',
                    company_id: "1"

                },
                success: function (data) {
                    if (data != null) {
                        for (let i = 0; i < data.length; i++) {
                            var htmlData = '<option value="' + data[i].taskStatusID + '">'
                                + data[i].taskStatus + '</option>';
                            $('#filtertaskstatusid').append(htmlData);
                            $('#taskStatus_id').append(htmlData);

                        }
                    }
                },
                error: function (error) {
                    alert(data);
                }
            });
        }

        function loadTaskPriorityList() {    // kanban  load task priority list 
            $.ajax({
                url: "masterDetails",
                type: 'post',
                data: {
                    actionType: 'taskPriorityList',
                    company_id: "1"
                },
                success: function (data) {
                    if (data != null) {
                        for (let i = 0; i < data.length; i++) {
                            var htmlData = '<option value="' + data[i].taskPriorityId + '">'
                                + data[i].taskPriority + '</option>';
                            $('#filtertaskpriorityid').append(htmlData);
                            $('#taskPriority_id').append(htmlData);
                        }
                    }
                },
                error: function (error) {
                    alert(data);
                }
            });
        }
        
        function loadTaskTypeList() {   // kanban task type list  and task type id
            $.ajax({
                url: "masterDetails",
                type: 'post',
                data: {
                    actionType: 'taskTypeList',
                    company_id: "1"
                },
                success: function (data) {
                    if (data != null) {
                        for (let i = 0; i < data.length; i++) {
                            var htmlData = '<option value="' + data[i].tasktypeID + '">'
                                + data[i].taskType + '</option>'
                            $('#taskType_id').append(htmlData);
                        }
                    }
                },
                error: function (error) {
                    alert(data);
                }
            });
        }

        function loadLogDocumentList() {   // kanban doument list 
            $.ajax({
                url: "tasks",
                type: "post",
                data: {
                    actionType: "documentList",
                    taskid: $('#taskid_id').val(),
                    isadditional: "1"
                },
                success: function (data) {
                    console.log(data, "DocumentsList");
                    var DName = document.getElementById("logFiletBody");
                    $("#logFiletBody").empty();
                    if (data != null) {
                        $("#updateAttachment_id").prop("hidden", true);
                        $("#updateAttachment_id").val("");
                        $("#uploadbtn_Id").prop("disabled", true);
                        $("#cancelbtn_id").prop("hidden", true);
                        $("#logFilesListId").prop("hidden", false);

                        var row = "";
                        row += '<tr><td><a href="#" onclick="deleteLogAttachmentById('
                            + data.document_id
                            + ');"class="text-danger cursor-pointer"><i class="material-icons text-sm me-2">cancel</i></a><a href="#" class="text-info cursor-pointer" id="viewLogAttachment" onclick="viewLogAttachment('
                            + $('#taskid_id').val()
                            + ', '
                            + data.document_id
                            + ');"><i class="material-icons text-sm me-2">preview</i></a><a href="tasks?actionType=downloadAttachment&taskid='
                            + data.task_id
                            + '&document_name='
                            + data.document_name
                            + '&isadditional=1" target="_top" class="text-info cursor-pointer" id="downloadAttachmentId" ><i class="material-icons text-sm me-2">download</i></a></td><td id="docNameFordwnId">'
                            + data.document_name
                            + '</td><td id="descriptionId">'
                            + data.documentDiscription
                            + '</td><td>'
                            + data.created_on + '</td></tr>';
                        DName.innerHTML = row;
                    } else {
                        $("#updateAttachment_id").prop("hidden", false);
                        $("#updateAttachment_id").val("");
                        $("#uploadbtn_Id").prop("disabled", false);
                        $("#logFilesListId").prop("hidden", true);
                    }
                }
            })
        }
        function today() {
            var d = new Date();
            var currDate = d.getDate();
            var currMonth = d.getMonth() + 1;
            var currYear = d.getFullYear();
            return currYear + "-"
                + ((currMonth < 10) ? '0' + currMonth : currMonth) + "-"
                + ((currDate < 10) ? '0' + currDate : currDate);
        }
        function currdateTime() {
            var d = new Date();
            var gethour = d.getHours() + 2;
            var getminute = d.getMinutes();
            var currDate = d.getDate();
            var currMonth = d.getMonth() + 1;
            var currYear = d.getFullYear();
            return currYear + "-"
                + ((currMonth < 10) ? '0' + currMonth : currMonth) + "-"
                + ((currDate < 10) ? '0' + currDate : currDate) + " " + gethour + ":" + ((getminute < 10) ? '0' + getminute : getminute);
        }
        function loadDepartmentList() {    // kanban department list 
            $
                .ajax({
                    url: "masterDetails?actionType=departmentList",
                    type: 'post',
                    data: {
                        company_id: "1",
                    },
                    success: function (data) {
                        console.log(data);
                        if (data != null) {

                            for (let i = 0; i < data.length; i++) {
                                var htmlData = '<option value="' + data[i].department_id + '">'
                                    + data[i].department_name + '</option>'
                                $('#searchdepartment_id').append(htmlData);
                            }
                        }
                    },
                    error: function (error) {
                        alert(error);

                    }
                });
        }




        function kanbangroupupdateStatus(tasknoid, StatusName) {     // kanban update status task no is AND status name
        	debugger;
            jQuery.ajax({
                type: "POST",
                url: "kanban",
                data: {
                    actionType: 'kanbangroupupdateStatus',
                    task_status: StatusName,
                    taskid: tasknoid

                },
                async: true,
                success: function (data) {
                    console.log(data);
                    $('#mytaskoverdueidbodyId').empty();
                    $('#mytaskreopenbodyId').empty();
                    $('#tasktgridinprogressbodyId').empty();
                    $('#tasknewbodyId').empty();
                    $('#taskfeedbackbodyId').empty();
                    $('#taskresolvedbodyId').empty();
                    $('#taskclosedbodyId').empty();

                    loadkanbanstatusList();
                    loadTaskStatusList();
                    createtaskgridrow(data);



                },
                error: function (data) {
                    alert("Error in process. Please try again.");
                }
            });
        }


        function loadkanbanstatusList() {     // load kanban status list and all data list pages
        	debugger;
           if($("#searchbyId").val()=="custom_dates" && $("#activityFilterStartDateid").val() == '' && $("#activityFilterEndDateid").val() == '')  {
        	   $("#activityFilterStartDateid").show();
               $("#activityFilterEndDateid").show();
               $("#searchId").show();
               $('#errormessageforfromdateId').hide();
           
           
           
          
   			var from_date = $("#activityFilterStartDateid").val();
   			var to_date = $("#activityFilterEndDateid").val();

   			
   			var startdate = new Date(from_date);
   			var endDate = new Date(to_date);
   			var diffTime = Math.abs(endDate - startdate);
   			var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); 
   		
   			if (from_date == ""){
   				$('#errormessageforfromdateId').show();						
   			}
   			else if (to_date == ""){
   				$('#errormessageforfromdateId').hide();		
   				$('#errormessagefortodateId').show();
   			}
   			else if (from_date > to_date ){
   				$('#errormessageforfromdateId').hide();	
   				$('#errormessagefortodateId').hide();
   				
   				$('#errMsgDateCompare').show();		
   			}
   			else if (diffDays > 90){
   				$('#errormessageforfromdateId').hide();			
   				$('#errormessagefortodateId').hide();
   				$('#errMsgDateCompare').hide();	
   				
   				$('#errormessagefordiffDaysId').show();	
   				return;
   			}
   			else {
   				$('#errormessageforfromdateId').hide();			
   				$('#errormessagefortodateId').hide();
   				$('#errMsgDateCompare').hide();	
   				$('#errormessagefordiffDaysId').hide();	
   			}
   		}
          
           
   	
   		if ($('#searchbyId').val() != 'custom_dates'){
   			
   			$("#activityFilterStartDateid").val("");
   			$("#activityFilterEndDateid").val("");
   			
   	 		$("#activityFilterStartDateid").hide();
   	 		$("#activityFilterEndDateid").hide();
   	 		$("#searchId").hide();
   		}
        
   	
   		$('#cPageNo').val(1);
   		if ($('#projectfiler_id').val() == "") {
   			loadSummaryOnReady();
   			loadSummaryByPriorityOnReady();
   		} else {
   			loadSummary();
   			loadSummaryByPriority();
   		}

   		$("#showMsgId").hide();
   		$('#mytasktbodyId').empty();
   		$('#mytasktgridbodyId').empty();
   		$('#mytaskcount').empty();
   		
   		if($("#activityFilterStartDateid").val()==''){
   			if($('#searchbyId').val() == "custom_dates"){
   			 	$("#activityFilterStartDateid").show();
   			 	$("#activityFilterEndDateid").show();
   			 	 $("#searchId").show();
    			 	 $("#loadmoreid").hide();
   			 	return;
   			}
   		else {
   				$("#activityFilterStartDateid").val("");
   			    $("#activityFilterEndDateid").val("");				
   				$("#activityFilterStartDateid").hide();
   				$("#activityFilterEndDateid").hide();
   				$("#searchId").hide();
   		    }
   			
   		}
           
   	 else{
   			 $("#loadmoreid").show();
   		}
         
              
           
           
           
           
           
        	$.ajax({
                url: "kanban",
                type: "POST",
                async: false,
                data: {
                    actionType: "kanbanstatuslist",          //  windows refresh in all data list 
                    projectId:$("#projectfiler_id").val(),
                    searchId:$("#searchbyId").val(),
                    startDate:$("#activityFilterStartDateid").val(),
                    enddate:$("#activityFilterEndDateid").val()
                },
                success: function (data) {               //    select project data list 
                	 $('#mytaskoverdueidbodyId').empty();
                	 $('#mytaskreopenbodyId').empty();
                	 $('#tasktgridinprogressbodyId').empty();
                	 $('#tasknewbodyId').empty();
                	 $('#taskfeedbackbodyId').empty();
                	 $('#taskresolvedbodyId').empty();
                	 $('#taskclosedbodyId').empty();
                	 
                	  document.getElementById("overdueCount").innerText = " (" + 0 + ")";     // all project count list and  select project 
                      document.getElementById("reopenCount").innerText = " (" + 0 + ")";
                      document.getElementById("inProgressCount").innerText = " (" + 0 + ")";
                      document.getElementById("newCount").innerText = " (" + 0 + ")";
                      document.getElementById("feedbackCount").innerText = " (" + 0 + ")";
                      document.getElementById("resolvedCount").innerText = " (" + 0 + ")";
                      document.getElementById("closedCount").innerText = " (" + 0 + ")";

                	 
                    var jsonData = eval(data);
                    if (jsonData.length > 0) {
                        var totalListCount = jsonData[0].count;
                        var overdueCount = 0;
                        var reopenCount = 0;
                        var inProgressCount = 0;
                        var newCount = 0;
                        var feedbackCount = 0;
                        var resolvedCount = 0;
                        var closedCount = 0;
                       
                        for (var i = 0; i < jsonData.length; i++) {
                            var rowdata = jsonData[i];

                            if (rowdata.taskStatusId == 1) {
                                overdueCount++;
                                if (overdueCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#mytaskoverdueidbodyId').append(newtaskgridrow);
                                }
                            }
                            if (rowdata.taskStatusId == 2) {
                                reopenCount++;
                                if (reopenCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#mytaskreopenbodyId').append(newtaskgridrow);
                                }

                            }
                            if (rowdata.taskStatusId == 3) {
                                inProgressCount++;
                                if (inProgressCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#tasktgridinprogressbodyId').append(newtaskgridrow);
                                }
                            }
                            if (rowdata.taskStatusId == 4) {
                                newCount++;
                                if (newCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#tasknewbodyId').append(newtaskgridrow);
                                }
                            }
                            if (rowdata.taskStatusId == 5) {
                                feedbackCount++;
                                if (feedbackCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#taskfeedbackbodyId').append(newtaskgridrow);
                                }
                            }
                            if (rowdata.taskStatusId == 6) {
                                resolvedCount++;
                                if (resolvedCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#taskresolvedbodyId').append(newtaskgridrow);
                                }
                            }
                            if (rowdata.taskStatusId == 7) {
                                closedCount++;
                                if (closedCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#taskclosedbodyId').append(newtaskgridrow);
                                }
                            }
                        }
                    



                        // Display the counts backend
                        console.log("Overdue Count: " + overdueCount);
                        console.log("Reopen Count: " + reopenCount);
                        console.log("In Progress Count: " + inProgressCount);
                        console.log("New Count: " + newCount);
                        console.log("Feedback Count: " + feedbackCount);
                        console.log("Resolved Count: " + resolvedCount);
                        console.log("Closed Count: " + closedCount);

                        document.getElementById("overdueCount").innerText = " (" + overdueCount + ")";
                        document.getElementById("reopenCount").innerText = " (" + reopenCount + ")";
                        document.getElementById("inProgressCount").innerText = " (" + inProgressCount + ")";
                        document.getElementById("newCount").innerText = " (" + newCount + ")";
                        document.getElementById("feedbackCount").innerText = " (" + feedbackCount + ")";
                        document.getElementById("resolvedCount").innerText = " (" + resolvedCount + ")";
                        document.getElementById("closedCount").innerText = " (" + closedCount + ")";


                    }

                },
            });
        }

        function loadTaskStatusList(cstatusid) {    // task status list in master details
            $('#statuslistid').empty();
            $
                .ajax({
                    url: "masterDetails",
                    type: 'post',
                    data: {
                        actionType: 'taskStatusList',
                        company_id: "1"
                    },
                    success: function (data) {
                        console.log(data);
                        if (data != null) {
                            for (let i = 0; i < data.length; i++) {
                                if (data[i].taskStatusID != cstatusid) {
                                    var htmlData = '<li><a class="dropdown-item border-radius-md" href="javascript:;" onclick="kanbangroupupdateStatus('
                                        + data[i].taskStatusID
                                        + ')">'
                                        + data[i].taskStatus + '</a></li>';
                                    $('#statuslistid').append(htmlData);

                                }
                            }
                        }
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
        }
        
        function loadSummaryOnReady() {
        	debugger;
    		$('#mysummarybodyId').empty();
    		jQuery.ajax({
    			type : "POST",
    			url : "kanban",
    			data : {
    				actionType : 'kanbantasklist',
    				projectfiler_id : $('#projectfiler_id').val(),
    				search_by : $('#searchbyId').val(),
    				actionType : 'tasksummaryonready',
    				from_date : $("#activityFilterStartDateid").val(),
    				to_date : $("#activityFilterEndDateid").val()

    			},
    			async : true,
    			success : function(data) {
    				var jsonData = eval(data);
    				var taskassociate = 0;
    				array = [];
    				if (jsonData.length > 0) {
    					for (var i = 0; i < jsonData.length; i++) {
    						var rowdata = jsonData[i];
    						taskassociate += rowdata.taskCount
    						var newsummaryrow = createsummaryrow(rowdata);
    						$('#mysummarybodyId').append(newsummaryrow);
    						
    				var StatusColours = createStatusElementColors(rowdata.taskStatus, rowdata.taskStatusType);

    				array.push({ value: rowdata.taskCount , label: rowdata.taskStatus ,color:StatusColours },);
    					}
    				}
    				$('#mytaskcount').empty();
    				$('#mytaskcount').append(taskassociate);
    				loadPiechartSummary('taskStatuschartId');
    				
    			},
    			error : function(data) {
    				alert("Error in process. Please try again.");
    			}
    		});
    	}
        

        function loadTaskStatusList() {      // kanban load task status list 
            $
                .ajax({
                    url: "masterDetails",
                    type: 'post',
                    data: {
                        actionType: 'taskStatusList',
                        company_id: "1"
                    },
                    success: function (data) {
                        if (data != null) {
                            for (let i = 0; i < data.length; i++) {
                                var htmlData = '<option value="' + data[i].taskStatusID + '">'
                                    + data[i].taskStatus + '</option>';
                                $('#filtertaskstatusid').append(htmlData);
                                $('#taskStatus_id').append(htmlData);

                            }
                        }
                    },
                    error: function (error) {
                        alert(data);
                    }
                });
        }

        function loadFollowers(projectid, departmentid) {   // kanban loadfollowers  list
            $('#addAllcheckboxId').prop('checked', false);
            $('#followerlistid').empty();
            if (projectid != "") {
                jQuery.ajax({
                    type: "POST",
                    url: "projectsemployee",
                    data: {
                        actionType: 'getprojectmembers',
                        projectid: projectid,
                        departmentid: departmentid,
                        listType: "getFollowers"
                    },
                    async: true,
                    success: function (data) {
                        var jsonData = eval(data);
                        if (jsonData.length > 0) {
                            for (var i = 0; i < jsonData.length; i++) {
                                var rowdata = jsonData[i];
                                console.log(rowdata);
                                // Check if isactive is not "0" before creating followers
                                if (rowdata.is_active !== "0") {
                                    newRowContent = getFollowerRowData(rowdata);
                                    $("#followerlistid").append(newRowContent);

                                }
                            }
                        }
                    },
                    error: function (data) {

                    }
                });
            } else {
                $('#searchdepartment_id').val("0");
                $('#msgError_project_id').text('Please select at least one option.');
                $('#msgError_project_id').show();
                $('#msgError_project_id').focus();
            }
        }


        function getFollowerRowData(data) {      // kanban get follower data 

            var rowData = "<div class=\"col-lg-3 col-md-6 col-sm-12\">";
            rowData += "<div class=\"d-flex px-2 py-1\">";
            rowData += "<div class=\"form-check px-2 py-1\">";
            rowData += "<input class=\"followers form-check-input\" type=\"checkbox\" onchange = \"checkfollowers();\"  name='chkfollowmember' value='" + data.employee_id + "' id='fmemberid_" + data.employee_id + "' ></div>";
            rowData += "<div><img src='uploads/avatar/" + data.employee_profile_avatar + "' class=\"avatar avatar-sm me-3\" alt=\"avatar image\">";
            rowData += "</div>";
            rowData += "<div class=\"d-flex flex-column justify-content-center\">";
            rowData += "<h6 class=\"mb-0 font-weight-normal text-sm\">"
                + data.employee_name + "</h6>";
            rowData += "</div>";
            rowData += "</div>";
            rowData += "</div>";
            return rowData;
        }


        function loadTaskDetails() {    // kanban task details all 
            jQuery.ajax({
                type: "POST",
                url: "tasks",
                data: {
                    actionType: 'taskdetails',
                    taskId: taskid
                },
                async: true,
                success: function (data) {
                    console.log("taskview", data);
                    var jsonData = eval(data);
                    $('#tasknameid').text("#" + taskid + " " + jsonData.taskName);
                    $('#task_description_id').text(jsonData.taskDescription);
                    $('#statusid').html(
                        createStatusElement(jsonData.taskStatusId,
                            jsonData.taskStatus, jsonData.taskStatusType));
                    $('#priorityid').html(
                        createPriorityElement(jsonData.taskPriorityId,
                            jsonData.taskPriority,
                            jsonData.taskPriorityType));
                    $('#startdateid').text(convertDate(jsonData.startDate));
                    $('#duedateid').text(convertDate(jsonData.dueDate));
                    $('#taskestimatedtimeid').text(
                        jsonData.taskEstimatedTime + " hrs");
                    $('#taskcompletionvalueid').text(
                        jsonData.taskCompletionValue + " %");
                    $('#assigneeid').html(
                        "<a href=\"javascript:;\" >" + jsonData.assigneeName
                        + "</a>");
                    loadTaskStatusList(jsonData.taskStatusId);
                },
                error: function (data) {
                    alert("Error in process. Please try again.");
                }
            });
        }

        function moreloadTaskList(id) {    // load more function pages no 
        	
            var pcpageno;
            if (id == 1) {
                pcpageno = parseInt($('#oPageNo1').val()) + 1;
                $('#oPageNo1').val(pcpageno);
            } else if (id == 2) {
                pcpageno = parseInt($('#rPageNo2').val()) + 1;
                $('#rPageNo2').val(pcpageno);
            } else if (id == 3) {
                pcpageno = parseInt($('#iPageNo3').val()) + 1;
                $('#iPageNo3').val(pcpageno);
            } else if (id == 4) {
                pcpageno = parseInt($('#nPageNo4').val()) + 1;
                $('#nPageNo4').val(pcpageno);
            } else if (id == 5) {
                pcpageno = parseInt($('#fPageNo5').val()) + 1;
                $('#fPageNo5').val(pcpageno);
            } else if (id == 6) {
                pcpageno = parseInt($('#rPageNo6').val()) + 1;
                $('#rPageNo6').val(pcpageno);
            } else if (id == 7) {
                pcpageno = parseInt($('#cPageNo7').val()) + 1;
                $('#cPageNo7').val(pcpageno);
            }


            
            jQuery.ajax({        // kanban board loadmore function
                type: "POST",
                url: "kanban",
                data: {
                    actionType: 'kanbantasklist',
                    statusid: id,
                    priorityid: $('#filtertaskpriorityid').val(),
                    projectid: $('#projectfiler_id').val(),
                      searchBy: $('#searchbyId').val(),
                    from_date: $("#activityFilterStartDateid").val(),
                    to_date: $("#activityFilterEndDateid").val(),
                    startIndex: 0,
                    endIndex: 5,
                    pageNo: pcpageno
                },
                async: true,
                success: function (data) {
                	
                	
                	
                    console.log("loadmorelist", data);
                    var jsonData = eval(data);

                    if (jsonData.length > 0) {
                        var overdueCount = 0;
                        var reopenCount = 0;
                        var inProgressCount = 0;
                        var newCount = 0;
                        var feedbackCount = 0;
                        var resolvedCount = 0;
                        var closedCount = 0;
                        
                        var taskRowsArray = [];
                        var taskRowsArray2 = [];
                        var taskRowsArray3 = [];
                        var taskRowsArray4 = [];
                        var taskRowsArray6 = [];
                        
                        for (var i = 0; i < jsonData.length; i++) {
                            var rowdata = jsonData[i];


                            if (rowdata.taskStatusId == 1) {
                                overdueCount++;
                                if (overdueCount < 6) {
                                 //   var newtaskgridrow = createtaskgridrow(rowdata);
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    taskRowsArray.push(newtaskgridrow);
                                    if(data.length < 5){
                                        $('#moreloadoverdueid').hide();
                                    }
                                	
                              
                                }

                                // Update the "overdueCount" element
                                var overdueCountElement = document.getElementById("overdueCount");
                                if (overdueCountElement) {
                                    overdueCountElement.textContent = " (" + overdueCount + ")";
                                }
                            }
                          
                            if (rowdata.taskStatusId == 2) {
                                reopenCount++;

                                if (reopenCount < 6) {
                                    // Assuming createtaskgridrow is a function that returns a valid HTML element
                                    var newtaskgridrow = createtaskgridrow(rowdata);

                                    // Assuming taskRowsArray2 is defined elsewhere in your code
                                    taskRowsArray2.push(newtaskgridrow);
                                    if(data.length < 5){
                                  	  $('#moreloadre-openid').hide();
                                    }
                                }

                                // Update the "reopenCount" element
                                var reopenCountElement = document.getElementById("reopenCount");
                                
                                if (reopenCountElement) {
                                    reopenCountElement.textContent = " (" + reopenCount + ")";
                                }
                            }
                            
                            if (rowdata.taskStatusId == 3) {
                                inProgressCount++;
                                if (inProgressCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    taskRowsArray3.push(newtaskgridrow);
                                   // $('#tasktgridinprogressbodyId').append(newtaskgridrow);
                                      if(data.length < 5){
                                    	  $('#loadmoreinprogressId').hide();
                                      }
                                }
                                // Update the "inProgressCount" element
                                var inProgressCountElement = document.getElementById("inProgressCount");
                                if (inProgressCountElement) {
                                	inProgressCountElement.textContent = " (" + inProgressCount + ")";
                                }
                            }
                            if (rowdata.taskStatusId == 4) {
                                newCount++;
                                if (newCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    taskRowsArray4.push(newtaskgridrow);
                                    //$('#tasknewbodyId').append(newtaskgridrow);
                                    if(data.length < 5){
                                        $('#loadmorenewId').hide();
                                    }
                                }
                                // Update the "newCount" element
                                var newCountElement = document.getElementById("newCount");
                                if (newCountElement) {
                                	newCountElement.textContent = " (" + newCount + ")";
                                }
                                
                            }
                            // Update the "feedback" element
                            if (rowdata.taskStatusId == 5) {
                                feedbackCount++;
                                if (feedbackCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#taskfeedbackbodyId').append(newtaskgridrow);
                                    if(data.length < 5){
                                    	 $('#loadmorefeedbackId').hide();
                                    }
                                }
                            }
                            // Update the "Resolved" element
                            if (rowdata.taskStatusId == 6) {
                                resolvedCount++;
                                if (resolvedCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    taskRowsArray6.push(newtaskgridrow);
                                  //  $('#taskresolvedbodyId').append(newtaskgridrow);
                                    if(data.length < 5){
                                   	 $('#loadmoreresolvedId').hide();
                                   }
                                }
                                var resolvedCountElement = document.getElementById("resolvedCount");
                                if (resolvedCountElement) {
                                	resolvedCountElement.textContent = " (" + resolvedCount + ")";
                                }
                                
                            }
                            // Update the "Close" element
                            if (rowdata.taskStatusId == 7) {
                                closedCount++;
                                if (closedCount < 6) {
                                    var newtaskgridrow = createtaskgridrow(rowdata);
                                    $('#taskclosedbodyId').append(newtaskgridrow);
                                    if(data.length < 5){
                                      	 $('#loadmorecloseId').hide();
                                      }
                                }
                            }
                        }
                        //console.log(taskRowsArray);
                       // console.log(taskRowsArray2);
                       // console.log(taskRowsArray4);
                        $('#mytaskoverdueidbodyId').append(taskRowsArray);
                        $('#mytaskreopenbodyId').append(taskRowsArray2);
                        $('#tasktgridinprogressbodyId').append(taskRowsArray3);
                        $('#tasknewbodyId').append(taskRowsArray4);
                        $('#taskresolvedbodyId').append(taskRowsArray6);
                    }

                    if (totalListCount == prevRows) {
                        $('#moreloadre-openid').hide(); // Hide the "Load More" link when there are no more tasks.
                        $('#moreloadoverdueid').hide();
                        $('#loadmoreinprogressId').hide();
                        $('#loadmorenewId').hide();
                        $('#loadmorefeedbackId').hide();
                        $('#loadmoreresolvedId').hide();
                        $('#loadmorecloseId').hide();
                    }

                    
                },
               
                error: function (data) {
                    alert("Error in process. Please try again.");
                 
                }
                
            });
        }

    </script>
    <script>
    function loadEmployeeList() {    // kanban board search filter
    	debugger;
        $('#cPageNo').val(1);
        $.ajax({
            url: "kanban",
            type: "POST",
            data: {
                actionType: 'kanbansearch',
                searchEmployeeName: $('#kanbanSearchId').val()

            },
            success: function (data) {
                var jsonData = eval(data);
                if (jsonData.length > 0) {
                    var totalListCount = jsonData[0].count;
                    var overdueCount = 0;
                    var reopenCount = 0;
                    var inProgressCount = 0;
                    var newCount = 0;
                    var feedbackCount = 0;
                    var resolvedCount = 0;
                    var closedCount = 0;
                    $('#mytaskoverdueidbodyId').empty();
                    $('#mytaskreopenbodyId').empty();
                    $('#tasktgridinprogressbodyId').empty();
                    $('#tasknewbodyId').empty();
                    $('#taskfeedbackbodyId').empty();
                    $('#taskresolvedbodyId').empty();
                    $('#taskclosedbodyId').empty();

                    
                    var taskRowsArray = [];
                    for (var i = 0; i < jsonData.length; i++) {
                        var rowdata = jsonData[i];

                        if (rowdata.taskStatusId == 1) {
                            overdueCount++;
                            if (overdueCount < 6) {
                                var newtaskgridrow = createtaskgridrow(rowdata);
                                $('#mytaskoverdueidbodyId').append(newtaskgridrow);
                            }
                        }
                        if (rowdata.taskStatusId == 2) {
                            reopenCount++;
                            if (reopenCount < 6) {
                                var newtaskgridrow = createtaskgridrow(rowdata);
                                $('#mytaskreopenbodyId').append(newtaskgridrow);
                            }

                        }
                        if (rowdata.taskStatusId == 3) {
                            inProgressCount++;
                            if (inProgressCount < 6) {
                                var newtaskgridrow = createtaskgridrow(rowdata);
                                $('#tasktgridinprogressbodyId').append(newtaskgridrow);
                            }
                        }
                        if (rowdata.taskStatusId == 4) {
                            newCount++;
                            if (newCount < 6) {
                                var newtaskgridrow = createtaskgridrow(rowdata);
                                $('#tasknewbodyId').append(newtaskgridrow);
                            }
                        }
                        if (rowdata.taskStatusId == 5) {
                            feedbackCount++;
                            if (feedbackCount < 6) {
                                var newtaskgridrow = createtaskgridrow(rowdata);
                                $('#taskfeedbackbodyId').append(newtaskgridrow);
                            }
                        }
                      

                        if (rowdata.taskStatusId == 1) {
                            overdueCount++;
                            if (overdueCount < 6) {
                             //   var newtaskgridrow = createtaskgridrow(rowdata);
                                var newtaskgridrow = createtaskgridrow(rowdata);
                                taskRowsArray.push(newtaskgridrow);
                              //  $('#mytaskoverdueidbodyId').append(newtaskgridrow);
                            }

                            // Update the "overdueCount" element
                            var overdueCountElement = document.getElementById("overdueCount");
                            if (overdueCountElement) {
                                overdueCountElement.textContent = " (" + overdueCount + ")";
                            }
                        }
                      
                        if (rowdata.taskStatusId == 7) {
                            closedCount++;
                            if (closedCount < 6) {
                                var newtaskgridrow = createtaskgridrow(rowdata);
                                $('#taskclosedbodyId').append(newtaskgridrow);
                            }
                        }
                    }
                    $('#mytaskoverdueidbodyId').append(taskRowsArray);

                    // Display the counts backend
                    console.log("Overdue Count: " + overdueCount);
                    console.log("Reopen Count: " + reopenCount);
                    console.log("In Progress Count: " + inProgressCount);
                    console.log("New Count: " + newCount);
                    console.log("Feedback Count: " + feedbackCount);
                    console.log("Resolved Count: " + resolvedCount);
                    console.log("Closed Count: " + closedCount);

                    document.getElementById("overdueCount").innerText = " (" + overdueCount + ")";
                    document.getElementById("reopenCount").innerText = " (" + reopenCount + ")";
                    document.getElementById("inProgressCount").innerText = " (" + inProgressCount + ")";
                    document.getElementById("newCount").innerText = " (" + newCount + ")";
                    document.getElementById("feedbackCount").innerText = " (" + feedbackCount + ")";
                    document.getElementById("resolvedCount").innerText = " (" + resolvedCount + ")";
                    document.getElementById("closedCount").innerText = " (" + closedCount + ")";



                }
            }
        });
    }
</script>

    </html>
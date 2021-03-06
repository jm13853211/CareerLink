<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Career Link - Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <style>
		body {
			padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
		}

    </style>
	
	<script type="application/javascript">
		var username;
	
		function DeleteJob(id){
			alert("going to delete job with id = " + id);
			var http_request = new XMLHttpRequest();
		   try{
			  // Opera 8.0+, Firefox, Chrome, Safari
			  http_request = new XMLHttpRequest();
		   }catch (e){
			  // Internet Explorer Browsers
			  try{
				 http_request = new ActiveXObject("Msxml2.XMLHTTP");
			  }catch (e) {
				 try{
					http_request = new ActiveXObject("Microsoft.XMLHTTP");
				 }catch (e){
					// Something went wrong
					alert("Your browser broke!");
					return false;
				 }
			  }
		   }
		   http_request.open("GET", "http://students.cec.wustl.edu/~morane/CareerLink/DeleteItem.pl", true);
		   http_request.send("username="+username+"&id="+id+"&type=job");
		}
		
		function RemoveCompany(id) {
			var http_request = new XMLHttpRequest();
		   try{
			  // Opera 8.0+, Firefox, Chrome, Safari
			  http_request = new XMLHttpRequest();
		   }catch (e){
			  // Internet Explorer Browsers
			  try{
				 http_request = new ActiveXObject("Msxml2.XMLHTTP");
			  }catch (e) {
				 try{
					http_request = new ActiveXObject("Microsoft.XMLHTTP");
				 }catch (e){
					// Something went wrong
					alert("Your browser broke!");
					return false;
				 }
			  }
		   }
		   http_request.open("GET", "http://students.cec.wustl.edu/~morane/CareerLink/DeleteItem.pl", true);
		   http_request.send("username="+username+"&id="+id+"&type=company");
		   //loadJSON();
		}
		
		function DeleteDoc(id) {
			var http_request = new XMLHttpRequest();
		   try{
			  // Opera 8.0+, Firefox, Chrome, Safari
			  http_request = new XMLHttpRequest();
		   }catch (e){
			  // Internet Explorer Browsers
			  try{
				 http_request = new ActiveXObject("Msxml2.XMLHTTP");
			  }catch (e) {
				 try{
					http_request = new ActiveXObject("Microsoft.XMLHTTP");
				 }catch (e){
					// Something went wrong
					alert("Your browser broke!");
					return false;
				 }
			  }
		   }
		   http_request.open("POST", "http://students.cec.wustl.edu/~morane/CareerLink/DeleteItem.pl", true);
		   http_request.send("username="+username+"&id="+id+"&type=document");
		   //loadJSON();
		}
	
		function readCookie(name) {
			var i, c, ca, nameEQ = name + "=";
			ca = document.cookie.split(';');
			for(i=0;i < ca.length;i++) {
				c = ca[i];
				while (c.charAt(0)==' ') {
					c = c.substring(1,c.length);
				}
				if (c.indexOf(nameEQ) == 0) {
					alert("found cooke - name = " + name);
					return c.substring(nameEQ.length,c.length);
				}
			}
			return '';
		}
	
		function loadJSON()
		{
			//get username from cookie
			username = readCookie("username");
		   //var username = "james";
		   var data_file = "http://students.cec.wustl.edu/~morane/CareerLink/"+username+"_profile.json";
		   var http_request = new XMLHttpRequest();
		   try{
			  // Opera 8.0+, Firefox, Chrome, Safari
			  http_request = new XMLHttpRequest();
		   }catch (e){
			  // Internet Explorer Browsers
			  try{
				 http_request = new ActiveXObject("Msxml2.XMLHTTP");
			  }catch (e) {
				 try{
					http_request = new ActiveXObject("Microsoft.XMLHTTP");
				 }catch (e){
					// Something went wrong
					alert("Your browser broke!");
					return false;
				 }
			  }
		   }
		   http_request.onreadystatechange  = function(){
			  if (http_request.readyState == 4  )
			  {
				var jsonObj = JSON.parse(http_request.responseText);
				document.getElementById("student_name").innerHTML = jsonObj.name+" <small>"+jsonObj.year+" | "+jsonObj.major+"</small>";
				
				//get all jobs
				var jobtable = document.getElementById("tagged_jobs");
				for (var i = 0; i < jsonObj.tagged_jobs.length; i++) {
					var id = "job_" + jsonObj.tagged_jobs[i].id;
					var row = jobtable.insertRow(1);
					var cell1 = row.insertCell(0);
					cell1.innerHTML="<button type=\"button\" class=\"btn btn-default btn-sm\" id=\""+ id+"\" onclick=\"DeleteJob("+jsonObj.tagged_jobs[i].id+")\"><span class=\"glyphicon glyphicon-trash\"></span></button>";
					var cellTitle = row.insertCell(1);
					cellTitle.innerHTML = jsonObj.tagged_jobs[i].title;
					var cellComp = row.insertCell(2);
					cellComp.innerHTML = jsonObj.tagged_jobs[i].company
					var cellLoc = row.insertCell(3);
					cellLoc.innerHTML = jsonObj.tagged_jobs[i].locations;
					var cellDead = row.insertCell(4);
					cellDead.innerHTML = jsonObj.tagged_jobs[i].deadline;
					var cellPost = row.insertCell(5);
					cellPost.innerHTML = jsonObj.tagged_jobs[i].posted;
					//document.getElementById(id).addEventListener("click", DeleteJob(jsonObj.tagged_jobs[i].id), false);
				}
				
				//get all companies
				var cmptable = document.getElementById("fave_companies");
				for (var j=0; j < jsonObj.fave_companies.length; j++) {
					var row2 = cmptable.insertRow(1);
					var cell2 = row2.insertCell(0);
					cell2.innerHTML="<button type=\"button\" class=\"btn btn-default btn-sm\" onclick=\"RemoveCompany("+jsonObj.fave_companies[j].id+")\"><span class=\"glyphicon glyphicon-trash\"></span></button>";
					var cellTitle = row2.insertCell(1);
					cellTitle.innerHTML=jsonObj.fave_companies[j].name;
					var cellCareer = row2.insertCell(2);
					if (jsonObj.fave_companies[j].careerFair == "true") {
						cellCareer.innerHTML = "<p><span class=\"glyphicon glyphicon-ok\"></span></p>";
					}
				}
				
				//get all documents
				var doctable = document.getElementById("documents");
				for (var k = 0; k < jsonObj.doc_links.length; k++) {
					var row3 = doctable.insertRow(1);
					var cellEdit = row3.insertCell(0);
					/*cellEdit.innerHTML="<button type=\"button\" class=\"btn btn-default btn-sm\" formtarget=\"_blank\" onclick=\"window.open(\'"+jsonObj.doc_links[k].link+"\')><span class=\"glyphicon glyphicon-pencil\"></span></button>"; */
					cellEdit.innerHTML="<a href=\"" +jsonObj.doc_links[k].link+"\"><span class=\"glyphicon glyphicon-pencil\"></span></a>";
					var cellDelete = row3.insertCell(1);
					cellDelete.innerHTML="<button type=\"button\" class=\"btn btn-default btn-sm\" onclick=\"DeleteDoc("+jsonObj.doc_links[k].id+")\"><span class=\"glyphicon glyphicon-trash\"></span></button>";
					var cell3 = row3.insertCell(2);
					cell3.innerHTML=jsonObj.doc_links[k].title;
				}
			  }
		   }
		   http_request.open("GET", data_file, true);
		   http_request.send();
		}
		document.addEventListener("DOMContentLoaded", loadJSON, false);
		
		
	</script>
  </head>

  <body>

<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="home">Home</a></li>
              <li class="active"><a href="profile">Profile</a></li>
              <li><a href="search">Search</a></li>
              <li><a href="events">Events</a></li>
              <li><a href="careerFair">Career Fair</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>
	
	<div class="container">
	<h1 id="student_name"></h1>
		<div class="panel-group" id="accordion">
		  <div class="panel panel-default">
			<div class="panel-heading">
			  <h4 class="panel-title">
				<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
				  Tagged Jobs
				</a>
			  </h4>
			</div>
			<div id="collapseOne" class="panel-collapse collapse">
			  <div class="panel-body">
			  </div>
			  <table class="table" id="tagged_jobs">
					<thead>
						<tr>
							<th></th>
							<th>Job Title</th>
							<th>Company</th>
							<th>Location(s)</th>
							<th>Deadline</th>
							<th>Posted</th>
						</tr>
					</thead>
				</table>
			</div>
		  </div>
		  <div class="panel panel-default">
			<div class="panel-heading">
			  <h4 class="panel-title">
				<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
				  Favorite Companies
				</a>
			  </h4>
			</div>
			<div id="collapseTwo" class="panel-collapse collapse">
			  <div class="panel-body">
			  </div>
			  <table class="table" id="fave_companies">
				<thead>
					<tr>
						<th></th>
						<th>Company</th>
						<th>Career Fair</th>
					</tr>
				</thead>
			  </table>
			</div>
		  </div>
		  <div class="panel panel-default">
			<div class="panel-heading">
			  <h4 class="panel-title">
				<a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
				  Resumes, Cover Letters, and other Documents
				</a>
			  </h4>
			</div>
			<div id="collapseThree" class="panel-collapse collapse">
			  <div class="panel-body">
			  </div>
			  <table class="table" id="documents">
				<thead>
					<tr>
						<th></th>
						<th></th>
						<th>Document</th>
						<!--<th>Last Updated On</th>-->
					</tr>
				</thead>
			  </table>
			  <button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-plus"></span> Add Document</button>
			</div>
		  </div>
		</div>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) 
    <script type="text/javascript" src="https://code.jquery.com/jquery.js"></script>-->
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>

    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
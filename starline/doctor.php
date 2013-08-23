<?php
require 'inc/inc_global.php';
require 'inc/inc_patients.php';
require 'inc/inc_interns.php';
require 'inc/inc_dr_surgery.php';
require 'inc/inc_schedule.php';

?>
<div id="jQueryUITabs1">
  <ul>
    <li><a href="#Home"><span>Home</span></a></li>
    <li><a href="#Patients"><span>Patients</span></a></li>
   <li><a href="#Interns"><span>Intern and Residents</span></a></li>
    <li><a href="#Surgeries"><span>Surgeries</span></a></li>
    <li><a href="#Schedules"><span>Schedules</span></a></li>
    <li><a href="#Reports"><span>Reports</span></a></li>
  </ul>
    
  <div id="Home"><br>
      <?php
        getCurrentPay();
      ?>
  </div>
  
  <div id="Patients"><br>
      <?php
        if (!isset($_POST['patientChoice']) || ($_POST['patientChoice'])==0) {
            getPatientForm();
            echo getPatientTable(0);
        } else {
            getPatientForm();
            echo getPatientTable($_SESSION['EmployeeID']);
        }

          
      ?>
  </div> 
  
   <div id="Interns"><br>
      <?php
      if (!isset($_POST['internType'])) {
            getInternForm();
            echo getInternTable(0);
        } else {
            getInternForm();
            echo getInternTable($_POST['internType']);
        }   
      ?>
  </div>  
   
  <div id="Surgeries"><br>
      <?php 
     
        if (isset($_POST['patientID']) && isset($_POST['eID1']) && isset($_POST['roomNum'])) {
          addSurgery($_POST['roomNum'], $_POST['patientID'], $_POST['eID1'], $_POST['eID2'], $_POST['eID3'], $_POST['startTime'], $_POST['endTime'], $_POST['surgeryType']);
        }
        if (isset($_GET['deleteSurgery'])) {
            deleteSurgery($_GET['deleteSurgery']);
        }        
        if (isset($_GET['surgery'])) {
            echo '<a href="index.php?#Surgeries">Return</a><br><br>';
            getSurgeryAddForm();
        }  else {
            echo '<a href="index.php?surgery=true#Surgeries">Click Here To Schedule a Surgery</a><br><br>';
        }
        echo getSurgeryTable();
     ?>    
  </div>
    
  <div id="Schedules"><br>
   <?php  
         
        echo getScheduleTable($_SESSION['EmployeeID']);
     ?>
  </div>
  
  <div id="Reports"><br>
  </div>   
    
</div>
<script type="text/javascript">$(function(){$("#jQueryUITabs1").tabs();$(".datepicker").datetimepicker({
	timeFormat: 'HH:mm:ss',
	stepHour: 2,
	stepMinute: 10,
	stepSecond: 10,
        dateFormat:'yy-mm-dd'
})});</script>

<?php
require 'inc/inc_global.php';
require 'inc/inc_forms.php';
require 'inc/inc_service.php';
require 'inc/inc_supply.php';
require 'inc/inc_staff.php';
require 'inc/inc_surgery.php';
require 'inc/inc_schedule.php';
require 'inc/inc_reports.php';

 if (isset($_GET['service'])) {
     // header('location: index.php#Services');
} 

?>

<div id="jQueryUITabs1">
  <ul>
    <li><a href="#Home"><span>Home</span></a></li>
    <li><a href="#Services"><span>Services</span></a></li>
    <li><a href="#Supplies"><span>Supplies</span></a></li>
    <li><a href="#Surgeries"><span>Surgeries</span></a></li>
    <li><a href="#Schedules"><span>Schedules</span></a></li>
    <li><a href="#Staff"><span>Staff</span></a></li>
<!--    <li><a href="#Reports"><span>Reports</span></a></li>-->
  </ul>
    
  <div id="Home"><br>
      <?php
        getCurrentPay();
      ?>
  </div>
    
    
  <div id="Services"> <br>
      <?php 
        
        if (isset($_POST['sType'])) {
            addServiceType($_POST['sType'], $_POST['aBill']);
        }
      
        if (isset($_POST['serviceID'])) {
            addService($_POST['serviceID'], $_POST['patientID'], $_POST['employeeID'], $_POST['unitID'], $_POST['startTime'], $_POST['endTime']);
        }
        if (isset($_GET['delete'])) {
            deleteService($_GET['delete']);
        }
        if (isset($_GET['service'])) {
            echo '<a href="index.php?#Services">View Services</a><br><br>';
            getServiceAddForm();
        }  else  if (isset($_GET['serviceType'])) {
            echo '<a href="index.php?#Services">View Services</a><br><br>';
            getServiceTypeAddForm();
        } else {
            if ($_SESSION['JobID'] == 1){ 
                 echo '<a href="index.php?serviceType=true#Services">Click Here To Add a Service Type</a><br>';
            }
            echo '<a href="index.php?service=true#Services">Click Here To Schedule a Service</a><br><br>Current Scheduled Services <br>';
            echo getServiceTable();
        }
      ?>
  </div>
    
  <div id="Supplies"><br>
     <?php 
     echo '<a href="index.php?#Supplies">Return to Start</a><br>';
     
        if (isset($_GET['tname'])) {
            orderSupply($_GET['tname'], $_GET['id']);
        }
     
         if (!isset($_POST['supplyType']) && !isset($_POST['supplySpecificType'])) {
            getOrderSupplyForm();
        } else if (!isset($_POST['supplySpecificType'])) {
            if ($_POST['supplyType'] != 'nutrition') {
                getSpecificSupplyForm($_POST['supplyType']);
            } else {
                getNutritionForm();
            }      
        } else {
            getAddForm($_POST['supplySpecificType']);
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
        }  else if ($_SESSION['JobID'] == 2 || $_SESSION['JobID'] == 3){ 
            echo '<a href="index.php?surgery=true#Surgeries">Click Here To Schedule a Surgery</a><br><br>';
        }
        echo getSurgeryTable();
     ?>      
  </div>
    
  <div id="Schedules"><br>
   <?php  
   
      getScheduleForm();
      if (isset($_POST['scheduleEmployeeID'])) {
        echo getScheduleTable($_POST['scheduleEmployeeID']);
      }  
    ?>
  </div>
    
  <div id="Staff"><br> 
    <?php 
        if (!isset($_POST['staffType'])) {
            getStaffForm();
            echo getStaffTable(0);
        } else {
            getStaffForm();
            echo getStaffTable($_POST['staffType']);
        }   
     ?>   
  </div>
  
<!--  <div id="Reports"><br>

  </div>   -->
    
</div>
<script type="text/javascript">$(function(){$("#jQueryUITabs1").tabs();$(".datepicker").datetimepicker({
	timeFormat: 'HH:mm:ss',
	stepHour: 2,
	stepMinute: 10,
	stepSecond: 10,
        dateFormat:'yy-mm-dd'
})});</script>
<?php
require 'inc/inc_global.php';
require 'inc/inc_schedule.php';

?>
<div id="jQueryUITabs1">
  <ul>
    <li><a href="#Home"><span>Home</span></a></li>
    <li><a href="#npInfo"><span>Nurse/Patient Info</span></a></li>
    <li><a href="#reports"><span>Report</span></a></li>
  </ul>
    
  <div id="Home"><br>
      <?php
        getCurrentPay();
        echo "<br> Current Schedule";
        echo getScheduleTable($_SESSION['EmployeeID']);
      ?>
  </div>
   <div id="npInfo"><br>
      <?php
        nurseList();
      ?>
  </div>
    
  <div id="reports"><br>
      <?php
        if(isset($_POST['nurseLookupID'])) {
            echo '<a href="index.php?#reports">Return</a><br><br>';
            echo 'Apointments: <br>';
            getAppointments($_POST['nurseLookupID']);
            echo '<br>Schedule: <br>';
            echo getScheduleTable($_POST['nurseLookupID']);
        } else {
            getHistoryForm();
        }
        
      ?>
  </div>

</div>
<script type="text/javascript">$(function(){$("#jQueryUITabs1").tabs();$(".datepicker").datetimepicker({
	timeFormat: 'HH:mm:ss',
	stepHour: 1,
	stepMinute: 10,
	stepSecond: 10,
        dateFormat:'yy-mm-dd'
})});</script>

<?php

    function nurseList() {
        echo '<p style="font-weight:bold"> List of Nurses On Same Shift Across All Units With Their Appointments </p>';
        $empID = $_SESSION['EmployeeID'];
        $query = "SELECT DISTINCT(e.EmployeeID) AS eID, CONCAT(e.FirstName,' ',e.LastName) AS EName
            FROM employee_schedule AS es JOIN employee AS e ON (es.EmployeeID = e.EmployeeID) 
            WHERE ScheduleID  IN (SELECT ScheduleID FROM employee_schedule WHERE employeeid = $empID) AND e.JobID = 10";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $eID = $row['eID'];
            $eName = $row['EName'];
            echo '<br>Nurse Name: <span style="color:darkred"> '.$eName.'  </span> and her patient services:';
            $apQuery = "SELECT * FROM employee_appointment WHERE EmployeeID = $eID";
            $res = mysql_query($apQuery);
            if (mysql_num_rows($res) > 0) {
                getAppointments($eID);
            } else {
                echo '<div style="color:darkblue">No appointments scheduled for this Nurse</div>';
            }
        }
    }
    
   function getHistoryForm() {
        $uID = $_SESSION['UnitID'];
        $form = '<div>';
        $form .= '<form action="index.php#reports" method ="POST">';
        
        $form .= 'Select Nurse in your Unit <select name="nurseLookupID">';
        $query = "SELECT EmployeeID as eID, CONCAT(e.FirstName,' ',e.LastName) AS EName 
            FROM employee AS e  WHERE e.JobID = 10 AND e.UnitID = $uID";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['eID'].'">'.$row['EName'].'</option>';
        }
        $form .= '</select> ';
        
        $form .= '<input name="submit_change" type="submit" value="Generate Report">'; 
        $form .= '</form></div> <br>';
        
        echo $form;
        
        $form = '<div>';
        $form .= '<form action="index.php#reports" method ="POST">';
        
        $form .= 'Select Nurses Across All Unit <select name="nurseLookupID">';
        $query = "SELECT EmployeeID as eID, CONCAT(e.FirstName,' ',e.LastName) AS EName 
            FROM employee AS e  WHERE e.JobID = 10";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['eID'].'">'.$row['EName'].'</option>';
        }
        $form .= '</select> ';

        $form .= '<input name="submit_change" type="submit" value="Generate Report">'; 
        $form .= '</form></div> <br>';

        
        echo $form;
        
    }
    

?>
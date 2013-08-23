<div id="jQueryUITabs1">
  <ul>
    <li><a href="#Home"><span>Lookup Info</span></a></li>
  </ul>
    
  <div id="Home"><br>
      <?php
        if (isset($_POST['mCard'])) {
            getInfo($_POST['mCard']);
        } else {
            getMainForm();
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
    
    function getMainForm() {
        $form = '<div><form action="patient.php" method ="POST">'; 
        $form .= 'Enter Your Medical Card Number<input type="text" name="mCard"> ';
        $form .= '<input name="submit_change" type="submit" value="Submit">'; 
        $form .= '</form></div>';
        echo $form;
    }
    
    function getInfo($mCard) {
        require 'inc/DB.php';
        $query = "SELECT p.HospitalCardID, p.FirstName, p.LastName, CONCAT(e.FirstName,' ',e.LastName) AS EName FROM `patient` AS p JOIN employee AS e ON (e.EmployeeID = p.DoctorID) WHERE `MedicareNumber` = $mCard";
        $result = mysql_query($query);
        $row = mysql_fetch_assoc($result);
        echo 'Welcome '. $row['FirstName'].' '.$row['LastName'].'<br> Your Primary Doctor is '.$row['EName'].'<br><br> List of your current appointments:';
        $pID = $row['HospitalCardID'];
        
        $query2 = "SELECT s.Name AS ServiceName, a.StartTime, a.EndTime
                FROM appointment AS a JOIN service AS s ON (a.ServiceID = s.ServiceID)  JOIN patient AS p ON (p.HospitalCardID = a.PatientID)
		WHERE a.PatientID = $pID ORDER BY `a`.`StartTime`  ASC";
        $result2 = mysql_query($query2);
        
        $table = '<div><table border="1" width ="450px">';
        $table .= '    <tr> <th class="tableHeaders" width ="150px">Service Name</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Start Time</th>';
        $table .= '         <th class="tableHeaders" width ="150px">End Time</th>';
        $table .= '    </tr>';
       // echo $query . '<br>'. $query2;
        while ($row = mysql_fetch_assoc($result2)) {
            $sName =  $row['ServiceName'];
            $st =  $row['StartTime'];
            $et =  $row['EndTime'];
            $table .= '    <tr> <td> '. $sName . ' </td>';
            $table .= '     <td> '. $st . ' </td>';
            $table .= '     <td> '. $et . ' </td>';
            $table .= '    </tr>';
        }
        $table .= '   </table> </div><br>';  
       
       echo $table;
       
       $medQuery = "SELECT m.Description
            FROM patient AS p
            JOIN medication_list AS ml ON ( p.MedicationListID = ml.MedicationListID ) 
            JOIN medication AS m ON ( m.MedicationID = ml.MedicationID ) 
            WHERE p.MedicareNumber =$mCard";
       $medresult = mysql_query($medQuery);
       
        $table = '<div><table border="1">';
        $table .= '    <tr> <th class="tableHeaders">Medication List</th>';
        $table .= '    </tr>';
       // echo $query . '<br>'. $query2;
        while ($row = mysql_fetch_assoc($medresult)) {
            $med =  $row['Description'];
            $table .= '    <tr> <td> '. $med . ' </td>';
            $table .= '    </tr>';
        }
        $table .= '   </table> </div>'; 
        
        echo $table;
       
    }

?>
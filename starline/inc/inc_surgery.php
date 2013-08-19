<?php
       function getSurgeryTable() {      
       $query = "SELECT a.AppointmentID, a.RoomID, s.Name, CONCAT(p.FirstName,' ',p.LastName) AS PName, a.StartTime, a.EndTime
                FROM appointment AS a 
                JOIN service AS s ON (a.ServiceID = s.ServiceID) 
                JOIN patient AS p ON (p.HospitalCardID = a.PatientID) 
                JOIN unit AS u ON (u.UnitID = a.UnitID)
                WHERE s.ServiceID = 1 OR s.ServiceID = 3 OR s.ServiceID = 9
                ORDER BY `a`.`StartTime`  ASC";
        $result = mysql_query($query);
        
        $table = '<div><table border="1" width ="830px">';
        $table .= '    <tr> <th class="tableHeaders" width ="100px">Room Number</th>';
        $table .= '         <th class="tableHeaders" width ="105px">Patient Name</th>';
        $table .= '         <th class="tableHeaders" width ="220px">Employees Name</th>';
        $table .= '         <th class="tableHeaders" width ="75px">Start Time</th>';
        $table .= '         <th class="tableHeaders" width ="75px">End Time</th>';
        $table .= '         <th class="tableHeaders" width ="125px">Notes</th>';  
        $table .= '         <th class="tableHeaders" width ="80px">Cancel?</th>'; 
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $room =  $row['RoomID'];
            $pName =  $row['PName'];
            $sd =  $row["StartTime"];
            $ed =  $row["EndTime"];
            $sName =  $row["Name"];
            $aID = $row["AppointmentID"];
       
        $table .= '    <tr> <td> '. $room . ' </td>';
        $table .= '         <td> '. $pName . ' </td>';
        
        $table .= '         <td> ';        
        $query2 = "SELECT e.EmployeeID as eID, CONCAT(e.FirstName,' ',e.LastName,' [',j.Name,']') AS EName 
            FROM employee AS e JOIN employee_appointment AS ea ON (ea.EmployeeID = e.EmployeeID) JOIN jobpayroll AS j ON (j.JobID = e.JobID)
            WHERE ea.AppointmentID = $aID
            ORDER BY j.JobID";
        $result2 = mysql_query($query2);
        $row2 = mysql_fetch_assoc($result2);
        $table .= $row2['EName'];
         while ($row2 = mysql_fetch_assoc($result2)) {
            $table .= '<br>'.$row2['EName'];
        }
        $table .= ' </td>';
        
        $table .= '         <td> '. $sd . ' </td>';
        $table .= '         <td> '. $ed . ' </td>';
        $table .= '         <td> '. $sName . ' </td>';
        if ($_SESSION['JobID'] == 2 || $_SESSION['JobID'] == 3 || $_SESSION['JobID'] == 4 ) {
            $table .= '         <td> <a href="index.php?deleteSurgery='.$row["AppointmentID"].'#Surgeries">Cancel</a> </td>';  
        } else {
            $table .= '         <td> Not Allowed </td>';
        }
        $table .= '    </tr>';
        }
        $table .= '   </table> </div>';  
        
        return $table;        
    }
     
    
    function getSurgeryAddForm() {
        
        $form = '<div>';
        $form .= '<form action="index.php#Surgeries" method ="POST">';
        
        $form .= 'Select Room Number <select name="roomNum">';
        $query = "SELECT RoomID FROM room WHERE UnitID = 3";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['RoomID'].'">'.$row['RoomID'].'</option>';
        }
        $form .= '</select><br>';
        
        $form .= 'Select Surgery Type <select name="surgeryType">';
        $query = "SELECT ServiceID, Name FROM Service WHERE ServiceID = 1 OR ServiceID = 3 OR ServiceID = 9";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['ServiceID'].'">'.$row['Name'].'</option>';
        }
        $form .= '</select><br>';
        
        $query2 = "SELECT EmployeeID as eID, CONCAT(e.FirstName,' ',e.LastName,' [',j.Name,']') AS EName 
            FROM employee AS e, jobpayroll AS j 
            WHERE j.JobID = e.JobID AND (e.JobID = 4)";
        
        $form .= 'Select Employees Involved in the Surgery <br> <select name="eID1" style="width: 150px">';
        $result2 = mysql_query($query2);
          while ($row2 = mysql_fetch_assoc($result2)) {
            $form .= '<option value="'.$row2['eID'].'">'.$row2['EName'].'</option>';
        }
        $form .= '      </select>   ';
        
        $query2 = "SELECT EmployeeID as eID, CONCAT(e.FirstName,' ',e.LastName,' [',j.Name,']') AS EName 
            FROM employee AS e, jobpayroll AS j 
            WHERE j.JobID = e.JobID AND (e.JobID > 4 AND e.JobID < 11)";
        
        $form .= '<select name="eID2" style="width: 150px">';
        $form .= '<option value="null">-----</option>';
        $result2 = mysql_query($query2);
        while ($row2 = mysql_fetch_assoc($result2)) {
           $form .= '<option value="'.$row2['eID'].'">'.$row2['EName'].'</option>';
        }
        $form .= '      </select> ';
        
        $form .= '<select name="eID3" style="width: 150px">';
        $form .= '<option value="null">-----</option>';
        $result2 = mysql_query($query2);
          while ($row2 = mysql_fetch_assoc($result2)) {
            $form .= '<option value="'.$row2['eID'].'">'.$row2['EName'].'</option>';
        }
        $form .= '      </select> ';
        
        $form .= '<br> Select Patient <select name="patientID" style="width: 150px">';
        $query2 = "SELECT HospitalCardID as pID, CONCAT(p.FirstName,' ',p.LastName) AS PName FROM patient AS p";
        $result2 = mysql_query($query2);
          while ($row2 = mysql_fetch_assoc($result2)) {
            $form .= '<option value="'.$row2['pID'].'">'.$row2['PName'].'</option>';
        }
        $form .= '      </select> <br>  ';
        $form .= 'Start Time: <input type="text" class="datepicker" name="startTime"/>';
        $form .= 'End Time: <input type="text" class="datepicker" name="endTime"/><br>';

        
        $form .= '<input name="submit_change" type="submit" value="Submit">'; 
        $form .= '</form> </div><br>';
        
       echo $form;

    }
   
    function addSurgery($rID, $pID, $eID, $eID2, $eID3, $startTime, $endTime, $serviceID) {
        
        $stQuery = "SELECT COUNT(*) AS count FROM `appointment` WHERE `StartTime` <= '$startTime' AND `EndTime` >= '$startTime' AND RoomID = $rID";
        $etQuery = "SELECT COUNT(*) AS count FROM `appointment` WHERE `StartTime` <= '$endTime' AND `EndTime` >= '$endTime' AND RoomID = $rID";
        $stresult = mysql_query($stQuery);
        $etresult = mysql_query($etQuery);
        $stRow = mysql_fetch_assoc($stresult);
        $etRow = mysql_fetch_assoc($etresult);
        if ($stRow['count'] > 0 || $etRow['count'] > 0) {
            //echo  $stQuery .'<br>' .$etQuery;
            echo "<p> This Room In Unavailable at the Specified Time. Please Pick Another Time. <br> </p>";
        } else {
            $result = mysql_query("SHOW TABLE STATUS LIKE 'appointment'");
            $row = mysql_fetch_assoc($result);
            $nextId = $row['Auto_increment'];
            $aID = $nextId;        

            $query = "INSERT INTO appointment (AppointmentID, StartTime, EndTime, PatientID, ServiceID, UnitID, RoomID)
                      VALUES ($nextId, '$startTime', '$endTime', $pID, $serviceID, 3, $rID)";

            $query2 = "INSERT INTO employee_appointment (EmployeeID, AppointmentID) VALUES ($eID, $aID)";
            if(mysql_query($query) && mysql_query($query2)) {
                if ($eID2 != null) {
                $query3 = "INSERT INTO employee_appointment (EmployeeID, AppointmentID) VALUES ($eID2, $aID)";
                mysql_query($query3);
                 }
                if ($eID3 != null) {
                $query3 = "INSERT INTO employee_appointment (EmployeeID, AppointmentID) VALUES ($eID3, $aID)";
                mysql_query($query3);
                 }
               echo '<br> Surgery Booked Succesfully! <br>';
            }  else {
                echo $query;
                echo $query2;
                echo 'query error';
            }
        }
    }
    
    function deleteSurgery($id) {
        $query = "DELETE FROM employee_appointment WHERE AppointmentID = $id";
        $query2 = "DELETE FROM appointment WHERE AppointmentID = $id";
        if(mysql_query($query) && mysql_query($query2)) {
            echo '<br> Surgery Canceled Succesfully! <br>';
        }  else {
            echo $query;
            echo 'query error';
        }
    }
   
    
?>
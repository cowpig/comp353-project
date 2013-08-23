<?php

      function getServiceTable() {
       $query = "SELECT a.AppointmentID, s.Name AS SName, CONCAT(p.FirstName,' ',p.LastName) AS PName, a.StartTime, a.EndTime, u.Name AS UName, u.UnitID AS uID
                FROM appointment AS a 
                JOIN service AS s ON (a.ServiceID = s.ServiceID) 
                JOIN patient AS p ON (p.HospitalCardID = a.PatientID)
                JOIN unit AS u ON (u.UnitID = a.UnitID) 
                WHERE s.ServiceID NOT IN (SELECT ServiceID FROM Surgeries)
                ORDER BY `a`.`StartTime`  ASC";
        $result = mysql_query($query);
            
        
        $table = '<div><table border="1" width ="830px">';
        $table .= '    <tr> <th class="tableHeaders" width ="100px">Service Name</th>';
        $table .= '         <th class="tableHeaders" width ="105px">Patient Name</th>';
        $table .= '         <th class="tableHeaders" width ="220x">Employee Name</th>';
        $table .= '         <th class="tableHeaders" width ="125px">Start Time</th>';
        $table .= '         <th class="tableHeaders" width ="125px">End Time</th>';
        $table .= '         <th class="tableHeaders" width ="75px">Unit Name</th>';  
        $table .= '         <th class="tableHeaders" width ="90px">Delete</th>'; 
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $sName =  $row['SName'];
            $pName =  $row['PName'];
            $sd =  $row["StartTime"];
            $ed =  $row["EndTime"];
            $unit =  $row["UName"];
            $aID = $row["AppointmentID"];
            if ($row["uID"] == 1) {
                $unit = 'Palliative';
            }
       
        $table .= '    <tr> <td> '. $sName . ' </td>';
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
        $table .= '         <td> '. $unit . ' </td>';
        if ($_SESSION['JobID'] == 2 || $_SESSION['JobID'] == 3) {
            $table .= '         <td> <a href="index.php?delete='.$row["AppointmentID"].'#Services">Delete Now</a> </td>';  
        } else {
            $table .= '         <td> Not Allowed </td>';
        }
        $table .= '    </tr>';
        }
        $table .= '   </table> </div>';  
        
        return $table;        
    }
     
    
    function getServiceAddForm() {
        
        $form = '<div>';
        $form .= '<form action="index.php#Services" method ="POST">'; 
        
        $form .= 'Select Service Type<select name="serviceID">';
        $query = "SELECT ServiceID, Name FROM Service as s WHERE s.ServiceID NOT IN (SELECT ServiceID FROM Surgeries)";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['ServiceID'].'">'.$row['Name'].'</option>';
        }
        $form .= '</select><br>';
       
        $form .= 'Select Patient <select name="patientID">';
        $query = "SELECT HospitalCardID as pID, CONCAT(p.FirstName,' ',p.LastName) AS PName FROM patient AS p";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['pID'].'">'.$row['PName'].'</option>';
        }
        $form .= '</select><br>';
          
        $form .= 'Select Employee <select name="employeeID">';
        $query = "SELECT EmployeeID as eID, CONCAT(e.FirstName,' ',e.LastName,' [',j.Name,']') AS EName 
            FROM employee AS e, jobpayroll AS j 
            WHERE j.JobID = e.JobID";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['eID'].'">'.$row['EName'].'</option>';
        }
        $form .= '</select><br>';
        
        $form .= 'Select Unit <select name="unitID">';
        $query = "SELECT UnitID AS uID, Name as UName FROM Unit";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['uID'].'">'.$row['UName'].'</option>';
        }
        $form .= '</select><br>';
        
        $form .= 'Select Room Number <select name="roomNum">';
        $query = "SELECT RoomID AS rID FROM room";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['rID'].'">'.$row['rID'].'</option>';
        }
        $form .= '</select><br>';
        $form .= 'Start Date: <input type="text" class="datepicker" name="startTime"/>';
        $form .= 'End Date: <input type="text" class="datepicker" name="endTime"/><br>';
        
        $form .= '<input name="submit_change" type="submit" value="Submit">'; 
        $form .= '</form></div>';

        
        echo $form;
        
    }
   
    function addService($serviceID, $patientID, $employeeID, $unitID, $startTime, $endTime, $rID) {
        $result = mysql_query("SHOW TABLE STATUS LIKE 'appointment'");
        $row = mysql_fetch_assoc($result);
        $nextId = $row['Auto_increment'];
        $query = "INSERT INTO appointment (AppointmentID, StartTime, EndTime, PatientID, ServiceID, UnitID, RoomID)
                  VALUES ($nextId, '$startTime', '$endTime', $patientID, $serviceID, $unitID, $rID)";
        $query2 = "INSERT INTO employee_appointment (EmployeeID, AppointmentID) VALUES ($employeeID, $nextId)";
        if(mysql_query($query) && mysql_query($query2)) {
            echo '<br> Service Inserted Succesfully! <br>';
        }  else {
            echo $query;
            echo $query2;
            echo 'query error';
        }
    }
    
        
    function deleteService($id) {
        $query = "DELETE FROM employee_appointment WHERE AppointmentID = $id";
        $query2 = "DELETE FROM appointment WHERE AppointmentID = $id";
        if(mysql_query($query) && mysql_query($query2)) {
            echo '<br> Service Deleted Succesfully! <br>';
        }  else {
            echo $query;
            echo 'query error';
        }
    }
   
    
    function getServiceTypeAddForm() {

        $form = '<div>';
        $form .= '<form action="index.php#Services" method ="POST">'; 

        $form .= 'Enter Service Type Name <input type="text" name="sType"><br>';
        $form .= 'Enter Service Amount Billable <input type="text" name="aBill">';

        $form .= '<input name="submit_change" type="submit" value="Submit">'; 
        $form .= '</form></div>';
        echo $form . '<br> Current Services List';
        
        $query = "SELECT ServiceID, Name, AmountBillable FROM Service AS s WHERE s.ServiceID NOT IN (SELECT ServiceID FROM Surgeries)";
        $result = mysql_query($query);
            
        $table = '<div><table border="1" width ="450px">';
        $table .= '    <tr> <th class="tableHeaders" width ="150px">Service Name</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Amount Billable</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Delete Service</th>';
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $sName =  $row['Name'];
            $abill =  $row['AmountBillable'];
       
            $table .= '    <tr> <td> '. $sName . ' </td>';
            $table .= '     <td> '. $abill . ' </td>';
            $table .= '     <td> <a href="index.php?deleteServiceType='.$row["ServiceID"].'#Services">Delete Now</a> </td>';
            $table .= '    </tr>';
        }
        $table .= '   </table> </div>';  
        
        echo $table;      
    }

    function addServiceType($sType, $aBill) {
        $query = "INSERT INTO service(Name, AmountBillable) VALUES ('$sType','$aBill')";
        if(mysql_query($query)) {
            echo '<br> Service Type Added Succesfully! <br>';
        }  else {
            echo $query;
            echo 'query error';
        }
    }    
    
    function deleteServiceType($id) {
        $seeUsed = "SELECT ServiceID FROM Appointment WHERE ServiceID = $id";
        $res = mysql_query($seeUsed);
        if (mysql_num_rows($res) > 0) {
            echo "<p> Cannot Delete Service Type, It has already been used in the Hospital</p>";
        } else {
            $query = "DELETE FROM Service WHERE ServiceID = $id";
            if(mysql_query($query)) {
                echo '<br> Service Type Deleted Succesfully! <br>';
            }  else {
                echo $query;
                echo 'query error';
            }
        }
    }
    
    
    
?>
<?php

    function getReportTable($id) {
        $query = "SELECT CONCAT( e.FirstName,  ' ', e.LastName ) AS EName, j.Name, s.StartTime, s.EndTime, u.Name as UnitName, u.UnitID
                FROM employee_schedule AS es
                JOIN schedule AS s ON ( s.ShiftID = es.ScheduleID ) 
                JOIN employee AS e ON ( e.EmployeeID = es.EmployeeID ) 
                JOIN jobpayroll AS j ON ( j.JobID = e.JobID )
                JOIN unit AS u ON ( e.UnitID = u.UnitID ) 
                WHERE es.EmployeeID = $id
                ORDER BY  `s`.`StartTime` ASC ";

        $result = mysql_query($query);
        $table = '<div><table border="1" width ="830px">';
        $table .= '    <tr> <th class="tableHeaders" width ="150px">Employee Name</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Job Title</th>';
        $table .= '         <th class="tableHeaders" width ="230px">Unit Name</th>'; 
        $table .= '         <th class="tableHeaders" width ="150px">Start Time</th>';
        $table .= '         <th class="tableHeaders" width ="150px">End Time</th>'; 
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $ename =  $row["EName"];
            $st = $row["StartTime"];
            $et = $row["EndTime"];
            $jname = $row["Name"];
            $uName = $row["UnitName"];
       
        $table .= '    <tr> <td> '. $ename . ' </td>';
        $table .= '         <td> '. $jname . ' </td>';  
        $table .= '         <td> '. $uName . ' </td>';
        $table .= '         <td> '. $st . ' </td>';
        $table .= '         <td> '. $et . ' </td>';       
        $table .= '    </tr>';
        
        }
        
        $table .= '   </table> </div>';  
        
        return $table;   
    }
     
    
    function getReportMainForm() {
        $form = '<div>';
        $form .= '<form action="index.php#Reports" method ="POST">';
        
        $form .= 'Select Report Type <br><br>';
        $form .= '<input type="radio" name="reportMainType" value="serviceReport"> Services - Unit <br>';
        $form .= '<input type="radio" name="reportMainType" value="supplyReport"> Supply Usage <br>';
        $form .= '<input type="radio" name="reportMainType" value="doctorReport"> Doctor - Services/Surgeries <br>';


        $form .= '<br><input name="submit_change" type="submit" value="Proceed">'; 
        $form .= '</form></div> <br>';

        
        echo $form;
    }
    
    function getSpecificReportForm($reportType) { 
        switch ($reportType) {
            case 'serviceReport': { getServiceReportForm(); break; }
            case 'supplyReport': { getSupplyReport(); break; }
            case 'doctorReport': { getDoctorReportForm(); break;}
        }
     }
     
     function getServiceReportForm() {
        $form = '<div>';
        $form .= '<form action="index.php#Reports" method ="POST">';
   
        $form .= 'Select Unit <br>';
        $form .= '<input type="radio" name="serviceUnit" value="1"> Long Term Palliative Care<br>';
        $form .= '<input type="radio" name="serviceUnit" value="2"> Children<br>';
        $form .= '<input type="radio" name="serviceUnit" value="3"> Surgical<br>';
        
        $form .= 'Chose Interval: From <input type="text" class="datepicker" name="startTimeReport"/>';
        $form .= 'to <input type="text" class="datepicker" name="endTimeReport"/><br>';
        $form .= '<br><input name="submit_change" type="submit" value="Generate Report">'; 
        $form .= '</form></div> <br>';
        echo $form;
     }
     
     function getServiceReport($uID, $st, $et) {
         $schServicesQuery = "SELECT a.StartTime, a.EndTime, a.RoomID, s.Name, s.AmountBillable FROM appointment a LEFT JOIN service s ON s.ServiceID = a.ServiceID
                    WHERE a.UnitID = $uID AND a.StartTime >= '$st' AND a.EndTime <= '$et' ORDER BY a.StartTime ASC";
         $servTypesQuery = "SELECT DISTINCT(s.Name) FROM appointment a JOIN service s ON s.ServiceID = a.ServiceID   
                        WHERE a.UnitID = $uID AND a.StartTime >= '$st' AND a.EndTime <= '$et'";
        // echo $schServicesQuery . '<br>' . $servTypesQuery;
         echo '<a href="index.php?#Reports">Return</a><br><br>';
         typeTable($servTypesQuery, 'service');
         getServiceScheduleTable($schServicesQuery);
         
     }
     
     function getServiceScheduleTable($query) {
        $result = mysql_query($query);
        
        $table = '<div><table border="1" width ="830px">';
        $table .= '         <th class="tableHeaders">Start Time</th>';
        $table .= '         <th class="tableHeaders">End Time</th>';
        $table .= '         <th class="tableHeaders">Service Name</th>';  
        $table .= '         <th class="tableHeaders">Room Number</th>'; 
        $table .= '         <th class="tableHeaders">Amount Billable</th>'; 
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $sd =  $row["StartTime"];
            $ed =  $row["EndTime"];
            $room =  $row["RoomID"];
            $ab = $row["AmountBillable"];
            $sn = $row["Name"];
       
        $table .= '    <tr> <td> '. $sd . ' </td>';
        $table .= '         <td> '. $ed . ' </td>';
        $table .= '         <td> '. $sn . ' </td>';
        $table .= '         <td> '. $room . ' </td>';
        $table .= '         <td> '. $ab . ' </td>';
        $table .= '    </tr>';
        }
        $table .= '   </table> </div>';  
        
        echo $table;    
     }

     function getSupplyReport() {
         $asQuery = "SELECT SUM(AmountLeft) AS AL , SUM(`Maximum Capacity`) AS MC, (SUM(AmountLeft)/SUM(`Maximum Capacity`)) AS percentage FROM administrativesupply";
         $surQuery = "SELECT SUM(AmountLeft) AS AL , SUM(`Maximum Capacity`) AS MC, (SUM(AmountLeft)/SUM(`Maximum Capacity`)) AS percentage FROM surgicalequipment";
         $supQuery = "SELECT SUM(AmountLeft) AS AL , SUM(`Maximum Capacity`) AS MC, (SUM(AmountLeft)/SUM(`Maximum Capacity`)) AS percentage FROM supportingdevices";
         $nutQuery = "SELECT SUM(AmountLeft) AS AL , SUM(`Maximum Capacity`) AS MC, (SUM(AmountLeft)/SUM(`Maximum Capacity`)) AS percentage FROM nutritionalsupply";
         $medQuery = "SELECT SUM(AmountLeft) AS AL , SUM(`Maximum Capacity`) AS MC, (SUM(AmountLeft)/SUM(`Maximum Capacity`)) AS percentage , SupplyRoomNumber FROM supplyroom_has_medication GROUP BY SupplyRoomNumber";
         $bpQuery = "SELECT SUM(AmountLeft) AS AL , SUM(`Maximum Capacity`) AS MC, (SUM(AmountLeft)/SUM(`Maximum Capacity`)) AS percentage , SupplyRoomNumber FROM supplyroom_has_basicpatientsupply GROUP BY SupplyRoomNumber";
         
         echo '<a href="index.php?#Reports">Return</a><br><br>';
         echo '<p style="color:blue"> For full breakdown of each supply with its names, cost, order dates and more, please refer to the supplies tab</p>';
         
         echo 'Administrative Supplies<br>';
         basicSupplyTable($asQuery);
         echo 'Surgical Equipment<br>';
         basicSupplyTable($surQuery);
         echo 'Supporting Devices<br>';
         basicSupplyTable($supQuery);
         echo 'Nutritional Supply<br>';
         basicSupplyTable($nutQuery);
         echo 'Medication<br>';
         complexSupplyTable($medQuery);
         echo 'Basic Patient Supplies<br>';
         complexSupplyTable($bpQuery);
     }
     
     function getDoctorReportForm() {
        echo '<a href="index.php?#Reports">Return</a><br><br>';
        $form = '<div>';
        $form .= '<form action="index.php#Reports" method ="POST">';
        $form .= 'Select Doctor <select name="doctorID">';
        $query = "SELECT EmployeeID as eID, CONCAT(FirstName,' ',LastName) AS EName FROM Employee WHERE JobID = 4";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['eID'].'">'.$row['EName'].'</option>';
        }
        $form .= '</select><br>';
        
        $form .= '<br><input name="submit_change" type="submit" value="Generate Report">'; 
        $form .= '</form></div> <br>';
        echo $form;        
     }
     
     
     function getDoctorReport($docID) {
         $queryServices = "SELECT COUNT(a.AppointmentID) AS NumServices FROM appointment AS a JOIN employee_appointment ea ON (a.AppointmentID = ea.AppointmentID)
                     WHERE ea.EmployeeID = $docID AND a.ServiceID NOT IN (SELECT ServiceID FROM Surgeries)";
         $querySurgeries = "SELECT COUNT(a.AppointmentID) AS NumSurgeries FROM appointment AS a JOIN employee_appointment ea ON (a.AppointmentID = ea.AppointmentID)
                     WHERE ea.EmployeeID = $docID AND a.ServiceID IN (SELECT ServiceID FROM Surgeries)";
         $queryServiceType = "SELECT DISTINCT(s.Name) FROM appointment AS a JOIN employee_appointment ea ON (a.AppointmentID = ea.AppointmentID)
                    JOIN service AS s ON (a.ServiceID = s.ServiceID)WHERE ea.EmployeeID = $docID AND a.ServiceID NOT IN (SELECT ServiceID FROM Surgeries)";
         $querySurgeryType = "SELECT DISTINCT(s.Name) FROM appointment AS a JOIN employee_appointment ea ON (a.AppointmentID = ea.AppointmentID)
                    JOIN service AS s ON (a.ServiceID = s.ServiceID)WHERE ea.EmployeeID = $docID AND a.ServiceID IN (SELECT ServiceID FROM Surgeries)";
         echo '<a href="index.php?#Reports">Return</a><br><br>';
         docTotalTable($queryServices, 'service');
         docTotalTable($querySurgeries, 'surgery');
         typeTable($queryServiceType, 'service');
         typeTable($querySurgeryType, 'surgery');  
     }
     
     function docTotalTable($query, $type) {
        $result = mysql_query($query);
        $row = mysql_fetch_assoc($result);
        if ($type == 'service') { $val = $row["NumServices"]; $title = "Total Number of Services";}
        else { $val = $row["NumSurgeries"]; $title = "Total Number of Surgeries"; }
        $table = '<div><table border="1">';
        $table .= '    <tr> <th class="tableHeaders">'.$title.'</th> </tr>';     
        $table .= '    <tr> <td> '. $val . ' </td> </tr>';
        $table .= '   </table> </div><br>';
        echo $table;
     }
     
     function typeTable($query, $type) {
        if ($type == 'service') { $title = "Service Types";}
        else {$title = "Surgery Types"; }
        $result = mysql_query($query);
        $table = '<div><table border="1"';
        $table .= '    <tr> <th class="tableHeaders">'.$title.'</th> </tr>';  
       while ($row = mysql_fetch_assoc($result)) {
         $val = $row["Name"];
         $table .= '    <tr> <td> '. $val . ' </td> </tr>';
        }
        $table .= '   </table> </div><br>';  
        echo $table; 
     }

     
     function basicSupplyTable($query) {
        $result = mysql_query($query);
        $row = mysql_fetch_assoc($result);
        $al = $row["AL"];
        $mc = $row["MC"];
        $percentage = round(($row['percentage'] * 100), 2);
        $table = '<div><table border="1" width ="300px">';
        $table .= '    <tr> ';
        $table .= '         <th class="tableHeaders" width ="150px">Amount Left</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Maximum Capacity</th>';   
        $table .= '    </tr>';
        if  ($percentage < 10) {  $table .= '         <td style="color:red"> '. $al . ' ('.$percentage.'% Left) </td>'; } 
        else {  $table .= '         <td> '. $al . ' ('.$percentage.'% Left) </td>';     }
        $table .= '         <td> '. $mc . ' </td>';
        $table .= '    </tr>';
        $table .= '   </table> </div><br>';
        echo $table;
     }
     
      function complexSupplyTable($query) {
        $result = mysql_query($query);
        $table = '<div><table border="1" width ="450px">';
        $table .= '    <tr> ';
        $table .= '         <th class="tableHeaders" width ="150px">Supply Room</th>';  
        $table .= '         <th class="tableHeaders" width ="150px">Amount Left</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Maximum Capacity</th>';   
        $table .= '    </tr>';
        
       while ($row = mysql_fetch_assoc($result)) {
            $al = $row["AL"];
            $mc = $row["MC"];
            $sr = $row["SupplyRoomNumber"];
            $percentage = round(($row['percentage'] * 100), 2);

            $table .= '         <td> '. $sr . ' </td>';
            if  ($percentage < 10) {
                $table .= '         <td style="color:red"> '. $al . ' ('.$percentage.'% Left) </td>';
            } else {
                $table .= '         <td> '. $al . ' ('.$percentage.'% Left) </td>';
            }
            $table .= '         <td> '. $mc . ' </td>';
            $table .= '    </tr>';
        }
        $table .= '   </table> </div><br>';  
        
        echo $table;  
      }
?>
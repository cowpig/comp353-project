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
     
    
    function getReportForm() {
        $form = '<div>';
        $form .= '<form action="index.php#Reports" method ="POST">';
        
        $form .= 'Select Employee Name <select name="reportType">';
        $query = "SELECT EmployeeID as eID, CONCAT(e.FirstName,' ',e.LastName,' [',j.Name,']') AS EName 
            FROM employee AS e, jobpayroll AS j 
            WHERE j.JobID = e.JobID";
        $result = mysql_query($query);
        while ($row = mysql_fetch_assoc($result)) {
            $form .= '<option value="'.$row['eID'].'">'.$row['EName'].'</option>';
        }
        $form .= '</select> ';

        $form .= '<input name="submit_change" type="submit" value="Get Schedule">'; 
        $form .= '</form></div> <br>';

        
        echo $form;
        
    }

?>
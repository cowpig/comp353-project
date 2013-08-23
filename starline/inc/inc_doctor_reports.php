<?php
     
    
    function getDoctorReportMainForm() {
        $form = '<div>';
        $form .= '<form action="index.php#Reports" method ="POST">';
        
        $form .= 'Select Report Type <br><br>';
        $form .= '<input type="radio" name="reportMainType" value="patientReportt"> Patients Similar Problems <br>';
        $form .= '<input type="radio" name="reportMainType" value="intResReport"> Interns/Residents Specialization <br>';

        $form .= '<br><input name="submit_change" type="submit" value="Proceed">'; 
        $form .= '</form></div> <br>';
        
        echo $form;
    }
    
    function getDoctorSpecificReportForm($reportType) { 
        switch ($reportType) {
            case 'patientReportt': { getPatientReport(); break; }
            case 'intResReport': { getIntResReport(); break; }
        }
     }
    
     function getIntResReport() {
         echo '<a href="index.php?#Reports">Return</a><br><br>';
         $query = "SELECT ea.EmployeeID, COUNT(a.ServiceID) AS Num, s.Name, CONCAT(e.FirstName,' ',e.LastName,' [',j.Name,']') AS EName
                FROM employee_appointment AS ea
                JOIN employee AS e ON (e.EmployeeID = ea.EmployeeID)
                JOIN appointment AS a ON (ea.AppointmentID = a.AppointmentID)
                JOIN service AS s ON (a.ServiceID = s.ServiceID)
                JOIN jobpayroll AS j ON (j.JobID = e.JobID)
                WHERE  e.JobID > 4 AND e.JobID < 9
                GROUP BY EmployeeID";
        $result = mysql_query($query);
        $table = '<div><table border="1" width ="830px">';
        $table .= '         <th class="tableHeaders">Name/Title</th>';
        $table .= '         <th class="tableHeaders">Service Specializatiton</th>';
        $table .= '         <th class="tableHeaders">Count</th>';  
        $table .= '         <th class="tableHeaders">Attending Phyiscian</th>'; 
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $eName =  $row["EName"];
            $sName =  $row["Name"];
            $count =  $row["Num"];
            $eID = $row['EmployeeID'];
       
        $table .= '    <tr> <td> '. $eName . ' </td>';
        $table .= '         <td> '. $sName . ' </td>';
        $table .= '         <td> '. $count . ' </td>';
        $query2 = "SELECT CONCAT(e.FirstName,' ',e.LastName) AS DName FROM attendingphysician AS ap JOIN employee AS e ON (e.EmployeeID = ap.AttendingID) WHERE JuniorDoctorID = $eID";       
        $row2 = mysql_fetch_assoc(mysql_query($query2));
        $table .= '         <td> '. $row2['DName'] . ' </td>';
        $table .= '    </tr>';
        }
        $table .= '   </table> </div>';  
        
        echo $table;   
         
         
     }

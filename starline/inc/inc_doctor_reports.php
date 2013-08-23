<?php
     
    
    function getDoctorReportMainForm() {
        $form = '<div>';
        $form .= '<form action="index.php#Reports" method ="POST">';
        
        $form .= 'Select Report Type <br><br>';
        $form .= '<input type="radio" name="reportMainType" value="patientReport"> Patients Similar Problems <br>';
        $form .= '<input type="radio" name="reportMainType" value="intResReport"> Interns/Residents Specialization <br>';

        $form .= '<br><input name="submit_change" type="submit" value="Proceed">'; 
        $form .= '</form></div> <br>';
        
        echo $form;
    }
    
    function getDoctorSpecificReportForm($reportType) { 
        switch ($reportType) {
            case 'patientReport': { getPatientReport(); break; }
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
        $table .= '         <th class="tableHeaders">Service Specialization</th>';
        $table .= '         <th class="tableHeaders">Count</th>';  
        $table .= '         <th class="tableHeaders">Attending Physician</th>'; 
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
     
     function getPatientReport(){
		   echo '<a href="index.php?#Reports">Return</a><br><br>';
         $query = "SELECT p.MedicareNumber, p.FirstName, p.LastName, m.Description, p.DoctorNotes
                FROM patient AS p
                JOIN medication_list AS ml ON ( p.medicationListID = ml.medicationListID ) 
                JOIN medication AS m ON ( m.medicationID = ml.medicationID )";
        $result = mysql_query($query);
        $table = '<div><table border="1" width ="830px">';
        $table .= '    <tr>';       
		$table .= '         <th class="tableHeaders">Medication Name</th>';
        $table .= '         <th class="tableHeaders">First Name</th>';
        $table .= '         <th class="tableHeaders">Last Name</th>';  
        $table .= '         <th class="tableHeaders">Medicare number</th>';
        $table .= '         <th class="tableHeaders" width>Doctor notes </th>'; 
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $medicare=$row["MedicareNumber"];
            $fname =  $row["FirstName"];
            $lname = $row["LastName"];
            $medlist =  $row["Description"];
            $notes =  $row["DoctorNotes"];
		$table .= '    <tr>';
        $table .= '         <td> '. $medlist . ' </td>'; 
        $table .= '         <td> '. $fname. ' </td>';       
        $table .= '         <td> '. $lname . ' </td>';
        $table .= '         <td> '. $medicare . ' </td>'; 
        $table .= '         <td> '. $notes . ' </td>';  
        $table .= '    </tr>';
        }
        $table .= '   </table> </div>';  
        
        echo $table;   
		 
		 
        }
?>
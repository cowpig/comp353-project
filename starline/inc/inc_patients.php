<?php

  function getPatientForm() {

        $form = '<div>';
        $form .= '<form action="index.php#Patients" method ="POST">'; 
        $form .= 'Select All or Own Patients <select name="patientChoice">';
        $form .= '<option value="0">All</option>';
        $form .= '<option value="1">Own patients</option>';
        $form .= '</select>';  
        $form .= '<input name="submit_change" type="submit" value="Go">'; 
        $form .= '</form></div>';

        echo $form;

    }

function updatePatient($hcard,$notes){
	
	$query = "UPDATE patient
			  SET DoctorNotes=$notes
			  WHERE HospitalCardID=$hcard"; 
	mysql_query($query) or die(mysql_error());
	
} 

function getPatientTable($id) {
        $query = "SELECT * 
                FROM patient as p ";
		if ($id !=0){
			$query .= " WHERE p.DoctorID=$id";
		} 
        $result = mysql_query($query);
        $table = '<div><table border="1" width ="700px">';
        $table .= '    <tr> <th class="tableHeaders" width ="100px">Hospital Card ID</th>';
        $table .= '         <th class="tableHeaders" width ="100px">Medicare Number</th>';
        $table .= '         <th class="tableHeaders" width ="100px">First Name</th>';
        $table .= '         <th class="tableHeaders" width ="100px">Last Name</th>';
        $table .= '         <th class="tableHeaders" width ="100px">Medication List ID </th>'; 
        $table .= '         <th class="tableHeaders" width ="400px">Doctor notes </th>';       
        if ($id != 0)
			$table .= '         <th class="tableHeaders" width ="400px">Update notes</th>';       
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $hcard=$row["HospitalCardID"];
            $medicare=$row["MedicareNumber"];
            $fname =  $row["FirstName"];
            $lname = $row["LastName"];
            $medlist =  $row["MedicationListID"];
            $notes =  $row["DoctorNotes"];
       
        $table .= '    <tr> <td> '. $hcard . ' </td>';
        $table .= '         <td> '. $medicare . ' </td>';
        $table .= '         <td> '. $fname . ' </td>';  
        $table .= '         <td> '. $lname. ' </td>';       
        $table .= '         <td> '. $medlist . ' </td>';
		$table .= '         <td> '. $notes . ' </td>';  
        if ($id != 0){
			$table .= '         <td>
									<form action="index.php#Patients" method="post">
									   Notes: <input type="text" size="30" name="updateNotes" /> 
									   <input type="submit" value="Submit" />
									</form>
								</td>';
			if (isset ($_POST['updateNotes'])){
					echo $_POST['updateNotes'];
					updatePatient($hcard, $_POST['updateNotes']);
			}
			
			}
			
			
		}


        $table .= '    </tr>';
       
         
        $table .= '   </table> </div>';  
        
        return $table;        
    }
    
 
    
;

?>


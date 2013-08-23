<?php

    function getOrderSupplyForm() {

        $form = '<div>';
        $form .= '<form action="index.php#Supplies" method ="POST">'; 
       // $form .= 'Select The Supply Type to Order <select name="supplyType">';
       // $form .= '<option value="null">---------</option>';
        $form .= '<br>Select The Supply Type to Order/View<br>';
        $form .= '<input type="radio" name="supplyType"value="medical">Medical<br>';
        $form .= '<input type="radio" name="supplyType" value="nonmedical">Non-Medical<br>';
        $form .= '<input type="radio" name="supplyType" value="nutrition">Nutrition<br>';
       // $form .= '</select>';  
        $form .= '<input name="submit_change" type="submit" value="Proceed">'; 
        $form .= '</form></div>';

        echo $form;

    }
   
    function getSpecificSupplyForm($type) {
        $form = '<div>';
        $form .= '<form action="index.php#Supplies" method ="POST">'; 
       // $form .= 'Select The Supply Type to Order <select name="supplySpecificType">';
       // $form .= '<option value="null">---------</option>';
        $form .= '<br>Select The Specific Supply Type to Order/View<br>';
        if($type == 'medical') {
            $form .= '<input type="radio" name="supplySpecificType" value="medication">Medication<br>';
            $form .= '<input type="radio" name="supplySpecificType"  value="surgical">Surgical Equipment<br>';
            $form .= '<input type="radio" name="supplySpecificType" value="support">Supporting Devices<br>';
        } else  if ($type == 'nonmedical') {
            $form .= '<input type="radio" name="supplySpecificType" value="patient">Basic Patient<br>';
            $form .= '<input type="radio" name="supplySpecificType" value="administrative">Administrative<br>';
        } 
       // $form .= '</select>';  
        $form .= '<input name="submit_change" type="submit" value="Proceed">'; 
        $form .= '</form></div>';

        echo $form;
    }
    
    function getAddForm($type) {
        switch ($type) {
            case 'medication': { getMedicationForm(); break; }
            case 'surgical': { getSurgicalForm(); break; }             
            case 'support': { getSupportForm(); break; }              
            case 'patient': { getPatientForm(); break; }            
            case 'administrative': { getAdministrativeForm(); break; }    
        }
    }
    
    function getMedicationForm() {
        $query = "SELECT m.MedicationID AS ID, m.Description, shm.LastOrdered, m.Cost, shm.AmountLeft, shm.`Maximum Capacity`, shm.SupplyRoomNumber, (AmountLeft/`Maximum Capacity`) AS percentage
                FROM medication AS m
                JOIN supplyroom_has_medication AS shm ON (m.MedicationID = shm.MedicationID) ORDER BY m.MedicationID ASC;";
        $result = mysql_query($query);
        echo "<div> Medication Supplies </div><br>";
        echo getTable($result, "medication");
    }
    
    function getSurgicalForm() {
        $query = "SELECT se.SurgicalID AS ID, se.Description, se.LastOrdered, se.Cost, se.AmountLeft, se.`Maximum Capacity`, (AmountLeft/`Maximum Capacity`) AS percentage
			FROM surgicalequipment AS se";
        $result = mysql_query($query);
        echo "<div> Surgical Supplies </div><br>";
        echo getTable($result, "surgicalequipment");
    }
    
    function getSupportForm() {
        $query = "SELECT se.SupportingDevicesID AS ID, se.Description, se.LastOrdered, se.Cost, se.AmountLeft, se.`Maximum Capacity`, (AmountLeft/`Maximum Capacity`) AS percentage
			FROM supportingdevices AS se";
        $result = mysql_query($query);        
        echo "<div> Support Supplies </div><br>";
        echo getTable($result, "supportingdevices");
    }
    
//    
//    SELECT bps.BasicPatientSupplyID AS ID, bps.Description, bps.LastOrdered, bps.Cost, bps.AmountLeft, bps.`Maximum Capacity`, shb.SupplyRoomNumber, shb.Floor 
//			FROM basicpatientsupply AS bps, supplyroom_has_basicpatientsupply AS shb
//			WHERE shb.BasicPatientSupplyID = bps.BasicPatientSupplyID
    function getPatientForm() {
        $query = "SELECT bps.BasicPatientSupplyID AS ID, bps.Description, shb.LastOrdered, bps.Cost, shb.AmountLeft, shb.`Maximum Capacity`, shb.SupplyRoomNumber, (AmountLeft/`Maximum Capacity`) AS percentage
                FROM basicpatientsupply AS bps
                JOIN supplyroom_has_basicpatientsupply AS shb ON (bps.BasicPatientSupplyID = shb.BasicPatientSupplyID) ORDER BY bps.BasicPatientSupplyID ASC";
        $result = mysql_query($query);
        echo "<div> Patient Supplies </div><br>";
        echo getTable($result, "basicpatientsupply");
    }
    
    function getAdministrativeForm() {
        $query = "SELECT ad.AdminSupplyID AS ID, ad.Description, ad.LastOrdered, ad.Cost, ad.AmountLeft, ad.`Maximum Capacity`, (AmountLeft/`Maximum Capacity`) AS percentage
			FROM administrativesupply AS ad";
        $result = mysql_query($query);
        echo "<div> Administrative Supplies </div><br>";
        echo getTable($result, "administrativesupply");
    }
    
    function getNutritionForm() {
        $query = "SELECT n.NutritionalSupplyID AS ID, n.Description, n.LastOrdered, n.Cost, n.AmountLeft, n.`Maximum Capacity`, (AmountLeft/`Maximum Capacity`) AS percentage
                FROM nutritionalsupply AS n";
        $result = mysql_query($query);
        echo "<div> Nutrition Supplies </div><br>";
        echo getTable($result, "nutritionalsupply");
    }
    

    
    function getTable($result, $tableName) {
        $table = '<div><table border="1" width ="830px">';
        $table .= '    <tr> ';
        if ($tableName == 'basicpatientsupply' || $tableName == 'medication') {
            $table .= '         <th class="tableHeaders width="150">Supply Room</th>';
        }
        $table .= '     <th class="tableHeaders" width="100">Description </th>';
        $table .= '         <th class="tableHeaders" width ="150px">Last Ordered </th>';
        $table .= '         <th class="tableHeaders" width ="50px">Cost</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Amount Left</th>';
        $table .= '         <th class="tableHeaders" width ="125px">Maximum Capacity</th>';
        $table .= '         <th class="tableHeaders" width ="125px">Order Now </th>';   
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $desc =  $row["Description"];
            $lo =  $row["LastOrdered"];
            $cost =  $row["Cost"];
            $al = $row["AmountLeft"];
            $mc = $row["Maximum Capacity"];
            $percentage = round(($row['percentage'] * 100), 2);

       
        $table .= '    <tr> ';
         if ($tableName == 'basicpatientsupply' || $tableName == 'medication') {
            $table .= '<td> '. $row["SupplyRoomNumber"] . ' </td>';
        }
        $table .= '<td> '. $desc . ' </td>';
        $table .= '         <td> '. $lo . ' </td>';
        $table .= '         <td> '. $cost . ' </td>';
        
        if  ($percentage < 10) {
            $table .= '         <td style="color:red"> '. $al . ' ('.$percentage.'% Left) </td>';
        } else {
            $table .= '         <td> '. $al . ' ('.$percentage.'% Left) </td>';
        }
        $table .= '         <td> '. $mc . ' </td>';
        if ($_SESSION['JobID'] == 2 || $_SESSION['JobID'] == 3) {
            $table .= '         <td> <a href="index.php?tname='.$tableName.'&id='.$row["ID"];
            if ($tableName == 'basicpatientsupply' || $tableName == 'medication') {
                $table .= '&sr='.$row["SupplyRoomNumber"].'#Supplies"> Submit Order </a> </td>';
            } else {
                $table .= '#Supplies"> Submit Order </a> </td>';
            }
            
        } else {
            $table .= '         <td> Not Allowed </td>';
        }
        $table .= '    </tr>';

        
        }
        $table .= '   </table> </div>';  
        
        return $table;        
    }
    
    function orderSupply($tname, $id, $sr) {
        switch ($tname) {
            case 'medication': { $idname = "MedicationID"; break; }
            case 'surgicalequipment': { $idname = "SurgicalID"; break; }             
            case 'supportingdevices': { $idname = "SupportingDeviceID"; break; }              
            case 'basicpatientsupply': { $idname = "BasicPatientSupplyID"; break; }            
            case 'administrativesupply': { $idname = "AdminID"; break; }   
            case 'nutritionalsupply': { $idname = "NutritionalSupplyID"; break; }     
        }
        if ($tname == 'medication') {
            $query = "UPDATE supplyroom_has_medication SET AmountLeft = `Maximum Capacity`, LastOrdered = CURDATE() WHERE $idname = $id AND SupplyRoomNumber = $sr";
        } else if ($tname == 'basicpatientsupply') {
            $query = "UPDATE supplyroom_has_basicpatientsupply SET AmountLeft = `Maximum Capacity`, LastOrdered = CURDATE() WHERE $idname = $id AND SupplyRoomNumber = $sr";
        } else {
            $query = "UPDATE $tname SET AmountLeft = `Maximum Capacity`, LastOrdered = CURDATE() WHERE $idname = $id";
        }
        
        if(mysql_query($query)) {
            echo '<br> Supply Ordered Succesfully! <br>';
        }  else {
            echo $query;
            echo 'query error';
        }
    }
?>
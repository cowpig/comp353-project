<?php

    function getOrderSupplyForm() {

        $form = '<div>';
        $form .= '<form action="index.php#Supplies" method ="POST">'; 
        $form .= 'Select The Supply Type to Order <select name="supplyType">';
        $form .= '<option value="null">---------</option>';
        $form .= '<option value="medical">Medical</option>';
        $form .= '<option value="nonmedical">Non-Medical</option>';
        $form .= '<option value="nutrition">Nutrition</option>';
        $form .= '</select>';  
        $form .= '<input name="submit_change" type="submit" value="Go">'; 
        $form .= '</form></div>';

        echo $form;

    }
   
    function getSpecificSupplyForm($type) {
        $form = '<div>';
        $form .= '<form action="index.php#Supplies" method ="POST">'; 
        $form .= 'Select The Supply Type to Order <select name="supplySpecificType">';
        $form .= '<option value="null">---------</option>';
        
        if($type == 'medical') {
            $form .= '<option value="medication">Medication</option>';
            $form .= '<option value="surgical">Surgical Equipment</option>';
            $form .= '<option value="support">Supporting Devices</option>';
        } else  if ($type == 'nonmedical') {
            $form .= '<option value="patient">Basic Patient</option>';
            $form .= '<option value="administrative">Administrative</option>';
        } 
        $form .= '</select>';  
        $form .= '<input name="submit_change" type="submit" value="Go">'; 
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
        $query = "SELECT m.MedicationID AS ID, m.Description, m.LastOrdered, m.Cost, m.AmountLeft, m.`Maximum Capacity`, (AmountLeft/`Maximum Capacity`) AS percentage
			FROM Medication AS m;";
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
        $query = "SELECT bps.BasicPatientSupplyID AS ID, bps.Description, bps.LastOrdered, bps.Cost, bps.AmountLeft, bps.`Maximum Capacity`, (AmountLeft/`Maximum Capacity`) AS percentage
			FROM basicpatientsupply AS bps";
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
        $query = "SELECT n.NutritionalSupplyID AS ID, n.Type AS 'Description', n.LastOrdered, n.NeedsFill 
                FROM nutritionalsupply AS n";
        $result = mysql_query($query);
        echo "<div> Nutrition Supplies </div><br>";
        echo getTable($result, "nutritionalsupply");
    }
    

    
    function getTable($result, $tableName) {
        $table = '<div><table border="1" width ="830px">';
        $table .= '    <tr> <th class="tableHeaders" width ="150px">Description </th>';
        $table .= '         <th class="tableHeaders" width ="150px">Last Ordered </th>';
        $table .= '         <th class="tableHeaders" width ="150px">Cost </th>';
        $table .= '         <th class="tableHeaders" width ="150px">Amount Left</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Maximum Capacity</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Order Now </th>';                      
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $desc =  $row["Description"];
            $lo =  $row["LastOrdered"];
            $cost =  $row["Cost"];
            $al = $row["AmountLeft"];
            $mc = $row["Maximum Capacity"];
            $percentage = round(($row['percentage'] * 100), 2);

       
        $table .= '    <tr> <td> '. $desc . ' </td>';
        $table .= '         <td> '. $lo . ' </td>';
        $table .= '         <td> '. $cost . ' </td>';
        
        if  ($percentage < 10) {
            $table .= '         <td style="color:red"> '. $al . ' ('.$percentage.'% Left) </td>';
        } else {
            $table .= '         <td> '. $al . ' ('.$percentage.'% Left) </td>';
        }
        $table .= '         <td> '. $mc . ' </td>';
        if ($_SESSION['JobID'] == 2 || $_SESSION['JobID'] == 3) {
            $table .= '         <td> <a href="index.php?tname='.$tableName.'&id='.$row["ID"].'#Supplies"> Submit Order </a> </td>';  
        } else {
            $table .= '         <td> Not Allowed </td>';
        }
        $table .= '    </tr>';

        
        }
        $table .= '   </table> </div>';  
        
        return $table;        
    }
    
    function orderSupply($tname, $id) {
        switch ($tname) {
            case 'medication': { $idname = "MedicationID"; break; }
            case 'surgicalequipment': { $idname = "SurgicalID"; break; }             
            case 'supportingdevices': { $idname = "SupportingDeviceID"; break; }              
            case 'basicpatientsupply': { $idname = "BasicPatientSupplyID"; break; }            
            case 'administrativesupply': { $idname = "AdminID"; break; }     
        }
        $query = "UPDATE $tname SET AmountLeft = `Maximum Capacity` WHERE $idname = $id";
        
        if(mysql_query($query)) {
            echo '<br> Supply Ordered Succesfully! <br>';
        }  else {
            echo $query;
            echo 'query error';
        }
    }
?>
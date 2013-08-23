<?php

    function getCurrentPay() {
        $empID = $_SESSION['EmployeeID'];
        $jobID = $_SESSION['JobID'];
        $query = "SELECT j.wagerate, j.payroll FROM employee as e, jobpayroll as j WHERE e.EmployeeID = $empID AND e.JobID = j.JobID";
        $result = mysql_query($query); 
        $resultdata = mysql_fetch_assoc($result);
        $wage =  $resultdata['wagerate'];
        $payroll = $resultdata['payroll'];

        if ($wage == 'hour') {
            $currentPay = getPayValue($jobID, $empID, $wage, $payroll);
            echo "Your current bi-weekly period pay is $";
            echo (''.($currentPay*2).'--- ($'.$currentPay.' actual as only 1 week recorded)<br>');
        } else {
            echo "Your current bi-weekly period pay is $".getPayValue($jobID, $empID, $wage, $payroll)." <br>";
        }
        if ($wage == 'year') { 
            echo 'Your total current yearly pay is $'.round($_SESSION['payrollAdjusted'],2); 
        }
    }
    
    function getEmployeePay($empID, $jobID) {
        $query = "SELECT j.wagerate, j.payroll FROM employee as e, jobpayroll as j WHERE e.EmployeeID = $empID AND e.JobID = j.JobID";
        $result = mysql_query($query); 
        $resultdata = mysql_fetch_assoc($result);
        $wage =  $resultdata['wagerate'];
        $payroll = $resultdata['payroll'];
        return getPayValue($jobID, $empID, $wage, $payroll);
        
    }
  
    function getPayValue($jobID, $empID, $wage, $payroll) {
       if ($wage == 'year') {
            if ($jobID < 4) {
                $query = "SELECT FLOOR(DATEDIFF( CURDATE( ) , startdate ) /365 ) AS year, multiply FROM employee, yearsofserviceadjustement as y WHERE EmployeeID = $empID AND y.JobID = $jobID";
                $result = mysql_query($query); 
                $resultdata = mysql_fetch_assoc($result);
                $numYears = $resultdata['year'];
                $multiply = $resultdata['multiply'];
                while ($numYears > 0) {
                    $payroll = $payroll * $multiply;
                    $numYears--;
                }
                $payroll = round($payroll, 2);
            }
           $_SESSION['payrollAdjusted'] = $payroll;
           $currentPay = round($payroll/26, 2);

        }
        else if ($jobID == 4 && $wage =='service') {
            
            $query = "SELECT SUM(s.AmountBillable) AS pay
                    FROM appointment AS a 
                    JOIN employee_appointment AS ea ON (a.AppointmentID = ea.AppointmentID) 
                    JOIN service AS s ON (a.ServiceID = s.ServiceID)
                    WHERE ea.EmployeeID = $empID";
            $result = mysql_query($query); 
            $resultdata = mysql_fetch_assoc($result);
            $currentPay =  $resultdata['pay'];
           
        } 
        else if ($wage == 'hour') {
            $query = "SELECT TIME_TO_SEC(SUM(TIMEDIFF(EndTime, StartTime)))/3600 AS hours, y.`add`, j.overtimemultiplier, FLOOR(DATEDIFF( CURDATE( ) , startdate ) /365 ) AS year
                    FROM schedule AS s
                    JOIN employee_schedule AS es ON s.ShiftID = es.ScheduleID
                    JOIN employee AS e ON e.EmployeeID = es.EmployeeID,
                    jobpayroll AS j, yearsofserviceadjustement AS y 
                    WHERE e.EmployeeID = $empID AND e.jobID = j.JobID AND y.JobID = e.JobID";
            $result = mysql_query($query); 
            $resultdata = mysql_fetch_assoc($result);
            $year = $resultdata['year'];
            $hours = $resultdata['hours'];
            $add = $resultdata['add'];
            $overtimeMul = $resultdata['overtimemultiplier'];
            
            if ($jobID == 9 || $jobID == 10) {
               $maxHours = 36;
               $numYears = floor($year/5);
            } else {
                $maxHours = 37.5;
                $numYears = floor($year/8);
            }
            
            while ($numYears > 0) {
               $payroll = $payroll + $add;
               $numYears--;
            }
            
            if($hours <= $maxHours) {
                $currentPay = $payroll * $hours;
            } else {
                $currentPay = $payroll * $maxHours;
                $hoursExtra =  $hours - $maxHours;
                $overtimePay = $payroll * $overtimeMul;
                $currentPay = $currentPay + ($overtimePay * $hoursExtra);
            }
        }
       return $currentPay;
    }
    
    
    function getAppointments($empID) {
        $query = "SELECT a.AppointmentID, s.Name AS SName, CONCAT(p.FirstName,' ',p.LastName) AS PName, a.StartTime, a.EndTime, u.Name AS UName, a.RoomID
                        FROM appointment AS a 
                        JOIN service AS s ON (a.ServiceID = s.ServiceID) 
                        JOIN patient AS p ON (p.HospitalCardID = a.PatientID)
                        JOIN unit AS u ON (u.UnitID = a.UnitID) 
                        JOIN employee_appointment AS ea ON (ea.AppointmentID = a.AppointmentID)
                        WHERE ea.EmployeeID = $empID
                        ORDER BY `a`.`StartTime`  ASC";
        $result = mysql_query($query);
        
        $table = '<div><table border="1" width ="700px">';
        $table .= '    <tr> <th class="tableHeaders" width ="150px">Service Name</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Patient Name</th>';
        $table .= '         <th class="tableHeaders" width ="150px">Start Time</th>';
        $table .= '         <th class="tableHeaders" width ="150px">End Time</th>';
        $table .= '         <th class="tableHeaders" width ="100px">Room Number</th>';
        $table .= '    </tr>';
        
        while ($row = mysql_fetch_assoc($result)) {
            $sName =  $row['SName'];
            $pName =  $row['PName'];
            $sd =  $row["StartTime"];
            $ed =  $row["EndTime"];
            $rn =  $row["RoomID"];
            $table .= '    <tr> <td> '. $sName . ' </td>';
            $table .= '         <td> '. $pName . ' </td>';        
            $table .= '         <td> '. $sd . ' </td>';
            $table .= '         <td> '. $ed . ' </td>';
            $table .= '         <td> '. $rn . ' </td>';
            $table .= '    </tr>';
        }
        $table .= '   </table> </div>'; 
        echo $table;
    }
    
    function getAttendingPhysician($empID) {
        $query = "SELECT CONCAT(e.FirstName,' ',e.LastName) AS EName FROM attendingphysician AS ap JOIN employee AS e ON (e.EmployeeID = ap.AttendingID) WHERE JuniorDoctorID = $empID";
        $result = mysql_query($query);
        $row = mysql_fetch_assoc($result);
        echo '<br><br>Your Attending Physician is '.$row['EName'].'<br>';
    }

    
?>
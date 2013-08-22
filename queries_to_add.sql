# Nurse shift supervisor checking all nurses' schedules today 
#   (starttime in last line can be changed to get a week or whatever)
SELECT ea.EmployeeID, a.StartTime, a.EndTime, a.PatientID, a.ServiceID, e.UnitID FROM employee super
    CROSS JOIN appointment a
    LEFT JOIN employee_appointment ea ON ea.AppointmentID = a.AppointmentID
    LEFT JOIN employee e ON ea.EmployeeID = e.EmployeeID AND super.UnitID = e.UnitID
    WHERE super.EmployeeID = $SUPERVISOR_ID
    AND a.StartTime < NOW() AND a.EndTime > NOW();

# Intern/Resident seeing what he is doing today
SELECT a.StartTime, a.EndTime, a.PatientID, a.ServiceID, a.RoomID FROM attendingphysician ap
    LEFT JOIN employee_appointment ea ON ea.EmployeeID = ap.AttendingID
    LEFT JOIN appointment a ON a.AppointmentID = ea.AppointmentID
    WHERE ap.JuniorDoctorID = $JUNIORID
    AND a.StartTime < NOW() AND a.EndTime > NOW();

# Nurse seeing what she is doing today 
#   (actually, this works with anyone who is scheduled for their own appointments)
SELECT a.StartTime, a.EndTime, a.PatientID, a.ServiceID, a.RoomID FROM employee e
    LEFT JOIN employee_appointment ea ON ea.EmployeeID = e.EmployeeID
    LEFT JOIN appointment a ON a.AppointmentID = ea.AppointmentID
    WHERE e.EmployeeID = $EMPLOYEEID
    AND a.StartTime < NOW() AND a.EndTime > NOW();

# Finding all services over a time period for a specific unit
#   Note that unit 3 is surgery, so setting UnitID to 3 will get all surgeries
SELECT a.StartTime, a.EndTime, a.PatientID, s.Name, s.AmountBillable FROM appointment a
    LEFT JOIN service s ON s.ServiceID = a.ServiceID
    WHERE a.UnitID = UNITID
    AND a.StartTime < NOW() AND a.EndTime > NOW();

# Finding all services performed by a specific doctor
#   (or any employee, for that matter)
SELECT a.StartTime, a.EndTime, a.PatientID, s.Name, s.AmountBillable FROM employee e
    LEFT JOIN employee_appointment ea ON ea.EmployeeID = e.EmployeeID
    LEFT JOIN appointment a ON a.AppointmentID = ea.AppointmentID
    LEFT JOIN service s ON s.ServiceID = a.ServiceID
    WHERE e.EmployeeID = EMPLOYEEID
    AND a.StartTime < NOW() AND a.EndTime > NOW();



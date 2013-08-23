<?php
require 'inc/inc_global.php';
require 'inc/inc_schedule.php';

?>
<div id="jQueryUITabs1">
  <ul>
    <li><a href="#Home"><span>Home</span></a></li>
  </ul>
    
  <div id="Home"><br>
      <?php
        getCurrentPay();
        echo "<br>Current Patient Appointments";
        getAppointments($_SESSION['EmployeeID']);
        echo "<br> Current Schedule";
        echo getScheduleTable($_SESSION['EmployeeID']);
      ?>
  </div>

</div>
<script type="text/javascript">$(function(){$("#jQueryUITabs1").tabs();$(".datepicker").datetimepicker({
	timeFormat: 'HH:mm:ss',
	stepHour: 1,
	stepMinute: 10,
	stepSecond: 10,
        dateFormat:'yy-mm-dd'
})});</script>

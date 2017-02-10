proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir /home/aaron/school/EGR426/Ro_sham_bo/Ro_sham_bo.cache/wt [current_project]
  set_property parent.project_path /home/aaron/school/EGR426/Ro_sham_bo/Ro_sham_bo.xpr [current_project]
  set_property ip_output_repo /home/aaron/school/EGR426/Ro_sham_bo/Ro_sham_bo.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  add_files -quiet /home/aaron/school/EGR426/Ro_sham_bo/Ro_sham_bo.runs/synth_1/seven_seg.dcp
  read_xdc /home/aaron/school/EGR426/Ro_sham_bo/Ro_sham_bo.srcs/constrs_1/new/Ro_sham_bo.xdc
  link_design -top seven_seg -part xc7a35tcpg236-1
  write_hwdef -file seven_seg.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force seven_seg_opt.dcp
  report_drc -file seven_seg_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force seven_seg_placed.dcp
  report_io -file seven_seg_io_placed.rpt
  report_utilization -file seven_seg_utilization_placed.rpt -pb seven_seg_utilization_placed.pb
  report_control_sets -verbose -file seven_seg_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force seven_seg_routed.dcp
  report_drc -file seven_seg_drc_routed.rpt -pb seven_seg_drc_routed.pb -rpx seven_seg_drc_routed.rpx
  report_methodology -file seven_seg_methodology_drc_routed.rpt -rpx seven_seg_methodology_drc_routed.rpx
  report_timing_summary -warn_on_violation -max_paths 10 -file seven_seg_timing_summary_routed.rpt -rpx seven_seg_timing_summary_routed.rpx
  report_power -file seven_seg_power_routed.rpt -pb seven_seg_power_summary_routed.pb -rpx seven_seg_power_routed.rpx
  report_route_status -file seven_seg_route_status.rpt -pb seven_seg_route_status.pb
  report_clock_utilization -file seven_seg_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force seven_seg_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}


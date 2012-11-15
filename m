From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/7] sensors-detect: Print timings at standard DDR2 speeds
Date: Thu, 15 Nov 2012 12:00:39 +0100
Message-ID: <20121115120039.5bfc3a92@endymion.delvare>
References: <20121115115231.341ac0c9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121115115231.341ac0c9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Print timings at standard DDR2 speeds. The minimum cycle times for the
3 supported CAS latency values do not necessarily match standard
speeds, and even if they do, they may not cover all standard speeds.
Display the timings at all standard supported speeds. This makes it
easier to figure out which memory modules will work well together
without tinkering with BIOS options.
---
 eeprom/decode-dimms |   51 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 15 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-10-25 14:02:21.000000000 +0200
+++ i2c-tools/eeprom/decode-dimms	2012-11-15 09:37:36.686924305 +0100
@@ -1074,7 +1074,7 @@ sub ddr2_core_timings($$$$$)
 	my ($cas, $ctime, $trcd, $trp, $tras) = @_;
 
 	return $cas . "-" . ceil($trcd/$ctime) . "-" . ceil($trp/$ctime) .
-		"-" . ceil($tras/$ctime) . " as DDR2-" . int(2000 / $ctime);
+		"-" . ceil($tras/$ctime);
 }
 
 # Parameter: EEPROM bytes 0-127 (using 3-62)
@@ -1082,7 +1082,7 @@ sub decode_ddr2_sdram($)
 {
 	my $bytes = shift;
 	my $temp;
-	my $ctime;
+	my ($ctime, $ctime1, $ctime2, $ctime_min, $ctime_max);
 
 # SPD revision
 	printl_cond($bytes->[62] != 0xff, "SPD Revision",
@@ -1091,7 +1091,7 @@ sub decode_ddr2_sdram($)
 # speed
 	prints("Memory Characteristics");
 
-	$ctime = ddr2_sdram_ctime($bytes->[9]);
+	$ctime_min = $ctime = ddr2_sdram_ctime($bytes->[9]);
 	my $ddrclk = 2 * (1000 / $ctime);
 	my $tbits = ($bytes->[7] * 256) + $bytes->[6];
 	if ($bytes->[11] & 0x03) { $tbits = $tbits - 8; }
@@ -1168,7 +1168,7 @@ sub decode_ddr2_sdram($)
 
 	if (exists $cas{$highestCAS}) {
 		$core_timings = ddr2_core_timings($highestCAS, $ctime,
-			$trcd, $trp, $tras);
+			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime);
 
 		$cycle_time = tns($ctime) . " at CAS $highestCAS (tCK min)";
 		$access_time = tns(ddr2_sdram_atime($bytes->[10]))
@@ -1176,35 +1176,56 @@ sub decode_ddr2_sdram($)
 	}
 
 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[23..24])) {
-		$ctime = ddr2_sdram_ctime($bytes->[23]);
-		$core_timings .= "\n".ddr2_core_timings($highestCAS-1, $ctime,
-			$trcd, $trp, $tras);
+		$ctime1 = ddr2_sdram_ctime($bytes->[23]);
+		$core_timings .= "\n".ddr2_core_timings($highestCAS-1, $ctime1,
+			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime1);
 
-		$cycle_time .= "\n".tns($ctime)
+		$cycle_time .= "\n".tns($ctime1)
 			     . " at CAS ".($highestCAS-1);
 		$access_time .= "\n".tns(ddr2_sdram_atime($bytes->[24]))
 			      . " at CAS ".($highestCAS-1);
 	}
 
 	if (exists $cas{$highestCAS-2} && spd_written(@$bytes[25..26])) {
-		$ctime = ddr2_sdram_ctime($bytes->[25]);
-		$core_timings .= "\n".ddr2_core_timings($highestCAS-2, $ctime,
-			$trcd, $trp, $tras);
+		$ctime2 = ddr2_sdram_ctime($bytes->[25]);
+		$core_timings .= "\n".ddr2_core_timings($highestCAS-2, $ctime2,
+			$trcd, $trp, $tras) . " as DDR2-" . int(2000 / $ctime2);
 
-		$cycle_time .= "\n".tns($ctime)
+		$cycle_time .= "\n".tns($ctime2)
 			     . " at CAS ".($highestCAS-2);
 		$access_time .= "\n".tns(ddr2_sdram_atime($bytes->[26]))
 			      . " at CAS ".($highestCAS-2);
 	}
 
+	$ctime_max = ddr2_sdram_ctime($bytes->[43]);
+
 	printl_cond(defined $core_timings, "tCL-tRCD-tRP-tRAS", $core_timings);
 	printl_cond(defined $cycle_time, "Minimum Cycle Time", $cycle_time);
 	printl_cond(defined $access_time, "Maximum Access Time", $access_time);
-	$temp = ddr2_sdram_ctime($bytes->[43]);
 	printl_cond(($bytes->[43] & 0xf0) && $bytes->[43] != 0xff,
 		    "Maximum Cycle Time (tCK max)",
-		    $temp == 0 ? "" : # Wouldn't be displayed, prevent div by 0
-		    tns($temp)." (DDR2-".int(2000 / $temp).")");
+		    $ctime_max == 0 ? "" : # Wouldn't be displayed, prevent div by 0
+		    tns($ctime_max)." (DDR2-".int(2000 / $ctime_max).")");
+
+# standard DDR2 speeds
+	prints("Timings at Standard Speeds");
+	foreach $ctime (1.875, 2.5, 3, 3.75, 5) {
+		my $best_cas;
+
+		# Find min CAS latency at this speed
+		if (defined $ctime2 && $ctime >= $ctime2) {
+			$best_cas = $highestCAS-2;
+		} elsif (defined $ctime1 && $ctime >= $ctime1) {
+			$best_cas = $highestCAS-1;
+		} else {
+			$best_cas = $highestCAS;
+		}
+
+		printl_cond($ctime >= $ctime_min && $ctime <= $ctime_max,
+			    "tCL-tRCD-tRP-tRAS as DDR2-".int(2000 / $ctime),
+			    ddr2_core_timings($best_cas, $ctime,
+					      $trcd, $trp, $tras));
+	}
 
 # more timing information
 	prints("Timing Parameters");

-- 
Jean Delvare

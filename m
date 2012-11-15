From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/7] decode-dimms: Print timings at standard DDR speeds
Date: Thu, 15 Nov 2012 12:48:02 +0100
Message-ID: <20121115124802.47ed07f3@endymion.delvare>
References: <20121115115231.341ac0c9@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121115115231.341ac0c9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Print timings at standard DDR speeds. The minimum cycle times for the
3 supported CAS latency values do not necessarily match standard
speeds, and even if they do, they may not cover all standard speeds.
Display the timings at all standard supported speeds. This makes it
easier to figure out which memory modules will work well together
without tinkering with BIOS options.
---
 eeprom/decode-dimms |   46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-11-15 09:37:36.000000000 +0100
+++ i2c-tools/eeprom/decode-dimms	2012-11-15 10:40:13.765625180 +0100
@@ -835,7 +835,7 @@ sub ddr_core_timings($$$$$)
 	my ($cas, $ctime, $trcd, $trp, $tras) = @_;
 
 	return $cas . "-" . ceil($trcd/$ctime) . "-" . ceil($trp/$ctime) .
-		"-" . ceil($tras/$ctime) . " as DDR-" . int(2000 / $ctime);
+		"-" . ceil($tras/$ctime);
 }
 
 # Parameter: EEPROM bytes 0-127 (using 3-62)
@@ -843,6 +843,7 @@ sub decode_ddr_sdram($)
 {
 	my $bytes = shift;
 	my $temp;
+	my ($ctime, $ctime1, $ctime2, $ctime_min, $ctime_max);
 
 # SPD revision
 	printl_cond($bytes->[62] != 0xff, "SPD Revision",
@@ -851,7 +852,7 @@ sub decode_ddr_sdram($)
 # speed
 	prints("Memory Characteristics");
 
-	my $ctime = ($bytes->[9] >> 4) + ($bytes->[9] & 0xf) * 0.1;
+	$ctime_min = $ctime = ($bytes->[9] >> 4) + ($bytes->[9] & 0xf) * 0.1;
 	my $ddrclk = 2 * (1000 / $ctime);
 	my $tbits = ($bytes->[7] * 256) + $bytes->[6];
 	if (($bytes->[11] == 2) || ($bytes->[11] == 1)) { $tbits = $tbits - 8; }
@@ -930,7 +931,7 @@ sub decode_ddr_sdram($)
 
 	if (exists $cas{$highestCAS}) {
 		$core_timings = ddr_core_timings($highestCAS, $ctime,
-			$trcd, $trp, $tras);
+			$trcd, $trp, $tras) . " as DDR-" . int(2000 / $ctime);
 
 		$cycle_time = "$ctime ns at CAS $highestCAS";
 		$access_time = (($bytes->[10] >> 4) * 0.1 + ($bytes->[10] & 0xf) * 0.01)
@@ -938,25 +939,27 @@ sub decode_ddr_sdram($)
 	}
 
 	if (exists $cas{$highestCAS-0.5} && spd_written(@$bytes[23..24])) {
-		$ctime = ($bytes->[23] >> 4) + ($bytes->[23] & 0xf) * 0.1;
-		$core_timings .= "\n".ddr_core_timings($highestCAS-0.5, $ctime,
-			$trcd, $trp, $tras);
+		$ctime1 = ($bytes->[23] >> 4) + ($bytes->[23] & 0xf) * 0.1;
+		$core_timings .= "\n".ddr_core_timings($highestCAS-0.5, $ctime1,
+			$trcd, $trp, $tras) . " as DDR-" . int(2000 / $ctime1);
 
-		$cycle_time .= "\n$ctime ns at CAS ".($highestCAS-0.5);
+		$cycle_time .= "\n$ctime1 ns at CAS ".($highestCAS-0.5);
 		$access_time .= "\n".(($bytes->[24] >> 4) * 0.1 + ($bytes->[24] & 0xf) * 0.01)
 			      . " ns at CAS ".($highestCAS-0.5);
 	}
 
 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[25..26])) {
-		$ctime = ($bytes->[25] >> 4) + ($bytes->[25] & 0xf) * 0.1,
-		$core_timings .= "\n".ddr_core_timings($highestCAS-1, $ctime,
-			$trcd, $trp, $tras);
+		$ctime2 = ($bytes->[25] >> 4) + ($bytes->[25] & 0xf) * 0.1,
+		$core_timings .= "\n".ddr_core_timings($highestCAS-1, $ctime2,
+			$trcd, $trp, $tras) . " as DDR-" . int(2000 / $ctime2);
 
-		$cycle_time .= "\n$ctime ns at CAS ".($highestCAS-1);
+		$cycle_time .= "\n$ctime2 ns at CAS ".($highestCAS-1);
 		$access_time .= "\n".(($bytes->[26] >> 4) * 0.1 + ($bytes->[26] & 0xf) * 0.01)
 			      . " ns at CAS ".($highestCAS-1);
 	}
 
+	$ctime_max = $bytes->[43] == 0xff ? 0 : $bytes->[43]/4;
+
 	printl_cond(defined $core_timings, "tCL-tRCD-tRP-tRAS", $core_timings);
 	printl_cond(defined $cycle_time, "Minimum Cycle Time", $cycle_time);
 	printl_cond(defined $access_time, "Maximum Access Time", $access_time);
@@ -964,8 +967,27 @@ sub decode_ddr_sdram($)
 		    "Maximum Cycle Time (tCK max)",
 		    $bytes->[43] == 0xff ? "No minimum frequency" :
 		    $bytes->[43] == 0 ? "" : # Wouldn't be displayed, prevent div by 0
-		    tns1($bytes->[43]/4)." (DDR-".int(8000 / $bytes->[43]).")");
+		    tns1($ctime_max)." (DDR-".int(8000 / $bytes->[43]).")");
+
+# standard DDR speeds
+	prints("Timings at Standard Speeds");
+	foreach $ctime (5, 6, 7.5, 10) {
+		my $best_cas;
 
+		# Find min CAS latency at this speed
+		if (defined $ctime2 && $ctime >= $ctime2) {
+			$best_cas = $highestCAS-1;
+		} elsif (defined $ctime1 && $ctime >= $ctime1) {
+			$best_cas = $highestCAS-0.5;
+		} else {
+			$best_cas = $highestCAS;
+		}
+
+		printl_cond($ctime >= $ctime_min && ($ctime_max < 1 || $ctime <= $ctime_max),
+			    "tCL-tRCD-tRP-tRAS as DDR-".int(2000 / $ctime),
+			    ddr_core_timings($best_cas, $ctime,
+					     $trcd, $trp, $tras));
+	}
 
 # more timing information
 	prints("Timing Parameters");

-- 
Jean Delvare

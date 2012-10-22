From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/3] decode-dimms: Print DDR2 core timings for all supported
 CAS values
Date: Mon, 22 Oct 2012 13:03:56 +0200
Message-ID: <20121022130356.5e3e565e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Print DDR2 core timings for all supported CAS values as we do for
DDR modules.
---
 eeprom/decode-dimms |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

--- i2c-tools.orig/eeprom/decode-dimms	2012-10-22 08:53:13.991250685 +0200
+++ i2c-tools/eeprom/decode-dimms	2012-10-22 08:53:16.894251352 +0200
@@ -1069,6 +1069,14 @@ sub ddr2_refresh_rate($)
 	       ($byte & 0x80 ? " - Self Refresh" : "");
 }
 
+sub ddr2_core_timings($$$$$)
+{
+	my ($cas, $ctime, $trcd, $trp, $tras) = @_;
+
+	return $cas . "-" . ceil($trcd/$ctime) . "-" . ceil($trp/$ctime) .
+		"-" . ceil($tras/$ctime) . " as DDR2-" . int(2000 / $ctime);
+}
+
 # Parameter: EEPROM bytes 0-127 (using 3-62)
 sub decode_ddr2_sdram($)
 {
@@ -1152,38 +1160,44 @@ sub decode_ddr2_sdram($)
 	$trp = ($bytes->[27] >> 2) + (($bytes->[27] & 3) * 0.25);
 	$tras = $bytes->[30];
 
-	printl("tCL-tRCD-tRP-tRAS",
-		$highestCAS . "-" .
-		ceil($trcd/$ctime) . "-" .
-		ceil($trp/$ctime) . "-" .
-		ceil($tras/$ctime));
-
 # latencies
 	printl("Supported CAS Latencies (tCL)", cas_latencies(keys %cas));
 
 # timings
-	my ($cycle_time, $access_time);
+	my ($cycle_time, $access_time, $core_timings);
 
 	if (exists $cas{$highestCAS}) {
+		$core_timings = ddr2_core_timings($highestCAS, $ctime,
+			$trcd, $trp, $tras);
+
 		$cycle_time = tns($ctime) . " at CAS $highestCAS (tCK min)";
 		$access_time = tns(ddr2_sdram_atime($bytes->[10]))
 			     . " at CAS $highestCAS (tAC)";
 	}
 
 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[23..24])) {
-		$cycle_time .= "\n".tns(ddr2_sdram_ctime($bytes->[23]))
+		$ctime = ddr2_sdram_ctime($bytes->[23]);
+		$core_timings .= "\n".ddr2_core_timings($highestCAS-1, $ctime,
+			$trcd, $trp, $tras);
+
+		$cycle_time .= "\n".tns($ctime)
 			     . " at CAS ".($highestCAS-1);
 		$access_time .= "\n".tns(ddr2_sdram_atime($bytes->[24]))
 			      . " at CAS ".($highestCAS-1);
 	}
 
 	if (exists $cas{$highestCAS-2} && spd_written(@$bytes[25..26])) {
-		$cycle_time .= "\n".tns(ddr2_sdram_ctime($bytes->[25]))
+		$ctime = ddr2_sdram_ctime($bytes->[25]);
+		$core_timings .= "\n".ddr2_core_timings($highestCAS-2, $ctime,
+			$trcd, $trp, $tras);
+
+		$cycle_time .= "\n".tns($ctime)
 			     . " at CAS ".($highestCAS-2);
 		$access_time .= "\n".tns(ddr2_sdram_atime($bytes->[26]))
 			      . " at CAS ".($highestCAS-2);
 	}
 
+	printl_cond(defined $core_timings, "tCL-tRCD-tRP-tRAS", $core_timings);
 	printl_cond(defined $cycle_time, "Minimum Cycle Time", $cycle_time);
 	printl_cond(defined $access_time, "Maximum Access Time", $access_time);
 	$temp = ddr2_sdram_ctime($bytes->[43]);


-- 
Jean Delvare
